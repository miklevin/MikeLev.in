---
date: 2022-09-01
title: OpenPyXL for creating a formatted Excel file from Python
headline: Creating a Formatted Excel File with OpenPyXL and Pandas
description: I used openpyxl and pandas to create a formatted Excel file from Python. I stepped through each item in a loop and outputted a different tab into the spreadsheet, and then finished the task by deleting. Read my blog post to find out how I did it!
keywords: OpenPyXL, Python, Excel, File, Loop, Spreadsheet, Pandas, Dataframes, Documentation, Delete
categories: excel, pandas, loop, python
permalink: /blog/openpyxl-for-creating-a-formatted-excel-file-from-python/
layout: post
---


I need to focus on some day-job stuff. I've got some openpyxl work to do. Do it
by hand, but use your by-hand process to plan the automated version.

1, 2, 3.. 1? Create the "blank" file with openpyxl.

First we do the example from https://openpyxl.readthedocs.io/en/stable/

```python
from openpyxl import Workbook
import datetime

wb = Workbook()
ws = wb.active
ws["A1"] = 42
ws.append([1, 2, 3])
ws["A2"] = datetime.datetime.now()
wb.save("sample.xlsx")
```

Okay, confirmed working. For the next steps, we go over to the docs at
https://openpyxl.readthedocs.io/en/stable/

We've got pandas support so inserting dataframes into a tab is no problem
https://openpyxl.readthedocs.io/en/stable/pandas.html

Okay, now I'm stepping through each item in a loop and outputting a different
tab into the spreadsheet:

```python
from openpyxl import Workbook
from openpyxl.utils.dataframe import dataframe_to_rows


wb = Workbook()
list_of_df_variations = []
for variation in variations:
    variation_path = Path(f"{prefix}{variation}")
    Path(variation_path).mkdir(parents=True, exist_ok=True)
    df_filtered = df_unfiltered[df_unfiltered["Variations"].str.contains(variation)]
    raw_pivot = Path(f"{variation_path}/raw_pivot{data_extension}")
    print(raw_pivot)
    list_of_df_variations.append(df_filtered)
    df_filtered.to_excel(raw_pivot, index=False, float_format="%.2f")
    ws = wb.create_sheet(variation)
    for r in dataframe_to_rows(df, index=True, header=True):
        ws.append(r)
xlfile = Path(f"{prefix}{name_space}-ranklayer.xlsx")
wb.save(xlfile)
```

The dataframes are quite big so this takes awhile to run. The documentation
says this "streams" the data into the file, so there should not be exploding
memory issues, except insofar as the dataframe itself may be large.

And if you're actually looking at this code, it won't run without all the setup
work. There's a pre-existing dataframe called df_unfiltered which is a
super-set of all the variations. It has a Variations column, which is a comma
separated field stuffed with variations, which you can think of as tags or
categories. The loop simply makes a smaller df for each variation or tag in the
(also pre-existing) variations Python list.

After that's done I'm going to delete Sheet1 in a second pass:

```python
# Delete Sheet1
from openpyxl import load_workbook
wb = load_workbook(xlfile)
sheet.get_sheet_by_name('Sheet')
wb.remove_sheet(sheet)
wb.save(xlfile)
```

Ugh! This takes so friggin' long! My files are like 70MB large. It's much
better to just put this tab delete in the loop.

```python
from openpyxl import Workbook
from openpyxl import load_workbook
from openpyxl.utils.dataframe import dataframe_to_rows


wb = Workbook()
list_of_df_variations = []
for variation in variations:
    variation_path = Path(f"{prefix}{variation}")
    Path(variation_path).mkdir(parents=True, exist_ok=True)
    df_filtered = df_unfiltered[df_unfiltered["Variations"].str.contains(variation)]
    raw_pivot = Path(f"{variation_path}/raw_pivot{data_extension}")
    print(raw_pivot)
    list_of_df_variations.append(df_filtered)
    df_filtered.to_excel(raw_pivot, index=False, float_format="%.1f")
    ws = wb.create_sheet(variation)
    for r in dataframe_to_rows(df_filtered, index=False, header=True):
        ws.append(r)
xlfile = Path(f"{prefix}{name_space}-ranklayer.xlsx")
sheet=wb.get_sheet_by_name('Sheet')
wb.remove_sheet(sheet)
wb.save(xlfile)
```

Okay, one giant step towards automating one of my bigger SEO deliverables.


<div class="post-nav"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/your-current-video-card-driver-does-not-support-this-nvenc-version-please-update-your-drivers">Your current video card driver does not support this NVENC version please update your drivers.</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/planning-multiple-blogs-within-one-github-pages-site">Planning Multiple Blogs Within One Github Pages Site</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/excel/'>Excel</a></h4></li>
<li><h4><a href='/loop/'>Loop</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li></ul>