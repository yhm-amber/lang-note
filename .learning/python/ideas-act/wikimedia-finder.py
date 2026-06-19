#!/usr/bin/env python3

from typing import Iterable, Callable
from result import Ok, Err, as_result, Result
from urllib.error import HTTPError, URLError, ContentTooShortError
from rich.console import Console
from pydantic import TypeAdapter
from polars import DataFrame


# ── 配置 ──────────────────────────────────────
def osenv_orask[T](
		envnames: Iterable[str], 
		default: str | T, 
		outtype: Callable[[str], T], 
		asking: str = None, 
		_skip_ask: bool = False, 
		) -> T:
	"""
	期效: 
	- 若指名存 则用其值 不问
	- 若不存 则用其全局名只值为默认以问 仍不存则以参传为默认
	- 皆不存则且问矣
	"""
	from os import getenv
	from itertools import tee
	from rich.prompt import Prompt
	envnames_glob, envnames_orig = tee(envnames, 2)
	pass
	asking = asking if asking else f'profile {'/'.join(list(envnames))} need to specified:'
	pass
	envgot_glob = next(
		( env for name in envnames_glob if (env := getenv(name)) ), None)
	envgot_orig = next(
		( env for name in envnames_orig if (env := getenv(name)) ), None)
	pass
	default = str(default) if envgot_glob is None else envgot_glob
	return outtype(
		Prompt.ask(
			f'[bold yellow]{asking}[/]', 
			default = default if default else ...) 
		if (not _skip_ask) and (envgot_orig is None) 
		else envgot_orig if envgot_orig else default)
	pass

SEARCH_KWD = osenv_orask(['SEARCH_KWD'], "hanjian.svg", str, 'Input your keyword for searching:')
OUT_DIR    = osenv_orask(['OUT_DIR'], "./.hanjian-svg", str, 'Input a path for saving:')
PAGE_SIZE  = osenv_orask(['PAGE_SIZE'], 6, int, 'How many entry(s) you want in one page?') # 项，一页多少
DELAY      = osenv_orask(['DELAY'], 2, int, 'Setting a waiting sec. num for delay:') # 秒，限流保护
AUTO_FLIP  = osenv_orask(
	['AUTO_FLIP','AUTOFLIP_MODE'], False, TypeAdapter(bool).validate_python, 
	'Do you want the script run in auto-mode (recommend “No/False” if you are first here) ?')
MAX_CONCURRENT = osenv_orask(['MAX_WORKERS','MAX_WORKER','MAX_CONCURRENT'], 1, int, _skip_ask = True)
#: 同时存在下载任务个数 (增加这个就要增加 DELAY 否则容易 429 - Wikimedia 的非官方请求容忍阈值大约是每秒 1 次以内)
HEADERS    = {
	"Referer": "https://commons.wikimedia.org/", 
	"User-Agent": "MediaFinder/1.2 (research; educational)" }
console = Console() # 控制台操作器（只需一个）

