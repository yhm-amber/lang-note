from typing import Iterable, Callable
from result import Ok, Err, as_result, Result  # noqa: F401
from urllib.error import HTTPError, URLError, ContentTooShortError
from rich.console import Console


# ── 配置 ──────────────────────────────────────
SEARCH_KWD = "hanjian.svg"
OUT_DIR    = "./.hanjian-svg"
HEADERS    = {
	"Referer": "https://commons.wikimedia.org/", 
	"User-Agent": "ZBot/1.0 (research; educational)" }
DELAY      = 2 # 秒，限流保护
PAGE_SIZE  = 6 # 项，一页多少
MAX_CONCURRENT = 1 # 同时存在下载任务个数 (增加这个就要增加 DELAY 否则容易 429 - Wikimedia 的非官方请求容忍阈值大约是每秒 1 次以内)

console = Console() # 控制台操作器（只需一个）


# ── 构建请求 ──────────────────────────────────
def wikiapi_url(offset: int = 0) -> str:
	from urllib.parse import urlencode
	return "https://commons.wikimedia.org/w/api.php?" + urlencode({
		"action":       "query",            #: 告以寻
		"generator":    "search",           #: 用以寻
		"gsrsearch":    SEARCH_KWD,         #: 寻何物
		"gsrnamespace": "6|14",             #: 从何寻
		"gsrlimit":     str(PAGE_SIZE),     #: 扩页长
		"gsroffset":    str(offset),        #: 翻页记
		"prop":         "imageinfo",        #: 寻得相
		"iiprop":       "url|size|mime",    #: 相中何
		"format":       "json",             #: 报予框
	})

def url_fetch(url: str) -> dict:
	from urllib.request import Request, urlopen
	from json import loads
	resp = urlopen(Request(url, headers=HEADERS), timeout=15)
	return loads(resp.read())

# ── 生成器：惰性翻页 ──────────────────────────
def pages_flipper(offset = 0):
	from time import sleep
	while offset is not None:
		#: 一页得 整页出
		console.print('~ page {}: ({}~{}) files info fetching ...'.format(
			offset // PAGE_SIZE + 1, 
			offset + 1, 
			offset + PAGE_SIZE, 
			))
		resp   = url_fetch(wikiapi_url(offset))
		yield  resp.get("query", {}).get("pages", {})
		#: 询下页 稍待时
		console.print('~ page {}: ({}~{}) waiting <{} sec.> before continue ...'.format(
			offset // PAGE_SIZE + 1, 
			offset + 1, 
			offset + PAGE_SIZE, 
			DELAY, 
			))
		offset = resp.get("continue", {}).get("gsroffset")
		sleep(DELAY)
	pass
	console.print('~ {} of any continue page, fin.'.format(offset))

# ── 管道：从翻页到文件清单 ────────────────────
def info_scraping(
		pages: Iterable[dict], 
		kwd: str | None = None, 
		) -> Iterable[dict[str, str]]:
	return ( 
	(
		{
			#: 文件标题
			"title": x.get("title", ""), 
			#: 最新地址
			"url":   (x.get("imageinfo") or [{}])[0].get("url"), 
			#: 文件大小
			"size":  (x.get("imageinfo") or [{}])[0].get("size"), 
		}
		for x in p.values()
		if kwd is None or kwd in x.get("title", ""))
	for p in pages )


#: generator prepare.
pages_info = info_scraping(pages_flipper())
# pages_info = info_scraping(pages_flipper(), SEARCH_KWD)


# ── 下载 ──────────────────────────────────────

def dir_prepare(path: str) -> str:
	from os import makedirs
	makedirs(path, exist_ok=True)
	return path

# @as_result(Exception)
@as_result(HTTPError, URLError, ContentTooShortError)
def url_downloader(url: str, path: str, _wait: int = 0) -> str:
	from time import sleep
	from urllib.request import Request, urlopen
	sleep(_wait)
	console.print('~ downloading to path <{}> from url <{}> after wait <{} sec.>.'.format(
		path, url, _wait))
	with urlopen(Request(url, headers=HEADERS), timeout=15) as resp:
		with open(path, "wb") as out:
			out.write(resp.read())
	return path


#~ files_info = see_generator(files_info, pl.DataFrame)
#~ from itertools import count as sequence
#~ pages_info = see_generator(pages_info, lambda p: (print(x) for x in ({ 'page': i, 'content': x } for i, x in enumerate((see_generator(x, pl.DataFrame) for x in p), 1))), say = list)
def see_generator[T, R](
		gen: Iterable[T], 
		see: Callable[[Iterable[T]], R] = list, 
		say: Callable[[R], None] = print, 
		) -> Iterable[T]:
	from itertools import tee
	return (lambda saw, orig: 
		(lambda _: orig) (say(see(saw)))
	) (* tee(gen, 2))


def _flip_pages(pages_info: Iterable[Iterable[dict[str, str]]]):
	from rich.prompt import Prompt
	for page_num, files_info in enumerate(pages_info, 1):
		while True:
			files_info = see_generator(
				gen = files_info, 
				see = lambda x: { 'page': page_num, 'content': pl.DataFrame(x) }, 
				say = console.print)
			console.print('[blue]If you see Err 429, you\'d better having a long wait before next downloads.[/]')
			match Prompt.ask(
				'[bold cyan]Try to (re)download all unfinished in page {} ?[/]'.format(page_num), 
				choices = ['y', 'N'], 
				default = 'y', 
			):
				case 'y':
					files_info = medias_download(files_info)
				case 'N':
					break
				case _:
					pass
		console.print('[bold cyan]Quit out from page {} ...[/]'.format(page_num))
		...
	pass


def medias_download(
		info_iter: Iterable[dict[str, str]], 
		_workers: int = MAX_CONCURRENT, 
		_wait_delay: int = DELAY, 
		) -> Iterable[Result[str, Exception]]:
	from concurrent.futures import ThreadPoolExecutor
	from os.path import join as path_concat
	from itertools import count as sequence
	with ThreadPoolExecutor(max_workers = _workers) as executor:
		return executor.map(
			lambda idx, info: info if 
				('status' in info) and 
				info['status'].is_ok() else 
			{ 
				** info, 
				'status': url_downloader(
					_wait = (idx % _workers + 1) * _wait_delay, 
					path = path_concat(
						dir_prepare(OUT_DIR), 
						info["title"].replace("File:", "")), 
					url = info["url"]), 
			}, 
			sequence(start = 1, step = 1), 
			info_iter)


if __name__ == "__main__":
	import polars as pl
	pl.Config.set_tbl_rows(-1) # 显示所有行
	pl.Config.set_tbl_cols(-1) # 显示所有列
	# pl.Config.set_tbl_width_chars(2048) # 避免因为终端宽度自动换行截断
	_flip_pages(pages_info)
	...
