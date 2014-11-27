# Lookarounds

This chapter covers **lookarounds**, a regex technique that allows us to *test* if a pattern exists without actually capturing it. The syntax can be a little confusing, and it's possible to get by without lookarounds. But they do allow for some more advanced patterns which I'll cover later in this chapter.

## Positive lookahead

A positive lookahead is denoted with a **question-mark-and-equals** sign inside of **parentheses**:

	cat(?=s)

&ndash; will match an instance of `cat` that is *immediately followed* by an `s` character.
	
> The cat is outside while the other **cat**s are inside

However, for the purposes of **Find-and-Replace**, only `cat` will be matched and replaced.

In the given text:

> How much wood can a woodchuck chuck if woodchuck could chuck wood

This **Find-and-Replace** pattern:

Find
: `wood(?=chuck)`

Replace
: `stone`

Results in:
> How much wood can a stonechuck chuck if stonechuck could chuck wood


------


#### Exercise

Delete the commas that are used as number delimiters below:

Original:

> 1,000 dachshunds, of the brown-colored variety, ran 12,000 laps.

Fixed:

> 1000 dachshunds, of the brown-colored variety, ran 12000 laps

#### Answer

Find
: `,(?=\d+)`

Replace
: *(with nothing)*

Notice how the replacement didn't affect the numbers matched with `\d+`. The positive lookahead only verifies that those numbers exist ahead of a comma; the regex engine only cares about replacing that comma.

Compare that to having to use capturing groups:

Find
: `,(\d+)`

Replace
: `$1`



## Negative lookahead

A **negative lookahead** works the same as the **positive** variation, except that it looks for the specified pattern to *not exist*. Instead of an equals sign, we use an **exclamation mark**:


	cat(!=s)

&ndash; will match an instance of `cat` that is *not immediately followed* by an `s` character.
	

In the given text:

> How much wood can a woodchuck chuck if woodchuck could chuck wood

This **Find-and-Replace** pattern:

Find
: `wood(?!chuck)`

Replace
: `stone`

Results in:
> How much stone can a woodchuck chuck if woodchuck could chuck stone


------

#### Exercise


Replace the commas that are used to separate sentence clauses with double-hyphens. Do not replace the commas used as number-delimiters:

Original:

> 1,000 dachshunds, of the brown-colored variety, ran 12,000 laps.

Fixed:

> 1000 dachshunds -- of the brown-colored variety -- ran 12000 laps

#### Answer

Find
: `,(?!\d+)`

Replace
: ` -- `


## Positive lookbehind

The **lookbehind** is what you expect: match a pattern *only if* a given pattern *immediately precedes it*. The following pattern matches an `s` character that is preceded by `cat`:

	`(?<=cat)s`

Given this phrase:

> How much wood can a woodchuck chuck if woodchuck could chuck wood

The following **Find-and-Replace**:

Find
: `(?<=wood)chuck`

Replace
: `duck`
	
Results in:
> How much wood can a woodduck chuck if woodduck could chuck wood.

------

### The limits of lookbehinds

The main caveat with lookbehinds is that are not supported across all regex flavors. And even for the regex flavors that *do* support lookbehinds, they only support a limited set of regex syntax.

Essentially, you may run into problems with lookbehinds that attempt to match a pattern of **variable length**. 

This is generally kosher
: `(?<=\d),`

This likely will *not* work
: `(?<=\d+)`

The difference is that the first pattern is just **one digit**. The latter could be one digit **or a thousand**. The regex engine can't handle that variability.  [Regular-expressions.info has an excellent explainer](http://www.regular-expressions.info/lookaround.html).

In other words, use lookbehinds with caution. We'll examine some alternatives at the end of this chapter.


#### Exercise

Given the following date listings:

	3/12/2010
	4/6/2001
	11/17/2009
	
Replace the four-digit years with two-digits:	
	
	3/12/2010
	4/6/2001
	11/17/2009
	
#### Answer

Find
: `(?<=/)\d{2}(?=\d{2})`	
	
Replace
: *(with nothing)*

	

## Negative lookbehind

Same concept and limits as the **positive** variation, with the difference that we're verifying the non-existence of a preceding pattern. The syntax is similar except an **exclamation mark** takes the place of the **equals sign**.

The following pattern matches an `s` character that is *not* preceded by `cat`:

	`(?<!cat)s`


In the given text:

> How much wood can a woodchuck chuck if woodchuck could chuck wood

The following **Find-and-Replace**:

Find
: `(?<!wood)chuck`

Replace
: `shuck`
	
Results in:

> How much wood can a woodchuck shuck if woodchuck could shuck wood

------

#### Exercise

Given the following text:

> Charles spent 20.5 at the chatusserie. He then withdrew 40.5 from the ATM.

Replace the **periods** used as decimal points with commas:

> Charles spent 20,5 at the chatusserie. He then withdrew 40,5 from the ATM.

#### Answer

Find
: `(?<![^\d])\.`

Replace
: `,`


## The importance of zero-width (TODO)

*This section will contain some advanced lookaround examples*
