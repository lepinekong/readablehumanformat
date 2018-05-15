
# Presenting the ReAdABLE Human Format


## written in its own format for highly productive Business Article or Software Documentation Writer


This is a continuously updated article, come back from time to time. 
WARNING: Version 2.0 will be coming soon and be simpler and richer at the same time.


### Goal of the ReAdABLE Human Format


The **ReAdABLE Human Format** aims at **Agile Documentation** by making WRITING and READING document easier for End User and Developer alike, while allowing a high degree of flexibility. 

Its primary goal is to generate [Markdown](https://daringfireball.net/projects/markdown/) (and conversion to other formats in the future) while being even simpler (less code to memorize) and richer (adding meta-data is straightforward and creating new semantics is easy).

It can still embed markdown for convenient formatting, for example the JSON link above is written as:

```
[JSON](https://www.json.org/)
```

Note that it is not an alternative to [JSON](https://www.json.org/) or [YAML](https://en.wikipedia.org/wiki/YAML) which are targeting machine automation. 
![https://i.snag.gy/qfjICd.jpg](https://i.snag.gy/qfjICd.jpg)
                    

### Origin: personal and professional hindrances


As for any good idea (sorry, I forgot humility on this one !), it comes from a few personal and professional hindrances encountered by own self.
Lastly, I have written 2 tutorials on [Dev.to](https://dev.to/lepinekong/red-for-hopeless-programmers---part-ii-258) about [Redlang](http://red-lang.org) then I stopped because it took me too much time and energy to publish on that online platform (it's not specific to dev.to though, it is for any others like medium).

Also in professional environment these latest years I've been many times in a situation where I have to reverse the features of big applications due to lack of documentation spending entire  weeks on that task while having to multi-task on others - though I'm paid to do so, it eats consequent budget and you can multiply this loss by the number of people on that project - some I'm involved are as big as 10 to 30 millions euros though I'd managed only 1/4 to 1/3 of the whole. I realized that it is due to the huge productivity problem about writing them that it is for Project Manager, Business Analyst or Developer. In big corporations heavy software development is often outsourced so that it is  dangerous to have barely no documentation. From Knowledge Management viewpoint, especially in regulated industries like Banking, Insurance or  Pharmaceutical, this is even outlawed for certain types of projects.

Though you cannot revolutionize things by changing a big company methodology Corpus - often, if not all of it is in Microsoft Word format - it is possible to generate these latter from a more usable text format that won't harass business analyst or developer. Versioning and tracking documents will also become easier with widely spread standard tools (among developers: [Git](https://git-scm.com/)).

More generally, since I'm a child, I've always been obsessed with doing things easier because I'm just lazy! Paradoxically this push me to sometimes work hard to build the tools I need to achieve that goal.

To make a secret confession, I'm passionate about programming concepts and software development related to business process, but I hate coding because I have the same repulsion as Bret Victor - though he is a great programmer and creative mind, famous for his seminal presentation that you don't want to miss ["Inventing on principle"](https://vimeo.com/36579366), who says: 

>“It sounds weird, when I want to make a thing, especially when I want to create something in software, there’s this initial layer of disgust that I have to push through, where I’m not manipulating the thing that I want to make, I’m writing a bunch of text into a text editor.”

>[(source: "Saving the world from code")](https://www.theatlantic.com/technology/archive/2017/09/saving-the-world-from-code/540393/)



### Example: authoring a web article


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
![https://i.snag.gy/pADrP6.jpg](https://i.snag.gy/pADrP6.jpg)
                    

### An other example: a glossary structure


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


![https://i.snag.gy/lA4ed5.jpg](https://i.snag.gy/lA4ed5.jpg)
                    

### Processing format to output markdown


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


![https://i.snag.gy/qYCBuP.jpg](https://i.snag.gy/qYCBuP.jpg)
                    

### Example of a full app markdown converter


If you want to test a full app which converts a list of VSCode Extensions to markdown which [demo is published on Medium](https://medium.com/@lepinekong/test-md-842c4a3bc6ec), just copy this [oneliner](https://gist.githubusercontent.com/lepinekong/a1b1bdff993fdfdb969e933eb14cd266/raw/8d08005efd8da8a267230d28aa9af5e0206e170a/install.red.and.run.script.with.powershell) in Powershell within any directory.


### Processing in other programming languages


What about processing in other programming languages? You don't even need to create a parser as there are binding for [Java, Android and .NET](https://github.com/red/red/tree/master/bridges) and natively C since the core is written in that language so that you can create a nodejs module to embed Red language.


### Conclusion


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


