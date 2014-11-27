{#laziness}
# Laziness and greediness

In this chapter, we'll take a closer look at how the `+` operator works. And we'll learn how to modify it so that it's not so "greedy."


## Greediness

This book doesn't take a close look at the internals of the regular expression engine. But we can still glean some insight by observing how it behaves.

Take the `+` operator, often by default is considered to be **greedy**.

When we pair it with a literal character, such as `a`:

	a+
	
We're telling the regex engine to essentially gobble up all consecutive `a` characters, as below:

> The sheep goes, "B**aaaaaaaa**"

When paired with a non-literal character, such as a character class, the `+` operator's greediness can act as a convenient catch-all. Let's say we wanted to replace everything inside quotation marks, knowing that the text consists completely of **word characters** without any spaces or punctuation:

> The sheep says "Cowabunga" to those who approach it.

Then the following regex does what we need:

Find
: `"\w+"`

Replace
: `"Hello"`
	
The regex engine starts its match when it finds the first quotation mark, then continues to the word character that immediately follows &ndash; `C` &ndash; and continues to capture each successive word character until it reaches the closing quotation mark.

But what happens if the quotation contains **non-word characters**?

> The sheep says "Cowabunga!" to those who approach it.

In this situation, the regex engine finds the first quotation mark, continues to match `Cowabunga`, but then stops at `!`, because exclamation marks are not word characters. 

In English, our regex pattern can be expressed as: *Match the text that consists of only word characters in between quotation marks*. Because `Cowabunga!` contains a non-word character, the regex engine quits before it reaches the closing quotation mark. In other words, the regex engine will fail to match anything and the replacement doesn't happen.


### Being too greedy

In the previous chapter, we learned about the **dot** operator, which will match any kind of character. This seems like just what we need, right?

Given the following text:

> The sheep says "Cowabunga!" to those who approach it.

Find
: `".+"`

Replace
: `"Hello"`

The result is:

> The sheep says "Hello" to those who approach it.


However, there's a serious problem with this solution. Given a more complicated phrase:

> When the sheep says "Cowabunga!", the cow will reply, "Baa! Baa!"

&ndash; when we apply the previous solution, we end up with:

> When the sheep says "Hello"

What happened? We got burned by **greediness**. 

Let's express the regex &ndash; `".+"` &ndash; in English: *Match a quotation mark and then match every character until you reach another quotation mark.*

That seems straightforward. But consider the power of the **dot**: it matches *any* character, except for newline characters. And "*any* character" includes the quotation mark.

So in our example text:

> When the sheep says "Cowabunga!", the cow will reply, "Baa! Baa!"

There's at least three ways that the regex engine can satisfy our pattern:

It could stop at the second quotation mark:

> When the sheep says **"Cowabunga!"**, the cow will reply, "Baa! Baa!"

*Or* it could keep going until the *third* quotation mark:

> When the sheep says **"Cowabunga!", the cow will reply, "**Baa! Baa!"

*Or* it could just go for broke until the *fourth* quotation mark, after which there's no other quotation marks to match:

> When the sheep says **"Cowabunga!", the cow will reply, "Baa! Baa!"**

All three matches satisfy our desired pattern: *A quotation mark, then any and all kind of characters, and then a quotation mark*. But by using the `+` operator, we've told the regex engine to grab as much of the text as possible, i.e. until the *fourth* and final quotation mark.

Hence, the term, **greediness**

## Laziness

Now that we know what greediness is, **laziness** is pretty easy to understand: it's the *opposite* of greediness.

Laziness is expressed by adding a **question mark** immediately after the `+` operator:

	".+?"


------

	
Going back to our example text:

> When the sheep says "Cowabunga!", the cow will reply, "Baa! Baa!"
	
The regex engine will start matching at the first quotation mark. The `.+` syntax will match `Cowabunga!` &ndash; but when the engine reaches that second quotation mark, it effectively says, "Well, my job is done!".

**Note:** The above description is a vast simplification of what's going on under the hood. But for our purposes, it's enough to understand that `.+?` is "reluctant" to deliver more than it needs to. In contrast, the `.+` regex is "eager" to match as much of the string as possible.

So doing a **Find-and-Replace-All** with the **laziness** operator has the desired effect:

Find
: `".+?"`

Replace
: `"Hello"`

Result:

> When the sheep says "Hello", the cow will reply, "Hello"

**Note:** Just a reminder: when we use the text-editor's **Replace-All**, as opposed to just a single **Replace** action, it's the **text editor** that continues looking for matching pattern, not the regex engine. The regex engine is revved up twice to match both instances of the pattern. If we didn't use **Replace All**, the resulting text would be:

> When the sheep says **"Hello"**, the cow will reply, "Baa! Baa!" 


#### Exercise: HTML to Markdown anchors

The **Markdown** language is a popular, alternative way to write HTML. It's not important to know HTML or Markdown for this exercise; all you need to know is what an anchor link looks like in both syntaxes: 

In HTML:

	<a href="http://example.com">Some link</a>
	
In Markdown, that same link is:

	[Some link](http://example.com)
	
Markdown is popular because it's easier to read and write &ndash; in fact, this whole book is written in Markdown. However, web browsers don't interpret Markdown. Usually web developers write in Markdown and use a separate utility to transfer it to HTML (and back).

So, given:

> `Today, I built a <a href="http://example.com">website</a> which is now listed <a href="http://www.google.com">on various search engines</a>.`

Write a regex to change it to Markdown syntax:

> `Today, I built a [website](http://example.com) which is now listed [on various search engines](http://www.google.com)`

#### Answer


Find
: `<a href="(.+?)">(.+?)</a>`

Replace
: `[\2](\1)`

**Note:** *This is a pretty loose answer that would work only on this particularly simple HTML example. For real-life HTML, it is generally not wise to try to parse a page with regexes only.*

### Laziness and the star

The laziness operator can be used with the **star** operator for those cases when there are *zero-or-more* instances of a pattern.

#### Exercise: Messier HTML to Markdown anchors

Again, it's not wise to try to parse HTML with regexes alone, especially if the HTML comes from a variety of authors and styles.

As a simple example of how complicated HTML can get, here's what happens when anchor tag markup has attributes inside it:

> `Today, I built a <a href="http://example.com" style="color:green;">website</a> which is now listed <a class="header remoteLink" href="http://www.google.com">on various search engines</a>.`

To convert to Markdown, all we care about is the `href` attribute. However, using our regex from the previous solution &ndash; `<a href="(.+?)">(.+?)</a>` &ndash; nets us this incorrect conversion:

> `Today, I built a [website](http://example.com" style="color:green;) which is now listed <a class="header remoteLink" href="http://www.google.com">on various search engines</a>.`

Use the **star** and laziness operator to convert this more-complicated HTML into Markdown.

#### Answer

The trick here is that the non-`href` attributes can come *before* or *after* the `href` attribute:

* `<a href="http://example.com" style="color:green;">`
* `<a class="header remoteLink" href="http://www.google.com">`
	
With the **star** operator, we can repeat a catch-all pattern for either situation. This pattern &ndash; `.*?` &ndash; need not be capturing, since all we care about is the `href` attribute:

Find
: `<a.*?href="(.+?)".*?>(.+?)</a>`

Replace
: `[\2](\1)`

**Note:** While the regex patterns we've learned are very flexible, do not think that there's a masterful regex that deals with all the edge cases floating out on the Web. The exercises above are just meant to be simple examples and they *may* work for simple real life scenarios, such as when all the HTML you're dealing with comes from one source.

If you're wondering, "Well, then how *are* we supposed to parse HTML?" That's something you want to learn a little programming and scripting for. Libraries such as [Nokogiri for Ruby](http://nokogiri.org/) and [Beautiful Soup for Python](http://www.crummy.com/software/BeautifulSoup/) handle the heavy lifting of correctly parsing HTML. (If you're wondering, "Why parse HTML in the *first place*?" Web scraping &ndash; the automatic extraction of data and useful bits from website &ndash; is a common use case.) 

--------

The difference between laziness and greediness is subtle, but it's important to understand it when you're trying to do a catch-all pattern that you'd prefer *not* catch *everything.*  In fact, the lazy version of a regex will generally be more useful than the greedy version when it comes to real life dirty text processing.