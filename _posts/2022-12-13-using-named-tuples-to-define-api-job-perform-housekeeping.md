---
date: 2022-12-13
title: Using Named Tuples to Define API-job & Perform Housekeeping
headline: Using Named Tuples to Store and Track Data Over 12 Months
description: I'm using named tuples from the Python standard library to store data in a SqliteDict file-handle as a database-dict. I've created a named tuple datatype, Arg, to store the site, start date, and end date for each loop iteration. I'm using a bit of code to output the first and last day of each month for the past year in the format of dd/mm/yyyy.
keywords: Python, Named Tuples, Standard Library, SqliteDict, File-Handle, Database-Dict, Arg, Date Range, dd/mm/yyyy, 12-Month Period, 3rd Party Package, Str(), Eval(), Unique-Constraint
categories: sqlitedict, python
permalink: /blog/using-named-tuples-to-define-api-job-perform-housekeeping/
layout: post
---

category: python

### Nested Loops for Cartesian Product Args

Let's say you have to look something up for every website in a list, and for
every date in a date-range. It's called a Cartesian Product when everything
from list-1 combines with everything from list-2 to create all the
combinations, and this is how you do it:

    for asite in sites:
      for adate in daterange:
        process(asite, adate)

But when this is done, how do you know that all the sites and dates processed?

### What's Better Than a Nested List?

One of the best tricks in Python is to populate a bunch of "Named Tuples" ahead
of time with all the values that are going to be required for all the lookups.
This gets rid of nested-loop complexity and lets you work from a single list
that contains all the combinations. The data-type you use in such flattened
bundles of API-calls is a tuple. Tuples are like short lists.

But there's a type of tuple that does an even better job of making this process
even more readable and usable called a ***namedtuple***. Named Tuples come from
collections in the Python standard library and you import them like this:

    from collections import namedtuple

It's worth mentioning for anyone reading this not familiar with a plain old
tuple, they're a lot like lists but can't be resized. Why would you use a list
that isn't dynamic? Because it's very memory-efficient (whereas lists are not).
And like lists, tuples are based on positions (not labels) like so:

    atuple = (1, 2, 3)

You'd have to grab values out of the tuple just like a list, so if you wanted
the middle value, you'd have to:

    atuple[1]

...which would output "2" (remember, zero-based indexes). But what if this
3-position tuple represented 3D coordinates for CAD or physics? Say we wanted
to "label" the first position x, the second position y and the 3rd position z?
We can define the following Named Tuple:

    Coord = namedtuple("Coord", "x, y, z")

You could break the second half of that into a list ["x", "y", "z"], but why do
all the extra typing if the API lets you use such an awesome shortcut. Thank
you Raymond Hettinger! Eval is not evil.

Okay, now that you have a namedtuple datatype (yes, you created a new
datatype), you can create new coordinate objects like this:

    acoord = Coord(1, 2, 3)

...and string representation of the object looks like this:

    Coord(x=1, y=2, z=3)

...and now you can grab the values out of this object like so:

    accoord.x (outputs 1)
    acooord.y (outputs 2)
    acooord.z (outputs 3)

And so the somewhat clunky square-bracket and numerical index system for
grabbing values out of a tuple can be replaced with dot-notation. That's a big
win right there, but it gets even better when you realize that the positions in
the tuple now have expertly labeled meaning! Code gets easier to write from the
dot-notation and it gets easier to read because the labels remind you know what
things represent.

Okay, so let's say you need to do a lookup for every month over the past year
for a site. Say the API you're using uses dd/mm/yyyy format and you have to
feed it the first day of the month and the last day of the month for each
date-range. This bit of code deserves its own page to explain, but you can do
it like so:

```python
from datetime import datetime
from dateutil.relativedelta import relativedelta

for x in range(12):
    start_date = datetime.now().date().replace(day=1) - relativedelta(months=x)
    end_date = start_date + relativedelta(months=1) - relativedelta(days=1)
    start_date = start_date.strftime("%d/%m/%Y")
    end_date = end_date.strftime("%d/%m/%Y")
    print(start_date, end_date)
```

