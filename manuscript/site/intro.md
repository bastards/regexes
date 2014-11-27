
About a year ago, I started writing an [online book for people who wanted to learn Ruby](http://ruby.bastardsbook.com/) (the programming language) and how to use it for practical tasks. The longest chapter in that book so far [is about regular expressions](http://ruby.bastardsbook.com/chapters/regexes/). And it begins with this advice:

> If you learn nothing else from this book, learn regular expressions. 

Since regular expressions are plenty useful on their own without knowing Ruby (or any other kind of programming or software), I've decided to write a whole separate **introductory-level** book on them. It's called the *[Bastards Book of Regular Expressions]((https://leanpub.com/bastards-regexes))* and you can [download it as an e-book here](https://leanpub.com/bastards-regexes) &ndash; for free &ndash; at Leanpub, where [I am self-publishing it](https://leanpub.com/bastards-regexes).

(If you don't want to go through the (easy) Leanpub signup process, you can [download the PDF here](/files/bastards-regexes.pdf), though Leanpub will have the most [up-to-date version](https://leanpub.com/bastards-regexes) in multiple formats.)

**Note:** *This book is a work in progress and still in the pre-release stage. Most of the main content is finished but I'm still adding content/code and still need to edit it. Leanpub refreshes the downloadable book draft as I revise it. You can follow me at [@dancow](http://twitter.com/dancow) and/or [@bastardsbook](https://twitter.com/bastardsbook) for updates.*

## What are regular expressions?

The easiest way to describe them is: "Find-and-Replace on steroids".

<strong>A longer description:</strong> Regular expressions &ndash; **regexes** for short &ndash; are just a way to describe **patterns in text**, either to find or to replace. Their general usefulness is easier told through demonstration, so here's an imaginary office task that shows some of the basic but toher

--------


## A block of text

The workday was just about to end until you checked your email and saw that damn priority email from your boss. You open it up and it's an attached text file. 

"Someone just sent us data that we need to look for, can you get this done by tomorrow?"

You open up the file and it's a massive glob of text. *Maybe* it was data at some point, on someone else's computer, before it got exported into this mess:

> JAMES FALLON 40,000 ALEX O'HARE 90 SAL THOMAS 300.25 ALVIN BARRY 121.99 KALEY SIMS 67,000 AL SMITH 52 SHAWN RALSON 300 MALLORY JOHNSON 800 ALBERT SACKS 300,500.99 SALLY POST 400 FALSTAFF YORK 0 ALLISON STEVENS 97,000 THOMAS BALLARD 10,000 CAL SIMMONS 56,800 RALPH MOUSE 24.54 ALEXANDER SINGER 9,300 ALFRED STAMPER 1,780.00 DAN SALSBURY 2,000.99


It looks like a list of first names, last names, and amounts of money, except that someone forgot to hit "Return" at the right places.

*(This is just an excerpt. Imagine it being a thousand times longer.)*


Well, at least you don't have to *do anything* with it, your boss tells you. You just need to look for entries related to a particular client.

"The client's name begins with 'Al,'" your boss says.

"Al...Al, what?"

"I'm not sure. Could be 'Alfred', or 'Albert'. Or maybe even 'Allie'."


You sigh. Well, you know how to find words using Microsoft Word. You hit Ctrl-F and type `AL` into Microsoft Word:

![Find in Microsoft Word](/images/front/word-AL.png)
	
Well, that was not much help. A search for `AL` ends up highlighting `AL` whether it appears in `ALVIN`, `SALLY`, or `SALSBURY`, nevermind if it appears in the first or last name. 


### A better Find

At this point, there's not much you can do but accept that you'll be clicking <strong>Find Next</strong> way more times than you want to.

If only there was a way to describe the *kind* of thing you're looking for, rather than just the *literal* term. 

This is what **regular expressions** allow us to do. Keep reading to see how regex can be used in this scenario. You can also follow along interactively by going to [Rubular.com](http://rubular.com) and pasting in the regex and text.

(**Note:** *it's worth noting that [Microsoft Word allows some regex usage](http://office.microsoft.com/en-us/help/add-power-to-word-searches-with-regular-expressions-HA001087305.aspx "Add power to Word searches with regular expressions - Support - Office.com"). However, they use a syntax extremely different from what you'll find in virtually all the other programs and contexts that use regex. If you want to learn two different flavors of regex, knock yourself out. But for now, it's just enough to understand the concepts and potential*)

-----


### AL, just AL, please

We're looking for an `AL` but we don't need `SAL`. So, what we're actually looking for is: `AL`, when it's the beginning of a name.

In Microsoft Word, you can be a little clever and change your search to look for a *space character* and *then* the word `AL`. That would limit your matches to where `AL` occurs at the *beginning* of a word.

In other words, we don't literally need just `AL`, but a *pattern* containing `AL` at the *beginning of a word*.

In regular expression syntax, we can express that a little more specifically: this is how you find `AL` when it occurs at the beginning of the word (which is usually, but not always, after a space character):

	\bAL
	
And here's what that highlights:

> JAMES FALLON 40,000 **AL**EX O'HARE 90 SAL THOMAS 300.25 **AL**VIN BARRY 121.99 KALEY SIMS 67,000 **AL** SMITH 52 SHAWN RALSON 300 MALLORY JOHNSON 800 **AL**BERT SACKS 300,500.99 SALLY POST 400 FALSTAFF YORK 0 **AL**LISON STEVENS 97,000 THOMAS BALLARD 10,000 CAL SIMMONS 56,800 RALPH MOUSE 24.54 **AL**EXANDER SINGER 9,300 **AL**FRED STAMPER 1,780.00 DAN SALSBURY 2,000.99

Nice! Adding an extra two characters &ndash; `\b` &ndash; saves you a bit of time already. The important thing here is that using regex is no different than doing any other kind of **Find** operation.

This is how easy it using [Rubular.com](http://rubular.com):

![AL in Rubular](/images/front/word-AL.png)

And this is how easy it is in a [regex-supporting text editor](http://www.sublimetext.com/):

![AL in Sublime Text 2](/images/front/sublime-AL.png)


(The [Bastards Book of Regular Expressions](https://leanpub.com/bastards-regexes) has a chapter on choosing from the several free and powerful text editors out there and how to use them.)


### First name "AL"-something, last name S...something

Time to narrow the search even more.

You ask your boss: "Do you have anything more specific than 'Al'? Like a last name?" 

She thinks for a few seconds. "Yes, I remember now. The client's last name begins with the letter 'S'." 

Now, without regexes, that bit of information is actually almost no help at all. 

You don't know if the client's name is "Alvin", "Allison", or just plain "Al". With the standard **Find** function, there's no way to specify this particular pattern: 

1. The letters `AL`
2. Followed by a bunch of other letters (or not, in the case of someone named just "Al")
3. A space character
4. A word that begins with `S`


But here's how we describe that pattern with regexes:

	\bAL\w* S
	
And this is what it highlights:

> JAMES FALLON 40,000 ALEX O'HARE 90 SAL THOMAS 300.25 ALVIN BARRY 121.99 KALEY SIMS 67,000 **AL SMITH** 52 SHAWN RALSON 300 MALLORY JOHNSON 800 **ALBERT SACKS** 300,500.99 SALLY POST 400 FALSTAFF YORK 0 **ALLISON STEVENS** 97,000 THOMAS BALLARD 10,000 CAL SIMMONS 56,800 RALPH MOUSE 24.54 **ALEXANDER SINGER** 9,300 **ALFRED STAMPER** 1,780.00 DAN SALSBURY 2,000.99
	
	
That pattern reduced the number of finds by a *lot*.

### Middle initials

Let's make this scenario harder. 

Let's say the text includes *maybe* a **middle initial** &ndash; or *maybe* not &ndash; for each first-name, last-name pair.
	
Now our previous regex won't work. It won't match any of the `AL S` instances we found before, and it will make unintended matches, such as `ALEX S O'HARE`:

> JAMES C. FALLON 40,000 **ALEX S**. O'HARE 90 SAL A. THOMAS 300.25 ALVIN BARRY 121.99 KALEY SIMS 67,000 AL J. SMITH 52 SHAWN K. RALSON 300 MALLORY A. JOHNSON 800 ALBERT O. SACKS 300,500.99 SALLY R. POST 400 FALSTAFF E. YORK 0 ALLISON O. STEVENS 97,000 THOMAS BALLARD 10,000 CAL R. SIMMONS 56,800 RALPH S. MOUSE 24.54 **ALEXANDER SINGER** 9,300 ALFRED Z. STAMPER 1,780.00 DAN R. SALSBURY 2,000.99

But we just have to make a more specific regex. In plain English, the pattern we want is: *A word that begins with "AL", followed by a space, followed by an optional middle initial with a period, and then another word that begins with an S*:

	\bAL\w*( \w\.)? S\w+
	
And that works:

> JAMES C. FALLON 40,000 ALEX S. O'HARE 90 SAL A. THOMAS 300.25 ALVIN BARRY 121.99 KALEY SIMS 67,000 **AL J. SMITH**  52 SHAWN K. RALSON 300 MALLORY A. JOHNSON 800 **ALBERT O. SACKS**  300,500.99 SALLY R. POST 400 FALSTAFF E. YORK 0 **ALLISON O. STEVENS**  97,000 THOMAS BALLARD 10,000 CAL R. SIMMONS 56,800 RALPH S. MOUSE 24.54 **ALEXANDER SINGER**  9,300 **ALFRED Z. STAMPER**  1,780.00 DAN R. SALSBURY 2,000.99

	
### Where's the money

So besides names, this clump of text contains money amounts. You anticipate that your search will involve filtering out numbers, so how *do* you find *just* numbers? Again, it's not possible with the standard Find function. But with regexes, here's how you specify a search for just **numerical digits**:	
	
	\d
	
And this is what that matches:

> JAMES C. FALLON **40**,**000** ALEX S. O'HARE **90** SAL A. THOMAS **300**.**25** ALVIN BARRY **121**.**99** KALEY SIMS **67**,**000** AL J. SMITH **52** SHAWN K. RALSON **300** MALLORY A. JOHNSON **800** ALBERT K. SACKS **300**,**500**.**99** SALLY R. POST **400** FALSTAFF E. YORK **0** ALLISON O. STEVENS **97**,**000** THOMAS BALLARD **10**,**000** CAL R. SIMMONS **56**,**800** RALPH S. MOUSE **24**.**54** ALEXANDER SINGER **9**,**300** ALFRED Z. STAMPER **1**,**780**.**00** DAN R. SALSBURY **2**,**000**.**99**
	

### Where's the big money

We're not interested in just amounts in the hundreds, your boss tells you. We're looking for amounts *at least in the thousands.*

Since the numbers in our text blob follow the convention of comma-every-three-significant-digits, here's the regex that matches *consecutive numbers, a comma, and more consecutive numbers*: 

	\d+,\d+
	
And this matches:

> JAMES C. FALLON **40,000**  ALEX S. O'HARE 90 SAL A. THOMAS 300.25 ALVIN BARRY 121.99 KALEY SIMS **67,000**  AL J. SMITH 52 SHAWN K. RALSON 300 MALLORY A. JOHNSON 800 ALBERT O. SACKS **300,500** .99 SALLY R. POST 400 FALSTAFF E. YORK 0 ALLISON O. STEVENS **97,000**  THOMAS BALLARD **10,000**  CAL R. SIMMONS **56,800**  RALPH S. MOUSE 24.54 ALEXANDER SINGER **9,300**  ALFRED Z. STAMPER **1,780** .00 DAN R. SALSBURY **2,000** .99

	
And if we just want to limit our our search to just *tens* of thousands:

	\d{2,},\d+
	
Which matches:

> JAMES C. FALLON **40,000** ALEX S. O'HARE 90 SAL A. THOMAS 300.25 ALVIN BARRY 121.99 KALEY SIMS **67,000** AL J. SMITH 52 SHAWN K. RALSON 300 MALLORY A. JOHNSON 800 ALBERT K. SACKS **300,500**.99 SALLY R. POST 400 FALSTAFF E. YORK 0 ALLISON O. STEVENS **97,000** THOMAS BALLARD **10,000** CAL R. SIMMONS **56,800** RALPH S. MOUSE 24.54 ALEXANDER SINGER 9,300 ALFRED Z. STAMPER 1,780.00 DAN R. SALSBURY 2,000.99
	

### The AL S. with the most money

Regexes have a reputation for being mind-numbingly complex. However, most of them only *look* complex. By combining the regex patterns we've used so far:

* Finding first name `AL`, last name `S`: `\bAL\w*( \w\.)? S\w+`
* Finding five significant digits or more: `\d{2,},\d+`

We just combine them together to find the high-rolling ALs:

	\bAL\w*( \w\.)? S\w+ \d{2,},\d+
	

And bingo:

> JAMES C. FALLON 40,000 ALEX S. O'HARE 90 SAL A. THOMAS 300.25 ALVIN BARRY 121.99 KALEY SIMS 67,000 AL J. SMITH 52 SHAWN K. RALSON 300 MALLORY A. JOHNSON 800 **ALBERT K. SACKS 300,500**.99 SALLY R. POST 400 FALSTAFF E. YORK 0 **ALLISON O. STEVENS 97,000** THOMAS BALLARD 10,000 CAL R. SIMMONS 56,800 RALPH S. MOUSE 24.54 ALEXANDER SINGER 9,300 ALFRED Z. STAMPER 1,780.00 DAN R. SALSBURY 2,000.99

	

## Makin' data

You proudly show the results of your regex-powered data mining to your boss.

"Our client with the biggest spend is someone named ALBERT SACKS with $300,500 listed," you tell her.

"That's nice," she responds. Now just save all the data in a spreadsheet so we can make some cool graphs.

**Argh.**

There was no "data" to begin with, just a block of text, or else you would've thrown the document into Excel and filtered/sorted by column. 

This is what happens when you copy-and-paste the text into Excel:


![Excel blob](/images/front/excel-regex-intro-non-delimited.png)

But even in a pile of text there's patterns. And a pattern is all we need for regexes to be useful.

### Making new lines

The text we've been searching through does have a reepating pattern. It goes something like this:

	FIRST NAME, MIDDLE INITIAL (maybe), LAST NAME, AMOUNT
	
It'd be easier to see if we had a line break after each occurrence. In regex syntax, what we want is to: *insert a line break wherever there is a space after a number*

We are no longer just doing a **Find** operation, but **Find-and-Replace**. 

So this is the regex that we **find**:

	\s(\d) 

Here's what we **Replace** it with:

	\1\n
	
And the result is much neater-looking:

	JAMES C. FALLON 40,000
	ALEX S. O'HARE 90
	SAL A. THOMAS 300.25
	ALVIN BARRY 121.99
	KALEY SIMS 67,000
	AL J. SMITH 52
	SHAWN K. RALSON 300
	MALLORY A. JOHNSON 800
	ALBERT K. SACKS 300,500.99
	SALLY R. POST 400
	FALSTAFF E. YORK 0
	ALLISON O. STEVENS 97,000
	THOMAS BALLARD 10,000
	CAL R. SIMMONS 56,800
	RALPH S. MOUSE 24.54
	ALEXANDER SINGER 9,300
	ALFRED Z. STAMPER 1,780.00
	DAN R. SALSBURY 2,000.99
	
	
### Separating names from amounts

But we can't just paste this into the spreadsheet, because we end up with:

![Excel line delimited](/images/front/excel-regex-intro-just-line-delimited.png)
	
So we need to put some kind of **separator** between the numbers and names, because a single space character isn't cutting it. Let's go with the **tab character**, which to the naked eye, looks like four whitespaces in a row. 

And where do we insert the tab character? Wherever there's a whitespace right *before* a number, kind of the opposite of the pattern we had previously:

	\s(\d)
	
We insert a tab character:

	\t\1
	
And *voila*:

	JAMES C. FALLON	40,000
	ALEX S. O'HARE	90
	SAL A. THOMAS	300.25
	ALVIN BARRY	121.99
	KALEY SIMS	67,000
	AL J. SMITH	52
	SHAWN K. RALSON	300
	MALLORY A. JOHNSON	800
	ALBERT K. SACKS	300,500.99
	SALLY R. POST	400
	FALSTAFF E. YORK	0
	ALLISON O. STEVENS	97,000
	THOMAS BALLARD	10,000
	CAL R. SIMMONS	56,800
	RALPH S. MOUSE	24.54
	ALEXANDER SINGER	9,300
	ALFRED Z. STAMPER	1,780.00
	DAN R. SALSBURY	2,000.99

If you copy-and-paste this directly into Excel, you get what your boss wanted:


![Excel: one tab delimited](/images/front/excel-regex-intro-one-tab-delimited.png)
	
	
### First, middle, and last name

You can already hear your boss's next demand: *Wouldn't it be nice if we could order this list alphabetically, by last name?*

This is a trickier problem. We can't simply separate by space, because there might or *might not* be a middle initial. We need three columns for the name.

Now, if you're an Excel wizard, you probably can devise a formula to do this, why use regexes now that everything is in a spreadsheet? 

Well, I am not an Excel pro, so I did a google search for a solution. This [blog post by Blue Moose Technology](http://www.bluemoosetech.com/microsoft-excel-functions.php?jid=32) was one of the best documented.

Here's the Excel formula to separate out the first name with middle initial:

	=IF(ISERROR(FIND(".",A1,1)),LEFT(A1,FIND(" ",A3,1)-1),LEFT(A1,FIND(".",A1,1)))
	
Here's the Excel formula to then get the last name in its own column:

	=IF(ISERROR(FIND(".",A1,1)),RIGHT(A1,LEN(A1)-FIND(" ",A1,1)),RIGHT(A1,LEN(A1)-FIND(".",A1,1)-1))
	

In comparison, this is the regex we can use to parse the names if we keep the text in our text-editor for now. First we **Find** this:

	(\w+) (\w\. )?(.+?)\t
	
Then we **Replace** it with this:	

	\1\t\2\t\3\t


You don't even have to add redundant columns like the Excel solution does. 

To see an interactive version, check out my pasteup on [RegExr](http://regexr.com?34bts) (note: the **Replace** syntax is slightly different there).


	JAMES	C. 	FALLON	40,000
	ALEX	S. 	O'HARE	90
	SAL	A. 	THOMAS	300.25
	ALVIN		BARRY	121.99
	KALEY		SIMS	67,000
	AL	J. 	SMITH	52
	SHAWN	K. 	RALSON	300
	MALLORY	A. 	JOHNSON	800
	ALBERT	K. 	SACKS	300,500.99
	SALLY	R. 	POST	400
	FALSTAFF	E. 	YORK	0
	ALLISON	O. 	STEVENS	97,000
	THOMAS		BALLARD	10,000
	CAL	R. 	SIMMONS	56,800
	RALPH	S. 	MOUSE	24.54
	ALEXANDER		SINGER	9,300
	ALFRED	Z. 	STAMPER	1,780.00
	DAN	R. 	SALSBURY	2,000.99


When we paste the result into Excel, we now have sortable last name columns:

![All delimited](/images/front/excel-regex-intro-full-delimited-last-name-sorted.png)


### All together

Even if you think the Excel version is easier, the bigger point to consider is that if you started from the raw text dump at the beginning of this scenario:

> JAMES C. FALLON 40,000 ALEX S. O'HARE 90 SAL A. THOMAS 300.25 ALVIN BARRY 121.99 KALEY SIMS 67,000 AL J. SMITH 52 SHAWN K. RALSON 300 MALLORY A. JOHNSON 800 ALBERT O. SACKS 300,500.99 SALLY R. POST 400 FALSTAFF E. YORK 0 ALLISON O. STEVENS 97,000 THOMAS BALLARD 10,000 CAL R. SIMMONS 56,800 RALPH S. MOUSE 24.54 ALEXANDER SINGER 9,300 ALFRED Z. STAMPER 1,780.00 DAN R. SALSBURY 2,000.99

There is virtually no spreadsheet technique that will fix that up for you.

But here's a regex that does everything &ndash; from adding newline characters, to separating numbers from names, and delimiting each part of the name &ndash; all in **one** **Find-and-Replace**.

**Find:**

	(.+?) (\w\. )?(.+?) ([\d., ]+)
	
**Replace:**

	\1\t\2\t\3\t\4\n
	
See the [interactive pasteup on RegExr](http://regexr.com?34bu8).	
	
	
### To the web!

You show the spreadsheet to your boss. She's satisfied. But since you finished so fast, could you post the data onto a webpage? 

"Not all of our clients have Excel, and I want them to see the data on their phones, too," she says.

Well, this is just one more pattern after we've tab-delimited the text. First, we add table column tags:	


**Find:**

	([^\t\n]+?)(\t|$)|\t

**Replace:**

	<td>\1</td>

**Result:**

	<td>JAMES</td><td>C. </td><td>FALLON</td><td>40,000 </td>
	<td>ALEX</td><td>S. </td><td>O'HARE</td><td>90 </td>
	<td>SAL</td><td>A. </td><td>THOMAS</td><td>300.25 </td>
	<td>ALVIN</td><td></td><td>BARRY</td><td>121.99 </td>
	<td>KALEY</td><td></td><td>SIMS</td><td>67,000 </td>
	<td>AL</td><td>J. </td><td>SMITH</td><td>52 </td>
	<td>SHAWN</td><td>K. </td><td>RALSON</td><td>300 </td>
	<td>MALLORY</td><td>A. </td><td>JOHNSON</td><td>800 </td>
	<td>ALBERT</td><td>O. </td><td>SACKS</td><td>300,500.99 </td>
	<td>SALLY</td><td>R. </td><td>POST</td><td>400 </td>
	<td>FALSTAFF</td><td>E. </td><td>YORK</td><td>0 </td>
	<td>ALLISON</td><td>O. </td><td>STEVENS</td><td>97,000 </td>
	<td>THOMAS</td><td></td><td>BALLARD</td><td>10,000 </td>
	<td>CAL</td><td>R. </td><td>SIMMONS</td><td>56,800 </td>
	<td>RALPH</td><td>S. </td><td>MOUSE</td><td>24.54 </td>
	<td>ALEXANDER</td><td></td><td>SINGER</td><td>9,300 </td>
	<td>ALFRED</td><td>Z. </td><td>STAMPER</td><td>1,780.00 </td>
	<td>DAN</td><td>R. </td><td>SALSBURY</td><td>2,000.99</td>
	


Then, we put some table row tags around each line:

**Find:**

	(.+)

**Replace:**

	<tr>\1</tr>

Which gets us this:
	
	<tr><td>JAMES</td><td>C. </td><td>FALLON</td><td>40,000 </td></tr>
	<tr><td>ALEX</td><td>S. </td><td>O'HARE</td><td>90 </td></tr>
	<tr><td>SAL</td><td>A. </td><td>THOMAS</td><td>300.25 </td></tr>
	<tr><td>ALVIN</td><td></td><td>BARRY</td><td>121.99 </td></tr>
	<tr><td>KALEY</td><td></td><td>SIMS</td><td>67,000 </td></tr>
	<tr><td>AL</td><td>J. </td><td>SMITH</td><td>52 </td></tr>
	<tr><td>SHAWN</td><td>K. </td><td>RALSON</td><td>300 </td></tr>
	<tr><td>MALLORY</td><td>A. </td><td>JOHNSON</td><td>800 </td></tr>
	<tr><td>ALBERT</td><td>O. </td><td>SACKS</td><td>300,500.99 </td></tr>
	<tr><td>SALLY</td><td>R. </td><td>POST</td><td>400 </td></tr>
	<tr><td>FALSTAFF</td><td>E. </td><td>YORK</td><td>0 </td></tr>
	<tr><td>ALLISON</td><td>O. </td><td>STEVENS</td><td>97,000 </td></tr>
	<tr><td>THOMAS</td><td></td><td>BALLARD</td><td>10,000 </td></tr>
	<tr><td>CAL</td><td>R. </td><td>SIMMONS</td><td>56,800 </td></tr>
	<tr><td>RALPH</td><td>S. </td><td>MOUSE</td><td>24.54 </td></tr>
	<tr><td>ALEXANDER</td><td></td><td>SINGER</td><td>9,300 </td></tr>
	<tr><td>ALFRED</td><td>Z. </td><td>STAMPER</td><td>1,780.00 </td></tr>
	<tr><td>DAN</td><td>R. </td><td>SALSBURY</td><td>2,000.99</td></tr>
	
	

We add some &lt;table&gt; tags around all of that and when a web browser sees that raw HTML, it gives us a nice web table:

 <table class="table table-striped"><tr><td>JAMES</td><td>C. </td><td>FALLON</td><td>40,000 </td></tr> <tr><td>ALEX</td><td>S. </td><td>O'HARE</td><td>90 </td></tr> <tr><td>SAL</td><td>A. </td><td>THOMAS</td><td>300.25 </td></tr> <tr><td>ALVIN</td><td></td><td>BARRY</td><td>121.99 </td></tr> <tr><td>KALEY</td><td></td><td>SIMS</td><td>67,000 </td></tr> <tr><td>AL</td><td>J. </td><td>SMITH</td><td>52 </td></tr> <tr><td>SHAWN</td><td>K. </td><td>RALSON</td><td>300 </td></tr> <tr><td>MALLORY</td><td>A. </td><td>JOHNSON</td><td>800 </td></tr> <tr><td>ALBERT</td><td>O. </td><td>SACKS</td><td>300,500.99 </td></tr> <tr><td>SALLY</td><td>R. </td><td>POST</td><td>400 </td></tr> <tr><td>FALSTAFF</td><td>E. </td><td>YORK</td><td>0 </td></tr> <tr><td>ALLISON</td><td>O. </td><td>STEVENS</td><td>97,000 </td></tr> <tr><td>THOMAS</td><td></td><td>BALLARD</td><td>10,000 </td></tr> <tr><td>CAL</td><td>R. </td><td>SIMMONS</td><td>56,800 </td></tr> <tr><td>RALPH</td><td>S. </td><td>MOUSE</td><td>24.54 </td></tr> <tr><td>ALEXANDER</td><td></td><td>SINGER</td><td>9,300 </td></tr> <tr><td>ALFRED</td><td>Z. </td><td>STAMPER</td><td>1,780.00 </td></tr> <tr><td>DAN</td><td>R. </td><td>SALSBURY</td><td>2,000.99</td></tr> </table>	
	
	
-------



## The joy of regex


Almost daily, I find myself in front of a pile of mush-text that needs to be sorted out. Or maybe there's just a 100,000-word document that might or might not contain a vague name. Even though I know how to program, if I had to write programs every time I had to solve these problems, I'd go crazy.

Instead, I use regexes. I think of the pattern I want to find or replace and I plop it all into a text editor. And I'm done. So I love regexes for saving me from extra work. If you don't know how to program, regexes could at least save you from tedious pointing-clicking-and-copying-pasting.

However, I love regexes even more because they make it possible &ndash; if not trivial &ndash; to do  research and analysis that is otherwise impossible, because believe it or not, most research and analysis start out with just giant blobs of text.

But that's jumping ahead. If I've kept your interest this far, [then go ahead and download my book](https://leanpub.com/bastards-regexes). It's **free**. And then you need a text editor (these are also free) that handles regular expressions. [My book](https://leanpub.com/bastards-regexes) has an entire chapter on finding the right text editor.

**The book is currently in pre-release:** it's readable, and useful, but **unfinished**. The [Leanpub](http://leanpub.com) service will notify you when I've made updates to the book. You can also follow me on Twitter, [@dancow](https://twitter.com/dancow), and on my blog, [danwin.com](http://danwin.com)

Get ["The Bastards Book of Regular Expressions" at Leanpub](https://leanpub.com/bastards-regexes).

