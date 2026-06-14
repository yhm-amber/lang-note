
#: ── define ───────────────────────────────────

#: lambda style
# ~~~ ────────────────────
from itertools import tee
see_gen = ( lambda 
		gen, 
		see = list, 
		say = print: 
	( lambda saw, orig: 
		(lambda _: orig) (say(see(saw))) 
	) (* tee(gen, 2)) )
# ~~~ ────────────────────

#: or better with typing
# ~~~ ────────────────────
from typing import Iterable, Callable
def see_gen[T, R](
		gen: Iterable[T], 
		see: Callable[[Iterable[T]], R] = list, 
		say: Callable[[R], None] = print, 
		) -> Iterable[T]:
	from itertools import tee
	return (lambda saw, orig: 
		(lambda _: orig) (say(see(saw)))
	) (* tee(gen, 2))
# ~~~ ────────────────────

#: ── define ───────────────────────────────────



#: using demo

#: using demo - data prepare

# ~~~ ────────────────────
from urllib.request import Request, urlopen
from urllib.parse import urlencode
from time import sleep
from json import loads

# ── 配置 ──────────────────────────────────────
SEARCH_KWD = "hanjian.svg"
HEADERS    = {
	"Referer": "https://commons.wikimedia.org/", 
	"User-Agent": "ZBot/1.0 (research; educational)" }
PAGE_SIZE  = 50 # 项，一页多少
DELAY      = 2  # 秒，限流保护

# ── 构建请求 ──────────────────────────────────
def _build_url(offset: int = 0) -> str:
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

def _fetch(url: str) -> dict:
	resp = urlopen(Request(url, headers=HEADERS), timeout=15)
	return loads(resp.read())

# ── 生成器：惰性翻页 ──────────────────────────
def pager(offset = 0) -> None:
	while offset is not None:
		#: 一页得 整页出
		print('~ page {}: ({}~{}) files info fetching ...'.format(
			offset // PAGE_SIZE + 1, 
			offset + 1, 
			offset + PAGE_SIZE, 
			...))
		resp   = _fetch(_build_url(offset))
		yield  resp.get("query", {}).get("pages", {})
		#: 询下页 稍待时
		print('~ page {}: ({}~{}) waiting <{} sec.> before continue ...'.format(
			offset // PAGE_SIZE + 1, 
			offset + 1, 
			offset + PAGE_SIZE, 
			DELAY, 
			...))
		offset = resp.get("continue", {}).get("gsroffset")
		time.sleep(DELAY)
	return offset

# ── 管道：从翻页到文件清单 ────────────────────
def search_file(
		pages: Iterable[dict], 
		kwd: str = SEARCH_KWD, 
		) -> Iterable[dict[str, str]]:
	return ( 
	{
		#: 文件标题
		"title": x.get("title", ""), 
		#: 最新地址
		"url":   (x.get("imageinfo") or [{}])[0].get("url"), 
		#: 文件大小
		"size":  (x.get("imageinfo") or [{}])[0].get("size"), 
	}
	for p in pages
	for x in p.values()
	if kwd in x.get("title", "") )

#: data here prepared.
files_info = search_file(pager(), SEARCH_KWD)
# ~~~ ────────────────────


#: using demo - see effect

# ~~~ ────────────────────
from polars import DataFrame

files_info = see_gen(files_info, DataFrame)
#|	shape: (11, 3)
#|	┌─────────────────────┬─────────────────────────────────┬───────┐
#|	│ title               ┆ url                             ┆ size  │
#|	│ ---                 ┆ ---                             ┆ ---   │
#|	│ str                 ┆ str                             ┆ i64   │
#|	╞═════════════════════╪═════════════════════════════════╪═══════╡
#|	│ File:㽣-hanjian.svg ┆ https://upload.wikimedia.org/w… ┆ 10259 │
#|	│ File:一-hanjian.svg ┆ https://upload.wikimedia.org/w… ┆ 3397  │
#|	│ File:人-hanjian.svg ┆ https://upload.wikimedia.org/w… ┆ 6917  │
#|	│ File:八-hanjian.svg ┆ https://upload.wikimedia.org/w… ┆ 6276  │
#|	│ File:夏-hanjian.svg ┆ https://upload.wikimedia.org/w… ┆ 18554 │
#|	│ …                   ┆ …                               ┆ …     │
#|	│ File:弌-hanjian.svg ┆ https://upload.wikimedia.org/w… ┆ 5530  │
#|	│ File:愛-hanjian.svg ┆ https://upload.wikimedia.org/w… ┆ 7444  │
#|	│ File:漢-hanjian.svg ┆ https://upload.wikimedia.org/w… ┆ 16735 │
#|	│ File:龍-hanjian.svg ┆ https://upload.wikimedia.org/w… ┆ 9643  │
#|	│ File:𠕹-hanjian.svg ┆ https://upload.wikimedia.org/w… ┆ 7506  │
#|	└─────────────────────┴─────────────────────────────────┴───────┘
files_info = see_gen(files_info, DataFrame)
#|	shape: (11, 3)
#|	┌─────────────────────┬─────────────────────────────────┬───────┐
#|	│ title               ┆ url                             ┆ size  │
#|	│ ---                 ┆ ---                             ┆ ---   │
#|	│ str                 ┆ str                             ┆ i64   │
#|	╞═════════════════════╪═════════════════════════════════╪═══════╡
#|	│ File:㽣-hanjian.svg ┆ https://upload.wikimedia.org/w… ┆ 10259 │
#|	│ File:一-hanjian.svg ┆ https://upload.wikimedia.org/w… ┆ 3397  │
#|	│ File:人-hanjian.svg ┆ https://upload.wikimedia.org/w… ┆ 6917  │
#|	│ File:八-hanjian.svg ┆ https://upload.wikimedia.org/w… ┆ 6276  │
#|	│ File:夏-hanjian.svg ┆ https://upload.wikimedia.org/w… ┆ 18554 │
#|	│ …                   ┆ …                               ┆ …     │
#|	│ File:弌-hanjian.svg ┆ https://upload.wikimedia.org/w… ┆ 5530  │
#|	│ File:愛-hanjian.svg ┆ https://upload.wikimedia.org/w… ┆ 7444  │
#|	│ File:漢-hanjian.svg ┆ https://upload.wikimedia.org/w… ┆ 16735 │
#|	│ File:龍-hanjian.svg ┆ https://upload.wikimedia.org/w… ┆ 9643  │
#|	│ File:𠕹-hanjian.svg ┆ https://upload.wikimedia.org/w… ┆ 7506  │
#|	└─────────────────────┴─────────────────────────────────┴───────┘
# ~~~ ────────────────────

#: so that we can see a generator many times.

#: or using with rich to show updated info tbl
#: -- need to run under script mode.

# ~~~ ────────────────────
import polars as pl
from rich.console import Console
from rich.prompt import Prompt

console = Console()        #: 控制台操作器只需一个
pl.Config.set_tbl_rows(-1) #: 显示所有行
pl.Config.set_tbl_cols(-1) #: 显示所有列

while True:
	console.clear()
	files_info = see_gen(
		files_info, 
		see=pl.DataFrame, 
		say=lambda df: console.print(df)
		)
	choice = Prompt.ask(
		"[bold cyan]Retry unfinished?[/]", 
		choices=["y", "n"], 
		default="y"
		)
	if choice == "y":
		#: do something
		#: files_info = _info_download(files_info)
		pass
	else:
		break
# ~~~ ────────────────────

