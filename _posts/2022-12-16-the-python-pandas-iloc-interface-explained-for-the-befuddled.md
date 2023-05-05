---
date: 2022-12-16
title: The Python Pandas .iloc Interface Explained For The Befuddled
headline: Master the .iloc Interface of Pandas for Data Manipulation
description: I'm sharing my knowledge of how to use Pandas, a data manipulation tool, to select columns from a DataFrame by using its name or the .loc or .iloc interfaces. I'll explain how to use slices to specify row and column ranges, how to use a colon to select all rows, and why the Pandas API has chosen to drop the use of square-brackets for slices.
keywords: Python, Pandas, .iloc, DataFrame, Slicing, Strings, API, Square-Brackets, Colon, Positional Argument, Rows, Columns
categories: api, python, pandas
permalink: /blog/the-python-pandas-iloc-interface-explained-for-the-befuddled/
layout: post
---

category: pandas

If your data is in rows and columns, chances are, Pandas is your answer. You
don't even need to use a database. Rather, Pandas is based on loading data into
memory, doing manipulations as you would in Excel or SQL, and then sending it
along. Loading and saving .csv files is very common.

### Selecting Column From Pandas DataFrame By a Numeric Index

If you want to grab a column out of data, you just name the column directly on
your DataFrame object. So with the dataframe created like this:

    cols = ["col1", "col2", "col3"]
    lol = [("foo", "bar", "baz"), ("fee", "fi", "fo"), ("bippity", "boppity", "boo")]
    df = pd.DataFrame(lol, columns=cols)

So your Pandas DataFrame (df) looks like this:

          col1     col2 col3
    0     foo,      bar  baz
    1      fee       fi   fo
    2  bippity  boppity  boo

You can easily ask for the first column of data by simply using its name
(a.k.a. column-label) like this and it is by far the most common use-case.

    df["col1"]

...and it would return column 1 as a Pandas Series:

    0        foo
    1        fee
    2    bippity
    Name: col1, dtype: object

Sometimes you want your column-selection to return a Pandas DataFrame instead
of a series. For that, you simply use square-brackets around your requested
column, implying you ***might*** ask for more columns, and thus a DataFrame is
more appropriate to return than a Series:

    df[["col1"]]

...returns:

          col1
    0     foo,
    1      fee
    2  bippity

...which is a DataFrame instead of a series. Get it? Ask for the column without
the request being in a list and you get a Pandas Series. Ask for a column (or
columns) inside a list, and you get a Pandas DataFrame back. The optional use
of square-brackets in Pandas is very important.

### The movement towards .loc and .iloc

There's been a movement in Pandas to go through the more formal interfaces .loc
and .iloc to do such manipulations. You have less chance of altering the
original DataFrame or blowing up memory by making accidental copies. So the
above is also accomplished with:

    df.loc[:, ["col1"]]

...which also returns:

          col1
    0     foo,
    1      fee
    2  bippity

...but now you're starting to be exposed to the strange colon comma colon
interface of .loc and .iloc. They both take row and column descriptors which
could be either lists or slices.

If you didn't know the column label, you can simply switch from the .loc
interface to the .iloc interface. Again we see the mysterious colon-comma:

    df.iloc[:, [0]]

...which also returns:

          col1
    0     foo,
    1      fee
    2  bippity

At first such an API arrangement can be confusing. What the heck is the
colon-comma before the list? This is about the most confusing thing in the
world, because why wouldn't it just be df[0] for the zero'th column or df[1]
for the 2nd column like everything else in Python?

Why the :, and why the list to specify the 1st column? Well, the answer is that
we naturally speak rows and columns, so the row indexing information comes
first, and there's a bit of Pandas API magic going on here. First, understand
that you can get the whole dataframe with this:

    df.iloc[:, :]

In the case of this particular DataFrame, another way to get back the identical
results would be to say:

    df.iloc[0:3, 0:3]

This is using the slice-API where the slices are row and column ranges,
respectively. How do we do the same thing with the list API? Easy, we address
each row and each column by numeric index:

    df.iloc[[0, 1, 2], [0, 1, 2]]

With positional arguments, you can't skip the first and set the second without
a comma. The mysterious naked colons go away because there are lists in their
place. The only way to get rid of the comma is to only ask for rows:

    df.iloc[[0, 1, 2]]

...but if we ask for only columns, we have to say "all rows" like this:

    df.iloc[:, [0, 1, 2]]

Crazy, right? But in regular Python, a colon with no numbers has exactly the
same meaning, and Pythonistas worldwide use variable[:] in place of
variable.copy() all the time. Same thing. A refresher on slicers. Say you
wanted Hello World to say ello orl. You'd do this:

    x = "Hello"
    y = "World"
    print((x[1:4], y[1:4]))

Which outputs:

    ('ell', 'orl')

So you see there are 2 slices defined and they're wrapped in the parenthesis of
the tuple so they can be fed together into the print statement. Leaving off the
value after the colon means "to the end":

    print((x[1:], y[1:]))

Outputs:

    ('ello', 'orld')

And likewise leaving the number off before the colon implies from the
beginning:

    print((x[:4], y[:4]))

Outputs:

    ('Hell', 'Worl')

So if you leave off both, you get the whole slice of each:

    print((x[:], y[:]))

Outputs:

    ('Hello', 'World')

Theefore if you have a required positional argument that supports either a
slice or a list and you want to say "everything" (all rows in this case), you
can simply put a naked colon in the required positional argument:

    df.iloc[:, [0]]

The way to remember this is that .loc and .iloc support 2 arguments, one on
either side of the comma, but it's always in the order: rows, columns.

You can't skip saying ***something*** for rows because it's in the required
first positional argument, and since it supports the slice API, you can just
throw in a colon comma (saying ***all rows***) and get onto specifying columns.

It's also important to mention that the Pandas API has decided to drop the use
of square-brackets for slices in their API and use them only instead for lists.
It's part of the power of Python that package developers can do whatever the
heck they want with APIs, overwriting traditional behavior or the meaning of
symbols. For example, the pathlib changes the meaning of forward-slash from the
mathematical division operator to appending Path(directory / locations), and so
too is Pandas changing how slices are defined inside its own objects.

And I guess it has to be mentioned that things get convoluted because rows
comes first. Nobody says "columns and rows". We all say "rows and columns". If
we lived in a bizarro world where we said things backwards, using the .iloc
interface to select columns would be much easier:

    df.iloc[0]

...but that actually chooses ***row 1!*** It still works, but it's choosing row
1 by its numeric index location. Things are much simpler when you're using only
the first position in location-sensitive APIs. But because we don't live in
that bizarro world where we say "columns and rows", we have to put the syntax
for "all rows" in position 1 so we can get to specifying columns. And those who
think Pythonically know that the way to specify a slice from the beginning to
the end is this:

    [:]

...and since Pandas leaves off the extra nested square-brackets as implied, and
Pandas insists on a slice for even a single column (least we get a Series
back), the counter-intuitive but extremely common use-case for grabbing columns
by list-index:

    df.iloc[:, [0]]

or by slice-index:

    df.iloc[:, 0:1]

Pshwew! Hope that helps. If so, follow me on YouTube and the social medias for
more.


<div class="post-nav"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/rotating-logo-returns-and-key-advice-in-life">Rotating Logo Returns and Key Advice in Life</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/e-e-a-t-the-new-google-quality-guidelines">E-E-A-T The New Google Quality Guidelines</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/api/'>API</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li></ul>