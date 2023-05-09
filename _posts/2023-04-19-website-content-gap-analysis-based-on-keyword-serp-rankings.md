---
date: 2023-04-19
title: Website Content GAP Analysis Based on Keyword SERP Rankings
headline: Creating a Content GAP Analysis Using Python and Microsoft Playwright
description: I recently completed a project to create a content GAP analysis between websites using MOZ data. I wrote code in Python and used Microsoft Playwright to automate the download of keyword lists. I used Pandas to create a pivot table, merge the dataframes, sort the data, drop duplicates, and save the data to an Excel file. My program helps identify gaps in content ranking between different sites and filter out keywords with less than 1000 monthly searches.
keywords: Website, Content, GAP Analysis, Keyword, SERP, Rankings, OpenAI, MOZ, Python, Microsoft Playwright, Automation, Download, Lists, Pandas, Pivot Table, Merge, Dataframes, Sort, Duplicates, Excel, File, Volume, Difficulty, Top Rank, URL, Standardize, Columns, NaN, Integers, Sample, Descending, Filter, Searches, CSVs, Clean, Remove, Blanks, Compare
categories: panda, ai, seo, python, microsoft playwright, search, filter
permalink: /blog/website-content-gap-analysis-based-on-keyword-serp-rankings/
layout: post
---


Wow, that last quick project on the way to creating category pages using the
OpenAI produced keywords was profoundly cool. I think it's one of my best
articles yet. Let's see if I can top it with this one. Every public journal
entry I make now is like Xmas in how the OpenAI generated keywords and
descriptions are a gift. I'm definitely pursuing my vision of cutting catapult
ropes to release the built-up internal potential of having invested in myself
over the years (as opposed to chasing the almighty dollar).

Before that project I was going the data project for MOZ, using the MOZ Pro web
interact to download some 50 lists of keywords for each true competitor. So now
I'm sitting on top of a directory full of these downloads. All this work isn't
really required to satisfy the data team's request, but it is necessary for me
to be speaking with the kind of authority and expertise that only comes with
hands-on experience. You have to walk the walk if you want to talk the talk,
and in order for me to not be an imposter, I've got to walk a bit.

Python code should be beautiful and be intuitive to read. I love the way that
last project went and I'm going to use that as a model for this one. So we
build it up. If you go back a few posts you'll find that I used Microsoft
Playwright to automate the download of the keyword lists. So now I have a
folder full of these .csv files. In fact it's mixed in with the prior true
competitor csv downloads as well, so I'm going to once again glob them up with
a filter:

```python
from pathlib import Path

DATADIR = "../data/moz/"
for i, f in enumerate(Path(DATADIR).glob("moz_*.csv")):
    print(i, f)
```

This pattern will serve you well. It's a simple way to get a list of files in a
directory. Organize your data files separately from your code files. I now have
a moz subdirectory in my data directory and lump everything downloaded form MOZ
into there because this is my practice directory, and I need just the right
amount of separation between my different practice data without going nuts with
directory structure I'd have to navigate. While more folders are good for
organization, it's terrible for long-term usability. Keep your directories
sparse and their nesting shallow.

This extremely light touch loads all those CSVs as a list of dataframes.

```python
from pathlib import Path
import pandas as pd

DATADIR = "../data/moz/"
dfs = []
for i, f in enumerate(Path(DATADIR).glob("moz_*.csv")):
    print(i, f)
    dfs.append(pd.read_csv(f))
```

Before we concat the dataframes with pd.concat, we need to add a column to each
one that identifies the source. This is a simple way to keep track of where the
data came from. I'm going to use the file name as the source identifier. I'm
going to use the same technique I used in the last project.

```python
from pathlib import Path
import pandas as pd

DATADIR = "../data/moz/"
dfs = []
for i, file in enumerate(Path(DATADIR).glob("moz_*.csv")):
    site = file.name.split("_")[1]
    print(i, site)
    # print(i, file)
    # dfs.append(pd.read_csv(file))
```

