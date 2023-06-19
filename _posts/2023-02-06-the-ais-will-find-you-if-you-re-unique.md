---
date: 2023-02-06
title: The AIs Will Find You If You're Unique
headline: "Exploring Google Photos Processing: My Journey to Automate and Archive a Month of Photos"
description: I'm taking my Google Photos processing to the next level by creating a service to download and copy one month of photos at random. To do this, I'm using Python scripts, headless Linux Chrome automation, and the headlines import to generate a list of files to be archived. I'm also taking the Google Photos tutorial out of the practice folder and moving it to the actual gphotos repo. Follow my journey as I take my Google Photos processing to the next level!
keywords: Google Photos, Python, Scripts, Automation, Headless Linux Chrome, Microsoft Playwright, File Archiving, Tutorial, Repo, Scheduling, Download, Copy, Media IDs, Week-Size Chunks, Trash
categories: microsoft playwright, tutorial, google, scheduling, python
permalink: /blog/the-ais-will-find-you-if-you-re-unique/
layout: post
group: blog
---


Be one of the most interesting people on the Net whether the general populace
realizes it or not. AIs will eventually realize it for them. That's a huge
point of AI, to recognize actual newness. When to pay attention to the outliers
is important. Be an outlier earlier when nobody is paying attention and use
that as a shield and smokescreen advantage to get ahead of everybody else in a
lot of skills that are going to be day-to-day necessary in the new world, and
then teach 'em. That's when you cash in, just as you're going into your
retirement, LOL!

Okay, but for right now I've got to take this Google Photos processing to the
next level. So far I have something I can schedule in a Linux service that will
download one new month at random from my Google Photos and copy it local. Over
time, it will all just accumulate up on the NAS, and first pass of the
80/20-rule will be accomplished. With step #1, all my Google Photos will be
backed up in time. It will take awhile, but I'm spreading it out. I want to
catch up with it with another task that will move archived items to the trash.

I download the list of archived and favorites for each week-period. The file
sizes for these database for a week time-frame aren't so big that I can't keep
them on the NAS too and work directly off of them for building lists and
checking status. Okay, so think. For each directory you encounter, you're going
to want to know right then all 3 lists:

- main
- all
- favorites

Okay, wow I put together this little gem to start the housekeeping work:

```python
# Generate List of Files to Be Archived
folders = [x.name for x in Path(f"{nas_loc}").glob("*")]
for folder in folders:
    main = f"{databases}/{folder}-main.db"
    favs = f"{databases}/{folder}-favs.db"
    allz = f"{databases}/{folder}-all.db"
    if all([Path(x).is_file() for x in [main, favs, allz]]):
        print(folder)
        with sqldict(main) as db:
            pass
        with sqldict(favs) as db:
            pass
        with sqldict(allz) as db:
            pass
```

And the next logical step takes us towards where we are going to want to build
a function:

```python
# Generate List of Files to Be Archived
folders = [x.name for x in Path(f"{nas_loc}").glob("*")]
for folder in folders:
    main = f"{databases}/{folder}-main.db"
    favs = f"{databases}/{folder}-favs.db"
    allz = f"{databases}/{folder}-all.db"
    if all([Path(x).is_file() for x in [main, favs, allz]]):
        print(folder)
        with sqldict(main) as db:
            for key in db:
                data = db[key]
        with sqldict(favs) as db:
            for key in db:
                data = db[key]
        with sqldict(allz) as db:
            for key in db:
                data = db[key]
```

The above becomes:

