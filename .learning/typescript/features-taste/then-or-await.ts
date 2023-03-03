
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
      
