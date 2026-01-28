

#' @title Tracker appender for magnet
#' @name magnet_tr_append
#' @param trackers {chr} urls of tracker
#' @param url_base {chr} (optional) base url of a magnet link
#' @param hash {chr} (optional) you can also just giving bt hash by this param
#'  rather than giving whole content of a magnet url
#' @param display_name {chr} (optional) to specify `dn` param of the query in url
#' @param trackers_output {lgl} (optional) you can setting this as `FALSE` if
#'  you don't need this tool give-back a tidy tracker urls
#' @returns {chr} a new magnet url which is done this appending
#' @examples \dontrun{
#' # simple
#' tracker_urls |> magnet_tr_append()
#' # specify hash
#' tracker_urls |> magnet_tr_append(hash = '18897a3938f74bdc559bd17eef4f01df42a977c3')
#' # specify base url
#' tracker_urls |> magnet_tr_append(url_base = 'magnet:?xt=urn:btih:18897a3938f74bdc559bd17eef4f01df42a977c3')
#' # don't output
#' tracker_urls |> magnet_tr_append(trackers_output = F)
#' tracker_urls |> magnet_tr_append(trackers_output = F, hash = '18897a3938f74bdc559bd17eef4f01df42a977c3')
#' # Verify
#' m = tracker_urls |> magnet_tr_append(hash = '18897a3938f74bdc559bd17eef4f01df42a977c3')
#' httr2::url_parse(m)
#' }
#' @description
#' Append trackers in your magnet url or a demo magnet url in default.
#' @export
#' 
magnet_tr_append <- function (
		trackers, 
		url_base = glue::glue_safe('magnet:?xt=urn:btih:{hash}'), 
		hash = '<hash>', 
		display_name = NULL, 
		trackers_output = T) trackers |> 
	urls_flat('\n') |> 
	urls_tidy(output_tidys = trackers_output) |> 
	utils::URLencode(reserved = T, repeated = F) |> 
	purrr::map_chr(~ glue::glue_safe("tr={.x}")) |> 
	base::append(url_base, after = 0) |> 
	magrittr::'%>%'({ if (base::is.null(display_name)) . else . |> base::append(
		values = "dn={dn}" |> glue::glue_safe(
			dn = display_name |> utils::URLencode(reserved = T, repeated = F)), 
		after = 1) }) |> 
	base::paste(collapse = '&') |> 
	glue::as_glue() |> 
	base::identity()

#' @title Split and flatten URLs by delimiter
#' @name urls_flat
#' @description
#' Flat the input string/vector by the specified delimiter (newline as default)
#' @param urls {chr} character vector containing URLs
#' @param delim {chr} (optional) character string to split by (defaults to newline `\n`)
#' @returns {chr} a flattened character vector of URLs
#' 
urls_flat <- function (
		urls, 
		delim = '\n') urls |> 
	base::strsplit(delim) |> 
	base::unlist() |> 
	base::identity()

#' @title Clean and deduplicate URLs chr
#' @name urls_tidy
#' @description
#' Trim whitespace, remove duplicates, and filter out empty strings from a vector of URLs.
#' @param urls {chr} vector of urls to be tidied
#' @param output_tidys {lgl} (optional) if TRUE, the tidyed urls will be printed to console
#' @returns {chr} a vector of unique, non-empty, trimmed urls
#' 
urls_tidy <- function (
		urls, 
		output_tidys = F) urls |> 
	base::trimws() |> 
	base::unique() |> 
	purrr::keep(~ base::nchar(.x) > 0) |> 
	magrittr::'%T>%'({
		if (base::isTRUE(output_tidys)) . |> 
			base::append('', after = 0) |> 
			base::append('' |> base::rep(2)) |> 
			base::paste(collapse = '\n') |> 
			base::cat()
	}) |> 
	base::identity()

#' @title Merge URL chr
#' @name urls_merge
#' @description
#' Combine multiple URL inputs. Delimiter split and tidy applying (trim, deduplicate, remove empty) supported.
#' @param ... {chr} URL(s)' input.
#' @param .output_res {lgl} (optional) show results in default.
#' @param .delim {chr} (optional) delimiter setting for content inputed, defaults to newline `\n`.
#' @returns {chr} merged & tidyed URLs (returned invisibly)
#' @export
#' @examples \dontrun{
#' # Basic usage
#' urls_merge(c("http://a.xyz:1010", "udp://b.info:1100"),"http://c.io")
#' # Custom delimiter
#' "https://a.co/, s3://b.xyz" |> urls_merge("http://c.info:9060", .delim = ",")
#' }
#' 
urls_merge <- function (
		..., 
		.output_res = T, 
		.delim = '\n') base::c(...) |> 
	urls_flat(.delim) |> 
	urls_tidy(output_tidys = .output_res) |> 
	base::invisible()

