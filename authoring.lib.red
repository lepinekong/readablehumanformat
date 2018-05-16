Red [
    Title: ".system.user.apps.authoring.library.red"
    Url: https://gist.github.com/lepinekong/7574892bfefe7e53e7bd4dd4759f30f8
    History: [
        v1.0: {initial version}
        V1.1: {+ .get-github-url}
        V1.1.1: {fixed bug .get-github-url}
        V1.2: {+ .to-json}
        v1.2.1: [{+ .get-file-extension} https://gist.githubusercontent.com/lepinekong/7574892bfefe7e53e7bd4dd4759f30f8/raw/96a7e9345212a7b24fabc643d380268d10235cdd/.system.user.apps.authoring.library.red]
        v2.0.0: {+ .copy-file}
    ]
]

->: .->: .=>: =>: ""

.use: func [locals [block!] body [block!]][
	do bind body make object! collect [
		forall locals [keep to set-word! locals/1]
		keep none
	]
]

use: :.use

.Config: func [spec [block!]][make object! spec]
Config: :.Config

.to-file: function [.file [file! string! word! block!]][

    either block? .file [
        return to-red-file rejoin .file
    ][
        return to-red-file form .file
    ]
    
]  

to-file: :.to-file

.to-dir:  function[.dir [word! string! file! url! block! unset!] /local ][

	{

        #### Example:
        - [x] [0]. to-dir %/c/test/ -> %/c/test/
        - [x] [1]. to-dir %/c/test -> %/c/test/
        - [X] [2]. to-dir c:\test -> %/c/test/

    }

    switch/default type?/word .dir [
        unset! [
            print {TODO:}
        ]
        file! [
            dir: :.dir
            if not dir? dir [
                append dir to-string "/"
                to-red-file dir            
            ]
            dir
        ]
        word! string! url! [
            dir: to-red-file to-string :.dir
            replace/all dir "//" "/"         
            to-dir (dir)
        ]
        block! [
            dir: .dir
            joined-dir: copy ""
            forall dir [
                append joined-dir rejoin [dir/1 "/"]
            ]
            repeat i 2 [replace/all joined-dir "//" "/"]
            to-red-file joined-dir
        ]
    ] [
        throw error 'script 'expect-arg varName
    ]
]

to-dir: :.to-dir

.switch: function [
    {Evaluates the first block following the value found in cases} 
    value [any-type!] "The value to match" 
    cases [block!] 
    case [block!] "Default block to evaluate"
][ 
    value: to-word value
    switch/default value cases case
] 

.type?: function [
    "Returns the datatype of a value" 
    value [any-type!] 
][
	type: type?/word get/any value
]

.cases: :.switch

.if: :either

.get-full-path: function[.path  [file! string! url!]][

    .cases .type? '.path [

        string! url! [
            path: to-red-file to-string .path
        ]
    ][
        path: .path
    ]

    clean-path path
]
.to-full-path: :.get-full-path

.request-file: function [/dir .default-dir][

    either dir [
        return request-file/file .default-dir
    ][
        return request-file/file what-dir
    ]
    
]

.get-short-filename: function[.filepath [file! url!] /wo-extension /without-extension][

    filepath: .filepath
    short-filename: (pick (split-path .filepath) 2)
    unless (without-extension or wo-extension) [
        return short-filename
    ]
    return (pick (.split-filename short-filename) 1)
    
]

get-short-filename: :.get-short-filename

.split-filename: function[.filename][

    {
        #### Example:
            .split-filename short-filename
    }
    ;example -> .filename: %/c/test/test.red
    filename: reverse copy .filename
    pos: index? find filename "."
    suffix: reverse (copy/part filename pos)
    short-filename: copy/part (reverse filename) ((length? filename) - (length? suffix))
    return reduce [short-filename suffix]
]

split-filename: :.split-filename

.get-file-extension: function[.filepath [file! url!]][
    short-filename: .get-short-filename .filepath 
    return pick (.split-filename short-filename) 2
]

get-file-extension: :.get-file-extension

.replace: function [
    series [series! none!] 
    pattern 
    value 
    /all 
][
    if error? try [
        either all [
            replace/all series pattern value
            return series
        ][
            replace series pattern value
            return series
        ]
        
    ][
        return none
    ]
]

.Read: function [
    "Reads from a file, URL, or other port" 
    source [file! url! string! unset!] 
    /part {Partial read a given number of units (source relative)} 
    length [number!] 
    /seek "Read from a specific position (source relative)" 
    index [number!] 
    /binary "Preserves contents exactly" 
    /clipboard "Read from clipboard"
    /lines "Convert to block of strings" 
    /info 
    /as {Read with the specified encoding, default is 'UTF-8} 
    encoding [word!]
    /local 
    source?
    out
][


    bin-to-string: function [bin [binary!]][
        text: make string! length? bin
        foreach byte bin [append text to char! byte]
        text
    ] 
    
    source?: true

    switch/default type?/word get/any 'source [
    unset! [
        if clipboard [
            source: read-clipboard
            source?: false
        ]
    ]
    url! [
        response: write/binary/info source [GET [User-Agent: "Red 0.6.3"]]
        out: bin-to-string response/3
    ]
    ][

        either lines [
            if (suffix? source) = %.zip [
                return ""
            ]
            switch/default (type?/word source) [
                file! url! [
                    out: sysRead/lines source
                ]
                string! [
                    out: split source newline
                ]
            ][
                out: sysRead/lines source
            ]
        ][
            ; prevent error when reading path not terminated with /
            if exists? source [
                if error? try [
                    out: sysRead source
                ][
                    if (last source) <> #"/" [
                        source: rejoin [source #"/"]
                        out: sysRead source
                    ]
                ]
            ]
        ] 
    ]

    either source? [
        either clipboard [
        ][
            out
        ]
    ][
        out
    ]
]