...which will output this:

    01/12/2022 31/12/2022
    01/11/2022 30/11/2022
    01/10/2022 31/10/2022
    01/09/2022 30/09/2022
    01/08/2022 31/08/2022
    01/07/2022 31/07/2022
    01/06/2022 30/06/2022
    01/05/2022 31/05/2022
    01/04/2022 30/04/2022
    01/03/2022 31/03/2022
    01/02/2022 28/02/2022
    01/01/2022 31/01/2022

Now let's say you have a file that has a list of sites inside of it, which you
can load into Python as a python list like this:

    with open("sites.csv") as fh:
        sites = [x.strip() for x in fh.readlines()]

And with sites in-memory you can now do this:

    for asite in sites:
        print(asite)

...which in my case outputs:

    https://mikelev.in
    https://pipulate.com
    https://levinux.com

And so now we can step through every site in your list for every date-range:

```python
for asite in sites:
    for x in range(12):
        start_date = datetime.now().date().replace(day=1) - relativedelta(months=x)
        end_date = start_date + relativedelta(months=1) - relativedelta(days=1)
        start_date = start_date.strftime("%d/%m/%Y")
        end_date = end_date.strftime("%d/%m/%Y")
        print(asite, start_date, end_date)
```

...which outputs:

    https://mikelev.in 01/12/2022 31/12/2022
    https://mikelev.in 01/11/2022 30/11/2022
    https://mikelev.in 01/10/2022 31/10/2022
    https://mikelev.in 01/09/2022 30/09/2022
    https://mikelev.in 01/08/2022 31/08/2022
    https://mikelev.in 01/07/2022 31/07/2022
    https://mikelev.in 01/06/2022 30/06/2022
    https://mikelev.in 01/05/2022 31/05/2022
    https://mikelev.in 01/04/2022 30/04/2022
    https://mikelev.in 01/03/2022 31/03/2022
    https://mikelev.in 01/02/2022 28/02/2022
    https://mikelev.in 01/01/2022 31/01/2022
    https://pipulate.com 01/12/2022 31/12/2022
    https://pipulate.com 01/11/2022 30/11/2022
    https://pipulate.com 01/10/2022 31/10/2022
    https://pipulate.com 01/09/2022 30/09/2022
    https://pipulate.com 01/08/2022 31/08/2022
    https://pipulate.com 01/07/2022 31/07/2022
    https://pipulate.com 01/06/2022 30/06/2022
    https://pipulate.com 01/05/2022 31/05/2022
    https://pipulate.com 01/04/2022 30/04/2022
    https://pipulate.com 01/03/2022 31/03/2022
    https://pipulate.com 01/02/2022 28/02/2022
    https://pipulate.com 01/01/2022 31/01/2022
    https://levinux.com 01/12/2022 31/12/2022
    https://levinux.com 01/11/2022 30/11/2022
    https://levinux.com 01/10/2022 31/10/2022
    https://levinux.com 01/09/2022 30/09/2022
    https://levinux.com 01/08/2022 31/08/2022
    https://levinux.com 01/07/2022 31/07/2022
    https://levinux.com 01/06/2022 30/06/2022
    https://levinux.com 01/05/2022 31/05/2022
    https://levinux.com 01/04/2022 30/04/2022
    https://levinux.com 01/03/2022 31/03/2022
    https://levinux.com 01/02/2022 28/02/2022
    https://levinux.com 01/01/2022 31/01/2022

Okay, now here's where Named Tuples come in. Can you see it? Let's create a
namedtuple datatype named Arg because each will be the arguments fed to an
interface that takes arguments:

    from collections import namedtuple

    Arg = namedtuple("Arg", "site, start_date, end_date")

And now we can use this in the loop:

```python
from datetime import datetime
from collections import namedtuple
from dateutil.relativedelta import relativedelta

Arg = namedtuple("Arg", "site, start_date, end_date")

for asite in sites:
    for x in range(12):
        start_date = datetime.now().date().replace(day=1) - relativedelta(months=x)
        end_date = start_date + relativedelta(months=1) - relativedelta(days=1)
        start_date = start_date.strftime("%d/%m/%Y")
        end_date = end_date.strftime("%d/%m/%Y")
        arg = Arg(asite, start_date, end_date)
        print(arg)
```

