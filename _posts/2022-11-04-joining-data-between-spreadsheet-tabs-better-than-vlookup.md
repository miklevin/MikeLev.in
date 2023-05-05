---
date: 2022-11-04
title: Joining Data Between Spreadsheet Tabs Better Than VLookup
headline: Discover How I Joined Data Between Spreadsheet Tabs Without VLookup or Pivot Tables
description: Discover how I joined data between spreadsheet tabs without using VLookup or Pivot Tables. I explored connecting to Google Sheets and the OAuth2 enabled GSheets API, but I eventually figured out a way to save the data as an .xlsx file and load individual tabs using Pandas. Now I'm exploring the best way to log into Google services from Jupyter - read my blog post to find out how!
keywords: Spreadsheet, Tabs, VLookup, Pivot Tables, Google Sheets, OAuth2, GSheets API, .xlsx, Pandas, Jupyter, Logging, Google Services
categories: jupyter, pandas
permalink: /blog/joining-data-between-spreadsheet-tabs-better-than-vlookup/
layout: post
---


Okay, certain tasks just keep recurring. For anyone in the field of data
manipulating and making sense of it, some of the more common tasks are vlookups
and pivot tables. Interestingly as popular as these concepts are thanks to
their labeling in spreadsheet software like Excel and Lotus 123 (back in the
day) the actual more fundamental concepts of what's going on is often lost and
not until you take up SQL do you learn about table joins and aggregate
functions. Vookups are a jerry rigged table-join while pivot tables are
slapping a user interface onto calculating aggregate values like sums and
counts from raw data. So the vlookup and the pivot table are two of the most
common functions that most people only know how to do through Excel these days.
Even those who have taken up SQL and know the grown-up versions of these
manipulations are hard pressed to perform them on-the-fly with any old data
that comes your way because SQL people usually need the data to be in a SQL
database somewhere, either online or local.

Start a little-tricks for big-payback series. That's really what I'm talking
about here: little tricks that result in a big payback. I'm chomping at the bit
to work the id_rsa keys and cloning of a few git repos into the lxdwin server
build script, but I can see there's some mental gymnastics I'll have to
perform. It's not quite rabbit holes, but it is enough to keep me from trying
to slip that work in during lunch. Instead I'm going to focus on the common
tasks above, but as accomplished ***outside the spreadsheet*** and in a Jupyter
Notebook instead, even though the original data starts out in a spreadsheet.

A practical alternative to VLookups and Pivot Tables!

1, 2, 3... 1? Do this efficiently. Strong nickname: vlookupless! Yes! Okay,
folder made. Notebook made.

Wow! I just discovered
https://developers.google.com/identity/protocols/oauth2/resources/oob-migration
which is pretty darn serious with this route. I was going to connect to Google
Sheets and grab the data, but I'm not going to now until I fix this. Ugh,
instead of the OAuth2 enabled GSheets API, I'm going to save-as

Hmmm. Okay, with save-as we can have an .xlsx file with all the tabs inside of
it, but they take an extra step to get to:

    xls = pd.ExcelFile("filename.xlsx")

And then I can load individual tabs like:

    df = pd.read_excel(xls, "Sheet1")

And so on. Of course it's better to just pull the data out of the Google Sheet
without having to save it first so that anything I do in a notebook reflects
the latest status of the data, but Google keeps changing the OAuth login
procedure on me. I got it working again but I had to take the OhAwf app out of
"production" where anyone on the Web can use it and into "testing" mode. This
is a Google Cloud Platform app thing. In testing mode I had to whitelist my
email address but it gives me a way to keep my logged in scheduled scripts
running in case they happen to be logged out.

The question now arises: what is the best way to log into Google services from
Jupyter?


<div class="post-nav"><div class="post-nav-prev"><span class="arrow">&nbsp;&rarr;</span><a href="/blog/made-a-python-program-to-rot13-an-id-rsa-file-for-github/">Made a Python Program to Rot13 an id_rsa file for Github</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/permission-denied-publickey-fatal-could-not-read-from-remote-repository/">Permission denied publickey fatal Could not read from remote repository</a><span class="arrow">&larr;&nbsp;</span></div></div>
## Categories

<ul>
<li><h4><a href='/jupyter/'>Jupyter</a></h4></li></ul>