I could do more things in each step, but I'm trying to make it so that someone
following along has an easy time identifying what's different between each
step. I edited out loading the dataframes for speed, but now we combine the 2
steps. This code stacks the dataframes, each having now an additional "Site"
column, and the last line makes it display the too of MOZ's dataframe, which
happens to be the 9th one:

```python
from pathlib import Path
import pandas as pd

DATADIR = "../data/moz/"
pd.set_option("display.width", 1000)

dfs = []
for i, file in enumerate(Path(DATADIR).glob("moz_*.csv")):
    site = file.name.split("_")[1]
    df = pd.read_csv(file)
    df['Site'] = site
    dfs.append(df)
print(dfs[8].head())
```

                 Keyword  Min Monthly Volume  Max Monthly Volume  Specific Monthly Volume  Difficulty  moz.com en-US Top Rank                moz.com en-US Top Ranking URL     Site
    0                moz                4301                6500                   6133.0          69                       1                             https://moz.com/  moz.com
    1   domain authority                1701                2900                   2200.0          67                       1   https://moz.com/learn/seo/domain-authority  moz.com
    2          learn seo                 851                1700                   1435.0          56                       1                    https://moz.com/learn/seo  moz.com
    3       learning seo                 851                1700                   1435.0          56                       1                    https://moz.com/learn/seo  moz.com
    4  what are keywords                 851                1700                   1393.0          60                       1  https://moz.com/learn/seo/what-are-keywords  moz.com

Looking at the dataframes we notice that the site's name is embedded into the
column names. That's fine in the sense that most column names will be blown
away when we concatenate the dataframes, but we need to get rid of the site
name of at least the first dataframe so it doesn't look like all the rows are
for the same site. So we standardize the column names:

```python
from pathlib import Path
import pandas as pd

DATADIR = "../data/moz/"
pd.set_option("display.width", 1000)
columns = ['Keyword', 'Min Monthly Volume', 'Max Monthly Volume',
           'Specific Monthly Volume', 'Difficulty', 'Top Rank',
           'Top Ranking URL', 'Site']

dfs = []
for i, file in enumerate(Path(DATADIR).glob("moz_*.csv")):
    site = file.name.split("_")[1]
    df = pd.read_csv(file)
    df['Site'] = site
    df.columns = columns
    dfs.append(df)
df = pd.concat(dfs)
print(df.sample(5))
```

The last line shows a random sample of 5 rows from the dataframe. This is a
good way to get a feel for the data.

                            Keyword  Min Monthly Volume  Max Monthly Volume  Specific Monthly Volume  Difficulty  Top Rank                                    Top Ranking URL                      Site
    7865         kidney cyst cancer                 201                 500                    365.0          48       1.0  https://www.medicalnewstoday.com/articles/can-...  www.medicalnewstoday.com
    7020                noindex tag                 101                 200                    160.0          50      13.0      https://yoast.com/help/how-do-i-noindex-urls/                 yoast.com
    9905  explainer animated videos                  51                 100                     74.0          48       2.0  https://www.wordstream.com/blog/ws/2014/03/13/...        www.wordstream.com
    4196  they come knocking review                 101                 200                    105.0          40       1.0  https://www.rottentomatoes.com/m/they_come_kno...    www.rottentomatoes.com
    7311              rihanna plane                 101                 200                    128.0          51       2.0  https://mashable.com/feature/rihanna-plane-tou...              mashable.com

That "Specific Monthly Volume" column is looking appealing for a sort, but it
is a float value with NaNs and too many decimal places. Let's fix that:

```python
from pathlib import Path
import pandas as pd
import numpy as np

DATADIR = "../data/moz/"
pd.set_option("display.width", 1000)
columns = ['Keyword', 'Min Monthly Volume', 'Max Monthly Volume',
           'Specific Monthly Volume', 'Difficulty', 'Top Rank',
           'Top Ranking URL', 'Site']

dfs = []
for i, file in enumerate(Path(DATADIR).glob("moz_*.csv")):
    site = file.name.split("_")[1]
    df = pd.read_csv(file)
    df['Site'] = site
    df.columns = columns
    dfs.append(df)
df = pd.concat(dfs)

print(df.shape)
# replace non-finite values with NaN
df.replace([np.inf, -np.inf], np.nan, inplace=True)
df.dropna(inplace=True)
df["Specific Monthly Volume"] = df["Specific Monthly Volume"].astype(int)
print(df.shape)
```