#' @title Extract URL query parameters (httr2 & purrr)
#' @name url_extquery.httr
#' @description Impl of extractor from url query part (with httr depd)
#' @param urls {chr} vector of urls to parse
#' @param keys {chr} names of the query parameters to extract
#' @returns {chr} a flattened vector of the extracted query values
#' 
url_extquery.httr <- function (urls, keys) urls |> 
	purrr::map(~ httr2::url_parse(.x)$query |> magrittr::'%>%'({ .[base::names(.) %in% keys] })) |> 
	base::unlist(use.names = F) |> 
	base::identity()

#' @title Extract URL query parameters (base & purrr)
#' @name url_extquery.base
#' @description Impl of extractor from url query part (with no httr depd)
#' @param urls {chr} vector of urls to parse
#' @param keys {chr} names of the query parameters to extract
#' @returns {chr} a flattened vector of the extracted query values
#' 
url_extquery.base <- function (urls, keys) urls |> 
	base::strsplit('?') |> purrr::map_chr(~ .x |> utils::tail(-1L) |> base::paste(collapse = '?')) |> 
	base::strsplit('&') |> base::unlist() |> base::unique() |> 
	base::strsplit('=') |> purrr::keep(~ base::length(.x) |> base::identical(2L)) |> 
	purrr::keep(~ .x |> utils::head(1L) |> base::'%in%'(keys)) |> 
	purrr::map_chr(~ .x |> utils::tail(1L)) |> 
	utils::URLdecode() |> 
	base::identity()

#' @title Extract URL query parameters
#' @name url_extquery
#' @description
#' A wrapper function that automatically dispatches to `url_extquery.httr` 
#' if the `httr2` package is available, otherwise falls back to `url_extquery.base`.
#' @param ... {any} arguments passed to `url_extquery.*`. Typically `urls` and `keys`.
#' @returns {chr} a character vector of extracted query values
#' @export
#' @examples \dontrun{
#' urls <- c("http://abc.xyz?a=1&b=2", "http://test.org?c=3")
#' keys <- c('a','c')
#' # This will use httr2 implementation if available, otherwise base R implementation
#' url_extquery(urls, keys)
#' }
url_extquery <- function (...) 'httr2' |> 
	base::requireNamespace(quietly = TRUE) |> 
	magrittr::'%>%'({ if (base::isTRUE(.)) 'httr' else 'base' }) |> 
	base::switch(
		httr = url_extquery.httr, 
		base = url_extquery.base) |> 
	magrittr::'%>%'({ .(...) }) |> 
	base::identity()

#' @title Extract trackers from magnet links
#' @name magnet_tr_extract
#' @param ... {chr} one or more magnet link strings
#' @returns {list} a list of tracker urls from each element you've given
#' @description
#' Extract `tr` (tracker) parameters from magnet links, tidy them, and return as a list.
#' @examples \dontrun{
#' # simple
#' m = tracker_urls |> magnet_tr_append(hash = '6feb855ae35dd2021ff970273996961ec4580d45')
#' trackers = magnet_tr_extract(m) |> unlist()
#' # more
#' m1 = tracker_urls.1 |> magnet_tr_append(hash = '3530df1450ff24e781e8a7beebde9714e04ce57a')
#' m2 = tracker_urls.2 |> magnet_tr_append(hash = '76fff592b71b3b2ba95a1c81de75e12706cb4f6a')
#' m3 = tracker_urls.3 |> magnet_tr_append(hash = '18897a3938f74bdc559bd17eef4f01df42a977c3')
#' m4 = tracker_urls.4 |> magnet_tr_append(hash = '9e7c26aca7e72b20441466e6e43d3b045e10f7a6')
#' trackers.ls = magnet_tr_extract(a = c(m1,m2), b = m3, c = m4)
#' }
#' @export
#' 
magnet_tr_extract <- function (...) base::list(...) |> 
	parallel::mclapply(\ (.entry) .entry |> 
		url_extquery('tr') |> urls_tidy() |> 
		glue::as_glue() |> 
		base::identity()) |> 
	base::identity()



##### taste #####