...and this outputs:

    Arg(site='https://mikelev.in', start_date='01/12/2022', end_date='31/12/2022')
    Arg(site='https://mikelev.in', start_date='01/11/2022', end_date='30/11/2022')
    Arg(site='https://mikelev.in', start_date='01/10/2022', end_date='31/10/2022')
    Arg(site='https://mikelev.in', start_date='01/09/2022', end_date='30/09/2022')
    Arg(site='https://mikelev.in', start_date='01/08/2022', end_date='31/08/2022')
    Arg(site='https://mikelev.in', start_date='01/07/2022', end_date='31/07/2022')
    Arg(site='https://mikelev.in', start_date='01/06/2022', end_date='30/06/2022')
    Arg(site='https://mikelev.in', start_date='01/05/2022', end_date='31/05/2022')
    Arg(site='https://mikelev.in', start_date='01/04/2022', end_date='30/04/2022')
    Arg(site='https://mikelev.in', start_date='01/03/2022', end_date='31/03/2022')
    Arg(site='https://mikelev.in', start_date='01/02/2022', end_date='28/02/2022')
    Arg(site='https://mikelev.in', start_date='01/01/2022', end_date='31/01/2022')
    Arg(site='https://pipulate.com', start_date='01/12/2022', end_date='31/12/2022')
    Arg(site='https://pipulate.com', start_date='01/11/2022', end_date='30/11/2022')
    Arg(site='https://pipulate.com', start_date='01/10/2022', end_date='31/10/2022')
    Arg(site='https://pipulate.com', start_date='01/09/2022', end_date='30/09/2022')
    Arg(site='https://pipulate.com', start_date='01/08/2022', end_date='31/08/2022')
    Arg(site='https://pipulate.com', start_date='01/07/2022', end_date='31/07/2022')
    Arg(site='https://pipulate.com', start_date='01/06/2022', end_date='30/06/2022')
    Arg(site='https://pipulate.com', start_date='01/05/2022', end_date='31/05/2022')
    Arg(site='https://pipulate.com', start_date='01/04/2022', end_date='30/04/2022')
    Arg(site='https://pipulate.com', start_date='01/03/2022', end_date='31/03/2022')
    Arg(site='https://pipulate.com', start_date='01/02/2022', end_date='28/02/2022')
    Arg(site='https://pipulate.com', start_date='01/01/2022', end_date='31/01/2022')
    Arg(site='https://levinux.com', start_date='01/12/2022', end_date='31/12/2022')
    Arg(site='https://levinux.com', start_date='01/11/2022', end_date='30/11/2022')
    Arg(site='https://levinux.com', start_date='01/10/2022', end_date='31/10/2022')
    Arg(site='https://levinux.com', start_date='01/09/2022', end_date='30/09/2022')
    Arg(site='https://levinux.com', start_date='01/08/2022', end_date='31/08/2022')
    Arg(site='https://levinux.com', start_date='01/07/2022', end_date='31/07/2022')
    Arg(site='https://levinux.com', start_date='01/06/2022', end_date='30/06/2022')
    Arg(site='https://levinux.com', start_date='01/05/2022', end_date='31/05/2022')
    Arg(site='https://levinux.com', start_date='01/04/2022', end_date='30/04/2022')
    Arg(site='https://levinux.com', start_date='01/03/2022', end_date='31/03/2022')
    Arg(site='https://levinux.com', start_date='01/02/2022', end_date='28/02/2022')
    Arg(site='https://levinux.com', start_date='01/01/2022', end_date='31/01/2022')

So now we're getting there! This is good, except that the namedtuples don't
last very long in that loop. We need them to hang around for awhile so we can
do housekeeping. That is, to be able to step through them again without that
complex code to make the nested loop and so that we can actually use those
values feeding to some API or Web Service.

This is another bit of nifty Python magic and the first time in this example
I'm using a Python package that's not part of the standard library. It makes
Python dictionaries persistent so they can be used like a database. Imagine
your python dicts simply not going away. It's super-cool. Get this package
with:

    pip install sqlitedict

And with it available, you can put all these named tuples into a database:

```python
from datetime import datetime
from collections import namedtuple
from sqlitedict import SqliteDict as sqldict
from dateutil.relativedelta import relativedelta

Arg = namedtuple("Arg", "site, start_date, end_date")

with open("sites.csv") as fh:
    sites = [x.strip() for x in fh.readlines()]

with sqldict('args.db') as db:
    for asite in sites:
        for x in range(12):
            start_date = datetime.now().date().replace(day=1) - relativedelta(months=x)
            end_date = start_date + relativedelta(months=1) - relativedelta(days=1)
            start_date = start_date.strftime("%d/%m/%Y")
            end_date = end_date.strftime("%d/%m/%Y")
            arg = Arg(asite, start_date, end_date)
            db[str(arg)] = None
            db.commit()
```