I print the shape of the dataframe before after dropping the rows that didn't
have a value for "Specific Monthly Volume".

    (530000, 8)
    (515928, 8)

df.shape reports rows and columns. So we went from 53K rows to 51.5K rows.
I'm sure in some scenarios we may have preferred using the minimum or maximum
volume numbers, but for this exercise we'll use the specific monthly volume.

Now we sort descending by volume and show a few records from the top:

```python
from pathlib import Path
import pandas as pd
import numpy as np

DATADIR = "../data/moz/"
pd.set_option("display.width", 1000)
columns = ['Keyword', 'Min Monthly Volume', 'Max Monthly Volume',
           'Specific Monthly Volume', 'Difficulty', 'Top Rank',
           'Top Ranking URL', 'Site']

dfs = []
for i, file in enumerate(Path(DATADIR).glob("moz_*.csv")):
    site = file.name.split("_")[1]
    df = pd.read_csv(file)
    df['Site'] = site
    df.columns = columns
    dfs.append(df)
df = pd.concat(dfs)

# replace non-finite values with NaN
df.replace([np.inf, -np.inf], np.nan, inplace=True)
df.dropna(inplace=True)
df["Specific Monthly Volume"] = df["Specific Monthly Volume"].astype(int)

# Sort descending by volume
df.sort_values(by="Specific Monthly Volume", ascending=False, inplace=True)
print(df.head())
```

Output:

                  Keyword  Min Monthly Volume  Max Monthly Volume  Specific Monthly Volume  Difficulty  Top Rank                                Top Ranking URL              Site
    0             walmart             6880001            95000000                 50500000          77       1.0                       https://www.walmart.com/   www.walmart.com
    0            best buy             6880001            95000000                 15031535          80       1.0                       https://www.bestbuy.com/   www.bestbuy.com
    9314   facebook login             1508001             6880000                  5626576          96      35.0  https://www.ipvanish.com/blog/facebook-login/  www.ipvanish.com
    1     walmart near me             1508001             6880000                  4570000          39       1.0           https://www.walmart.com/store-finder   www.walmart.com
    1             bestbuy             1508001             6880000                  3938797          83       1.0                       https://www.bestbuy.com/   www.bestbuy.com

As you can see that first unlabeled column is the index. We can reset it to
start at 0 and drop the old index with this command.

```python
df.reset_index(drop=True, inplace=True)
```

And here's our first introduction of the Pandas pivot_table function. We'll
use it to turn every site into a column and every row into a keyword. The
intersection of site and keyword will show the best search position (being the
minimum rank) for that keyword on that site. It's a bit counter-intuitive that
he minimum rank is the best position, but that's how SERPs work. The lower the
number the higher the position in search you are. For that aggregate function,
I could also choose "mean" or "count" if I wanted the average position or
number of times pages that the site ranked for that keyword.

```python
from pathlib import Path
import pandas as pd
import numpy as np

DATADIR = "../data/moz/"
pd.set_option("display.width", 1000)
pd.set_option("display.max_columns", 999)
columns = ['Keyword', 'Min Monthly Volume', 'Max Monthly Volume',
           'Specific Monthly Volume', 'Difficulty', 'Top Rank',
           'Top Ranking URL', 'Site']

dfs = []
for i, file in enumerate(Path(DATADIR).glob("moz_*.csv")):
    site = file.name.split("_")[1]
    df = pd.read_csv(file)
    df['Site'] = site
    df.columns = columns
    dfs.append(df)
df = pd.concat(dfs)

# replace non-finite values with NaN
df.replace([np.inf, -np.inf], np.nan, inplace=True)
df.dropna(inplace=True)
df["Specific Monthly Volume"] = df["Specific Monthly Volume"].astype(int)
df["Top Rank"] = df["Top Rank"].astype(int)

# Sort descending by volume & reset index
df.sort_values(by="Specific Monthly Volume", ascending=False, inplace=True)
df.reset_index(drop=True, inplace=True)

df_pivot = pd.pivot_table(
        df,
        index=["Keyword"],
        columns=["Site"],
        values=["Top Rank"],
        aggfunc=["min"],
    ).reset_index()
df_pivot
```

