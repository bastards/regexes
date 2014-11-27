base text:
JAMES FALLON 40,000 ALEX O'HARE 90 SAL THOMAS 300.25 ALVIN BARRY 121.99 KALEY SIMS 67,000 AL SMITH 52 SHAWN RALSON 300 MALLORY JOHNSON 800 ALBERT SACKS 300,500.99 SALLY POST 400 FALSTAFF YORK 0 ALLISON STEVENS 97,000 THOMAS BALLARD 10,000 CAL SIMMONS 56,800 RALPH MOUSE 24.54 ALEXANDER SINGER 9,300 ALFRED STAMPER 1,780.00 DAN SALSBURY 2,000.99

-----
AL
JAMES F**AL**LON 40,000 **AL**EX O'HARE 90 S**AL** THOMAS 300.25 **AL**VIN BARRY 121.99 K**AL**EY SIMS 67,000 **AL** SMITH 52 SHAWN R**AL**SON 300 M**AL**LORY JOHNSON 800 **AL**BERT SACKS 300,500.99 S**AL**LY POST 400 F**AL**STAFF YORK 0 **AL**LISON STEVENS 97,000 THOMAS B**AL**LARD 10,000 C**AL** SIMMONS 56,800 R**AL**PH MOUSE 24.54 **AL**EXANDER SINGER 9,300 **AL**FRED STAMPER 1,780.00 DAN S**AL**SBURY 2,000.99

\bAL

JAMES FALLON 40,000 **AL**EX O'HARE 90 SAL THOMAS 300.25 **AL**VIN BARRY 121.99 KALEY SIMS 67,000 **AL** SMITH 52 SHAWN RALSON 300 MALLORY JOHNSON 800 **AL**BERT SACKS 300,500.99 SALLY POST 400 FALSTAFF YORK 0 **AL**LISON STEVENS 97,000 THOMAS BALLARD 10,000 CAL SIMMONS 56,800 RALPH MOUSE 24.54 **AL**EXANDER SINGER 9,300 **AL**FRED STAMPER 1,780.00 DAN SALSBURY 2,000.99



------------
\bAL\w* S

JAMES FALLON 40,000 ALEX O'HARE 90 SAL THOMAS 300.25 ALVIN BARRY 121.99 KALEY SIMS 67,000 **AL SMITH** 52 SHAWN RALSON 300 MALLORY JOHNSON 800 **ALBERT SACKS** 300,500.99 SALLY POST 400 FALSTAFF YORK 0 **ALLISON STEVENS** 97,000 THOMAS BALLARD 10,000 CAL SIMMONS 56,800 RALPH MOUSE 24.54 **ALEXANDER SINGER** 9,300 **ALFRED STAMPER** 1,780.00 DAN SALSBURY 2,000.99

--------------

\bAL\w* S

JAMES C. FALLON 40,000 **ALEX S**. O'HARE 90 SAL A. THOMAS 300.25 ALVIN BARRY 121.99 KALEY SIMS 67,000 AL J. SMITH 52 SHAWN K. RALSON 300 MALLORY A. JOHNSON 800 ALBERT O. SACKS 300,500.99 SALLY R. POST 400 FALSTAFF E. YORK 0 ALLISON O. STEVENS 97,000 THOMAS BALLARD 10,000 CAL R. SIMMONS 56,800 RALPH S. MOUSE 24.54 **ALEXANDER SINGER** 9,300 ALFRED Z. STAMPER 1,780.00 DAN R. SALSBURY 2,000.99
 
-------------------


\bAL\w*( \w\.)? S\w+
JAMES C. FALLON 40,000 ALEX S. O'HARE 90 SAL A. THOMAS 300.25 ALVIN BARRY 121.99 KALEY SIMS 67,000 **AL J. SMITH**  52 SHAWN K. RALSON 300 MALLORY A. JOHNSON 800 **ALBERT O. SACKS**  300,500.99 SALLY R. POST 400 FALSTAFF E. YORK 0 **ALLISON O. STEVENS**  97,000 THOMAS BALLARD 10,000 CAL R. SIMMONS 56,800 RALPH S. MOUSE 24.54 **ALEXANDER SINGER**  9,300 **ALFRED Z. STAMPER**  1,780.00 DAN R. SALSBURY 2,000.99


