{#star-operator}

# Match zero-or-more with the star sign

The plus operator is handy for matching an unknown number of repeating characters or sequences. But sometimes you don't even know if there's even a *single* occurrence of a character.


## The star sign

The star-sign, `*`, is used to match *zero or more* of the pattern that *precedes* it. For example:

	e*

&ndash; matches any occurrence of **zero-or-more** consecutive *letter* `e` characters.

The pattern:

	be*g
	
&ndash; matches:

	beg
	beeeeg
	bg

--------


#### Exercise: Baaa!


The paragraph below has a variety of sheep-based expressions:

> The first sheep says "Baa!" Another sheep says "Baaaa!!!". In reply, the sheep says, "Baaaaaa". Another "Baaa" is heard. Finally, there's a "Baaaa!"


Convert all of them to, simply, "Baa!"

> The first sheep says "Baa!" Another sheep says "Baa!". In reply, the sheep says, "Baa!". Another "Baa!" is heard. Finally, there's a "Baa!"

If we use the **plus operator**, we have:

Find
: `Baa+!+`

Replace
: `Baa!`
	
> The first sheep says "Baa!" Another sheep says "Baa!". In reply, the sheep says, "**Baaaaaa**". Another "**Baaa**" is heard. Finally, there's a "Baa!"	
	
Because the second `+` depends on there being *at least one exclamation mark* in the pattern &ndash; i.e. `Baa!!` &ndash; it fails to match a `Baaa` that *doesn't* end with an exclamation mark.
	
	
#### Answer 	
	
Find
: `Baa+!*`

Replace
: `Baa!`

---------

If you know the plus sign operator, then the star sign is just a slightly more flexible variation.
