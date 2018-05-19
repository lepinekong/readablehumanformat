Red [
    Title: "index.red"
]

Article: [

    Title: "Welcome to ReAdABLE Human Format"

    List: [

        .title: {Presenting the ReAdABLE Human Format}
        .links: [
            "Presenting the ReAdABLE Human Format" %./readablehumanformat
        ]

    ]

    Examples: [

        .title: {Examples:}
        .links: [
            {Template Kit with Guidance: "How To Write Good Articles"} %./examples/howtowritegoodarticle
            {Memento with .code markup: "Github Custom Domain"} http://mymementos.space/github.custom.domain
        ]

    ]

    French-Examples: [
        .title: {French Examples:}
        .links: [
            "Comment avoir 18/20 au Bac de Français quand on est plutôt un(e) matheux(se)" "#"
        ]
    ]

]

do read http://readablehumanformat.com/lib.red

markdown-gen