It's getting a bit difficult to view the output in either Jupyter or a console.
Eventually such a pivot table will end up in Excel or Google Sheets for easier
viewing. But it wouldn't look all that great now anyway because it lost the
concept of being sorted descending by volume. Adding it back on a pivot table
isn't so easy, so we're going to flatten it into just a normal table and set
its index to Keyword.

The next step is a little bit nutty. Different systems have different ways of
handling this, but a pivot is basically a group-by on one column, the data of
one of the rows grouped and turned into columns, and then an aggregate function
applied to a third row of data with the results inserted into the cells. In
pivot-table nomenclature the first row is the index, the second row is the
columns, and the third row is the values. The aggfunc is the aggregate function
applied to the values.

Once you understand that, you can see why any other columns than these three
that define a pivot table are lost. They're not part of the group-by, they're
not part of the columns, and they're not part of the values. So we're going to
have to add them back in. We'll do that by merging the original dataframe with
the pivot table. We'll use the keyword as the key to merge on.

Not to toot my own horn too much, but this is a remarkable step. By just doing
this pivot, we turned a bunch of separate datapulls into a content gap analysis
between sites. We can now see which sites are ranking for which keywords and
which keywords they're not ranking for.

When you look at the data for your own site, blank cells mean that you're not
ranking for that keyword, and thus is probably a content-gap.

```python

```python
from pathlib import Path
import pandas as pd
import numpy as np


# Configuration and CONATANTS
pd.set_option("display.width", 1000)
pd.set_option("display.max_columns", 999)
DATADIR = "../data/moz/"
COLUMNS = ['Keyword', 'Min Monthly Volume', 'Max Monthly Volume',
           'Specific Monthly Volume', 'Difficulty', 'Top Rank',
           'Top Ranking URL', 'Site']

# Load all the MOZ keyword data CSVs into one giant datatframe.
dfs = []
for i, file in enumerate(Path(DATADIR).glob("moz_*.csv")):
    site = file.name.split("_")[1]
    df = pd.read_csv(file)
    df['Site'] = site
    df.columns = COLUMNS
    dfs.append(df)
df = pd.concat(dfs)

# replace non-finite values with NaN
df.replace([np.inf, -np.inf], np.nan, inplace=True)
df.dropna(inplace=True)
df["Specific Monthly Volume"] = df["Specific Monthly Volume"].astype(int)
df["Top Rank"] = df["Top Rank"].astype(int)

# Sort descending by volume & reset index
df.sort_values(by="Specific Monthly Volume", ascending=False, inplace=True)
df.reset_index(drop=True, inplace=True)

# Create a pivot-table dataframe
df_pivot = pd.pivot_table(
        df,
        index=["Keyword"],
        columns=["Site"],
        values=["Top Rank"],
        aggfunc=["min"],
    ) #.reset_index(level=None)