tracker_urls = 'magnet:?xt=urn:btih:N7VYKWXDLXJAEH7ZOATTTFUWD3CFQDKF&dn=&tr=http%3A%2F%2F104.143.10.186%3A8000%2Fannounce&tr=udp%3A%2F%2F104.143.10.186%3A8000%2Fannounce&tr=http%3A%2F%2Ftracker.openbittorrent.com%3A80%2Fannounce&tr=http%3A%2F%2Ftracker3.itzmx.com%3A6961%2Fannounce&tr=http%3A%2F%2Ftracker4.itzmx.com%3A2710%2Fannounce&tr=http%3A%2F%2Ftracker.publicbt.com%3A80%2Fannounce&tr=http%3A%2F%2Ftracker.prq.to%2Fannounce&tr=http%3A%2F%2Fopen.acgtracker.com%3A1096%2Fannounce&tr=https%3A%2F%2Ft-115.rhcloud.com%2Fonly_for_ylbud&tr=http%3A%2F%2Ftracker1.itzmx.com%3A8080%2Fannounce&tr=http%3A%2F%2Ftracker2.itzmx.com%3A6961%2Fannounce&tr=udp%3A%2F%2Ftracker1.itzmx.com%3A8080%2Fannounce&tr=udp%3A%2F%2Ftracker2.itzmx.com%3A6961%2Fannounce&tr=udp%3A%2F%2Ftracker3.itzmx.com%3A6961%2Fannounce&tr=udp%3A%2F%2Ftracker4.itzmx.com%3A2710%2Fannounce&tr=http%3A%2F%2Ftr.bangumi.moe%3A6969%2Fannounce' |> url_extquery('tr') |> urls_tidy()
tracker_urls.1 = 'magnet:?xt=urn:btih:3530df1450ff24e781e8a7beebde9714e04ce57a&dn=%E8%91%AB%E8%8A%A6%E5%85%84%E5%BC%9F%20(1986)&tr=udp%3A%2F%2Ftracker.opentrackr.org%3A1337%2Fannounce&tr=https%3A%2F%2Ftracker2.ctix.cn%3A443%2Fannounce&tr=https%3A%2F%2Ftracker1.520.jp%3A443%2Fannounce&tr=udp%3A%2F%2Fopentracker.i2p.rocks%3A6969%2Fannounce&tr=udp%3A%2F%2Ftracker.openbittorrent.com%3A6969%2Fannounce&tr=http%3A%2F%2Ftracker.openbittorrent.com%3A80%2Fannounce&tr=udp%3A%2F%2Fopen.demonii.com%3A1337%2Fannounce&tr=udp%3A%2F%2Fopen.stealth.si%3A80%2Fannounce&tr=udp%3A%2F%2Fexodus.desync.com%3A6969%2Fannounce&tr=udp%3A%2F%2Ftracker.moeking.me%3A6969%2Fannounce&tr=udp%3A%2F%2Ftracker.torrent.eu.org%3A451%2Fannounce&tr=udp%3A%2F%2Ftracker.bitsearch.to%3A1337%2Fannounce&tr=http%3A%2F%2Fbt.endpot.com%3A80%2Fannounce&tr=udp%3A%2F%2Ftracker1.bt.moack.co.kr%3A80%2Fannounce&tr=udp%3A%2F%2Fmovies.zsw.ca%3A6969%2Fannounce&tr=udp%3A%2F%2Fexplodie.org%3A6969%2Fannounce&tr=udp%3A%2F%2Fv1046920.hosted-by-vdsina.ru%3A6969%2Fannounce&tr=udp%3A%2F%2Fuploads.gamecoast.net%3A6969%2Fannounce&tr=udp%3A%2F%2Ftracker.theoks.net%3A6969%2Fannounce&tr=udp%3A%2F%2Ftracker.leech.ie%3A1337%2Fannounce&tr=https%3A%2F%2Ftracker.bt4g.com%3A443%2Fannounce' |> url_extquery('tr') |> urls_tidy()
tracker_urls.2 = 'magnet:?xt=urn:btih:76fff592b71b3b2ba95a1c81de75e12706cb4f6a&dn=%E8%91%AB%E8%8A%A6%E5%B0%8F%E9%87%91%E5%88%9A%20(1991)&tr=udp%3A%2F%2Ftracker.opentrackr.org%3A1337%2Fannounce&tr=https%3A%2F%2Ftracker2.ctix.cn%3A443%2Fannounce&tr=https%3A%2F%2Ftracker1.520.jp%3A443%2Fannounce&tr=udp%3A%2F%2Fopentracker.i2p.rocks%3A6969%2Fannounce&tr=udp%3A%2F%2Ftracker.openbittorrent.com%3A6969%2Fannounce&tr=http%3A%2F%2Ftracker.openbittorrent.com%3A80%2Fannounce&tr=udp%3A%2F%2Fopen.demonii.com%3A1337%2Fannounce&tr=udp%3A%2F%2Fopen.stealth.si%3A80%2Fannounce&tr=udp%3A%2F%2Fexodus.desync.com%3A6969%2Fannounce&tr=udp%3A%2F%2Ftracker.moeking.me%3A6969%2Fannounce&tr=udp%3A%2F%2Ftracker.torrent.eu.org%3A451%2Fannounce&tr=udp%3A%2F%2Ftracker.bitsearch.to%3A1337%2Fannounce&tr=http%3A%2F%2Fbt.endpot.com%3A80%2Fannounce&tr=udp%3A%2F%2Ftracker1.bt.moack.co.kr%3A80%2Fannounce&tr=udp%3A%2F%2Fmovies.zsw.ca%3A6969%2Fannounce&tr=udp%3A%2F%2Fexplodie.org%3A6969%2Fannounce&tr=udp%3A%2F%2Fv1046920.hosted-by-vdsina.ru%3A6969%2Fannounce&tr=udp%3A%2F%2Fuploads.gamecoast.net%3A6969%2Fannounce&tr=udp%3A%2F%2Ftracker.theoks.net%3A6969%2Fannounce&tr=udp%3A%2F%2Ftracker.leech.ie%3A1337%2Fannounce&tr=https%3A%2F%2Ftracker.bt4g.com%3A443%2Fannounce' |> url_extquery('tr') |> urls_tidy()
tracker_urls.3 = '
https://tracker.renfei.net:443/announce
http://share.camoe.cn:8080/announce
http://tracker.gbitt.info:80/announce
https://1337.abcvg.info:443/announce
https://tracker.tamersunion.org:443/announce
https://tracker.gbitt.info:443/announce
http://tracker.bt4g.com:2095/announce
http://open.acgnxtracker.com:80/announce
https://tracker.lilithraws.cf:443/announce
http://tracker.files.fm:6969/announce
udp://193.218.118.220:6969/announce
udp://tracker2.dler.org:80/announce
udp://p4p.arenabg.com:1337/announce
udp://tracker.moeking.me:6969/announce
udp://movies.zsw.ca:6969/announce
udp://tracker4.itzmx.com:2710/announce
udp://tracker1.itzmx.com:8080/announce
udp://exodus.desync.com:6969/announce
udp://open.stealth.si:80/announce
udp://tracker.opentrackr.org:1337/announce
udp://tracker.tiny-vps.com:6969/announce
udp://tracker1.bt.moack.co.kr:80/announce
udp://opentracker.i2p.rocks:6969/announce
udp://tracker.dler.org:6969/announce
udp://www.torrent.eu.org:451/announce
udp://daveking.com:6969/announce
udp://edu.uifr.ru:6969/announce
udp://tracker0.ufibox.com:6969/announce
udp://retracker.hotplug.ru:2710/announce
udp://vibe.community:6969/announce
udp://us-tracker.publictracker.xyz:6969/announce
udp://engplus.ru:6969/announce
udp://fe.dealclub.de:6969/announce
udp://ipv6.tracker.zerobytes.xyz:16661/announce
udp://mail.realliferpg.de:6969/announce
udp://mts.tvbit.co:6969/announce
udp://tracker.shkinev.me:6969/announce
udp://app.icon256.com:8000/announce
udp://inferno.demonoid.is:3391/announce
udp://peru.subventas.com:53/announce
udp://tracker.v6speed.org:6969/announce
udp://public.tracker.vraphim.com:6969/announce
udp://tracker.zerobytes.xyz:1337/announce
udp://valakas.rollo.dnsabr.com:2710/announce
udp://47.ip-51-68-199.eu:6969/announce
udp://tracker.internetwarriors.net:1337/announce
udp://opentor.org:2710/announce
udp://9.rarbg.to:2710/announce
udp://udp-tracker.shittyurl.org:6969/announce
udp://tracker.0x.tf:6969/announce
udp://discord.heihachi.pw:6969/announce
udp://tracker.beeimg.com:6969/announce
udp://tracker.birkenwald.de:6969/announce
udp://6rt.tace.ru:80/announce
udp://tracker.altrosky.nl:6969/announce
udp://cdn-1.gamecoast.org:6969/announce
udp://retracker.lanta-net.ru:2710/announce
udp://tracker.sigterm.xyz:6969/announce
udp://cdn-2.gamecoast.org:6969/announce
udp://line-net.ru:6969/announce
udp://free.publictracker.xyz:6969/announce
udp://vibe.sleepyinternetfun.xyz:1738/announce
udp://ln.mtahost.co:6969/announce
udp://tracker.uw0.xyz:6969/announce
udp://bubu.mapfactor.com:6969/announce
udp://thetracker.org:80/announce
udp://torrentclub.online:54123/announce
udp://9.rarbg.me:2710/announce
udp://tracker.e-utp.net:6969/announce
udp://ipv4.tracker.harry.lu:80/announce
udp://tracker.torrent.eu.org:451/announce
udp://open.demonii.com:1337/announce
http://tracker.ipv6tracker.ru:80/announce
http://ipv4announce.sktorrent.eu:6969/announce
http://torrentsmd.com:8080/announce
http://ns3107607.ip-54-36-126.eu:6969/announce
https://tracker.nitrix.me:443/announce
http://bt.3kb.xyz:80/announce
https://tracker.nanoha.org:443/announce
http://vps02.net.orel.ru:80/announce
udp://tracker3.itzmx.com:6961/announce
udp://37.235.174.46:2710/announce
udp://163.172.170.127:6969/announce
udp://51.15.40.114:80/announce
udp://46.148.18.250:2710/announce
udp://46.148.18.254:2710/announce
udp://51.68.34.33:6969/announce
udp://tracker.cyberia.is:6969/announce
udp://explodie.org:6969/announce
udp://51.81.46.170:6969/announce
udp://51.68.199.47:6969/announce
udp://5.206.49.194:6969/announce
udp://185.181.60.67:80/announce
udp://184.105.151.164:6969/announce
udp://181.43.17.35:1337/announce
udp://91.216.110.52:451/announce
udp://208.83.20.20:6969/announce
http://tr.cili001.com:8070/announce
http://tracker3.itzmx.com:6961/announce
http://tracker.trackerfix.com:80/announce
https://tracker.coalition.space:443/announce
https://tr.steins-gate.moe:2096/announce
http://www.wareztorrent.com:80/announce
https://tp.m-team.cc:443/announce.php
http://siambit.org:80/announce.php
https://tracker.sloppyta.co:443/announce
https://tracker.iriseden.eu:443/announce
http://milanesitracker.tekcities.com:80/announce
https://tracker.foreverpirates.co:443/announce
https://trakx.herokuapp.com:443/announce
http://tracker2.itzmx.com:6961/announce
https://w.wwwww.wtf:443/announce
http://54.37.106.164:80/announce
https://tr.ready4.icu:443/announce
https://bt.nfshost.com:443/announce
http://bt.okmp3.ru:2710/announce
https://www.wareztorrent.com:443/announce
https://tracker.parrotsec.org:443/announce
http://1337.abcvg.info:80/announce
https://www.wareztorrent.com:443/announc
https://torrents.linuxmint.com:443/announce.php
http://tracker.noobsubs.net:80/announce
http://t.nyaatracker.com:80/announce
https://tracker.bt-hash.com:443/announce
http://rt.tace.ru:80/announce
https://tracker.hama3.net:443/announce
udp://93.158.213.92:1337/announce
https://tracker.imgoingto.icu:443/announce
http://tracker.opentrackr.org:1337/announce
udp://9.rarbg.to:2800/announce
udp://tracker.justseed.it:1337/announce
udp://tracker.leechers-paradise.org:6969
https://tracker.fastdownload.xyz:443/announce
udp://tracker.zer0day.to:1337/announce
udp://tracker.leechers-paradise.org:6969/announce
udp://coppersurfer.tk:6969/announce' |> urls_flat('\n') |> urls_tidy()
tracker_urls.4 = 'magnet:?xt=urn:btih:TZ6CNLFH44VSARAUM3TOIPJ3ARPBB55G&dn=&tr=http%3A%2F%2F208.67.16.113%3A8000%2Fannounce&tr=udp%3A%2F%2F208.67.16.113%3A8000%2Fannounce&tr=http%3A%2F%2Ftracker.openbittorrent.com%3A80%2Fannounce&tr=http%3A%2F%2Ftracker.publicbt.com%3A80%2Fannounce&tr=http%3A%2F%2Ftracker.prq.to%2Fannounce&tr=http%3A%2F%2Fopen.nyaatorrents.info%3A6544%2Fannounce&tr=http%3A%2F%2Fopen.acgtracker.com%3A1096%2Fannounce&tr=http%3A%2F%2Fretracker.adminko.org%2Fannounce&tr=http%3A%2F%2Ftracker.xelion.fr%3A6969%2Fannounce&tr=http%3A%2F%2Fexodus.desync.com%3A6969%2Fannounce&tr=http%3A%2F%2Fopen.demonii.com%3A1337%2Fannounce&tr=http%3A%2F%2Ftracker.istole.it%2Fannounce&tr=http%3A%2F%2Ftracker.openbittorrent.com%2Fannounce&tr=http%3A%2F%2Ftracker.publicbt.com%2Fannounce&tr=http%3A%2F%2Fi.bandito.org%2Fannounce&tr=http%3A%2F%2Ftracker.anime-miako.to%3A6969%2Fannounce&tr=http%3A%2F%2Ftracker.nwps.ws%3A6969%2Fannounce' |> url_extquery('tr') |> urls_tidy()
tracker_urls.m = 'magnet:?xt=urn:btih:57b6da0706589a8454fee67bdd7766266d14c5fe&dn=ATID-535-uncensored-HD&ref=https://671cy.com/thread-504290-1-1.html&xl=3502069786&tr=http://sukebei.tracker.wf:8888/announce&tr=http://montreal.nyap2p.com:8080/announce&tr=http://tracker1.itzmx.com:8080/announce&tr=http://anidex.moe:6969/announce&tr=udp://101.43.174.230:6969/announce&tr=udp://kokodayo.site:6969/announce&tr=udp://106.14.254.164:6969/announce&tr=http://tracker.skyts.net:6969/announce&tr=https://tracker.jiesen.life:8443/announce&tr=http://tracker4.itzmx.com:8080/announce&tr=http://tracker.ali213.net:8000/announce&tr=http://bt.3dmgame.com:2710/announce&tr=http://bt.ali213.net:8080/announce&tr=udp://tracker.openbtba.com:6969/announce&tr=http://open.tracker.ink:6969/announce&tr=http://tracker.skyts.cn:6969/announce&tr=udp://tracker1.bt.moack.co.kr:80/announce&tr=udp://156.234.201.18:80/announce&tr=udp://172.105.235.127:6969/announce&tr=udp://laze.cc:6969/announce&tr=http://tracker.baltracker.net:3390/announce&tr=http://mediaclub.tv/announce&tr=udp://buddyfly.top:6969/announce&tr=udp://185.212.59.40:6969/announce&tr=http://fxtt.ru/announce&tr=http://212.6.3.67/announce&tr=http://tracker.theempire.bz:3110/announce&tr=http://torrentzilla.org/announce.php&tr=http://tracker.minglong.org:8080/announce&tr=udp://52.58.128.163:6969/announce&tr=udp://tracker.filemail.com:6969/announce&tr=https://tr.abir.ga/announce&tr=http://www.tvnihon.com:6969/announce&tr=udp://torrentclub.space:6969/announce&tr=udp://50.116.14.248:6969/announce&tr=http://tracker.gcvchp.com:2710/announce&tr=http://torrentsmd.com:8080/announce&tr=https://t.btcland.xyz/announce&tr=udp://smtp-relay.odysseylabel.com.au:6969/announce&tr=udp://167.172.199.173:6969/announce&tr=udp://tracker.army:6969/announce&tr=udp://tracker.torrent.eu.org:451/announce&tr=udp://91.216.110.53:451/announce&tr=udp://5.196.89.204:6969/announce&tr=udp://thouvenin.cloud:6969/announce&tr=udp://135.125.106.92:6969/announce&tr=udp://rep-art.ynh.fr:6969/announce&tr=udp://198.91.25.157:8000/announce&tr=udp://slicie.icon256.com:8000/announce&tr=udp://176.31.250.174:6969/announce&tr=udp://tamas3.ynh.fr:6969/announce&tr=udp://admin.videoenpoche.info:6969/announce&tr=udp://anidex.moe:6969/announce&tr=http://nyaa.tracker.wf:7777/announce&tr=udp://epider.me:6969/announce&tr=udp://51.68.174.87:6969/announce&tr=udp://bt.ktrackers.com:6666/announce&tr=http://finbytes.org/announce.php&tr=http://blackz.ro/announce.php&tr=udp://sugoi.pomf.se:80/announce&tr=udp://65.108.63.133:80/announce&tr=udp://tracker.pomf.se:80/announce&tr=udp://65.21.91.32:6969/announce&tr=udp://zecircle.xyz:6969/announce&tr=http://95.217.161.135/announce&tr=http://95.217.167.10:6969/announce&tr=http://tracker.mywaifu.best:6969/announce&tr=http://tracker.lelux.fi/announce&tr=udp://ipv4.tracker.harry.lu:80/announce&tr=udp://tracker.leech.ie:1337/announce&tr=udp://46.138.242.240:6969/announce&tr=udp://astrr.ru:6969/announce&tr=udp://uploads.gamecoast.net:6969/announce&tr=udp://185.102.219.163:6969/announce&tr=udp://199.217.118.72:6969/announce&tr=udp://bubu.mapfactor.com:6969/announce&tr=udp://tracker.swateam.org.uk:2710/announce&tr=udp://185.134.22.3:6969/announce&tr=udp://tracker.altrosky.nl:6969/announce&tr=udp://209.126.11.233:6969/announce&tr=udp://torrents.artixlinux.org:6969/announce&tr=udp://138.3.249.47:6969/announce&tr=udp://psyco.fr:6969/announce&tr=udp://37.187.95.112:6969/announce&tr=udp://93.158.213.92:1337/announce&tr=udp://tracker.theoks.net:6969/announce&tr=udp://209.141.59.16:6969/announce&tr=udp://tracker.tiny-vps.com:6969/announce&tr=udp://opentrackr.org:1337/announce&tr=udp://107.175.221.194:6969/announce&tr=udp://run-2.publictracker.xyz:6969/announce&tr=udp://103.122.21.50:6969/announce&tr=udp://download.nerocloud.me:6969/announce&tr=udp://208.83.20.20:6969/announce&tr=udp://exodus.desync.com:6969/announce&tr=udp://vibe.sleepyinternetfun.xyz:1738/announce&tr=udp://149.28.47.87:1738/announce&tr=udp://black-bird.ynh.fr:6969/announce&tr=http://tracker.opentrackr.org:1337/announce&tr=udp://82.65.115.10:6969/announce&tr=http://incine.ru:6969/announce&tr=http://144.76.118.107:6969/announce&tr=udp://192.81.211.104:6969/announce&tr=udp://tracker.tcp.exchange:6969/announce&tr=udp://tracker.btsync.gq:6969/announce&tr=udp://leefafa.tk:6969/announce&tr=udp://95.216.74.39:6969/announce&tr=udp://htz3.noho.st:6969/announce&tr=http://btracker.top:11451/announce&tr=udp://167.99.185.219:6969/announce&tr=udp://moonburrow.club:6969/announce&tr=http://www.megatorrents.kg/announce.php&tr=udp://89.36.216.8:6969/announce&tr=udp://6ahddutb1ucc3cp.ru:6969/announce&tr=udp://104.131.98.232:6969/announce&tr=udp://carr.codes:6969/announce&tr=udp://run.publictracker.xyz:6969/announce&tr=udp://193.37.214.12:6969/announce&tr=http://tracker.vraphim.com:6969/announce&tr=udp://f1sh.de:6969/announce&tr=udp://89.58.49.71:6969/announce&tr=udp://107.189.11.230:6969/announce&tr=udp://tracker.moeking.me:6969/announce&tr=udp://qtstm32fan.ru:6969/announce&tr=udp://185.106.94.80:6969/announce&tr=udp://pow7.com:80/announce&tr=udp://148.251.53.72:6969/announce&tr=udp://fe.dealclub.de:6969/announce&tr=udp://88.99.2.212:6969/announce&tr=udp://fh2.cmp-gaming.com:6969/announce&tr=udp://93.104.214.40:6969/announce&tr=udp://tracker.monitorit4.me:6969/announce&tr=udp://keke.re:6969/announce&tr=udp://134.122.65.89:6969/announce&tr=udp://51.15.79.209:6969/announce&tr=udp://tracker2.dler.com:80/announce&tr=udp://163.172.209.40:80/announce&tr=udp://tracker.breizh.pm:6969/announce&tr=http://tracker3.dler.org:2710/announce&tr=http://95.107.48.115/announce&tr=http://vps02.net.orel.ru/announce&tr=udp://aarsen.me:6969/announce&tr=http://big-boss-tracker.net/announce.php&tr=udp://5.188.6.45:6969/announce&tr=udp://public.publictracker.xyz:6969/announce&tr=udp://41.79.68.156:6969/announce&tr=udp://176.123.1.180:6969/announce&tr=udp://mirror.aptus.co.tz:6969/announce&tr=udp://mail.artixlinux.org:6969/announce&tr=udp://144.91.88.22:6969/announce&tr=udp://94.243.222.100:6969/announce&tr=http://tracker.dler.org:6969/announce&tr=udp://tracker.artixlinux.org:6969/announce&tr=udp://161.97.67.210:6969/announce&tr=udp://new-line.net:6969/announce&tr=udp://open.free-tracker.ga:6969/announce&tr=udp://194.53.137.231:6969/announce&tr=udp://51.158.144.42:6969/announce&tr=udp://198.100.149.66:6969/announce&tr=udp://movies.zsw.ca:6969/announce&tr=udp://185.181.60.155:80/announce&tr=udp://open.stealth.si:80/announce&tr=udp://89.208.105.58:6969/announce&tr=https://tracker.gbitt.info/announce&tr=udp://sanincode.com:6969/announce&tr=https://tr.fuckbitcoin.xyz/announce&tr=https://tracker.nanoha.org/announce&tr=udp://95.31.11.224:6969/announce&tr=https://tr.burnabyhighstar.com/announce&tr=https://tracker1.520.jp/announce&tr=https://tracker.foreverpirates.co/announce&tr=udp://tracker.opentrackr.org:1337/announce&tr=udp://explodie.org:6969/announce&tr=http://tracker.ipv6tracker.ru/announce&tr=udp://tracker.birkenwald.de:6969/announce&tr=http://tracker.bt4g.com:2095/announce&tr=http://tracker.files.fm:6969/announce&tr=udp://opentracker.i2p.rocks:6969/announce&tr=http://open.acgnxtracker.com/announce&tr=https://tracker.cyber-hub.net/announce&tr=https://tracker.lilithraws.cf/announce&tr=udp://tracker.bitsearch.to:1337/announce&tr=https://tr.abiir.top/announce&tr=http://ipv-6.tk:6969/announce&tr=http://open-v6.demonoid.ch:6969/announce&tr=udp://mail.zasaonsk.ga:6969/announce&tr=udp://tracker.joybomb.tw:6969/announce&tr=udp://tracker.jonaslsa.com:6969/announce&tr=udp://tracker.cubonegro.xyz:6969/announce&tr=udp://dns.xxtor.com:53/announce&tr=udp://tracker.skynetcloud.site:6969/announce&tr=udp://tracker.wellknownclub.net:8100/announce&tr=http://tracker4.itzmx.com:2710/announce&tr=https://tracker.lilithraws.org/announce&tr=udp://www.torrent.eu.org:451/announce&tr=http://t.acg.rip:6699/announce&tr=udp://tracker.blacksparrowmedia.net:6969/announce&tr=udp://open.publictracker.xyz:6969/announce&tr=udp://tracker.auctor.tv:6969/announce&tr=udp://static.54.161.216.95.clients.your-server.de:6969/announce&tr=udp://cpe-104-34-3-152.socal.res.rr.com:6969/announce&tr=udp://ipv6.tracker.harry.lu:80/announce&tr=http://t.overflow.biz:6969/announce&tr=http://bt.okmp3.ru:2710/announce&tr=udp://tracker.beeimg.com:6969/announce&tr=udp://bt1.archive.org:6969/announce&tr=udp://tracker.4.babico.name.tr:3131/announce&tr=udp://tracker.lelux.fi:6969/announce&tr=udp://v1046920.hosted-by-vdsina.ru:6969/announce&tr=https://t1.hloli.org/announce&tr=udp://tracker.cyberia.is:6969/announce&tr=udp://open.dstud.io:6969/announce&tr=udp://creative.7o7.cx:6969/announce&tr=udp://wepzone.net:6969/announce&tr=udp://cutscloud.duckdns.org:6969/announce&tr=udp://yahor.ftp.sh:6969/announce&tr=https://tracker2.ctix.cn/announce&tr=udp://jutone.com:6969/announce&tr=udp://bt2.archive.org:6969/announce&tr=http://t.nyaatracker.com/announce&tr=udp://tracker.srv00.com:6969/announce&tr=udp://open.4ever.tk:6969/announce&tr=udp://tracker-udp.gbitt.info:80/announce&tr=http://tracker.gbitt.info/announce&tr=udp://tracker6.lelux.fi:6969/announce&tr=http://tracker.vrpnet.org:6969/announce&tr=udp://tracker.dler.com:6969/announce&tr=udp://tracker.yangxiaoguozi.cn:6969/announce&tr=udp://tracker.pimpmyworld.to:6969/announce&tr=udp://ipv6.tracker.monitorit4.me:6969/announce&tr=https://tracker1.ctix.cn/announce&tr=udp://ben.kerbertools.xyz:6969/announce&tr=https://tracker.tamersunion.org/announce&tr=udp://94-227-232-84.access.telenet.be:6969/announce&tr=udp://admin.52ywp.com:6969/announce&tr=udp://ftp.pet:2710/announce&tr=http://li1406-230.members.linode.com:6969/announce&tr=udp://tracker.openbittorrent.com:6969/announce' |> url_extquery('tr') |> urls_tidy()
#: or :# tracker_urls.m = utils::readClipboard() |> url_extquery('tr') |> urls_tidy() #: after your copy. `clipr::read_clip()` also able to do that. :#


