# Changing phone format (TODO)

Todo: This was moved over from a different chapter. Need to rewrite introductory guff.


## Telephone game


If you've ever signed up for something on the Internet, you've undoubtedly entered your phone number in an HTML form. And you've probably noticed that some forms are smarter than others.

For example, some forms will automagically handle the formatting of the phone number. As you type, it'll insert dashes and parentheses so that it's easy for you to read. Thus, typing in:

     5556667777

Will show up in your web browser (through the magic of Javascript) as this:

     (555)-666-7777

However, on less sophisticated websites, the web forms might tell you explicitly how the number should be formatted. For example, it might read "Please do not use dashes." Or, "Please enter your number in XXX-YYY-ZZZZ" format. And if you don't follow the instructions, the form rejects your submission.

Hopefully, you know enough about regexes to wonder: *Why don't they just use regexes to flexibly adapt to what a user enters?* And you would be right, in my opinion, to accuse them of lazy programming.

But let's not just sulk about it. Let's see what the actual technical hurdle is in implementing an auto-formatting feature.

We'll start out with how to match the simplest form of a (standard U.S.) phone number. And then we'll add more and more variation to the possible phone number formats and adjust our regex to become more inclusive.

For each exercise, the goal is to convert any given phone number to the following format:

     (555)-666-7777

##### Exercise: A solid line of digits

The simplest form of phone number is just 10-digits in a row, with no dashes or space in between them:

     5552415010
     5559812705
     9112400000
     1015557745

**What's the pattern?**

##### Answer

In English
: Ten numerical digits. However, we want to separate them into three segments, so we'll need capturing groups.

Find
: `(\d\d\d)(\d\d\d)(\d\d\d\d)`

Replace
: `(\1)-\2-\3` 



### Curly braces for known repetition

Before we move on, let's see if there's a better way to handle a *known* quantity of repetition. In our telephone number exercise, we *know* that we need to partition out the 10 digits into 3 digits, 3 digits, and 4 digits.

We can't use the `+` operator because it matches *one-or-more*. But there is a finer-grained regex technique to capture an exact number of repetitions:

T> ## Curly braces for matching a specific quantity of repetitions
T>
T> To capture *n* repeated instances of a pattern, enclose *n* (where *n* is the number of repetitions) inside **curly braces**
T>
T> The following pattern:
T>> `a{4}`
T> &ndash; will match *exactly* four `a` characters

Let's use the **curly braces** to simplify our phone number regex:

Find
: `(\d{3})(\d{3})(\d{4})` 

Replace
: `(\1)-\2-\3`

That's a bit easier to read; at a glance, we can immediately see how many digits we're matching in each captured group. There is some extra "visual complexity" in that we have (curly) braces nested inside other braces (parentheses, in this case). But nested braces is just something your brain will have to get used to deconstructing.

##### Exercise: Grouped digits, possibly separated by spaces

Instead of requiring users to give us 10 straight digits, we allow them to use spaces. Why might we do this? Because it reduces mistakes on the *user* end. Sure, they might know their phone number as well as their birthdate. But using spaces lets them more easily spot typos. Compare reading `5553121121` to `555 312 1121`

So now our regex has to expect this kind of input (as well as 10 straight digits):


     5552415010
     555 981 2705
     9112400000
     101 555 7745

###### Answer

We want to match 10 numerical digits in three capturing groups. However, there may or may not be a space between each group.

This is a perfect time to use the `?` operator.


Find
: `(\d{3}) ?(\d{3}) ?(\d{4})` 

Replace
: `(\1)-\2-\3`

The question mark signifies that the preceding whitespace character is *optional*. Note that the **Replace** value doesn't have to change, because the capturing group still contains the same number of digits.

##### Exercise: Grouped digits, possibly separated by a hyphen or a space

Many people use hyphens instead of space-characters to separate their phone digits. We need to change our regex to match that possibility.

     555-241-5010
     555 981 2705
     9112400000
     101-555 7745


**What's the pattern?**

We want to match 10 numerical digits in three capturing groups. However, there may or may not be a space &ndash; *or a hyphen* &ndash; between each group.

We can use the `?` operator as before, but we'll throw in a character set to handle either a hyphen or a whitespace character.

###### Answer

Find
: `(\d{3})[ \-]?(\d{3})[ \-]?(\d{4})` 

Replace 
:`(\1)-\2-\3` 

Let's focus on the regex we use to match *either a hyphen or a whitespace character*:

     [ \-]

So there's a space in there. But what's with the *backslash-hyphen*? Recall that hyphens, when *inside square brackets*, become a special character. For example, `[a-z]`, is the character set of lowercase letters from `a` to `z`.

Thus, when we want to include a *literal* hyphen inside a square-bracketed character set, we need to **escape it with a backslash**.

One more thing to note: the square brackets act as a sort of grouping: thus, the `?` makes optional either the hyphen *or* whitespace character (and whatever other characters we want to include in those square brackets).

##### Exercise: Exactly 10 digits

So our web-form will now correctly handle a 10-digit phone number that may or may not have hyphens/spaces. 

But what happens when the user enters in *more* than 10-digits? If you apply the previous solution to the following number:

    25556164040

The pattern will match this and the replacement will end up as:

    (255)-561-64040

In a real-life application, we do not want our regex to be flexible enough to accept this. Why? Because this kind of input indicates that there is an error by the user. Maybe that initial `2` is a typo. Or maybe his finger slipped at the end and added an extra `0`. Either way, we do not want our regex to match this. We want the user to know that he possibly screwed up.


###### Answer

**What's the pattern?**

We want to match *only* phone numbers that contain exactly 10 digits (with optional spaces/hyphens) on a *single line*.

