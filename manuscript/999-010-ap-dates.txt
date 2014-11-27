# Dating, Associated Press Style (TODO)

The AP Stylebook basically *the* dictionary for newspaper professionals. Many newspaper jobs involved a written test of AP style. To non-journalists, the sometimes-arcane rules are probably not well known. Most writers, for example, would be satisfied with abbreviating "Arizona" with its postal code, "AZ". But AP writers use "Ariz." 

Numbers 1 through 10 would be spelled out &ndash; "three policemen", "seven ducklings" &ndash; unless used with ages or percentages: "Kaley, a 7-year-old" and "99 percent." 

For the longest time, "website" was [spelled as "Web site"](http://mashable.com/2010/04/16/ap-stylebook-website/). And so on. 

As you might expect, the AP has a set of rules when listing dates.


## Scenario

Imagine that you have a giant text file containing news stories in which the writer didn't adhere to AP style on dates. We need to write a regular expression that can sweep through the file and abbreviate month names *en masse*.

#### Prerequisites

* Alternation with the pipe character, `|`
* Character sets, such as `\d`
* Repetition with the `+`
* Limited repetition with curly braces, `{1,2}`
* Capturing groups
* **Optional:** Character sets with square brackets, `[a-z]`
* **Optional:** Lookahead with `(?=)`


## The AP Date format

When spelling out the full date &ndash; February 1, 2012 &ndash; the month is abbreviated:

February 1, 2012
: Feb. 1, 2012
January 19, 1999
: Jan. 19, 1999
May 6, 2014
: May 6, 2014
March 22, 1788
: Mar. 22, 1788
June 7, 1960
: June 7, 1960

### Abbreviate the month

As you can see from the above examples, all months *more than 4* characters long are *abbreviated to 3* letters* with a dot. The warm months of May, June, and July are left unabbreviated.

\* **Note:** September is abbreviated to **Sept.** in AP style.


#### The literal solution

There's only &ndash; and will always only be &ndash; 12 months, nine of which are actually affected. So without much thinking, we can match them *literally* with the use of **alternation**

Find
: `(January|February|March|April|August|September|October|November|December)`

Replace
: ???

Unfortunately, it's not that easy. This pattern makes a match, but what do we replace it with? Capturing the entire month's name gives us a backreference to...the *entire* month's name, which is unhelpful if we're trying to abbreviate the month. 

We need to **capture** the first three characters of the long months and discard the rest. Let's also use a **bracekted character set** to match (but *not* capture) the rest of the month's name to *discard*:

Find
: `(Jan|Feb|Mar|Apr|Aug|Sept|Oct|Nov|Dec)\w+`
Replace
: `\1.`

Try it on this list of dates:

	February 1, 2012
	January 19, 1999
	May 6, 2014
	March 22, 1788
	June 7, 1960


### Match just full dates

There's one twist to AP Style dates: only dates that include a specific day use the abbreviated month style.

So our pattern needs to become more specific. It must not affect non-exact dates, such as:

* The president last visited the state in **October 1980**


**Todo:** I messed up here and forgot that abbreviations *do* occur if the date does not include the year. So I need to revise the exercises below accordingly.

In addition to the month name, our pattern needs to match a day value &ndash; one or two digits &ndash; a comma, and the four-digit year.

Let's keep the previous solution. We can use the character class of `\d` with **repetition** syntax:

Find
: `(Jan|Feb|Mar|Apr|Aug|Sept|Oct|Nov|Dec)\w+ (\d+, \d+)`

Replace
: `\1. \2`

Try it out on the following:

	January 12, 2012
	May 9, 2013
	August 4, 1999
	September 1874
	June 2, 2000
	February 8, 1999
	March 2
	December 25
	April 2, 1776


Note that the second-capturing group catches both the day and the year, as well as the literal comma. This seems lazy, maybe, but we're only required to alter just the month, not anything that follows it.

### Match the specific repetition

Our solution above seems to work, but it's just a little too promiscuous. Consider the following valid AP Style sentence:

> Then in **September 1909, 52** pandas launched an aerial assault on the encampment.

Because our pattern uses `\d+, \d+` &ndash; match *one-or-more* digits followed by a comma, a space, and then *one-or-more* digits &ndash; the sequence `1909, 52` is inadvertently swept up:

> Then in **Sept. 1909, 52** pandas launched an aerial assault on the encampment.

We will need to limit the repetition to make it more specific. If we assume that the day always consists of *1 to 2* digits and the year will always be `4 digits` (at least for AP stories dealing with events give or take a millennium):

Find
: `(Jan|Feb|Mar|Apr|Aug|Sept|Oct|Nov|Dec)\w+ (\d{1,2}, \d{4})`

Replace
: `\1. \2`

### Reduce wasteful capturing

Since we're only modifying the name of the month, why even bother capturing (and having to echo) the rest of the date?

We can use the **positive-lookahead** to test if a pattern exists *ahead* of the pattern we seek to replace. The regex engine will check if that assertion but otherwise won't try to modify it.

Using the lookahead will make our **Find** pattern a little longer, but it will simplify our **Replace** pattern. It is also more efficient, though we won't notice the difference unless we're trying to apply the pattern to hundreds of thousands of text strings at once:


Find
: `(Jan|Feb|Mar|Apr|Aug|Sept|Oct|Nov|Dec)\w+ (?=\d{1,2}, \d{4})`

Replace
: `\1`



### Handling imaginary months

We're pretty much done here; the above regex will handle mass-correction of 99% of the unabbreviated full-dates that might show up in an otherwise proper Associated Press story.

But what if we didn't have just 12 months to consider? It's easy to type out such a small set of literal month names. 

Let's stretch out our problem-solving muscles and find a solution that *doesn't* depend on the Gregorian(TK) month names. To keep things simple, we'll keep the same following expectations and requirements:

* Month names are capitalized and consist only of alphabet letters
* Abbreviate only the month names that are than 4 characters
* The day and year format is the same as before

The solution will involve a bit more special regex syntax, but the change can be described like this: *look for a word that begins with a capital letter and is followed by at least four lower-case letters.* 

Let's break that down:

begins with a capital letter
: `\b[A-Z]`

followed by at least four lower-case letters
: `[a-z]{4,}`

(**Note**: I use the word-boundary `\b` to avoid matching something like "Mc**Gregor**", though I guess there's no reason why there couldn't be Scottish-named months in our scenario...)

We're almost there. Remember that we still have to replace the month's name with an abbreviation consisting of the month's first three letters (we'll ignore the special case of September). So we need to *halve* the second part of the pattern above:

	[a-z]{2}[a-z]{2,}