# Set the index of the orinal df and the new df_pivot to Keyword
df.set_index("Keyword", inplace=True)
df_pivot = df_pivot.reset_index().set_index("Keyword")
df_pivot.columns = df_pivot.columns.droplevel().droplevel()
df2 = df.join(df_pivot)
df2 = df2.sort_values(by="Specific Monthly Volume", ascending=False)
```

However, a nuanced problem lurks. SQL people might recognize on as an inner vs.
outer join problem. The pivot table is an inner join, so it only includes
keywords that are in both the original dataframe and the pivot table. Normally
that makes the left-table the row restriction, but in this case the pivot table
is the row restriction.

So there are multiple rows with the same keyword on the left, even though the
keyword has been made into the index. For SQL people for whom indexes are like
unique keys, this is a bit of a mind-bender.

We can expose the problem by comparing the number of rows in the joined
dataframe to the number of unique keywords in that same dataframe. Each keyword
should appear on only one row, so the number of rows should equal the number of
unique keywords.

```python
print(len(list(df2.index)))
print(len(list(df2.index.unique())))
```

Outputs:

    515928
    468992

And there's the problem.

The solution is to use the `reset_index` method to turn the index back into a
column. Then we can use the `drop_duplicates` method to remove all but the first
row for each keyword.

```python
df2 = df2.reset_index().drop_duplicates(subset="Keyword", keep="first")
```

And the deliverable is pretty close to finished. There's a bunch of NaNs in the
dataframe, but that's because some sites are not ranking for some keywords. It
makes the cells look ugly. We can fix that by replacing the NaNs with empty
strings.

```python
df2.fillna("", inplace=True)
```

And finally, all the cells for the Site columns appear to have a single decimal
point. That's because the pivot table is a float, and the original dataframe is
an int. We can fix that by converting the Site columns to ints.

```python
for site in df2.columns[8:]:
    df2[site] = df2[site].astype(int)
```

I also want to change the Top Rank numbers in the cells back to int's. They
appear to have become floats during the pivot (makes sense). However, since
there's NaN's or blanks or whatever in those cells, the conversion to int is
problematic. It wouldn't be a problem if they were zeros, so we can just arange
it so:

```python
from pathlib import Path
import pandas as pd
import numpy as np


# Configuration and CONATANTS
pd.set_option("display.width", 1000)
pd.set_option("display.max_columns", 999)
DATADIR = "../data/moz/"
COLUMNS = ['Keyword', 'Min Monthly Volume', 'Max Monthly Volume',
           'Specific Monthly Volume', 'Difficulty', 'Top Rank',
           'Top Ranking URL', 'Site']

# Load all the MOZ keyword data CSVs into one giant datatframe.
dfs = []
for i, file in enumerate(Path(DATADIR).glob("moz_*.csv")):
    site = file.name.split("_")[1]
    df = pd.read_csv(file)
    df['Site'] = site
    df.columns = COLUMNS
    dfs.append(df)
df = pd.concat(dfs)

# replace non-finite values with NaN
df.replace([np.inf, -np.inf], np.nan, inplace=True)
df.dropna(inplace=True)
df["Specific Monthly Volume"] = df["Specific Monthly Volume"].astype(int)
df["Top Rank"] = df["Top Rank"].astype(int)

# Sort descending by volume & reset index
df.sort_values(by="Specific Monthly Volume", ascending=False, inplace=True)
df.reset_index(drop=True, inplace=True)

# Create a pivot-table dataframe
df_pivot = pd.pivot_table(
        df,
        index=["Keyword"],
        columns=["Site"],
        values=["Top Rank"],
        aggfunc=["min"],
    ) #.reset_index(level=None)

# Set the index of the orinal df and the new df_pivot to Keyword
df.set_index("Keyword", inplace=True)
df_pivot = df_pivot.reset_index().set_index("Keyword")
df_pivot.columns = df_pivot.columns.droplevel().droplevel()
df2 = df.join(df_pivot)
df2 = df2.sort_values(by="Specific Monthly Volume", ascending=False)
df2 = df2.reset_index().drop_duplicates(subset="Keyword", keep="first")
df2.fillna("0", inplace=True)
for site in df2.columns[8:]:
    df2[site] = df2[site].astype(int)
for site in df2.columns[8:]:
    df2[site] = df2[site].replace(0, "")