There's some profoundly cool magic going on here. A file named args.db gets
created on your storage device in the same location where your script is
running. This is the kind of thing you do in Jupyter Notebooks. You wouldn't
write things to the local folder this way if you were doing WebDev, but in just
jockeying data around, it's just fine and certainly the easiest way to go
because paths outside your working directory can be tricky.

But the awesome part is that you can get your values back out of this database
with this simple bit of code:

```python
with sqldict('args.db') as db:
    for key in db:
        arg = eval(key)
        print(arg)
```

I won't re-print all that output, but I will point out a few important facts
here. The 3rd party package SqliteDict that I'm using here only supports
strings as dictionary keys (or database keys, if you prefer). So when we use
them as dict keys going in, we use the str() function to turn the nametuples to
their string equivalents (identical to the eye but not to Python), and likewise
coming out we have to reverse the str() process with the eval() function. This
is important because we need it as its original namedtuple datatype to use it.

Another thing to notice is the "None" being set to the value for that key when
the data goes in. So for each argument, the recorded data is Python's None
value, which means (by the convention we create right here) that that argument
has not been processed yet. If it HAD been processed, we would replace the None
with some other value, like True (for having been processed) or even the output
of the API-call! args.db in this case could actually contain the results, in
which case we would choose a better filename, like results.db.

For my purposes, the result of the API-call is going to be a file that I drop
onto the drive. Now while you CAN shove files into databases (SQLite which is
what we're ***really*** using here supports "blobs"), I think it's better to
drop the file onto the drive and maybe use the filename as the database value.

Just a reminder, we're using Python dicts for the database, so there's a
key/value thing going on. The key/value is currently arg/None, after we
actually make our API-calls, it can become arg/results or arg/filename.

Okay, so when you're using this record keeping in making the API-calls, you now
might do something like this:

```python
with sqldict('args.db') as db:
    for key db:
        data = db[key]
        if not data:
            args = eval(key)

            # This looks like a good place for a splat
            result = positional_function(*args)

            # Or optionally, a dict-style labeled keyword splat
            result = kwargs_function(**args)

            if result:
                db[key] = result
            else:
                # Record failure, or optionally keep it None for a retry
                db[key] = "Failed"
```

Voila! Perfect house-keeping for stepping through all your API-calls. The
amount of cool stuff going on in this example is... well, enough to base a
whole career on. In case you're missing all the awesome nuance, let me lay out
a few important concepts for you.

I mentioned tuples are like memory-efficient lists if you don't have to change
the length of the list. But I didn't mention that because they're a static
data-type, they make pretty darn good dict keys.

Oh, dict keys! Did you know they are a set? That means you can't have a
dictionary with multiple identical keys. The keys in a dict are also in a set,
so that ensures that there are no duplicate keys and that each is unique. That
just wouldn't make sense. As such, dict keys can't be dynamic datatypes (i.e.
mutable) like lists, but they can be static data types (i.e. immutable) like
tuples. So tuples can be dict keys!

    adict[atuple] = almost_any_datatype

And as such, your tuples such as (1, 2, 3) becomes a multi column primary key!
This deserves its own page, but is worth pointing out. E`ven though we're using
something like tuples as keys with the example above where the database-dict is
actually a SqliteDict file-handle, it's important to point out that SqliteDict
doesn't actually allow tuples as keys (regular dicts do), we have to convert
the tuple to a string before using it as a key:

    sqldict[str(atuple)] = almost_any_datatype

We get all the same unique-constraint advantages as if it were a pure tuple key
because it still must be a unique key, albeit not multi-column anymore and we
have to deal with tuple/string conversions here and there. An eval() readily
turns the stringified key back into a tuple.

<div class="post-nav"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/let-the-decrufting-begin/">Let The Decrufting Begin!</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/editing-all-pages-all-at-once/">Editing All Pages All At Once</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/sqlitedict/'>SqliteDict</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li></ul>