# Regular Expressions are for Everyone

{#intro}
W>## A pre-release warning
W>
W> What you're currently reading is a very alpha release of the book. I still have plenty of work in terms of writing all the content, polishing, and fact-checking it.
W>
W> You're free to download it as I work on it. Just don't expect perfection.
W>
W>This is my first time using [Leanpub](http://leanpub.com), so I'm still trying to get the hang of its particular dialect of Markdown. At the same time, I know people want to know the general direction of the book. So rather than wait until the book is even reasonably polished, I'm just hitting "Publish" as I go. 
W>
W> Also, you can visit this book's repo at [Github](//github.com/bastards/regexes) as of November 2014


----

The shorthand term for regular expressions, "*regexes*," is about the closest to sexy that this mini-language gets.

Which is too bad, because if I could start my programming career over, I would begin it by learning regular expressions, rather than ignoring it because it was in the optional chapter of my computer science text book. It would've saved me a lot of mind-numbing typing throughout the years. I don't even want to think about all the cool data projects I didn't even attempt because they seemed unmanageable, yet would've been made easy with basic regex knowledge.

Maybe by devoting an entire mini-book to the subject, that alone might convince people, "hey, this subject could be useful." 

But you don't have to be a programmer to benefit from knowing about regular expressions. If you have a job that deals with text-files, spreadsheets, data, writing, or webpages &ndash; which, in my estimation, covers *most* jobs involving a desk and computer &ndash; then you'll find *some* use for regular expressions. And you don't need anything fancy, other than your choice of freely-available text editors.

At worst, you'll have a find-and-replace-like tool that will occasionally save you minutes or hours of monotonous typing and typo-fixing. 

But my hope is that after reading this short manual, you'll not only have that handy tool, but you'll get a greater insight into the patterns that make data *data*, whether the end product is a spreadsheet or a webpage.


## FAQ

### Who is the intended audience?

I claim that "regular expressions are for anyone," but in reality, only those who deal with a lot of text will find an everyday use for them.

But by "text," I include datasets (including spreadsheets and databases) and HTML/CSS files. It goes without saying that programmers need to know regexes. But web developers/designers, data analysts, and researchers can also reap the benefits. For this reason, I'm devoting several of the higher-level chapters in this book for demonstrating those use-cases.

### How technical is this book?

This book aims to reach people who've never installed a separate text editor (outside of Microsoft Word). In order to reduce the intimidation factor, I do not even come close to presenting an exhaustive reference of the regular expression syntax.

Instead, I focus mostly on the regexes I use on a daily basis. I don't get into the details of how the regex engine works under the hood, but I try to explain the logic behind the different pieces of an expression, and how they combine to form a high-level solution. 

### How hard are regexes compared to learning programming? Or HTML?

Incredibly complex regexes can be formed by, more or less, dumbly combining basic building blocks. So the "hard part" is memorizing the conventions. 

Memorization isn't fun, but you can print out a cheat sheet (*note: will create one for this book's appendix*) of the syntax. The important part is to be able to describe in plain English *what you want to do*: then it's just a matter of glancing at that cheat sheet to find the symbols you need.

For that reason, this book puts a lot of emphasis on describing problems and solutions in plain, conversational English. The actual symbols are just a detail.

### How soon will my knowledge of regular expressions go obselete?

The theory behind regular expressions is as old as [modern computing](http://en.wikipedia.org/wiki/Regular_expression). It represents a formal way to describe patterns and structures in text. In other words, it's not a fad that will go away, not as long as we have language.

You don't need to be a programmer to use them, but if you do get into programming, every modern language has an implementation of regexes, as they are incredibly useful for virtually any application you can imagine.

The main caveat is that each language &ndash; Javascript, Ruby, Perl, .NET &ndash; has small variations. This book, however, focuses on the general uses of regexes that are more or less universal across all the major languages. (I'll be honest: I can't even remember the differences among regex flavors, because it's rarely an issue in daily usage). 


### What special program will I need to use regexes?

You'll need a text editor that supports regular expressions. Nearly all text-editors that are aimed towards coders support regular expressions. In the first chapter, I list the free (and powerful) text editors for all the major operating systems.

Beyond understanding the syntax, actually *using* the regular expressions requires nothing more than doing a **Find-and-Replace** in the text editor, with the "use regular expressions" checkbox checked.

### What are the actual uses of regular expression?

Because regexes are as easy as **Find-and-Replace**, the first chapters of this book will show how regexes can be used to replace *patterns* of text: for example, converting a list of dates in `MM/DD/YYYY` format to `YYYY-MM-DD`. Later on, we'll show how this pattern-matching power can be used to turn unstructured blocks of text into usable spreadsheet data, and how to turn spreadsheet data into webpages.


I have hopes that by the end of this book, regexes will become a sort of "gateway drug" for you to seek out even better, more powerful ways to explore the data and information in your life. The exercises in this book can teach you how to find needles in a haystack &ndash; a name, a range of dates, a range of currency amounts, amid a dense text. But once you've done that, why settle for searching one haystack &ndash; a document, in this case &ndash; when you could apply your regex knowledge to search thousands or millions of haystacks?

Regular expressions, for all their convoluted sea-of-symbols syntax, are just *patterns*. Learning them is a small but non-trivial step toward realizing how much of our knowledge and experience is captured in patterns. And how, knowing these patterns, we can improve the way we sort and filter the information in our lives.



----

*This book is a spinoff of the Bastards Book of Ruby, which devoted an [awkwardly-long chapter to the subject](http://ruby.bastardsbook.com/chapters/regexes/). You can get a preview of what this book will cover by checking out that [(unfinished) chapter](http://ruby.bastardsbook.com/chapters/regexes/).* 

*If you have any questions, feel free to mail me at [dan@danwin.com](mailto:dan@danwin.com)*

- Dan Nguyen @[dancow](https://twitter.com/dancow), [danwin.com](http://danwin.com)


