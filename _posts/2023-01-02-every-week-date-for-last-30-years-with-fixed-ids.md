---
date: 2023-01-02
title: Every Week Date for Last 30 Years With Fixed IDs
headline: "Enumerating Life in Weeks: A Simple Way to Remember Birthdays"
description: I had a project to work on that required me to work with a lot of data. To make sense of the data, I decided to enumerate life in terms of weeks starting from the week of birth. Using named tuples, I was able to calculate clean week-start dates and give each week a fixed ID. This allowed me to list the data in a way that I could easily remember what day of the week a person was born on.
keywords: Enumerate, Week, Birth, Named Tuples, Fixed IDs, Chart Lines, Trends, API-Parameters, Database
categories: database
permalink: /blog/every-week-date-for-last-30-years-with-fixed-ids/
layout: post
group: blog
---


Wow, January 2nd. Okay, it's the second day of the new year, and I have off
from work. Take inventory. Make your next steps easier. Think! I've got
projects to get done, but also what I'm doing for the website really helps with
all my work. Refine my thoughts here on the great and secret MikeLev.in/blog,
then put the refined versions over on Pipulate.com/software.

Got a bit project that's tough to tackle because there's just so much data?
Does the API support subdividing the job by date? Are days too small of an
increment and months too big? Have you considered weeks, the great unsung hero
of time-period slicing? A week is just the right amount of days to plot chart
lines and see trends emerge. Most people shy away from weeks because they don't
start and end on even increments like days, months or years. But there is a
solution: just calculate clean week-start dates!

If you pick one particular week, sometime in the past and call it week #1, you
can count weeks forward from there, incrementing the week-ID by 1 until you get
to the most current full week. That ID is then meaningful because it's the
number of weeks since your start date, and you can watch that number grow
bigger, but not unreasonably, into the future. If you live to 100 years old,
that's only 52 weeks-per-year for 100 years, or week IDs up to 5200. You can
almost count that high. So over the course of your entire lifetime, you can
watch a number grow from 1 to 5200 and have a pretty good sampling-size of data
for looking at things about your life. What was I earning then? How many pets
did I have?

Hmm, let's see. Let's list week-by-week for the last ~30 years in a way that
the week start-dates are consistent whenever you run the query. We want to
expose the Day-of-Week as in Monday, Tuesday, etc. Also, we want a fixed-ID for
each week from the start. And so the start is the oldest date, and we won't
change that over time. There is a beginning, albeit calculated to the nearest
start-of-week date given an approximate.

Also, when we do an exercise like this, it's almost always to make calls to an
API, and so we do my now traditional populating of namedtuples as keys into a
sqlite database. This turns all queries we plan to execute into sequentially
enumerated keys we can systematically step through, interrupt jobs, resume,
etc. It's good data housekeeping.

```python
from collections import namedtuple
from datetime import date, timedelta
from sqlitedict import SqliteDict as sqldict

# Calculate the most recent full week
today = date.today()
weekday = today.weekday()
days_to_sunday = 6 - weekday
end_date = today - timedelta(days=days_to_sunday)

# Calculate closest week-start near start date
start_date = date(1970, 8, 27)
weekday = start_date.weekday()
days_to_sunday = 6 - weekday
start_date = start_date - timedelta(days=days_to_sunday)

print(f"Dates: {start_date} to {end_date}")

# Calculate number of days
num_days = (end_date - start_date).days + 1
print(f"Number of days: {num_days}")

Week = namedtuple("Week", "id, start")

# Give each week a fixed ID
show_date = start_date
table = []
for i in range(num_days):
    # print(i, show_date)
    table.append((Week(i, f"{show_date}")))
    show_date = show_date + timedelta(days=7)
    if show_date > end_date:
        break

# Plug api-parameters as keys into database
with sqldict("weeks.db") as db:
    for week in table:
        db[str(week)] = None
    db.commit()
```

And that roughly outputs:

    Week(id=0, start='1970-08-24')
    Week(id=1, start='1970-08-31')
    Week(id=2, start='1970-09-07')
    Week(id=3, start='1970-09-14')
    Week(id=4, start='1970-09-21')
    Week(id=5, start='1970-09-28')
    Week(id=6, start='1970-10-05')
    Week(id=7, start='1970-10-12')
    Week(id=8, start='1970-10-19')
    Week(id=9, start='1970-10-26')
    ...
    Week(id=2722, start='2022-10-24')
    Week(id=2723, start='2022-10-31')
    Week(id=2724, start='2022-11-07')
    Week(id=2725, start='2022-11-14')
    Week(id=2726, start='2022-11-21')
    Week(id=2727, start='2022-11-28')
    Week(id=2728, start='2022-12-05')
    Week(id=2729, start='2022-12-12')
    Week(id=2730, start='2022-12-19')
    Week(id=2731, start='2022-12-26')

Isn't that just the most beautiful thing? We can enumerate our lives thus-far
in terms of named tuples for each week, starting the week of your birth.
Solomon Grundy, this starts on a Monday. So if you forget what day of the week
you were born, this is a good way to check. First row is Monday. I was born on
a Thursday.

Okay, so now we have a tuple for each week you've been alive. What now?


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/every-week-date-for-last-30-years-with-fixed-ids/">Every Week Date for Last 30 Years With Fixed IDs</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/life-in-weeks-ipynb/">life_in_weeks.ipynb</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/database/'>Database</a></h4></li></ul>