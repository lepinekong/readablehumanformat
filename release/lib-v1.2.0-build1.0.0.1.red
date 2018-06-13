Red [
    Title: "ReAdABLE.Human.Format.lib.red"
    Description: {Presenting the ReAdABLE Human Format written in its own format for highly productive aspiring Writer}
    Build: 1.0.0.1
    History: [
        v1.0.0: {initial version}
        v1.1.0: {
            - added .code and .text sections (.text is same as content)
            - support multiple paragraphs with same labels
        }      
        v1.1.1: { added articles-types: [
                    Article
                    Book
                    Index
                    Summary               
                    Glossary
                    Tutorial
                    Memento
                    Troubleshooting
                    Troubleshooting
                    tip
                    Tips
                    How-to
                    How.to
                    Cheatsheet
                    Faq
                ]
        }
        v1.2.0: {Added utilities for workflow:
            - .copy-files
        }
    ]
    Todo: [
        FIX: {
            - code tabs are not well indented
        }

        FEATURE-REQUEST: {
            - Automatically push to Github
            - Automatically create categories folders on Github
            - Automatically create tags on Github
        }
    ]

    ReAdABLE-Human-Format: [
        {
            Article: [
                Title: "Title of the article"
                Sub-Title: {Sub-title of the article}
                Paragraphs: [ ; optional paragraph is supported out of paragraphs
                    Paragraph: [
                        .title: [
                            "Title for Paragraph P1"
                            .mandatory: yes
                        ] 
                        .content: {Content for Paragraph P1}
                        .text: {same as content}
                        .code: {code}
                        .image: http://optional.image-1.jpg
                        .text: {multiple text instances supported}
                    ]
                    Paragraph: [
                        .title: {anonymous paragraph with non-unique label}
                    ]
                    [
                        .title: {anonymous paragraph with no label}
                    ]
                ]
            ]   
        }
    ] 
]

;===========================================================================================
; PREAMBLE
;===========================================================================================

; loading library 
REMOTE-LIB: false

unless ((REMOTE-LIB = false) and (exists? lib: %.system.user.apps.authoring.library.red)) [
    print "Loading remote lib"
    do read https://gist.githubusercontent.com/lepinekong/7574892bfefe7e53e7bd4dd4759f30f8/raw/2dec6c1f92fe1834632d998ffb831539caa23d63/.github.lib.red
    github-url-entry: https://gist.github.com/lepinekong/7574892bfefe7e53e7bd4dd4759f30f8
    lib: get-github-url github-url-entry %.system.user.apps.authoring.library.red
]
do read lib

;launched script path (first one may be different from current executing script)
script-path: system/options/script

either none? script-path [
    short-filename: "ReAdABLE.Human.Format.red"
][
    short-filename: .get-short-filename/wo-extension script-path
]


;===========================================================================================
; DATA
;===========================================================================================

; don't forget to toggle word-wrap in VSCode

; if no article has been loaded
articles-types: [
    Article
    Articles
    Message
    Messages
    Book
    Books
    Index
    Indexes
    Summary
    Summaries
    Glossary
    Glossaries
    Tutorial
    Tutorials
    Memento
    Mementos
    Snippet
    Snippets
    Bookmark
    Bookmarks
    Journal
    Journals
    Bug
    Bugs
    Issue
    Issues
    Feature
    Features
    Troubleshooting
    Troubleshootings
    Tips
    How-To
    How-Tos
    Faq
    Faqs    
    Cheatsheet
    Cheatsheets
    Best-Practice
    Best-Practices
    Coding-Standard
    Coding-Standards
    Coding-Style
    Coding-Styles
]

article?: false
article?: false foreach article-type articles-types [
	if value? article-type [
		article?: true
		article: get in system/words article-type 
		break
	]
]