if not value? 'sysRead [
    sysRead: :Read
    Read: :.Read
]      


.Html.Read: function[url [file! url!]][

    exclude-urls: []
    exclude: 0

    foreach exclude-url exclude-urls [
        if find url exclude-url [
            exclude: 1
        ]
    ]

    either (exclude = 1) [
        return ""
    ][

        convert-invalid: function [page] [
            collect/into [foreach c page [keep to-char c]]  clear ""
        ]    

        if error? try [
            return .read url
        ][
            return convert-invalid url
        ]

        ]
]

Html.Read: :.Html.Read

.html.get-title: function[source][

    html-to-parse: .html.read to-url source

    rules: [thru {<title} thru {>} copy title to </title> to end]
    either parse html-to-parse rules [
        title: trim/head/tail title
        print title
        print [{from:} source]
        return title
    ][
        print [{no title found} {in} source]
        return none
    ]
]

html.get.title: :.html.get-title
html.get6title: :.html.get-title

.select: function [.block-spec [block!] .selector [word! string!]][
    selector: to-set-word form .selector
    block: .block-spec
    select block selector
]

.emit: function [.line [char! string! block! none!]][

    if none? .line [exit]

    either block? .line [
        line: rejoin .line
    ][
        line: .line
    ]
    write/lines/append =>output-file line
]

.get-github-url: function[.github-url [url!] .id [string! file!]][

    {description: get github url for ReAdABLE.Human.Format.red}

    either file? .id [
        id: rejoin ["file-" .id]
        replace/all id "." "-"
        replace/all id "--" "-"
        id: lowercase id
    ][
        id: .id
    ]

    github: read .github-url
    div-id: rejoin [{<div id="} id {" class="file">}]
    parse github [
        to div-id
        thru {href="} copy url to {">Raw</a>}
    ]
    url: to-url rejoin [https://gist.githubusercontent.com url]            
]

get-github-url: :.get-github-url

if not value? 'syswrite-clipboard [
    syswrite-clipboard: :write-clipboard
    write-clipboard: function [data [string! file! url!] /local filePath][
        if url? data [
            data: to-string data
        ]
        syswrite-clipboard data
    ]  
]     

.to-reAdABLE: function['.source [string! file! url! unset!]][

    if not value? 'load-json [
        github-url: https://gist.github.com/lepinekong/7574892bfefe7e53e7bd4dd4759f30f8
        remote-lib: .get-github-url github-url %.system.libraries.reAdABLE-json.red
        do read remote-lib
    ]

    switch type?/word get/any '.source [
    unset! [
        ask "copy json to clipboard then enter..."
        source: read-clipboard
        readable: load-json/flat source
        ask "ReAdable will be copied to clipboard..."
        write-clipboard mold readable
    ]
    file! [
        source: .read .source
    ]
    url![
        .source: form .source
        source: .read .source
    ]
    ]
    
    return load-json/flat source

] 

to-reAdABLE: :.to-reAdABLE

.to-json: function[.source [block! file! url!]][

    if not value? 'to-json [
        github-url: https://gist.github.com/lepinekong/7574892bfefe7e53e7bd4dd4759f30f8
        remote-lib: .get-github-url github-url %.system.libraries.reAdABLE-json.red
        print remote-lib
        do read remote-lib
    ]

    source: .source

    switch type?/word get/any '.source [
    file! [
        source: .read .source
    ]
    url![
        .source: form .source
        source: .read .source
    ]
    ]

    return to-json source    
]

.build-markup: func [
    {Return markup text replacing <%tags%> with their evaluated results.}
    content [string! file! url!]
    /bind obj [object!] "Object to bind"    ;ability to run in a local context
    /quiet "Do not show errors in the output."
    /local out eval value
][
    content: either string? content [copy content] [read content]
    out: make string! 126
    eval: func [val /local tmp] [
        either error? set/any 'tmp try [either bind [do system/words/bind load val obj] [do val]] [
            if not quiet [
                tmp: disarm :tmp
                append out reform ["***ERROR" tmp/id "in:" val]
            ]
        ] [
            if not unset? get/any 'tmp [append out :tmp]
        ]
    ]
    parse content [
        any [
            end break
            | "<%" [copy value to "%>" 2 skip | copy value to end] (eval value)
            | copy value [to "<%" | to end] (append out value)
        ]
    ]
    out
]

