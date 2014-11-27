# Finding needles in haystacks (TODO)

Regexes are especially helpful in finding an answer that you don't really know, but you'll know it when you see it.

For example, dates and quantities. With some cleverness, you can choose to find dates in a certain range. 

And you can do this without any programming.

In investigative work, this tool is incredibly useful, possibly the most useful 

* Find extremely long words
* Find extremely long words that are not pronouns
* Certain dates, ranges
* 


## Shakespeare's longest word  

In his collected works, the bard wrote more than TK words. Which of them was his longest?

Let's think about what we don't know:

We don't know the actual word (duh) 
We don't know how long the longest word is

Here's what we do know:

We know that the longest word is probably longer than 15 characters

And, more to the point:

We know the regex for finding a string of word-characters 15 characters or more:

    \w{15,}

Searching for this pattern across the entirety of Shakespeare's *ouvre*, we'll find more than 80 matches. Not bad. We can manually eyeball each word and get our answer in a minute.

But why even waste a minute? Let's just increase the threshold from 15 to 20:

    \w{20,}

There is only one word that passes the threshold:

    honorificabilitudinitatibus

The context:

> COSTARD. O, they have liv'd long on the alms-basket of words. I marvel thy master hath not eaten thee for a word, for thou are not so long by the head as **honorificabilitudinitatibus**; thou art easier swallowed than a flap-dragon.   


### Hyphenation and punctuation

In the paragraph above, we see the shortcomings of our simple pattern: the `\w` group would not match a word such as `liv'd` because of the apostrophe. Nor would it match words that are hyphenated.

So let's modify our original pattern and see if there are any long compound words:

    \b[a-zA-Z'\-]{20,}

This pattern matches about a dozen compound words:
    
    tragical-comical-historical-pastoral
    one-trunk-inheriting
    to-and-fro-conflicting
    wholesome-profitable
    obligation-'Armigero
    Castalion-King-Urinal
    death-counterfeiting
    candle-wasters--bring
    six-or-seven-times-honour'd
    water-flies-diminutives
    that-way-accomplish'd


### Longest proper noun

One of my favorite uses for regexes is to find names of people in large sets of documents. There are fancy libraries for this, natural language processing.

But sometimes I just need a quick look-see. And this is my strategy:

    Proper nouns begin with capital letters.

OK, I'm not going to win any literacy awards with that definition. But it works.

Let's see how it does with Shakespeare. We'll try to find the longest name and


### Longest character name



### longest pronoun


Castalion-King-Urinal
\b[A-Z][a-zA-Z'\-]{19,}


