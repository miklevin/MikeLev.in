---
date: 2022-12-29
title: Planning a Pivot of Big Data Pull
headline: Organizing Big Data Pull with Microsoft Playwright and Python for Best SEO Results
description: I'm organizing data from a browser automation job using Microsoft Playwright and Python. To practice 'Best Foot Forward' SEO, I'm using Google Sheets to create sparklines with linear regression lines. I'm also using pivot tables and group by functions to summarize and analyze the data in Excel and Google Sheets. I'll deliver the data transforms by tonight, and the choice between the two depends on my needs and the complexity of the data.
keywords: Microsoft Playwright, Python, Google Sheets, Sparklines, Linear Regression, Excel, Pivot Tables, Group By, Data Transforms, Browser Automation, SEO, SLOPE Function, Sparkline Color, Sparkline Style, Line Sparkline, Regression Line, Aggregate Columns, Metrics
categories: python, google, microsoft playwright, panda, browser automation, seo
permalink: /blog/planning-a-pivot-of-big-data-pull/
layout: post
group: blog
---


Wow, I'm doing a fairly large Browser Automation job... right now! It's over 1
virtual desktop to the right, because that's where I keep fullscreen JupyterLab
relative to my fullscreen vim journal. I should really live-cast more of me
journaling, especially here in the public one that I push out as blog posts on
[MikeLev.in/blog.](http://mikelev.in/blog/).

Start updating Pipulate. Make it the memetic master copy/paste location for
modern SEO, Data Science & Engineering.

I need a directory structure! Organization is everything.

Browser automation, browser automation, lots of fun with browser automation! I
don't know what you're talking about. We're not using bots. You should see his
hands move over the keyboard! It's just a blur. No way, no how Playwright. Uh,
did I say that out loud? Yeah, Microsoft Playwright is ready for prime time.

I said it before right here in this blog, and I'll say it again.

    python -m playwright codegen --target python-async --save-storage keep.db --viewport-size 1400,1400
    python -m playwright codegen --target python-async --load-storage keep.db --viewport-size 1400,1200

Use Microsoft Playwright for browser automation. I am a Python person and for
quite some time I used pyppeteer which is an unofficial wrapper-package to the
official Google JavaScript NPM library, puppeteer. But it stalled out and a
couple of the main puppeteer developers went to work for Microsoft, and
Microsoft's Edge browser is based on Chrome, and old tech for doing stuff like
this like Selenium and PhantomJS were a bit crusty.

Microsoft threw so much resources behind their port of puppeteer called
playwright that it supports Python as a primary client library made available
for controlling browsers in either asynchronous mode, or the much simpler
synchronous mode.

Unfortunately, and also fortunately (depending on how you look at it), you can
run Microsoft Playwright automations from Jupyter Notebooks. But it has to be
asynchronous mode, and if you haven't worked in asynchronous mode yet, then
something awaits you. I promise.

Wow, when this huge data-pull is done, I'm going to have to do a bit of magical
data transforms, fast! I still have to deliver it tonight.

I'm gonna do it, and I'm gonna use it as an opportunity to practice and sharpen
my message... my message of "Best Foot Forward" SEO. If I want to coin the
phrase, I have to elaborate on it. Hmm, okay. What's a Meta For? Well, for
using in statistical analysis, so you can feed your findings back up to
executive function and use it to do something more productive with your life.

Okay, that's about it. You have to just be able to do stuff generically with
data. I know that sounds stupid and abstract, but maybe with a bit of
visualization tech thrown in to make it sexy, sexy, then it'll grab some
attention. Shall I talk about the holy grail holographic web map? Soon!

There is always other work that interrupts, but even the interruptions are
love-worthy in their own rights and help me chip away at best modern practices.
Let's see... when it comes time to pivot a lot of data? When you pivot
logfile-like data, you're going to get a time-series of data-points ready-made
for plotting. You can use them in spark lines or you can use them with linear
regression.

Asking ChatGPT...

## How do you create sparklines with linear regression lines in Google Sheets?

To create a sparkline with a linear regression line in Google Sheets, follow these steps:

1. Select the cells where you want to create the sparklines.
1. Click the "Insert" tab in the top menu.
1. Click the "Sparkline" button in the charts group.
1. In the "Sparkline" dialog box, select the data range for the sparkline in the "Data" field.
1. Click the "Customize" tab.
1. In the "Customize" tab, select "Linear" from the "Type" dropdown.
1. Click the "Apply" button to insert the sparklines.

You can then customize the appearance of the sparklines and regression lines by using the options in the "Customize" tab, such as changing the colors or adding data markers.

Note: If you want to add a regression line to a sparkline that has already been inserted, you can right-click the sparkline and select "Sparkline color & style" from the context menu to open the "Sparkline" dialog box. Then follow steps 5 through 7 above to add the regression line.

How do you create sparklines with linear regression lines in Excel?

1. Select the cells where you want to create the sparklines.
1. Click the "Insert" tab in the top menu.
1. Click the "Sparkline" button in the "Charts" group.
1. In the "Create Sparklines" dialog box, select the data range for the sparkline in the "Data range" field.
1. Click the "Line" option in the "Type" group.
1. Click the "OK" button to insert the sparklines.

You can then customize the appearance of the sparklines and regression lines by right-clicking the sparkline and selecting "Sparkline Color" or "Sparkline Style" from the context menu.

Note: If you want to add a regression line to a sparkline that has already been inserted, you can select the sparkline and then click the "Sparkline Tools" tab in the top menu. From there, you can use the options in the "Type" group to change the type of sparkline to a line sparkline and add a regression line.

---

Okay, it's clear. There's plenty of roads to regression. I wonder if you can
get a coefficient for sorting?

Oh, I know... ask the Bot!

How do you get the coefficient of a linear regression sparkline in excel for sorting?

To get the coefficient of a linear regression sparkline in Excel, you can use the SLOPE function. This function calculates the slope of the regression line based on the data in the sparkline.

Here's an example of how to use the SLOPE function:

- Select the cell where you want to display the coefficient of the linear regression sparkline.
- Type the following formula:

    =SLOPE(data_range)

Replace "data_range" with the range of cells that contain the data for the sparkline.

For example, if your data is in the range A1:A10, you would use the following formula:

    =SLOPE(A1:A10)

- Press "Enter" to display the coefficient of the linear regression sparkline in the selected cell.

You can then use this coefficient in a sorting operation by using the SORT function or by using a custom sort criteria. For example, you could use the following formula to sort a range of cells based on the coefficient of the linear regression sparkline:

    =SORT(A1:A10, SLOPE(A1:A10), TRUE)

This will sort the cells in ascending order based on the coefficient of the linear regression sparkline. You can use the "FALSE" argument to sort in descending order.

---

Wow! Okay, things are a bit different than they used to be. Thank you, Robbie.
I am sure I will have an emotional connection with you shortly.

Okay, back to tonight's project. I have to do this step actually remarkably
quickly, because pulling down the data was such a big deal, the final
transforms should be almost effortless. Don't want to stay up late on this and
there should be no reason to. Think! Data pulls 2/3rds done. Got about an hour
to plan the globbing and the concatting and the pivoting.

In broad strokes...

```python
import pandas as pd
from pathlib import Path

files = Path("downloads").glob("*")

table = []
for afile in files:
    df = pd.read_csv(afile)
    table.append(df)
df = pd.concat(table)
```

This would be fine if you actually had all the columns you needed already in
each download. The trick in situations like this is that the information you
need as a column before the concatenation is only found in the filename. And
this is how we generically solve that.

```python
import pandas as pd
from pathlib import Path

files = Path("downloads").glob("*")

table = []
for afile in files:
    filename = afile.name
    df = pd.read_csv(afile)
    table.append(df)
df = pd.concat(table)
```

Say you had 3 files...

    [py311] ubuntu@Aahz:~/repos/test/downloads $ ls -la
    total 0
    drwxr-xr-x 1 ubuntu ubuntu 4096 Dec 29  2022 .
    drwxr-xr-x 1 ubuntu ubuntu 4096 Dec 29  2022 ..
    -rw-r--r-- 1 ubuntu ubuntu   12 Dec 29  2022 foo-1.csv
    -rw-r--r-- 1 ubuntu ubuntu   12 Dec 29  2022 foo-2.csv
    -rw-r--r-- 1 ubuntu ubuntu   12 Dec 29  2022 foo-3.csv
    [py311] ubuntu@Aahz:~/repos/test/downloads $

Each containing the identical contents:

    bar
    bam
    baz

They would load into the DataFrame indistinguishable from each other.

       bar
    0  bam
    1  baz
    0  bam
    1  baz
    0  bam
    1  baz

Instead, we parse the filename and use what we find as a new column in the
DataFrame:

```python
import pandas as pd
from pathlib import Path

files = Path("downloads").glob("*")

table = []
for afile in files:
    filename = afile.name
    df = pd.read_csv(afile)
    df["file"] = filename.split("-")[1].split(".")[0]
    table.append(df)
df = pd.concat(table)

print(df)
```

Which outputs:

       bar file
    0  bam    1
    1  baz    1
    0  bam    2
    1  baz    2
    0  bam    3
    1  baz    3

And in this way, we can add whatever columns we need in preparation for a
pivot. Okay, I've changed the 3 input files to be:

foo-1.csv

    name,value
    bar,1
    bam,2
    baz,3

foo-2.csv

    name,value
    bar,2
    bam,2
    baz,2

foo-3.csv

    name,value
    bar,3
    bam,2
    baz,1

And now our program outputs:

      name  value file
    0  bar      1    1
    1  bam      2    1
    2  baz      3    1
    0  bar      2    2
    1  bam      2    2
    2  baz      2    2
    0  bar      3    3
    1  bam      2    3
    2  baz      1    3

Nifty, huh? And all ready to pivot. If it works with this, it'll work with tons
of input files just as well.

I'm going to simplify it by not cramming it all into one pivot. I'm going to
create a separate output pivot table per column. Hmmm. Maybe not necessary. I
just pivot them all at once. Is it just a transpose?

```python
df.transpose()
```

Produces:

             0    1    2    0    1    2    0    1    2
    name   bar  bam  baz  bar  bam  baz  bar  bam  baz
    value    1    2    3    2    2    2    3    2    1
    file     1    1    1    2    2    2    3    3    3

But if you set the index to name:

```python
df.set_index("name").transpose()
```

...then the output is much more tidy:

    name  bar bam baz bar bam baz bar bam baz
    value   1   2   3   2   2   2   3   2   1
    file    1   1   1   2   2   2   3   3   3

Uh, no. Definitely not a transpose that I need to do tonight. I'd get thousands
of columns. There ought only be 12 columns, one for each month. Probably
actually 11, given the incompleteness of December right now. So it's either
going to be an Excel-like concept of a pivot table, or plain old grouping and
aggregate functions.

Let's ask ChatGPT!

## What is the difference between a pivot table and a group by function with aggregate columns?

A pivot table and a group by function with aggregate columns are two different
tools that can be used to summarize and analyze data in a spreadsheet. Here are
the main differences between the two:

Pivot tables are a feature in Excel and Google Sheets that allow you to quickly
summarize and analyze large amounts of data. You can use pivot tables to create
summary reports, calculate sums and averages, and display data in different
ways by dragging and dropping fields. Pivot tables are easy to use and allow
you to interact with the data by filtering, sorting, and drilling down into the
details.

A group by function with aggregate columns is a way to group and summarize data
using a formula. You can use the GROUP BY clause in a SELECT statement to group
rows by one or more columns, and then use aggregate functions such as SUM, AVG,
MIN, and MAX to calculate summary values for each group. Group by functions are
often used in SQL and other programming languages, and they allow you to
specify more complex grouping and aggregation rules than what is possible with
pivot tables.

In general, pivot tables are easier to use and more suitable for interactive
data analysis, while group by functions are more flexible and powerful but
require more programming knowledge. The choice between the two depends on your
needs and the complexity of the data you are working with.

---

Hmmm, not bad.

So if I rename the files:

    foo-jan.csv
    foo-feb.csv
    foo-mar.csv

Then the output changes to:

      name  value file
    0  bar      2  feb
    1  bam      2  feb
    2  baz      2  feb
    0  bar      1  jan
    1  bam      2  jan
    2  baz      3  jan
    0  bar      3  mar
    1  bam      2  mar
    2  baz      1  mar

And that makes it easier for me to think through. I get confused because I
think that because I ***have to*** use an aggregate or min/max function of some
sort on a pivot that it will actually reduce data-points, but if each
coordinate is unique, then even summing a column on a pivot won't change the
value. As thus...

```python
df = df.pivot_table(index='name', columns='file', values='value', aggfunc='sum')
df = df.reset_index()
df = df[["name", "jan", "feb", "mar"]]
print(df)
```

Produces:

    file name  jan  feb  mar
    0     bam    2    2    2
    1     bar    1    2    3
    2     baz    3    2    1

And that's pretty much my solution for tonight.

But there are multiple metrics which complicates it enormously.

I can output an easily readable table per metric. Let me change my sample data
to be:

foo-jan.csv

    name,value,metric
    bar,1,1
    bam,2,2
    baz,3,3

foo-feb.csv

    name,value,metric
    bar,2,4
    bam,2,5
    baz,2,6

foo-mar.csv

    name,value
    bar,3,7
    bam,2,8
    baz,1,9

And I've adjusted my parsing code a bit:

```python
import pandas as pd
from pathlib import Path

files = Path("downloads").glob("*")

table = []
for afile in files:
    filename = afile.name
    df = pd.read_csv(afile)
    df["file"] = filename.split("-")[1].split(".")[0]
    table.append(df)
df = pd.concat(table)
print("Raw data:")
print(df)
print()

print("Per metric")
for metric in ['value', 'metric']:
    print(metric)
    print()
    dfp = df.pivot_table(index='name', columns='file', values=metric, aggfunc='sum')
    print("Unsorted pivot")
    print(dfp)
    print()
    dfp = dfp.reset_index()
    dfp = dfp[["name", "jan", "feb", "mar"]]
    print("Final pivot")
    print(dfp)
    print()
```

...which outputs:

    Raw data:
      name  value  metric file
    0  bar      2       1  feb
    1  bam      2       2  feb
    2  baz      2       3  feb
    0  bar      1       4  jan
    1  bam      2       5  jan
    2  baz      3       6  jan
    0  bar      3       7  mar
    1  bam      2       8  mar
    2  baz      1       9  mar

    Per metric
    value

    Unsorted pivot
    file  feb  jan  mar
    name
    bam     2    2    2
    bar     2    1    3
    baz     2    3    1

    Final pivot
    file name  jan  feb  mar
    0     bam    2    2    2
    1     bar    1    2    3
    2     baz    3    2    1

    metric

    Unsorted pivot
    file  feb  jan  mar
    name
    bam     2    5    8
    bar     1    4    7
    baz     3    6    9

    Final pivot
    file name  jan  feb  mar
    0     bam    5    2    8
    1     bar    4    1    7
    2     baz    6    3    9

And that solidly looks like my solution for tonight. I can make each one of
these a tab in an Excel sheet, or more likely just make one CSV file per
metric. So much easier!

<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/windows-subsystem-for-linux-is-now-available-in-the-microsoft-store/">Windows Subsystem for Linux is now available in the Microsoft Store!</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/browser-automation-becoming-natural-easy-at-long-last/">Browser Automation Becoming Natural & Easy At Long Last</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/google/'>Google</a></h4></li>
<li><h4><a href='/microsoft-playwright/'>Microsoft Playwright</a></h4></li>
<li><h4><a href='/panda/'>Pandas</a></h4></li>
<li><h4><a href='/browser-automation/'>Browser Automation</a></h4></li>
<li><h4><a href='/seo/'>SEO</a></h4></li></ul>