build-markup: :.build-markup

.string.expand: function[.string-template [string!] .block-vars[block!]][

    return build-markup/bind .string-template Context Compose .block-vars
]

string-expand: :.string.expand
.expand: :.string.expand


.Redlang.Get-Meta: function[.src [string! file! url!]][

    {Purpose: 
        Contrary to Interpreter,
        Red compiler doesn't play well with all text above Red [] 
        so we must clean all above Red [...] before compiling
    }

    ; accept:
    ; c:\test\test.red ; windows format without space
    ; "c:\test with space\test.red" ; windows format
    ; %/c/test/test.red ; red file format
    case [
        string! = type? .src [src: .src]
        (file! = type? .src) or (url! = type? .src) [
            .src: to-red-file form .src
            src: read .src
        ]
    ]

    ; Extract Red meta
    rule-meta: [
        copy meta to "Red ["
    ]   
        
    parse src rule-meta  
    return meta    
]

Redlang.Get-Meta: :.Redlang.Get-Meta

.Redlang.Get-Body: function[.src [string! file! url!]][

    {Purpose: 
        Contrary to Interpreter,
        Red compiler doesn't play well with all text above Red [] 
        so we must clean all above Red [...] before compiling
    }

    ; accept:
    ; c:\test\test.red ; windows format without space
    ; "c:\test with space\test.red" ; windows format
    ; %/c/test/test.red ; red file format
    case [
        string! = type? .src [src: .src]
        (file! = type? .src) or (url! = type? .src) [
            .src: to-red-file form .src
            src: read .src
        ]
    ]

    ; Extract Red body
    rule-body: [
        any [
            to "Red [" start: thru "Red ["
        ] to end
        (body: copy start)
    ]
    parse src rule-body
    return body    
]

Redlang.Get-Body: :.Redlang.Get-Body

.do-trace: function [.line-number [integer!] '.block [word! block! unset!] .file [file! url! string!]
/filter that-contains [string! file! url!]
][

	{

        #### Example:
        - [x] [1]. 
        
```
        f: function [.file .argument][
            do-trace 2 [
                probe .argument
            ] .file
        ]
        f %test-this-file.red "test this file"
```

        - [x] [2]. 
        
```
        g: function [.file .argument][
            do-trace/filter 2 [
                probe .argument
            ] .file "test" 
        ]
        g %this-should-not-be-traced.red "this file should not be traced"

```


    }

    file: form .file
    if filter [
            either not find file that-contains [exit][
        ]
    ]

    switch type?/word get/any '.block [
        unset! [
            print {TODO:}
        ]
        block! [

            .do-events/no-wait
            print  [file "line" .line-number ": "]
            .do-events/no-wait
            do :.block
            ask "pause..."
        ]
    ]

]

do-trace: :.do-trace

.guiconsole?: not (system/console = none)


.do-events: function [
    
	{Launch the event loop, blocks until all windows are closed} 
	/no-wait "Process an event in the queue and returns at once" 
	return: [logic! word!] "Returned value from last event" 
	/local result 
	win
][
    try [
        either no-wait [
            do-events/no-wait
        ][
            do-events
        ]
    ]
] 

f:  function['.sub-folder [word! string! file! url! block! unset!] /local ][
    switch/default type?/word get/any '.sub-folder [
        unset! [
            print {TODO:}
        ]
        word! string! file! url! block! [
            .sub-folder: form .sub-folder
            print {TODO:}
        ]
    ] [
        throw error 'script 'expect-arg .sub-folder
    ]
]


.copy-file: function[ .what-files [file! block!]
    /target-folder .target-folder 
    /github '.sub-folder [word! file! path! url! unset!]; same as none target-folder
    ; .target-folder will be first .github folder encountered in parent folders
    ; .sub-folder is optional
    /target-file .target-file
    ][

    copy-file: function[.what-file][
        what-file: .what-file
        filename: .get-short-filename what-file

        either (github or not target-folder) [

            if github [

                print "github"
                probe (type?/word get/any '.sub-folder)
                ask "pause"

                switch type?/word get/any '.sub-folder [
                    unset! [
                        print "unset"
                    ]
                    word! path! url! file! [
                        .sub-folder: form .sub-folder
                        ?? .sub-folder
                    ]
                ]
            ]

            get-target-folder: function[path][

                files: read path

                folders: find files %.github/

                either folders [
                    target-folder: .to-file rejoin [path folders/1]
                    return target-folder
                ][
                    unless (clean-path path) = %/ [
                        path: to-red-file rejoin [path "../"]
                        get-target-folder path
                    ]
                ]
            ]

            path: %./
            target-folder: get-target-folder path
            
        ][
            target-folder: .target-folder
        ]

        target-file: clean-path .to-file rejoin [target-folder filename]

        print ["Copying" what-file "to" target-file]
        write/binary target-file read/binary what-file        
    ]


    either block? .what-files [
        forall .what-files [
            copy-file .what-files/1
        ]
    ][
        copy-file .what-files
    ]
]