```python
def get_ids(dbname):
    ids = []
    with sqldict(dbname) as db:
        for key in db:
            data = db[key]
            if "mediaItems" in data:
                ids += [x["id"] for x in data["mediaItems"]]
    return set(ids)


# Generate List of Files to Be Archived
folders = [x.name for x in Path(f"{nas_loc}").glob("*")]
for folder in folders:
    maindb = f"{databases}/{folder}-main.db"
    favsdb = f"{databases}/{folder}-favs.db"
    allzdb = f"{databases}/{folder}-all.db"
    if all([Path(x).is_file() for x in [maindb, favsdb, allzdb]]):
        print(folder, end=" ")
        main = get_ids(maindb)
        favs = get_ids(favsdb)
        allz = get_ids(allzdb)
        archive = allz - main
        move_to_trash_all = archive - favs
        main_files = {x.name.split("____")[0] for x in Path(f"{nas_loc}/{folder}").glob("*")}
        archive_files = {x.name.split("____")[0] for x in Path(f"{nas_loc}/{folder}/archive").glob("*")}
        move_to_trash = move_to_trash_all - archive_files
        print(len(move_to_trash))
```

Wow, and this gives me 3 sets of media IDs to work with. There's a derivative
list to produce now, the archives, which is allz - main. Okay, done. I have the
list of ids that should be moved to trash. So what do we do now?

We get a list of the files that are on the filesystem that match those IDs.
There are 2 places to look in each week-number directory: right inside of it,
and in the archive folder that's inside of it.

Hmmm. This also gives me a natural processing order, and in fact a chunking
order. We don't want oversized runaway jobs we're waiting forever for it to
complete. Rather, we want to take advantage of the natural week-size chunks we
already tended to ensuring.

Okay, so let's improve the output and make it so it could process one
week-folder on each run. This now requires the headlines import:

```python
from headlines import *

h2("Making First Set of IDs for Moving")

# Generate List of Files to Be Archived
folders = [x.name for x in Path(f"{nas_loc}").glob("*")]
for folder in folders:
    maindb = f"{databases}/{folder}-main.db"
    favsdb = f"{databases}/{folder}-favs.db"
    allzdb = f"{databases}/{folder}-all.db"
    if all([Path(x).is_file() for x in [maindb, favsdb, allzdb]]):
        h3(f"Folder: {folder}")

        # Get list of main files per database and filesystem
        main_files = {
            x.name.split("____")[0] for x in Path(f"{nas_loc}/{folder}").glob("*")
        }
        main = get_ids(maindb)

        if len(main_files) > len(main):
            favs = get_ids(favsdb)
            allz = get_ids(allzdb)
            archive = allz - main
            move_to_trash_all = archive - favs
            archives_gen = Path(f"{nas_loc}/{folder}/archive").glob("*")
            archive_files = {x.name.split("____")[0] for x in archives_gen}
            move_to_trash = move_to_trash_all - archive_files
            print(f"Media items to move to trash: {len(move_to_trash)}")
            break
```

The next step is to add file-moving to the already existing headless Linux
Chrome automation under Microsoft Playwright. It's now in Python synchronous
mode so it won't run under Jupyter anymore, but now that it's under nbdev, I
can ***partially*** develop it under Jupyter and have the actual scheduled
running come from the complete .py extraction. Of course I have to get the
in-Notebook but non-executable portion correct.

Okay, I got it working on the headless Linux LXD NAS server, but now I have git
committed changes to the nbdev auto-generated .py file getting it working. I
committed on the server and pulled local.

Wow, it's in very nice shape. I think I want to take the Google Photos tutorial
out of the practice folder. This has become so specific on how it works. If I
want to go public with it, I want to do it with the actual gphotos repo and not
my practice folder.

Okay, done.


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/nbdev-makes-py-file-extractions-from-notebooks/">nbdev Makes .py-file Extractions From Notebooks</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/backup-google-photos-to-self-hosted-alternative/">Backup Google Photos to Self Hosted Alternative</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/microsoft-playwright/'>Microsoft Playwright</a></h4></li>
<li><h4><a href='/tutorial/'>Tutorial</a></h4></li>
<li><h4><a href='/google/'>Google</a></h4></li>
<li><h4><a href='/scheduling/'>Scheduling</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li></ul>