df2
```

Is it ready? Is this now a gap analysis deliverable ready to hand to a client?
Almost! I think having 3 columns for different kinds of search volumes is a bit
much. We can delete 2 of them. The "Site" column is also now redundant with the
site columns. Oh yeah, we also have to save it. We'll choose the slow but most
likely desirable format, Excel xlsx. Don't forget you need to have pip
installed openpyxl for that step to work.

```python
from pathlib import Path
import pandas as pd
import numpy as np


# Configuration and CONATANTS
pd.set_option("display.width", 1000)
pd.set_option("display.max_columns", 999)
DATADIR = "../data/moz/"
COLUMNS = ['Keyword', 'Min Monthly Volume', 'Max Monthly Volume',
           'Specific Monthly Volume', 'Difficulty', 'Top Rank',
           'Top Ranking URL', 'Site']

# Load all the MOZ keyword data CSVs into one giant datatframe.
dfs = []
for i, file in enumerate(Path(DATADIR).glob("moz_*.csv")):
    site = file.name.split("_")[1]
    df = pd.read_csv(file)
    df['Site'] = site
    df.columns = COLUMNS
    dfs.append(df)
df = pd.concat(dfs)

# replace non-finite values with NaN
df.replace([np.inf, -np.inf], np.nan, inplace=True)
df.dropna(inplace=True)
df["Specific Monthly Volume"] = df["Specific Monthly Volume"].astype(int)
df["Top Rank"] = df["Top Rank"].astype(int)

# Sort descending by volume & reset index
df.sort_values(by="Specific Monthly Volume", ascending=False, inplace=True)
df.reset_index(drop=True, inplace=True)

# Create a pivot-table dataframe
df_pivot = pd.pivot_table(
        df,
        index=["Keyword"],
        columns=["Site"],
        values=["Top Rank"],
        aggfunc=["min"],
    ) #.reset_index(level=None)

# Set the index of the orinal df and the new df_pivot to Keyword
df.set_index("Keyword", inplace=True)
df_pivot = df_pivot.reset_index().set_index("Keyword")
df_pivot.columns = df_pivot.columns.droplevel().droplevel()

# Join the tables, sort desc by volume and drop dupes
df2 = df.join(df_pivot)
df2 = df2.sort_values(by="Specific Monthly Volume", ascending=False)
df2 = df2.reset_index().drop_duplicates(subset="Keyword", keep="first")

# Clean up the numbers in the Top Rank cells
df2.fillna("0", inplace=True)
for site in df2.columns[8:]:
    df2[site] = df2[site].astype(int)
for site in df2.columns[8:]:
    df2[site] = df2[site].replace(0, "")

# Get rid of unnecessary columns and turn Keyword into index
df2.drop("Min Monthly Volume", axis=1, inplace=True)
df2.drop("Max Monthly Volume", axis=1, inplace=True)
df2.drop("Site", axis=1, inplace=True)
df2.set_index("Keyword", inplace=True)

# Save to Excel (without nuking the system)
df2 = df2[df2["Specific Monthly Volume"] >= 1000]
df2.to_excel(f"{DATADIR}/gap_analysis.xlsx")
print("Done")
```

Wow! That's a million-dollar deliverable. SEO firms could make a living on this
process alone. Of course it required downloading a ton from MOZ Pro in such a
way that burned through monthly quota, but that's a small price to pay for
getting a client's site to the top of the SERPs.

And I had to add a filter because the file was too big to save. We can bring it
from almost 500,000 rows down to 80,000 by filtering out keywords with less than
1000 monthly searches.

```python
print(df2.shape)
print(df2[df2["Specific Monthly Volume"] >= 1000].shape)
```

    (468992, 57)
    (79410, 57)

Even cutting it down to 80K rows, openpyxl is still crapping out on the save.
I'm switching the Pandas Excel engine to XlsxWriter. And even then it craps
out, but at least it's reporting it's because it exceeds Excel's 65K limit on
the number of URLs allowed in a file! All this power-work and it's Excel file
limitations that are the problem. I'd keep it as CSV if that were acceptable
for delivery to a client, but it's not. We still have some formatting issues
ahead of us... for another post. Here's the final code for today:

```python
from pathlib import Path
import pandas as pd
import numpy as np


