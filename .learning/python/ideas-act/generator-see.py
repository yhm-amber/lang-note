
#: ── define ───────────────────────────────────

#: lambda style
from itertools import tee
see_gen = ( lambda gen, see = list: 
	( lambda saw, orig: 
		(lambda _: orig) (print(see(saw))) 
	) (* tee(gen, 2)) )

#: or better with typing
from typing import Iterable, Callable
def see_gen[T, R](
		gen: Iterable[T], 
		see: Callable[[Iterable[T]], R] = list, 
		) -> Iterable[T]:
	from itertools import tee
	return (lambda saw, orig: 
		(lambda _: orig) (print(see(saw)))
	) (* tee(gen, 2))

#: ── define ───────────────────────────────────



#: using demo

#: using demo - data prepare

from urllib.request import Request, urlopen
from urllib.parse import urlencode
import json

# ── 配置 ──────────────────────────────────────
SEARCH_KWD = "hanjian.svg"
HEADERS    = {
	"Referer": "https://commons.wikimedia.org/", 
	"User-Agent": "ZBot/1.0 (research; educational)" }
PAGE_SIZE  = 50 # 项，一页多少

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
	return json.loads(resp.read())

# ── 生成器：惰性翻页 ──────────────────────────
def pages(offset = 0) -> None:
	while offset is not None:
		#: 一页得 整页出
		resp   = _fetch(_build_url(offset))
		yield  resp.get("query", {}).get("pages", {})
		#: 询下页 稍待时
		offset = resp.get("continue", {}).get("gsroffset")
		time.sleep(DELAY)
	return offset

# ── 管道：从翻页到文件清单 ────────────────────
all_fileinfo = ( 
	{
		#: 文件标题
		"title": x.get("title", ""), 
		#: 最新地址
		"url":   (x.get("imageinfo") or [{}])[0].get("url"), 
		#: 文件大小
		"size":  (x.get("imageinfo") or [{}])[0].get("size"), 
	}
	for p in pages()
	for x in p.values()
	if SEARCH_KWD in x.get("title", "") )



#: using demo - see effect

from polars import DataFrame

all_fileinfo = see_gen(all_fileinfo, DataFrame)
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
all_fileinfo = see_gen(all_fileinfo, DataFrame)
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

#: so that we can see a generator many times.


