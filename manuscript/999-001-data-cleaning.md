# Data Cleaning with the Stars

Anyone can do smart analyses when the data is nicely organized and delivered in a spreadsheet. But when it's just straight text, that's where regexes separate the resourceful from the poor chumps who try to clean up the text by hand, or give up all together.


This chapter contains a few examples of dirty data and how regexes can get them ready for the spreadsheet.


## Normalized alphabetical titles

Even alphabetical-sorting can be a pain, if you're dealing with titles. The definite and indefinite articles &ndash; "the" and "a" or "an", respectively &ndash; will give us a disproportionate number of titles in the "A" and "T" part of the alphabet:


	A
	A BEAUTIFUL MIND
	A FISTFUL OF DOLLARS
	AN AMERICAN IN PARIS
	STAR TREK II: THE WRATH OF KHAN
	THE APARTMENT
	THE BIG LEBOWSKI
	THE GODFATHER
	THE GOOD, THE BAD, AND THE UGLY
	THE GREAT GATSBY
	THE KING AND I
	THE LORD OF THE RINGS: THE RETURN OF THE KING
	THE SHAWSHANK REDEMPTION
	THE WRESTLER
	
	
	


In order for us to sort these titles alphabetically, we need to remove [definite and indefinite articles](http://en.wikipedia.org/wiki/Article_(grammar)) from the titles, e.g. "THE" and "A/AN". 

A simple find-and-delete for the word `THE` won't work:

	LORD OF RINGS: RETURN OF KING


We need to remove the articles *only* if they appear at the *beginning of the title*.  And, moreover, we need to *append them to the end of the title*, with a comma:

		LORD OF THE RINGS: THE RETURN OF THE KING, THE
	

Let's break this into two steps; first, the article: Use the beginning-of-line anchor and the alternation operator to capture just the "THE"'s at the start of a movie's title:

	^(THE|AN?)

Then the rest of the title can be captured with the dot operator:

	(.+)

All together:

Find
: `^(THE|AN?) (.+)`

Replace
: `\2, \1`

This results in a list of titles that can be sorted alphabetically:

	A
	AMERICAN IN PARIS, AN
	APARTMENT, THE
	BEAUTIFUL MIND, A
	BIG LEBOWSKI, THE
	FISTFUL OF DOLLARS, A
	GODFATHER, THE
	GOOD, THE BAD, AND THE UGLY, THE
	GREAT GATSBY, THE
	KING AND I, THE
	LORD OF THE RINGS: THE RETURN OF THE KING, THE
	STAR TREK II: THE WRATH OF KHAN

As a bonus, notice that our regex doesn't screw up the movie titled *A* by converting it to `, A`. Our regex requires that at least one space and a non-newline character exist on the same line.



## Make your own delimiters

Sometimes interesting data comes to you in clumps. Here's a sample of [movies with IMDb user ratings](http://www.imdb.com/chart/top):

	The Godfather: Part II R 9 1974
	Pulp Fiction R 8.9 1994
	8½ NR 8.1 1963
	The Good, the Bad and the Ugly R 8.9 1966
	12 Angry Men PG 8.9 1957
	The Dark Knight PG-13 8.9 2008
	1984 R 7.1 1984
	M NR 8.5 1931
	Nosferatu U 8 1922
	Schindler's List R 8.9 1993
	Midnight Cowboy X 8 1969
	Fight Club R 8.8 1999
	

It'd be nice if we could do something like graph the correlation between user rating and when a movie was made, or what MPAA rating it got. But we have to first separate those values into their own fields. 

But it's not trivial. The MPAA ratings can contain anywhere from one (e.g. "R") to five characters (e.g. "PG-13"). The user ratings can be integers or include a decimal point. And finally, the titles can be as short as one letter or no letters at all.

One way to approach this is to **work backwards**, because the most reliable part of the pattern is the *year* the movie was produced. The pattern to capture that is simply:

	\d{4}$

The next part is *IMDb user rating*. At the very least it contains one digit. And it may optionally include a decimal point and a second digit. Such a pattern could be expressed as:

	\d\.?\d?
	
This seems a little loose to me, but I suppose we also have to prepare for the unlikely case that a movie has a perfect `10` rating, which the above pattern would be flexible enough to match.

The next datapoint to capture is the *MPAA rating*. This is the most complicated, though only in appearance. You could easily capture this field like so:

	G|PG|PG-13|R|NC-17|X|U|NR|M|MA
	
If you want to challenge yourself to write something less literal, you could practice using character sets and optionality:


	[GMNPRUX][ACGR]?(?:-\d{2})?

Finally, we have the title. This seems like the trickiest part, since the titles can be of variable length and contain any type of character, including punctuation. 

However, this should work for our purposes:

	^.+?
	
Why does this work? The `.+?` regex seems like it would inadvertently scoop up non-title parts of the line. Luckily for us, the rest of the line's data points are more or less consistently. Whatever the **dot-plus** swallows, it has to leave a minimum of structured fields in the right most part of the pattern.

So even if we have a movie named "X X 9 1999", with a rating of "R", a user rating of "8", and a production year of "2000":

	X X 9 1999 R 8 2000
	
The title-capturing part of the regex would stop at `1999` because it has to leave at least one rating-type pattern (`R`), one user-rating-type pattern (`8`), and a four-digit number at the very end (`2000`).



All together now:

Find
: `^(.+?) ([GMNPRUX][ACGR]?(?:-\d{2})?) (\d\.?\d?) (\d{4})$`

Replace
: `\1\t\2\t\3\4`

Or, if you prefer comma delimited style:
: `"\1","\2","\3","\4"`


	"The Godfather: Part II","R","9","1974" 
	"Pulp Fiction","R","8.9","1994" 
	"8½","NR","8.1","1963" 
	"The Good, the Bad and the Ugly","R","8.9","1966" 
	"12 Angry Men","PG","8.9","1957" 
	"The Dark Knight","PG-13","8.9","2008" 
	"1984","R","7.1","1984" 
	"M","NR","8.5","1931" 
	"Nosferatu","U","8","1922" 
	"Schindler's List","R","8.9","1993" 
	"Midnight Cowboy","X","8","1969" 
	"Fight Club","R","8.8","1999" 
