# Moving forward

Thank you for taking the time to read this book and congrats if you managed to finish it without cursing me or regexes too much. If the syntax and details still seem adrift in your memory, *that's fine*. Print out a cheat sheet. Look at it whenever the chance to use regexes come up and soon they'll be as familiar as you've ever done on a computer.

The trick is to find opportunities to practice. The first thing is to use a regex-enabled text editor as often as you can, either by opening text files or pasting text/spreadsheets into them.

Then, find the little things to fix. Maybe there's a place in the document where there's 3 spaces where there should be one. Instead of clicking on that space and hitting *Backspace* twice, just pop-up the **Find-and-Replace** dialogue and look for `\s+`

Or, if you've written a lengthy article and you just *know* you've misused "its" and "it's" *somewhere*. Paste your article into a text editor and do a quick search for `it'?s`

I promised at the beginning that you'd find regexes useful even if you don't program. *However*, I promise that with just a little programming, regexes become *even more* powerful. Using a regex to find proper nouns or large numbers is pretty useful in a 100-page document. Imagine how useful it becomes when you write a script to search 1,000 100-page documents, all at once, with that same pattern.

But the beauty of regexes is that they're useful no matter what your technical level. So don't program if you don't feel like you can invest the time, but hopefully what you've learned so far will have sparked ideas and uses you had never thought of.



## Additional references and resources

This book covers about 90% of the regexes I use in a day to day basis, but it by no means covers the many powerful (and crazy) uses that are out there. More importantly, I cover virtually none of the theory or inner-workings of why the regex engine behaves as it does, which is essential as your pattern-making becomes more and more complicated.

Luckily, there are a huge amount of resources for you to go as deep as you need to, and many of these resources are free and online. Here's a short list of ones I've found useful.

* [http://www.regular-expressions.info/](Regular-expressions.info) &ndash; I think I owe my regex ability almost entirely to this site. It offers both easy-to-read overviews of the concepts and indepth walkthroughs when you need to know the details. It's no surprise that regular-expressions.info is almost always the first Google result for any regex-related query.

* [Regular Expressions Cookbook](http://www.amazon.com/gp/product/1449319432/ref=as_li_ss_tl?ie=UTF8&camp=1789&creative=390957&creativeASIN=1449319432&linkCode=as2&tag=danwincom-20) &ndash; You thought my book was long? This invaluable reference, written by the same folks behind regular-expressions.info, is 612 pages.

* [Learn Regular Expressions the Hard Way](http://regex.learncodethehardway.org/) &ndash; another in the well-regarded series of learn-to-code books by Zed Shaw.

[Smashing Magazine's Crucial Concepts Behind Advanced Regular Expressions](http://coding.smashingmagazine.com/2009/05/06/introduction-to-advanced-regular-expressions/) &ndash; A nice primer on regex technique and details.

* ["Do I have that right? And more importantly, what do you think?"](http://stackoverflow.com/questions/1732348/regex-match-open-tags-except-xhtml-self-contained-tags) &ndash; this is one of the most cited Stack Overflow questions ever because it so perfectly embodies the conflict between the promise of regexes and cold hard reality. The top-responder's ranting will increasingly make sense as you continue to use regexes for *everything*.

* [Putting regular expressions to work in Word](http://office.microsoft.com/en-us/support/putting-regular-expressions-to-work-in-word-HA001087304.aspx) &ndash; it's not quite true that you *can't* do regular expressions in Word. Word does have some wildcard functionality; however, its syntax is limited and is completely foreign to the syntax used in every other major language.