To make the abbreviation, we want to **capture** the first (uppercase) letter, plus the next two lowercase characters. So, all together:

	\b([A-Z][a-z]{2})[a-z]{2,}

And now, the complete pattern, including the lookahead for the day and year digits:

Find
: `\b([A-Z][a-z]{2})[a-z]{2,} (?=\d{1,2}, \d{4})`

Try it out on this text:

	January 12, 2012
	May 9, 2013
	August 4, 1999
	September 1874
	June 2, 2000
	February 8, 1999
	March 2
	December 25
	April 2, 1776
	Then in September 1909, 52 pandas launched an aerial assault on the encampment.

 


## Real-world considerations

So which solution is wiser: the one that explicitly lists the month names or the more abstract pattern with bracketed character sets? 

In the real world, the **first** solution is smarter, given the circumstances. As far as we can predict, the names of months will not change, so why write a flexible pattern? Moreover, the flexible pattern would inadvertently capture phrases that aren't dates at all:

> According to a classified report from Deep **Space 9, 2335** was when panda attacks reached their peak before plateauing for the next 12 years. 

However, it's good to get in the habit of searching out the most abstract pattern, for practice sake. Not every data problem will be as easily enumerable as the list of calendar months.

### How to overthink a problem

Sometimes, the concrete solution isn't so simple, though.

Reliable regex solutions often require some **domain knowledge** of the problem. Recall that we had to use the pattern `\d{1,2}, \d{4}` &ndash; instead of the unspecific `\d+` &ndash; to capture the day and year.

But just to be safe, we might need to be even more specific:

The second-digit of a day, if there is one, is never anything else than `1`, `2`, or `3`.

We can use the optionality operator, `?`, to limit the range of day. So instead of:

	\d{1,2}
	
We could use:

	[123]?\d


But wait. There's still more logic to consider:

* If the date is single-digit, then it can only be from `1` to `9` (i.e. not `0`)
* If the date is two-digits and begins with a `3`, then the ones-place digit must be either `0` or `1`, as the day `32` does not exist for any month.
* If the month is February, then the tens-place digit can never be more than `2`
* And what about leap years?

There is actually a way, I *think*, to capture this logic with regex syntax only. It would require **conditionals**, something I avoided covering in the book because of its convoluted syntax. The actual regex pattern would likely be several lines long. 

I say *likely* because I haven't &ndash; and will not &ndash; attempt it. And neither should you.


## The limits of regex

So is the AP style date-enforcer a futile goal in the real world?

Well, imagine that your job is to create *something* that could process a news organization's thousands (perhaps millions) of articles and reliably abbreviate the dates.

*If* you had the technical chops to be trusted with that task, you would use the far more versatile (and easier to use) techniques that general programming makes available to deal with such complicated logic. If you tried to, instead, solve it with a single regex, you would either go insane or, hopefully, just be fired.

As powerful and flexible as regexes are, they are simply one tool. To paraphrase the aphorism, "When all you have is a hammer, everything looks like a nail." So part of understanding regexes is knowing that certain problems are not simply "nails." 


### Knowing is half the battle

For example, here's a much more likely problem that you'll have to fix: the writers don't even bother spelling out the dates and instead, use `10/25/1980` as a shorthand for `October 25, 1980`.

How can a single regex "know" that `10` corresponds to `October` (nevermind properly abbreviate it)? Again, I'm not going to even guess what that regex (or series of regexes) would be.

But that's the kind of problem that you may want to solve, right? It may be frustrating that all of this regex practice won't give you the direct solution. But at least you *recognize* that this is a problem that *might* be solvable with regexes and *something else*. And that's a big shift in mindset.

Remember when I said regexes were a `gateway drug` into programming? Learning programming is a topic for another book. But as we go through these exercises, I'll try to get you to think about how your regex abilities can be further expanded.