--------------

## Let's match numbers

\d

JAMES C. FALLON **4****0**,**0****0****0** ALEX S. O'HARE **9****0** SAL A. THOMAS **3****0****0**.**2****5** ALVIN BARRY **1****2****1**.**9****9** KALEY SIMS **6****7**,**0****0****0** AL J. SMITH **5****2** SHAWN K. RALSON **3****0****0** MALLORY A. JOHNSON **8****0****0** ALBERT K. SACKS **3****0****0**,**5****0****0**.**9****9** SALLY R. POST **4****0****0** FALSTAFF E. YORK **0** ALLISON O. STEVENS **9****7**,**0****0****0** THOMAS BALLARD **1****0**,**0****0****0** CAL R. SIMMONS **5****6**,**8****0****0** RALPH S. MOUSE **2****4**.**5****4** ALEXANDER SINGER **9**,**3****0****0** ALFRED Z. STAMPER **1**,**7****8****0**.**0****0** DAN R. SALSBURY **2**,**0****0****0**.**9****9**

### Match at least four significant digits
\d+,\d+
JAMES C. FALLON **40,000**  ALEX S. O'HARE 90 SAL A. THOMAS 300.25 ALVIN BARRY 121.99 KALEY SIMS **67,000**  AL J. SMITH 52 SHAWN K. RALSON 300 MALLORY A. JOHNSON 800 ALBERT O. SACKS **300,500** .99 SALLY R. POST 400 FALSTAFF E. YORK 0 ALLISON O. STEVENS **97,000**  THOMAS BALLARD **10,000**  CAL R. SIMMONS **56,800**  RALPH S. MOUSE 24.54 ALEXANDER SINGER **9,300**  ALFRED Z. STAMPER **1,780** .00 DAN R. SALSBURY **2,000** .99

------------

### Match only 5 significant digits or more

\d{2,},\d+

JAMES C. FALLON **40,000** ALEX S. O'HARE 90 SAL A. THOMAS 300.25 ALVIN BARRY 121.99 KALEY SIMS **67,000** AL J. SMITH 52 SHAWN K. RALSON 300 MALLORY A. JOHNSON 800 ALBERT K. SACKS **300,500**.99 SALLY R. POST 400 FALSTAFF E. YORK 0 ALLISON O. STEVENS **97,000** THOMAS BALLARD **10,000** CAL R. SIMMONS **56,800** RALPH S. MOUSE 24.54 ALEXANDER SINGER 9,300 ALFRED Z. STAMPER 1,780.00 DAN R. SALSBURY 2,000.99


### Find all entries of first name AL, last name S, connected to 5 significant digits or more


\bAL\w*( \w\.)? S\w+ \d{2,},\d+

JAMES C. FALLON 40,000 ALEX S. O'HARE 90 SAL A. THOMAS 300.25 ALVIN BARRY 121.99 KALEY SIMS 67,000 AL J. SMITH 52 SHAWN K. RALSON 300 MALLORY A. JOHNSON 800 **ALBERT K. SACKS 300,500**.99 SALLY R. POST 400 FALSTAFF E. YORK 0 **ALLISON O. STEVENS 97,000** THOMAS BALLARD 10,000 CAL R. SIMMONS 56,800 RALPH S. MOUSE 24.54 ALEXANDER SINGER 9,300 ALFRED Z. STAMPER 1,780.00 DAN R. SALSBURY 2,000.99

## Find and replace


Now, this text is not natural for text editors. 

We want it in a spreadsheet.

Let's say you wanted this text blob in a spreadsheet, so you could sort amounts by name.


![image](/TK/excel-regex-intro-non-delimited.png)

Regexes can do more than find things. They can replace text, and flexibly


### Working with Excel


### New lines