;if  ((not value? 'Article) and (not value? 'Tutorial)) [
if not article? [
    Article: [

        Title: "Presenting the ReAdABLE Human Format"
        Sub-Title: {written in its own format for highly productive Business Article or Software Documentation Writer
        }
        Mode: Anonymous-Paragraph-Support ; by default or choose No-Anonymous-Paragraph-Support

        Paragraphs: [

            P0: [
                .title: ""
                .content: {This is a continuously updated article, come back from time to time.
                }
            ]

            P1: [
                .title: {Goal of the ReAdABLE Human Format}
                .content: {
                    The **ReAdABLE Human Format** aims at **Agile Documentation** by making WRITING and READING document easier for End User and Developer alike, while allowing a high degree of flexibility. It is not an alternative to [JSON](https://www.json.org/) or [YAML](https://en.wikipedia.org/wiki/YAML) which are targeting machine automation. It's closer to [Markdown](https://daringfireball.net/projects/markdown/) simplicity for writer, while being even simpler (less code to memorize) and targeting larger goal than just outputting formatted document (we'll see that in a future article only). It can still embed markdown for convenient formatting, for example the JSON link above is written as:

                    ```                
                    [JSON](https://www.json.org/)
                    ```
                }
                .image: https://i.snag.gy/qfjICd.jpg
                
            ]        

            P2: [
                .title: {Origin: personal and professional hindrances}
                .content: {
                    As for any good idea (sorry, I forgot humility on this one !), it comes from a few personal and professional hindrances encountered by own self.
                    Lastly, I have written 2 tutorials on [Dev.to](https://dev.to/lepinekong/red-for-hopeless-programmers---part-ii-258) about [Redlang](http://red-lang.org) then I stopped because it took me too much time and energy to publish on that online platform (it's not specific to dev.to though, it is for any others like medium).

                    Also in professional environment these latest years I've been many times in a situation where I have to reverse the features of big applications due to lack of documentation spending entire  weeks on that task while having to multi-task on others - though I'm paid to do so, it eats consequent budget and you can multiply this loss by the number of people on that project - some I'm involved are as big as 10 to 30 millions euros though I'd managed only 1/4 to 1/3 of the whole. I realized that it is due to the huge productivity problem about writing them that it is for Project Manager, Business Analyst or Developer. In big corporations heavy software development is often outsourced so that it is  dangerous to have barely no documentation. From Knowledge Management viewpoint, especially in regulated industries like Banking, Insurance or  Pharmaceutical, this is even outlawed for certain types of projects.

                    Though you cannot revolutionize things by changing a big company methodology Corpus - often, if not all of it is in Microsoft Word format - it is possible to generate these latter from a more usable text format that won't harass business analyst or developer. Versioning and tracking documents will also become easier with widely spread standard tools (among developers: [Git](https://git-scm.com/)).

                    More generally, since I'm a child, I've always been obsessed with doing things easier because I'm just lazy! Paradoxically this push me to sometimes work hard to build the tools I need to achieve that goal.

                    To make a secret confession, I'm passionate about programming concepts and software development related to business process, but I hate coding because I have the same repulsion as Bret Victor - though he is a great programmer and creative mind, famous for his seminal presentation that you don't want to miss ["Inventing on principle"](https://vimeo.com/36579366), who says:             

                    >“It sounds weird, when I want to make a thing, especially when I want to create something in software, there’s this initial layer of disgust that I have to push through, where I’m not manipulating the thing that I want to make, I’m writing a bunch of text into a text editor.”
                    
                    >[(source: "Saving the world from code")](https://www.theatlantic.com/technology/archive/2017/09/saving-the-world-from-code/540393/)    
                
            }]

            P3: [
                .title: {Example: authoring a web article}
                .content: {
                    Concretely let's take a simple example of an author who are used to write dozens of articles each year, he can systematize the way he organize them with a structure such as:

                    ```
                    Article: [

                        Title: "Title of the article"
                        Sub-Title: {Sub-title of the article}
                        
                        Paragraphs: [

                            P1: [
                                .title: "Title for Paragraph P1"
                                .content: {Content for Paragraph P1}
                                .image: http://optional.image-1.jpg
                            ]
                            .
                            .
                            .
                            Pn: [
                                .title: "Title for Paragraph P1"
                                .content: {Content for Paragraph P1}
                                .image: http://optional.image-n.jpg
                            ]

                            Conclusion: [
                                .title: "Conclusion"
                                .content: {Content for Conclusion}
                            ]
                        ]
                        
                    ]
                    ```
                    I'm actually using this structure for writing the article you are reading now - eat your own dog's food.
                }
                .image: https://i.snag.gy/pADrP6.jpg
            ]

            P4: [
                .title: {An other example: a glossary structure}
                .content: {
                    An other example is a glossary structure below. My first attempt was to use Markdown before I realise it really sucks as it mixed presentation with content whereas the ReAdABLE format is pure content so that you can output any kind of presentation you need. 

                    ```
                    Git.Glossary: [

                        Repository: [
                            .definition: {
                                The purpose of Git is to manage a set of files, as they change over time. Git stores this information in a data structure called a repository.            
                            }
                            .note: {
                                A git repository contains, among other things, the following:

                                - A set of commit objects.
                                - A set of references to commit objects, called heads.
                            }
                            .see-also: [commit-object heads]
                            .references: [
                                https://www.sbf5.com/~cduan/technical/git/git-1.shtml
                            ]
                        ]

                        Commit-Object: [
                            .definition: {
                                A commit object contains three things:

                                - A set of files, reflecting the state of a project at a given point in time.
                                - References to parent commit objects.
                                - An SHA1 name, a 40-character string that uniquely identifies the commit object. The name is composed of a hash of relevant aspects of the commit, so identical commits will always have the same name.
                            } 
                            .see-also: [parent-commit-object]
                            .references: [
                                https://www.sbf5.com/~cduan/technical/git/git-1.shtml
                            ]        

                        ]
                    ]
                    ```
                }
                .image: https://i.snag.gy/lA4ed5.jpg
            ]

            P5: [
                .title: {Processing format to output markdown}
                .content: {
                    How to process such kind of structure to output markdown or word document? That's the other beauty of this format. It is based on a gem language called [Rebol](http://www.rebol.com/) invented by [Carl Sassenrath (known for being Amiga OS Architect)](https://en.wikipedia.org/wiki/Carl_Sassenrath) with a modernized version named [Red-lang](https://www.red-lang.org/). So it can be easily be processed. For the article structure above, without any special library, you can type this below the data using free [Visual Studio Code](https://code.visualstudio.com/) and [Red extension](https://marketplace.visualstudio.com/items?itemName=red-auto.red):

                    ```
                        ; - 1. Extract the children of Article's block by name (Title, Sub-Title, Paragraphs):

                            title: select Article to-set-word 'Title ; or using library: .select Article 'Title 
                            sub-title: select Article to-set-word 'Sub-Title
                            Paragraphs: select Article to-set-word 'Paragraphs ; -> [P1: [.title: ...] P2: [.title: ...]    

                        ; - 2. Transform Paragraphs block to Object:

                            oParagraphs: Object Paragraphs ; by converting into object we can use values-of to get-rid of labels Pi
                            Paragraphs-blocks: values-of oParagraphs ; -> [[.title: ...] [.title: ...]]

                        ; - 3. Iterate through Paragraphs-blocks:

                            foreach paragraph-block Paragraphs-blocks [

                                title: .select paragraph-block '.title
                                content: .select paragraph-block '.content 
                                image: .select paragraph-block '.image 

                            ]  
                    ```
            }
            .image: https://i.snag.gy/qYCBuP.jpg
            ]

            P6: [
                .title: {Example of a full app markdown converter}
                .content: {
                    If you want to test a full app which converts a list of VSCode Extensions to markdown which [demo is published on Medium](https://medium.com/@lepinekong/test-md-842c4a3bc6ec), just copy this [oneliner](https://gist.githubusercontent.com/lepinekong/a1b1bdff993fdfdb969e933eb14cd266/raw/8d08005efd8da8a267230d28aa9af5e0206e170a/install.red.and.run.script.with.powershell) in Powershell within any directory.
                }
            ]

            P7: [
                .title: {Processing in other programming languages}
                .content: {
                    What about processing in other programming languages? You don't even need to create a parser as there are binding for [Java, Android and .NET](https://github.com/red/red/tree/master/bridges) and natively C since the core is written in that language so that you can create a nodejs module to embed Red language.
                }
            ]

            Conclusion: [
                .title: {Conclusion}
                .content: {
                    This format has very little formalism to memorize so is easier to write or much more productive than JSON, YAML or even our beloved Markdown (just try the ReAdABLE Human Format, you'll really see!):

                    - Enclose Structures and Sub-Structures within Brackets 
                    - Each Structure can define as many fields as needed using the format

                    > Key: Value

                    - String value use `"` or `{}`, this latter accepts multiple-lines content including markdown

                    The source of this article in **ReAdABLE Human Format** is available at 
                    [https://gist.github.com/lepinekong/b59fa3e8d386dea1ebaa1a096488c542](https://gist.github.com/lepinekong/b59fa3e8d386dea1ebaa1a096488c542)

                    Just paste the content of .ReAdABLE.HumanFormat.deploy.ps1 in Powershell at:
                    https://gist.github.com/lepinekong/b59fa3e8d386dea1ebaa1a096488c542
                    It will install Red and the source of the Article, the markdown and a batch file to re-execute it.
                    
                }
            ]
        ]
    ]
]

;===========================================================================================
; SPIKE
;===========================================================================================
;to play with the format set .spike to true
.spike: false
if .spike [

    ; - 1. Extract the children of article by name:
    title: select Article to-set-word 'Title ; extract title from Article - if using library: .select Article 'Title 
    print title
    ;Sub-title: select Article to-set-word 'Sub-Title ; extract sub-title from Article
    ;print Sub-Title
    Paragraphs: select Article to-set-word 'Paragraphs ; extract all labels-and-paragraphs from Articles
    ;-> [P1: [.title: ...] P2: [.title: ...]  
    ;probe Paragraphs
    ;print length? Paragraphs
    ; - 2. Transform Paragraphs block to Object
    ; oParagraphs: Object Paragraphs ; convert paragraphs to object for easing extraction with values-of
    ; Paragraphs-blocks: values-of oParagraphs ; extract all paragraphs details with their labels
    ; ; -> [[.title: ...] [.title: ...]]
    ; probe Paragraphs-blocks
    ; print length? Paragraphs-blocks

    Paragraphs-Blocks: extract/index Paragraphs 2 2

    ; ; - 3. Iterate through Paragraphs-blocks
    ; foreach paragraph-block Paragraphs-blocks [

    ;     title: .select paragraph-block '.title ; select title from paragraph block (using library .select method)
    ;     content: .select paragraph-block '.content ; select content from paragraph block (using library .select method)
    ;     image: .select paragraph-block '.image ; select image from paragraph block (using library .select method)

    ; ]   

    forall Paragraphs-Blocks [
        Paragraph-Content: Paragraphs-Blocks/1
        forall Paragraph-Content [
            label: Paragraph-Content/1
            value: Paragraph-Content/2
            Paragraph-Content: next Paragraph-Content
        ]

    ]

]

;===========================================================================================
; PROGRAM
;===========================================================================================


.markdown-gen: function [ /input <=input-file /output =>output-file [file! url! string! unset!]][

    condition: (not value? 'article) and (not value? 'tutorial)  

    either (condition) [

        .default-input-file: %ReAdABLE.Human.Format.data.red
        .default-output-file: %ReAdABLE.Human.Format.md

        unless input [
            <=input-file: .default-input-file
        ]

        unless output [
            =>output-file: .default-output-file
        ]

        print ["reading" <=input-file "..."]
        do read <=input-file
    ][

    ]

    if not value? 'article [
        if value? 'Tutorial [
            System/words/Article: Tutorial
        ]
        
    ]  

    either output [
        =>output-file: .to-file =>output-file
    ][
        =>output-file: .to-file reduce [short-filename ".md"]
    ]


    if exists? =>output-file [
        delete =>output-file
        print ["deleting..." =>output-file]
    ]

    use ["global .emit you don't need to touch"][
        ; start cloning global .emit function
        spec: spec-of :.emit
        body: body-of :.emit

        ; attach body words meaning to same meaning as in local context of '=>output-file 
        bind body '=>output-file 

        emit: function spec body
        ; end cloning global .emit function
    ]
    use ["alert messages you can customize"][
        message-processing: function[][
            .do-events/no-wait ; this is just to make console run smoother 
            print "processing..."
            .do-events/no-wait            
        ]

        refresh-screen: function[][
            .do-events/no-wait 
        ]
    ]
    use ["generic formatting functions you can customize"][

        emit-title-level: function [.title .title-level][
            title: .title
            n: .title-level
            title: .replace/all title  "    " ""
            marker: copy ""
            repeat i n [append marker {#}]
            emit [newline marker { } title newline]  
        ]

        emit-title: function[.title][   
            unless none? .title [
                emit-title-level .title 1  
            ]         
        ]
        .title: :emit-title

        emit-sub-title: function[.title][

            unless none? .title [
                emit-title-level .title 2  
            ]

        ]
        .sub-title: :emit-sub-title

        emit-paragraph-title: function[.title][

            unless ((none? .title) or (.title = "")) [
                emit-title-level .title 3     
            ]      
        ]
        .paragraph-title: :emit-paragraph-title

        emit-image: function[image][

            if find image "https://imgur.com" [
                ; check extension if none add .png
                if not find image ".png" [
                    image: rejoin [image ".png"]
                ]
            ]
            unless none? image [
                emit [
                    {![} image {]}
                    {(} image {)
                    }
                ]
            ]            
        ]
        .image: :emit-image

        emit-content: function [content][
            content-block: copy []  
            either find content {```} [
                use [lines flag flag_line][
                    
                    lines: .read/lines content
                    flag: false
                    forall lines [
                        line: lines/1
                        i: index? lines
                        if find line {```} [
                            .replace/all line  "    " ""
                            flag: not flag; flag: false -> true
                            either flag [
                                line: rejoin [newline newline line]
                            ][
                                append line newline
                                append line newline
                            ]
                        ]
                        either flag = true [
                            .replace/all line  "                " ""
                            append line newline
                        ][
                            .replace/all line  "    " ""
                        ]
                        append content-block line                   
                    ]
                ]

                content: copy ""
                forall content-block [
                    i: index? content-block
                    n: length? content-block
                    
                    append content content-block/1
                    unless i = n [
                        unless find content newline [
                            append content newline
                        ]
                        
                    ]
                    
                ]
            ][
                content: .replace/all content  "    " ""
            ]
            emit content
        ]
        .content: :emit-content

        youtube?: function[url][

            either block? url [
                foreach element url [
                    try [
                        if find element "youtube.com" [
                            return true
                        ]                        
                    ]
                ]
            ][
                if find url "youtube.com" [
                    return true
                ]
            ]

            return false
        ]

        normalize-url-block: function[title-with-url][

            first-item: title-with-url/1
            either url? first-item [
                title: title-with-url/2
                url: title-with-url/1
            ][
                title: title-with-url/1
                url: title-with-url/2

                if issue? url [
                    url: rejoin [ (to-string url) (mold title-with-url/3)]
                ]
            ]   
            return reduce [title url]         
        ]

        emit-youtube: function[youtube-url-or-id [url! string! word! block!]][

            YOUTUBE_WIDTH: 560
            YOUTUBE_HEIGHT: 315

            YOUTUBE_EMBED_URL_PREFIX: https://www.youtube.com/embed/


            unless none? youtube-url-or-id [

                title: none

                either url? youtube-url-or-id [
                    youtube-url: youtube-url-or-id
                ][

                    either not block? youtube-url-or-id [
                        id: youtube-url-or-id
                        youtube-url: rejoin [YOUTUBE_EMBED_URL_PREFIX id]
                    ][
                        set [title youtube-url] normalize-url-block youtube-url-or-id


                    ]
                    
                ]
                
                either find youtube-url "/embed/" [
                    youtube-embed-url: youtube-url-or-id
                ][
                    parse youtube-url [
                        thru "v=" copy id to end
                    ]
                    youtube-embed-url: rejoin [YOUTUBE_EMBED_URL_PREFIX id]
                ]

                unless none? title [
                    emit [title]
                ]

                emit [
                    {<iframe width="} YOUTUBE_WIDTH {" height="} YOUTUBE_HEIGHT {" src="}
                    youtube-embed-url
                    {" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>}
                ]                
            ]
        ]
        .youtube: :emit-youtube               

        emit-link: function[
            url.or.title-with-url [url! file! path! block! none!] 
            /no-bullet
            /screen-copy
            ][

            if none? url.or.title-with-url [
                return false
            ]

            url: url.or.title-with-url
            title: url

            if block? url.or.title-with-url [

                url.or.title-with-url: normalize-url-block url.or.title-with-url

                set [title url] url.or.title-with-url

            ]

            unless none? url.or.title-with-url  [

                either not youtube? url [
                    bullet: ""
                    unless no-bullet [
                        bullet: "- "
                    ]

                    emit [
                        bullet
                        {[} title {]}
                        {(} url {)
                        }
                    ]
                ][
                    emit-youtube url
                ]
            ] 
            

        ]
        .link: :emit-link

        emit-links: function[links-collection][

            foreach [title url] links-collection [

                either not block? title [

                    either ((not url? title) and (not file? title)) [
                        url-block: reduce [title url]
                        emit-link url-block ; reduce will convert to block type
                    ][
                        emit-link title
                        emit-link url
                    ]
                    
                ][
                    emit-link title ; it's already a link block
                    emit-link url
                ]

            ]
        ]
        .links: :emit-links

    ]

;-------------------------------------------------------------------------

    {
        Article: [
            Title: "Title of the article"
            Sub-Title: {Sub-title of the article}
            Paragraphs: [
                P1: [
                    .title: "Title for Paragraph P1"
                    .content: {Content for Paragraph P1}
                    .image: http://optional.image-1.jpg
                ]
            ]
        ]   
    }    



    title: .select Article 'Title ; extract title from Article
    Sub-title: .select Article 'Sub-Title ; extract sub-title from Article
    Paragraphs: .select Article 'Paragraphs ; extract all paragraphs from Articles
    ;-> [P1: [.title: ...] P2: [.title: ...]

    if none? Paragraphs [
        Paragraphs: copy []
        forall Article [

            label: Article/1
            value: Article/2

            if block? value [
                if set-word? label [
                    append Paragraphs label
                    append/only Paragraphs value
                ]
            ]
        ]
    ]
    
    ; oParagraphs: Object Paragraphs ; convert paragraphs to object for easing extraction with values-of
    ; Paragraphs-blocks: values-of oParagraphs ; extract all paragraphs details without labels

    Paragraphs-Blocks: extract/index Paragraphs 2 2

    ; -> [[.title: ...] [.title: ...]]


;--------------------------------------------------------------------------
    message-processing ; this is for notifying user
;--------------------------------------------------------------------------
    .title title ; emit markdown for article's title

    .sub-title sub-title ; emit markdown for article's sub-title


    forall Paragraphs-Blocks [

        Paragraph-Content: Paragraphs-Blocks/1
        forall Paragraph-Content [

            refresh-screen

            label: Paragraph-Content/1
            value: Paragraph-Content/2

            if (form label) = ".title" [
                title: value
                .paragraph-title title ; emit markdown for paragraph title
            ]

            if (((form label) = ".text" ) or ((form label) = ".content" )) [
                content: value
                .content content ; emit markdown content with code block when any

            ]            

            if find (form label)  ".code" [

                code-markup: {```}
                if find (form label) "/" [
                    language: (pick (split (form label) "/") 2)
                    replace language ":" ""
                    code-markup: rejoin [code-markup language]
                ]               

                content: rejoin [
                    code-markup
                    newline 
                    value
                    newline
                    {```}
                ] 
                .content content ; emit markdown content with code block when any   
            ]


            if (form label) = ".image" [
                image: value
                .image image ; emit markdown for embedding image    
            ]

            if (((form label) = ".link" ) or ((form label) = ".url" )) [
                url: value

                either find (form label) "/" [
                    ;refinement: (pick (split (form label) "/") 2)
                    refinements: remove (split (form label) "/")
                    forall refinements [replace/all refinements/1 ":" ""]
                    
                ][
                    .link url ; emit markdown for link 
                ]
            
            ]  

            if (((form label) = ".links" ) or ((form label) = ".urls" )) [
                links-collection: value
                .links links-collection ; emit markdown for embedding image    
            ]                        

            if (form label) = ".youtube" [
                you-tube-url-or-id: value
                .youtube you-tube-url-or-id
            ]                        

            Paragraph-Content: next Paragraph-Content
        ]        

    ]

    print (.to-full-path =>output-file) ; print file output path for info
]
markdown-gen: :.markdown-gen

.copy-file: function[what-file to-file][
    write/binary to-file read/binary what-file
]

update-lib: function[][
    .copy-file %ReAdABLE.Human.Format.lib.red %../.github/lib.red
    .copy-file %ReAdABLE.Human.Format.lib.red %../.github/src/lib/ReAdABLE.Human.Format.lib.red
]

Update-lib-authoring: function[][
    .copy-file to-red-file 
        "C:\rebol\.system.user\.code\.domains\.apps\Authoring\libraries\.system.user.apps.authoring.library.red" 
        %../.github/authoring.lib.red
]

;Update-lib-authoring
update-lib