# Configuration and CONATANTS
pd.set_option("display.width", 1000)
pd.set_option("display.max_columns", 999)
DATADIR = "../data/moz/"
COLUMNS = ['Keyword', 'Min Monthly Volume', 'Max Monthly Volume',
           'Specific Monthly Volume', 'Difficulty', 'Top Rank',
           'Top Ranking URL', 'Site']

# Load all the MOZ keyword data CSVs into one giant datatframe.
dfs = []
for i, file in enumerate(Path(DATADIR).glob("moz_*.csv")):
    site = file.name.split("_")[1]
    df = pd.read_csv(file)
    df['Site'] = site
    df.columns = COLUMNS
    dfs.append(df)
df = pd.concat(dfs)

# replace non-finite values with NaN
df.replace([np.inf, -np.inf], np.nan, inplace=True)
df.dropna(inplace=True)
df["Specific Monthly Volume"] = df["Specific Monthly Volume"].astype(int)
df["Top Rank"] = df["Top Rank"].astype(int)

# Sort descending by volume & reset index
df.sort_values(by="Specific Monthly Volume", ascending=False, inplace=True)
df.reset_index(drop=True, inplace=True)

# Create a pivot-table dataframe
df_pivot = pd.pivot_table(
        df,
        index=["Keyword"],
        columns=["Site"],
        values=["Top Rank"],
        aggfunc=["min"],
    ) #.reset_index(level=None)

# Set the index of the orinal df and the new df_pivot to Keyword
df.set_index("Keyword", inplace=True)
df_pivot = df_pivot.reset_index().set_index("Keyword")
df_pivot.columns = df_pivot.columns.droplevel().droplevel()

# Join the tables, sort desc by volume and drop dupes
df2 = df.join(df_pivot)
df2 = df2.sort_values(by="Specific Monthly Volume", ascending=False)
df2 = df2.reset_index().drop_duplicates(subset="Keyword", keep="first")

# Clean up the numbers in the Top Rank cells
df2.fillna("0", inplace=True)
for site in df2.columns[8:]:
    df2[site] = df2[site].astype(int)
for site in df2.columns[8:]:
    df2[site] = df2[site].replace(0, "")

# Get rid of unnecessary columns and turn Keyword into index
df2.drop("Min Monthly Volume", axis=1, inplace=True)
df2.drop("Max Monthly Volume", axis=1, inplace=True)
df2.drop("Top Ranking URL", axis=1, inplace=True)
df2.drop("Site", axis=1, inplace=True)
df2.set_index("Keyword", inplace=True)

# Save to Excel (without nuking the system)
df2 = df2[df2["Specific Monthly Volume"] >= 1000]
out_file = f"{DATADIR}/gap_analysis.xlsx"
writer = pd.ExcelWriter(out_file, engine='xlsxwriter')
df2.to_excel(writer)
writer.close()
print("Done")
```

Open the resulting file in excel. Filter any column by "removing blanks" and
compare it to any other column. Those are the "gaps" of the gap analysis. That
site has content ranking for that keyword, but the other site doesn't.

I'll format the Excel much better soon, but I do have to shift to other data
projects that are more SERP-oriented than Site-oriented. Site-oriented is good
for gap analysis. SERP-oriented is good for finding open-ended things, like new
sites you haven't considered that are scoring well for a keyword.

<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/going-from-blog-keyword-histogram-to-category-pages/">Going From Blog Keyword Histogram to Category Pages</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/planning-on-adding-front-matter-support-to-journal-entries/">Planning on Adding Front Matter Support to Journal Entries</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/panda/'>Pandas</a></h4></li>
<li><h4><a href='/ai/'>AI</a></h4></li>
<li><h4><a href='/seo/'>SEO</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/microsoft-playwright/'>Microsoft Playwright</a></h4></li>
<li><h4><a href='/search/'>Search</a></h4></li>
<li><h4><a href='/filter/'>Filter</a></h4></li></ul>