tracker_urls = 'magnet:?xt=urn:btih:f44ad2a3869895e376eb7b6974283fec72237821&dn=%E6%88%8F%E6%A2%A6%E5%B7%B4%E9%BB%8E%5B%E6%9C%AA%E5%89%AA%E5%88%87%E7%89%88%E7%AE%80%E7%B9%81%E4%B8%AD%E5%AD%97%5D.The.Dreamers.2003.UNCUT.BluRay.1080p.x264.DTS-NowYS&tr=udp%3A%2F%2Ftracker.opentrackr.org%3A1337%2Fannounce&tr=https%3A%2F%2Ftracker2.ctix.cn%3A443%2Fannounce&tr=https%3A%2F%2Ftracker1.520.jp%3A443%2Fannounce&tr=udp%3A%2F%2Fopentracker.i2p.rocks%3A6969%2Fannounce&tr=udp%3A%2F%2Ftracker.openbittorrent.com%3A6969%2Fannounce&tr=http%3A%2F%2Ftracker.openbittorrent.com%3A80%2Fannounce&tr=udp%3A%2F%2Fopen.demonii.com%3A1337%2Fannounce&tr=udp%3A%2F%2Fopen.stealth.si%3A80%2Fannounce&tr=udp%3A%2F%2Fexodus.desync.com%3A6969%2Fannounce&tr=udp%3A%2F%2Ftracker.torrent.eu.org%3A451%2Fannounce&tr=udp%3A%2F%2Ftracker.moeking.me%3A6969%2Fannounce&tr=udp%3A%2F%2Ftracker.bitsearch.to%3A1337%2Fannounce&tr=udp%3A%2F%2Fexplodie.org%3A6969%2Fannounce&tr=http%3A%2F%2Fbt.endpot.com%3A80%2Fannounce&tr=udp%3A%2F%2Ftracker.tiny-vps.com%3A6969%2Fannounce&tr=https%3A%2F%2Ftracker.tamersunion.org%3A443%2Fannounce&tr=udp%3A%2F%2Fuploads.gamecoast.net%3A6969%2Fannounce&tr=udp%3A%2F%2Ftracker2.dler.org%3A80%2Fannounce&tr=udp%3A%2F%2Ftracker1.bt.moack.co.kr%3A80%2Fannounce&tr=udp%3A%2F%2Ftracker.theoks.net%3A6969%2Fannounce&tr=https%3A%2F%2Ftracker.bt4g.com%3A443%2Fannounce' |> 
	url_extquery('tr') |> urls_tidy() |> 
	base::c(tracker_urls.1, tracker_urls.2) |> 
	base::c(tracker_urls.3, tracker_urls.4) |> 
	base::c(tracker_urls, tracker_urls.m) |> 
	urls_flat('\n') |> 
	urls_tidy(output_tidys = T)

tracker_urls |> 
	magnet_tr_append(
		hash = 'f44ad2a3869895e376eb7b6974283fec72237821', 
		display_name = '戏梦巴黎[未剪切版简繁中字].The.Dreamers.2003.UNCUT.BluRay.1080p.x264.DTS-NowYS', 
		trackers_output = F) |> 
	magrittr::'%T>%'(clipr::write_clip(.))
