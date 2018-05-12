Red [
    Title: "Github Custom Domain"
    File: github.custom.domain.red
    Output-files: [github.custom.domain.md]
    Categories: [Github]
    Tags: [Github "Custom Domain"]

    Dates: [
        Created: 2018-05-12 11:57:11
        Modified: [
            2018-05-12 11:57:15 -> 2018-05-12 12:30:59
            2018-05-12 14:30:31 -> 2018-05-12 14:34:35
        ]
        Generated: 2018-05-12 14:48:17
    ]
]

Tutorial: [

    Title: {Github Custom Domain}

    Source: [
        .title: {ReAdABLE Source:}
        .text: {[http://mymementos.space/github.custom.domain.red](https://github.com/lepinekong/mymementos/blob/master/github.custom.domain.red)}
        .Published-Url: http://mymementos.space/github.custom.domain 
    ]

    Step-1: [

        .title: {Step 1: Add custom domain to your Github Page}
        .text: {- Click on Settings under your Github Pages:
        }
        .image: https://imgur.com/yglTzwS

        .text: {- Add your custom domain:
        }
        .image: https://i.imgur.com/wCY2wVC.png

        .references: [
            https://help.github.com/articles/adding-or-removing-a-custom-domain-for-your-github-pages-site/
            https://help.github.com/articles/setting-up-an-apex-domain/
        ]
    ]

    Step-2: [

        .title: {Step 2: Modify your DNS Record}
        .text: {- Access your domain Console at your registrar and go to DNS Record, for example, for Namesilo click on Globe Icon:
        }
        .image: https://imgur.com/JMRAfM7

        .text: {- Add A records for Github using these IP addresses:}

        .code: {
                - 185.199.108.153

                - 185.199.109.153

                - 185.199.110.153

                - 185.199.111.153
        }
        .image: https://imgur.com/KlwKV3I
        .caption: "Namesilo DNS Record"
        .image: https://imgur.com/Prh0H0G
        .caption: "Namecheap DNS Record"

        .text: {- Change CNAME www target:
        }
        .image: https://imgur.com/xnkeyEE

        .references: [
            https://help.github.com/articles/setting-up-an-apex-domain/#configuring-an-alias-or-aname-record-with-your-dns-provider
            https://www.namesilo.com/CustomDomain/Github
            https://www.namecheap.com/support/knowledgebase/article.aspx/319/2237/how-can-i-set-up-an-a-address-record-for-my-domain
            https://www.namecheap.com/support/knowledgebase/article.aspx/9646/2237/how-can-i-set-up-a-cname-record-for-my-domain
        ]             
    ]

    Step-3: [
        .title: {Step 3: (Optional) migrate DNS to Cloudflare}
        .text: {TODO}

        .references: [
            https://www.jonathan-petitcolas.com/2017/01/13/using-https-with-custom-domain-name-on-github-pages.html
        ]
    ]
]

do read http://readablehumanformat.com/lib.red
markdown-gen
