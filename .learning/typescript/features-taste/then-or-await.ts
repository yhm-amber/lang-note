
// then:

const pick_webhtml =
    (webmessage: {sitehost: string, mainpath: string, picker: (d: Document, p: string) => string })
    : Promise<string> => 
    {
        const pick_perhtml =
            (msg: {path: string, host: string, picker: (d: Document, p: string) => string})
            : Promise<string> =>
                fetch(`https://${msg.host}/${msg.path}`)
                    .then
                    ( 
                        response => response.text()
                        , reject => 
                            `<!-- [ERROR]: fetch 'https://${msg.host}/${msg.path}' got reject: ${reject} -->`
                    )
                    .then(t => (new DOMParser()).parseFromString(t,"text/html"))
                    .then(document => msg.picker(document,msg.path) )
                    .catch(err => `<!-- [FAILED]: job on 'https://${msg.host}/${msg.path}' failed: ${err} -->`)
        
        return fetch(`https://${webmessage.sitehost}/${webmessage.mainpath}`)
            .then(r => r.text())
            .then(t => (new DOMParser()).parseFromString(t,"text/html"))
            .then
            (htmldom => 
                Array.from( htmldom.getElementsByClassName("reference internal") )
                    .map(elem => `${webmessage.mainpath}/${elem.getAttribute("href") ?? ""}`)
                    .map(pathper => {return {path: pathper, host: webmessage.sitehost, picker: webmessage.picker}})
                    .map(msgper => pick_perhtml(msgper))
            )
            .then(htmparts_promising => Promise.all(htmparts_promising) )
            .then(htmparts => htmparts.reduce((x,y) => x+y))
    } ;

// await

const pick_webhtml =
    async (webmessage: {sitehost: string, mainpath: string, picker: (d: Document, p: string) => string })
    : Promise<string> => 
    {
        const pick_perhtml =
            (msg: {path: string, host: string, picker: (d: Document, p: string) => string})
            : Promise<string> =>
                fetch(`https://${msg.host}/${msg.path}`)
                    .then
                    ( 
                        response => response.text()
                        , reject => 
                            `<!-- [ERROR]: fetch 'https://${msg.host}/${msg.path}' got reject: ${reject} -->`
                    )
                    .then(t => (new DOMParser()).parseFromString(t,"text/html"))
                    .then(document => msg.picker(document,msg.path) )
                    .catch(err => `<!-- [FAILED]: job on 'https://${msg.host}/${msg.path}' failed: ${err} -->`)
        
        const response = await fetch(`https://${webmessage.sitehost}/${webmessage.mainpath}`) ;
        const webhtml = await response.text() ;
        const htmldom = (new DOMParser()).parseFromString(webhtml,"text/html") ;
        const htmparts_promising = 
            Array.from(htmldom.getElementsByClassName("reference internal"))
                .map(elem => `${webmessage.mainpath}/${elem.getAttribute("href")??""}`)
                .map(pathper => { return { path: pathper,host: webmessage.sitehost,picker: webmessage.picker }; })
                .map(msgper => pick_perhtml(msgper)) ;
        const htmparts = await Promise.all(htmparts_promising) ;
        const result = htmparts.reduce((x,y) => x+y) ;
        return result ;
    } ;

// but i need this ...

const pick_webhtml =
    (webmessage: {sitehost: string, mainpath: string, picker: (d: Document, p: string) => string })
    : Promise<string> => 
    {
        const pick_perhtml =
            (msg: {per_path: string, main_hostpath: string, picker: (d: Document, p: string) => string})
            : Promise<string> =>
                fetch(`https://${msg.main_hostpath}/${msg.per_path}`)
                    .then
                    ( response => response.text()
                    , reject => `<!-- [ERROR] :pick_perhtml: fetch 'https://${msg.main_hostpath}/${msg.per_path}' got reject: ${reject} -->`
                    )
                    .then(t => (new DOMParser()).parseFromString(t,"text/html"))
                    .then(document => msg.picker(document,msg.per_path) )
                    .catch(err => `<!-- [FAILED] :pick_perhtml: job on 'https://${msg.main_hostpath}/${msg.per_path}' failed: ${err} -->`)
        
        return fetch(`https://${webmessage.sitehost}/${webmessage.mainpath}`)
            .then
            ( response => response.text()
            , reject => `<!-- [ERROR] :pick_webhtml: fetch 'https://${webmessage.sitehost}/${webmessage.mainpath}' got reject: ${reject} -->` 
            )
            .then(t => (new DOMParser()).parseFromString(t,"text/html"))
            .then
            ( htmldom => 
                Array.from( htmldom.getElementsByClassName("reference internal") )
                    .map(elem => `${webmessage.mainpath}/${elem.getAttribute("href") ?? ""}`)
                    .map(pathper => {return {per_path: pathper, main_hostpath: `${webmessage.sitehost}`, picker: webmessage.picker}})
                    .map(msgper => pick_perhtml(msgper))
            )
            .then(htmparts_promising => Promise.all(htmparts_promising) )
            .then(htmparts => htmparts.reduce((x,y) => x+y))
            .catch(err => `<!-- [FAILED] :pick_webhtml: job on 'https://${webmessage.sitehost}/${webmessage.mainpath}' failed: ${err} -->`)
    } ;

// 🙃


// by normal, things in Promise cannot be used out of it.
// but, you can use this :

interface AsyncRes<T>
{
    is_complete: boolean ;
    res?: T ;
    err?: any ;
} ;

const run_async = 
    <T,> (promising: Promise<T> | PromiseLike<T>)
    : AsyncRes<T> =>
    {
        const result: AsyncRes<T> = {is_complete: false} ;
        promising
            .then
            ( res => 
            {
                result.res = res ;
                result.is_complete = true ; }
            , (err: any) => 
            {
                result.err = err ;
                result.is_complete = true ; }
            )
        
        return result ;
    } ;

const async_res = run_async(picking) ;


const iid = setInterval
((): void =>
{
    if (async_res.is_complete)
    {
        clearInterval(iid) ;
        if (async_res.err)
        { console.log (`[err]: ${async_res.err}`) }
        { console.log (`[res]: ${async_res.res}`) } ;
    }
}, 100)

// known this by gpt ai: https://chatgpt.icloudnative.io/#/chat/1677822819602