# ── 构建请求 ──────────────────────────────────
def wikiurl_filesapi(offset: int = 0) -> str:
	"""
	符其令
	用取期
	
	Make full url for wikimedia api.
	"""
	from urllib.parse import urlencode
	return "https://commons.wikimedia.org/w/api.php?" + urlencode(
	{
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
	pass

def url_fetch(url: str) -> dict:
	"""
	取诸天
	受所机
	
	Fetch url
	 and load its
	 response.
	"""
	from urllib.request import Request, urlopen
	from json import loads
	resp = urlopen(Request(url, headers = HEADERS), timeout=15)
	return loads(resp.read())
	pass

# ── 生成器：惰性翻页 ──────────────────────────
def pages_flipper(wikiapi_url, offset = 0):
	"""
	定我页
	见若行
	
	Create page flipper which is in lazy mode.
	Will printing messages during real running.
	"""
	from time import sleep
	while offset is not None:
		p_n = offset // PAGE_SIZE + 1
		p_bg, p_ed = offset + 1, offset + PAGE_SIZE
		#: 一页得 整页出
		console.print(f'[bold blue]:: [/]page {p_n}: ({p_bg}~{p_ed}) files info fetching ...')
		resp   = url_fetch(wikiapi_url(offset))
		yield  resp.get("query", {}).get("pages", {})
		#: 询下页 稍待时
		console.print(f'[bold blue]:: [/]page {p_n}: ({p_bg}~{p_ed}) finding continue with <{DELAY} sec.> waiting ...')
		offset = resp.get("continue", {}).get("gsroffset")
		sleep(DELAY)
	from random import choice as whateverone
	console.print('[bold blue]:: [/]{} of any continue page, fin. {}'.format(
		offset, 
		whateverone(['✨', '🙃', '🙄', '🎆', '👻', '🙈', ':D', ':P', '🎇', '🕹']), 
	))
	...

# ── 管道：从翻页到文件清单 ────────────────────
def info_scraping(
		pages: Iterable[dict], 
		kwd: str = None, 
		) -> Iterable[dict[str, str]]:
	"""
	取我所用
	尽我设择
	
	Scraping info during pages' flipping.
	Format of 'info' specified here.
	"""
	return ( 
	( 
		{
			#: 文件标题
			"filename": filename, 
			#: 最新地址
			"url":   (x.get("imageinfo") or [{}])[0].get("url"), 
			#: 文件大小
			"size":  (x.get("imageinfo") or [{}])[0].get("size"), 
		}
		for x in p.values()
		if (
			filename := x.get("title", "").removeprefix("File:"), 
			kwd is None or kwd in filename)[-1] )
	for p in pages )
	pass


#: generator prepare.
pages_info = info_scraping(pages_flipper(wikiurl_filesapi))
# pages_info = info_scraping(pages_flipper(wikiurl_filesapi), SEARCH_KWD)


# ── 下载 ──────────────────────────────────────

def dir_prepare(path: str) -> str:
	"""
	兵马未动粮草先行
	若用一地方显备之
	
	Prepare a dir's path before you using it.
	"""
	from os import makedirs
	makedirs(path, exist_ok=True)
	return path
	pass

# @as_result(Exception)
@as_result(HTTPError, URLError, ContentTooShortError)
def url_downloader(url: str, path: str, _wait: int = 0) -> str:
	"""
	取天至地
	再报成否
	
	Download url into path
	 and return report in <rustedpy/result> mode.
	"""
	from time import sleep
	from urllib.request import Request, urlopen
	sleep(_wait)
	console.print(
		'[bold blue]:: [/]downloading to path <{}> from url <{}> after wait <{} sec.>.'.format(
			path, url, _wait))
	with urlopen(Request(url, headers=HEADERS), timeout=15) as resp:
		with open(path, "wb") as out:
			out.write(resp.read())
	return path
	pass


def generator_observe[T, R, X, Y](
		gen: Iterable[T], 
		see: Callable[[Iterable[T]], X] = list, 
		say: Callable[[X], Y] = print, 
		fin: Callable[
			[Callable[[X], Y], Callable[[Iterable[T]], X]], 
			Callable[[Iterable[T], Iterable[T]], R]] = (
				lambda say, see: 
				lambda saw, orig: 
					(lambda _: orig) (say(see(saw))) ), 
		) -> R:
	"""
	可见其内
	犹返若初
	
	Can see a gen by the way you choose
	 then return such gen which didn't had any consuming yet.
	
	----
	Demo: 
	
	~~~ py
	seq6 = ( { 'i_py': x, 'i_R': 1 + x } for x in range(6) )
	seq6 = generator_observe(seq6, pl.DataFrame)
	seq6_df, seq6 = generator_observe(
		gen = seq6, 
		see = pl.DataFrame, 
		say = (lambda x: (lambda _: x) (print(x)) ), 
		fin = (
			lambda say, see: 
			lambda saw, orig: 
				(lambda y: (y, orig)) (say(see(saw))) ))
	~~~
	"""
	from itertools import tee
	return (fin) (say, see) (* tee(gen, 2))
	pass

def gen_obs[T, R](
		gen: Iterable[T], 
		see: Callable[[Iterable[T]], R] = list, 
		say: Callable[[R], None] = print, 
		) -> tuple[Iterable[T], R]:
	"""
	可得其内
	返与犹初
	
	Can see a gen by the way you choose
	 then return is such gen 
	 which didn't had any consuming yet
	 with an item which used for that saw.
	
	----
	Demo: 
	
	~~~ py
	seq6 = ( { 'i_py': x, 'i_R': 1 + x } for x in range(6) )
	seq6, _ = gen_obs(seq6, pl.DataFrame)
	seq6, _ = gen_obs(seq6, pl.DataFrame, say = console.print)
	seq6, seq6_df = gen_obs(seq6, pl.DataFrame)
	seq6, seq6_df = gen_obs(seq6, pl.DataFrame, say = console.print)
	~~~
	"""
	return generator_observe(
		say = (lambda x: (lambda _: x) (say(x)) ), 
		fin = (
			lambda say, see: 
			lambda saw, orig: 
				(lambda y: (orig, y)) (say(see(saw))) ), 
		see = see, 
		gen = gen)
	pass

def gen_see[T, R](
		gen: Iterable[T], 
		see: Callable[[Iterable[T]], R] = list, 
		say: Callable[[R], None] = print, 
		) -> Iterable[T]:
	"""
	可见其内
	僅返犹初
	
	Can see a gen by the way you choose
	 and only return such gen which didn't had any consuming yet.
	
	----
	Demo: 
	
	~~~ py
	seq6 = ( { 'i_py': x, 'i_R': 1 + x } for x in range(6) )
	seq6 = gen_see(seq6, pl.DataFrame)
	seq6 = gen_see(seq6, pl.DataFrame, say = console.print)
	~~~
	"""
	return generator_observe(
		fin = (
			lambda say, see: 
			lambda saw, orig: 
				(lambda _: orig) (say(see(saw))) ), 
		say = say, 
		see = see, 
		gen = gen)
	pass

def _determine_obs(df: DataFrame) -> tuple[bool, DataFrame]:
	"""
	辨初否 备与决
	
	To determine is this obs page is (not) the first
	 times it generated.
	"""
	return (
		not (nece_judge := 'status' in df.schema), 
		df.with_columns(status = None).filter(nece_judge) 
			if not nece_judge else df)
	pass

def _judge_obs(pageobs_df: DataFrame) -> bool:
	"""
	观其页 知其况
	
	To aggregate a statused OBS-DF
	 for know is there any necessary to try again
	 and more ....
	"""
	_, _determined_df = _determine_obs(pageobs_df)
	judged = _determined_df.with_columns(
		status_type = pl.col('status').map_elements(
			function = lambda a: type(a).__name__, 
			return_dtype = pl.String), 
		error_message = pl.col('status').map_elements(
			function = lambda a: a.unwrap_or_else(str) 
				if isinstance(a, Err) else None, 
			return_dtype = pl.String), 
		is_done = pl.col('status').map_elements(
			function = lambda a: isinstance(a, Ok), 
			return_dtype = pl.Boolean), 
	).group_by(
		('status_type','is_done','error_message',), 
		maintain_order = True, 
	).agg(
		names = pl.col('filename').str.join(', '), 
		count = pl.len(), 
	).with_columns(
		message_fill = pl.col('is_done').map_elements(
			function = lambda a: '...' if a else None, 
			return_dtype = pl.String), 
	).with_columns(
		_show = pl.format(
			'- {} ({}/{}): {} ~ {}', 
			pl.col('status_type'), 
			pl.col('count'), 
			pl.lit(PAGE_SIZE), 
			pl.col('names'), 
			pl.col('error_message').fill_null(
				pl.col('message_fill').fill_null(
					'???impossible-here!!!!')), 
		)
	).select('_show','is_done')
	for _show, _ in judged.iter_rows():
		console.print(_show)
		pass
	return (lambda j: next(j, False) and all(j) ) ( 
		is_done for _, is_done in judged.iter_rows() )
	pass

def _flip_pages(pages_info: Iterable[Iterable[dict[str, str]]]):
	"""
	作业以问
	页页致之
	
	Control with asking
	 to flip the lazying page.
	"""
	from rich.prompt import Prompt
	for page_num, files_info in enumerate(pages_info, 1):
		while True:
			files_info, _obs = gen_obs(
				gen = files_info, 
				see = lambda x: { 'page': page_num, 'content': pl.DataFrame(x) }, 
				say = console.print)
			_is_first, _judgable_obs = _determine_obs(_obs['content'])
			_page_alldone = _judge_obs(_judgable_obs)
			pass
			from random import choice as whateverone
			console.print(
				f'[bold blue]:: [/]all done in page {page_num} {whateverone(['🉑','🔮','🗝','🏹','✅','✔'])}'
			) if _page_alldone else ...
			console.print(
				'[green italic][bold]([/]~ You\'d be better to [bold]having a long wait[/] before next downloading If you see Err 429 here ~[bold])[/][/]'
			) if all([not _is_first, not _page_alldone]) else ...
			pass
			match Prompt.ask(
				f'[bold cyan]Try to (re)download all unfinished in page {page_num} ?[/]', 
				choices = ['y', 'N'], 
				default = 'y', 
			) if not AUTO_FLIP else ('y' if not _page_alldone else 'N'):
				case 'y':
					files_info = medias_download(files_info)
				case 'N':
					break
				case _:
					pass
			pass
		console.print('[bold cyan]Quit out from page {} ...[/]'.format(page_num))
		pass
	...


def medias_download(
		info_iter: Iterable[dict[str, str]], 
		_workers: int = MAX_CONCURRENT, 
		_wait_delay: int = DELAY, 
		) -> Iterable[Result[str, Exception]]:
	"""
	仅允定式以入
	可并行作业然不荐 故工者定为一
	将返报以仍合定式 可再入以复作业其为未成
	
	Only support the info-format dict that defined in `info_scraping` for input.
	Support parallel downloading with workers limit choose
	 but parallel downloading will not good for 'wikimedia'
	 so here we don't let user choose the `MAX_CONCURRENT`.
	Will return a info-format dict with one more field `status`
	 and it can be input into this tool like a info-format dict also
	 and only files which with an Err status will be download again
	 at this time.
	"""
	from concurrent.futures import ThreadPoolExecutor
	# from os.path import join as path_concat
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
					path = f'{dir_prepare(OUT_DIR)}/{info["filename"]}', 
					# path = path_concat(
					# 	dir_prepare(OUT_DIR)}, 
					# 	info["filename"]), 
					url = info["url"]), 
			}, 
			sequence(start = 1, step = 1), 
			info_iter)
	pass


if __name__ == '__main__':
	"""
	些许显设 而作业之
	"""
	import polars as pl
	pl.Config.set_tbl_rows(-1) # 显示所有行
	pl.Config.set_tbl_cols(-1) # 显示所有列
	# pl.Config.set_tbl_width_chars(2048) # 避免因为终端宽度自动换行截断
	_flip_pages(pages_info)
	...
