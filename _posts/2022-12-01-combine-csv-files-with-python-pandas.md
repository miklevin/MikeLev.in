---
date: 2022-12-01
title: Combine CSV Files with Python Pandas
permalink: /blog/combine-csv-files-with-python-pandas/
headline: Process CSVs Easily with Python Pandas and DrinkMe Linux!
description: Create a new repo in DrinkMe Linux called 'combinecsvfiles' for processing CSVs. Extract information from filenames and add it to rows of the CSV using Python Pandas. Easily stack CSV dataframes in a Python list using 'pd.concat(lot)'. Discover how easy it is to combine CSVs into a single file - just use the code 'df = pd.concat(lot)'!
keywords: Python, Pandas, DrinkMe, Linux, CSV, files, combine, extract, information, filenames, rows, stack, dataframes, list, df, concat, easy, peasy
categories: linux, csv, easy, drinkme, python
layout: post
---

Have you ever had to copy-paste the contents of multiple tabs in Excel or
Google Sheets into one single tab? There are convoluted formulaic ways, but
what if you wanted it to be permanent and formula-less? Just combining all the
CSV or XLSX files from a directory into a single file is what I mean.

In particular when you combine the CSV or XLSX files, it should increase the
number of rows in the resulting output (and not columns). In SQL the concept is
known as a Union. In Excel or Google Sheets, the concept is known as tedious to
the point of impossible for large numbers of files.

As an aside, if the number of columns increased upon combining, it would be
known in SQL as a JOIN or in Excel and Google Sheets as a vastly inferior and
tedious VLOOKUP. Excel and Google Sheets now have embedded "Query" languages
for doing SQL-like things such as traditional SQL Joins, but all that does is
embed more invisible formulas and use unnecessary additional tabs. Both UNIONS
and JOINS, two of the most common data-tasks are infuriatingly difficult with
the world's most popular software for the everyday joe to do this sort of
stuff, relegating it to highly-paid data professionals. That's the state of
things right now. If you can rapidly do UNIONs and JOINs without the overhead
of an entire SQL instance and without the difficult convolutions of desktop
spreadsheet software, then you're golden.

My next project has got to be processing CSVs. I'm going to find the love in
this project by making a new default repo in DrinkMe Linux. Yup.

Okay, we're going to start with a very strong repo name: combinecsvfiles. Make
that folder, done.

This is a very good idea to create a strong nickname for each of the main types
of tasks I do for my career and then to pin them up somewhere easy to find for
myself and others. How about on my homepage?

It's always a good idea to document the code here in my journal as well so that
it exists at least 2 places, and sometimes revealing the evolution of a project.

This code is from doing a number of CSV data file saves from a product called
SEMRush. The files contain important data in the actual filename itself and not
inside the CSV. In other words, if you were to just read the contents of the
CSV file itself, you'd lose what month and year the data is from. The month and
year is revealed only in the filename. So a bit of information "extracted" or
parsed from the filename belongs in the rows, once for each row, the same data
repeated for every row that came from that file. This is how we do it:

```python
import pandas as pd
from pathlib import Path
from time import strptime


lots = []
for afile in files:
    print(afile)
    df = pd.read_csv(afile)
    month = afile.name.split()[2][6:]
    month = strptime(month, "%b").tm_mon
    year = afile.name.split()[3]
    year = year[:4]
    df["month"] = month
    df["year"] = year
    lots.append(df)
```

And so this ends with a list of dataframes. You know how in Python you can do
this:

    table = []
    table.append(1)
    table.append(2)
    table.append(3)

And you end up with the following Python list:

    [1, 2, 3]

Well it turns out you can do the same thing with Pandas DataFrames (or df's)
like so:

    df1 = pd.read_csv("file1.csv")
    df2 = pd.read_csv("file2.csv")
    df3 = pd.read_csv("file3.csv")
    table = []
    table.append(d1)
    table.append(d2)
    table.append(d3)

And now you will have a Python list full of dataframes that looks like this:

    [df1, df2, df3]

Now if the columns are compatible between CSVs (and thus df's too), then you
can just combine them with this single magical million-dollar Pandas command
(a.k.a. function or method, depending on what school you come from).

    df_combined = pd.concat(table)

And that's pretty much it. That's stacking CSV files on top of each other as if
they were copy-pasted from multiple tabs in Excel or Google Sheet all into a
single tab--one of the most tedious tasks imaginable with traditional
spreadsheet software, but easier than one would imagine should be possible with
Pandas.

And so finishing the above code to stack the CSV dataframes held in the Python
list "lot" variable is simply:

    df = pd.concat(lot)

Easy peasy!


## Categories

<ul>
<li><h4><a href='/linux/'>Linux</a></h4></li>
<li><h4><a href='/csv/'>CSV</a></h4></li>
<li><h4><a href='/easy/'>Easy</a></h4></li>
<li><h4><a href='/drinkme/'>DrinkMe</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li></ul>