In order to do this, we make our regex more *rigid*. We can do this by using the line anchors `^` and `$` to indicate that we don't expect any other kinds of characters besides the 10-digits and the optional hypens/spaces.


Find 
: `^(\d{3})[ \-]?(\d{3})[ \-]?(\d{4})$` 

Replace 
: `(\1)-\2-\3` 

If you apply it to these sample numbers:

    25556164040
    5556164040

You will end up with:

    25556164040
    (555)-616-4040

The first number is not transformed because it is not matched by the pattern.


##### Exercise: Dial 1?

If you've ever moved from office to office, one of the perplexing questions is: *Do I have to dial 1 to make an outside call?*

So some people are used to having `1-` be a part of their phone number, especially if they're using their office phone. Some of these people might add this prefix to their number out of reflex:

     1-555-241-5010
     555 981 2705
     9112400000
     1 101-555-7745






###### Answer

In English
: The same as before, except that the ten-digits *might* be preceded with the digit `1` *and also might* be preceded by a hyphen *or* a whitespace character. There's no new technique here. We just need to use the `?` operator at least once more.

Find
: `^1?[ \-]?(\d{3})[ \-]?(\d{3})[ \-]?(\d{4})$`

Replace
: `(\1)-\2-\3` 

This pattern does the job of matching an optional `1` as well as an optional hyphen or whitespace *before* the actual ten digits of the phone number. We can use the same value for the **Replace** field because we're using the same captured groups.

If you apply it to the following numbers:

    5556164040
    1 555 2929010
    2 555 616 4040

The resulting transformation is:

    (555)-616-4040
    (555)-292-9010
    2 555 616 4040

The last number is *not transformed* because its prefix is a `2`, which is something we don't expect (in a standard U.S. number).


### A more precise grouping

There's something a bit off to the previous solution. Since *both* the `1` *and* the whitespace/hyphen are optional, that means our regex would also  match the following:

    -555-212-0000

And turn it into:

    (555)-212-0000

You might think: *Yeah, so?* Well, it's true that there's *probably* no harm done in matching (and then ignoring) a stray hyphen, sometimes you have to ask, *why is there a stray hyphen without a 1?* It may be harmless to us, but it might indicate that the user misunderstood what was supposed to be the phone field. Perhaps they're trying to enter an international format and got cutoff. 

Who knows. But just to be safe, let's make our regex more *rigid* so that it *won't* match that kind of input. In other words, we want a regex that matches:

     `1-555-212-0000`

But not:

     `-555-212-0000`

A little obsessive-compulsive, maybe, but let's just do it for practice.

**What's the pattern?**

We're looking for the standard 10-digit number that *may* be preceded by a `1` *and* either a hyphen *or* a whitespace character (compare this to the previous pattern we looked for).

Remember from the previous chapter that parentheses act as a way to group parts of a pattern together. So let's try the following:

Find
: `^(1[ \-])?(\d{3})[ \-]?(\d{3})[ \-]?(\d{4})$` 

Replace
: `(\1)-\2-\3` 

Apply it to the following sample input:

    5552415010
    1 555 981 2705
    1-9112400000
    -101 555 7745

And you will get:

    ()-555-241
    (1 )-555-981
    (1-)-911-240
    -101 555 7745


What the? The very last number wasn't affected, which is what we wanted. But the matched patterns got replaced by non-sensical values.

The problem is our use of an extra set of parentheses *without* modifying our **Replace** value. Remember that when using **backreferences**, the numbers correspond to each sequential captured group.

In other words, `\1` no longer refers to `(\d{3})` but to `(1[ \-])`, which is simply the optional `1-` prefix.

There are two ways to fix this. The (intellectually) lazy (but more physically demanding) way is to alter the **Replace** field to correspond to the extra captured group:

|**Replace** | `(\2)-\3-\4` |

This works because it effectively throws away the first captured group.

But if we're going to throw away that first group, why even capture it at all (remember, we're still in obsessive-compulsive mode)?

If you remember from the chapter on **capturing groups**, there was a way to designate that a set of parentheses was **non-capturing**:

     (?:whatever-we-want-to-capture)

Remember when I said earlier in this chapter that that `?` character has multiple meanings? In this case, the `?` &ndash; when it comes *immediately* after a `(` *and* followed by a **colon** character &ndash; denotes that the parentheses is not intended to store a **back-reference**.

So, the cleaned-up (but more complicated-looking) solution:

Find
: `^(?:1[ \-])?(\d{3})[ \-]?(\d{3})[ \-]?(\d{4})$` 

Replace
: `(\1)-\2-\3` 

When we apply it to:

	5552415010
	1 555 981 2705
	1-9112400000
	-101 555 7745

We get:

	(555)-241-5010
	(555)-981-2705
	(911)-240-0000
	-101 555 7745

--------


The upshot of this chapter, besides introducing the `?` as the *optional* operator, is to show how a simple regex can slowly become more-and-more complicated, even as we still understand its basic purpose.

Remember that our first solution looked like this:

    (\d{3})(\d{3})(\d{4})

And we ended up with:

    ^(1[ \-])?(\d{3})[ \-]?(\d{3})[ \-]?(\d{4})$

And yet both variations handle the same problem: how to match a U.S. 10-digit phone number.

So maybe handling all kinds of phone numbers *isn't* as simple as we thought (though every mediocre programmer should be able to figure this out). We could add a few more variations &ndash; what if there were more than one space (or hyphen) separating the numbers? what if the spaces/hyphens grouped the numbers in a different pattern than 3-3-4? &ndash; but I think we're all phoned out for now.