To get this text blob into Excel, we just have to put a tab between each part of the name. And a line break after each number.

How can you do this with find-and-replace? How do you instruct it to put a newline at the end of every complete number? Hell, how do you even put a line break at the end of any number?

With regex, here it is:

Find
: \s(\d) 

Replace
: \1\n

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
 

### Tabs in between names and numbers

Pasting the above output is nicer, but we need to separate names from numbers.

![image](/TK/excel-regex-intro-just-line-delimited.png)

We need tab delimiting

Almost the same as the last one:


Find
: (\d)

Replace
: \t\1

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


How much better is that? Now when we paste it directly into Excel, we have two separate columns. 

![image](/TK/excel-regex-intro-one-tab-delimited.png)

We can sort by the second column to easily compare the number amounts:

![image](/TK/excel-regex-intro-one-tab-delimited-sorted.png)


### Separate first, middle, last name

OK, let's get fancy. We want to sort this list alphabetically, but by last name.

Now in Excel, you can do something to separate spaces

Something like:

http://office.microsoft.com/en-us/excel-help/split-names-by-using-the-convert-text-to-columns-wizard-HA010102340.aspx#BMdelimit

But that's not enough. You have to account for the middle name:
http://www.bluemoosetech.com/microsoft-excel-functions.php?jid=32

First name
=IF(ISERROR(FIND(".",A1,1)),LEFT(A1,FIND(" ",A3,1)-1),LEFT(A1,FIND(".",A1,1)))

Last name
=IF(ISERROR(FIND(".",A1,1)),RIGHT(A1,LEN(A1)-FIND(" ",A1,1)),RIGHT(A1,LEN(A1)-FIND(".",A1,1)-1))


With regular expressions, here it is:

Find

	(\w+) (\w\. )?(.+?)\t

Replace

	\1\t\2\t\3\t
	
The result:	

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


To see an interactive version, check out my pasteup on [RegExr](http://regexr.com?34bts) (note: the **Replace** syntax is slightly different there).

When we paste the result into Excel, we now have sortable last name columns:

![image](/TK/excel-regex-intro-full-delimited-last-name-sorted.png)


### All together

Maybe those last few regexes seemed like too much work. You've been using Excel for years, best to stick with the crap syntax you know than the one you don't, right?

But here's the thing. Excel syntax works when the text you have is mostly organized.

But if it's not, then you're really in for a headache. 

Remember the text that we started with:

JAMES C. FALLON 40,000 ALEX S. O'HARE 90 SAL A. THOMAS 300.25 ALVIN BARRY 121.99 KALEY SIMS 67,000 AL J. SMITH 52 SHAWN K. RALSON 300 MALLORY A. JOHNSON 800 ALBERT O. SACKS 300,500.99 SALLY R. POST 400 FALSTAFF E. YORK 0 ALLISON O. STEVENS 97,000 THOMAS BALLARD 10,000 CAL R. SIMMONS 56,800 RALPH S. MOUSE 24.54 **ALEXANDER SINGER** 9,300 ALFRED Z. STAMPER 1,780.00 DAN R. SALSBURY 2,000.99

How do you get from that to a neatly sorted list with just Excel?

You can't. Or you might be able.

Not only is it possible with regexes, it's even possible in one fell step:


Find: 

	(.+?) (\w\. )?(.+?) ([\d., ]+)


Replace:

	\1\t\2\t\3\t\4

That regex looks complicated but it's really just a bunch of small steps all put together.

The bigger thing: Regexes work virtually everywhere. Whether you're in a text editor. Or using it in a programming language, such as Python or Javascript. Or in database programs. Excel works in Excel.

REgexes work everywhere, which is important when you're in the real world trying to make patterns out of things that didn't come in handy spreadsheet form.


### To HTML

One more simple exercise. Maybe you want to make a webpage. Spreadsheets aren't in, HTML is.

Here's a common regex I use to turn tabular data into web tables. You simply copy and paste from Excel:


And do this:

.+?





---

I've only expounded the simplest of regexes. I use them all the time. F

