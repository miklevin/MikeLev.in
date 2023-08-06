---
date: 2023-04-19
title: Going From Blog Keyword Histogram to Category Pages
headline: "Improving My Website: Creating Category Pages with Jekyll Liquid Template"
description: I wrote a program to create category pages for my website using the Jekyll Liquid template. I used a SQLite database to store topics and keywords, and deleted all previous category pages to create new ones based on the keywords. With the collections module's Counter, I created a keyword histogram and a dictionary of keywords and associated URLs. I am feeling successful today as I have taken a step towards improving my website by writing a list of slugs to a file. Join me on my journey.
keywords: Python, Linux, Vim, Git, AI, SEO, Windows, LXD, WSL, YouTube, Microsoft, JupyterLab, Jupyter, Journaling, Jupyter Notebooks, GitHub, Code, Projects, Upgrading, Programming Languages, Conferences, Meetups, Deduping, Histograms, Category Pages, Markdown, SQLite, Database, Liquid Template, Slugs, File
categories: git, container, database, python, seo, youtube, vim, jupyter, wsl, ai, linux, microsoft, journaling
permalink: /blog/going-from-blog-keyword-histogram-to-category-pages/
layout: post
group: blog
---


Yesterday was an intense day. I'm going to try to a couple of quick one-offs to
start getting incremental advantage from the work I recently did. First, the
keyword histogram again. Here's some of the shortest, coolest code I know:

```python
from sqlitedict import SqliteDict as sqldict

with sqldict("topics.db") as db:
    for i, (k, v) in enumerate(db.iteritems()):
        print(i, k, v)
```

That steps through an existing Sqlite database and prints out the key and value
along with a numeric index. This should probably be one of the first things
taught in Python after the basics of lists, dicts and tuples. Did somebody say
list? There's no list there, just dicts and tuples. Oh, here's a list:

```python
from sqlitedict import SqliteDict as sqldict

keywords = []
with sqldict("topics.db") as db:
    for i, (k, v) in enumerate(db.iteritems()):
        print(i, k)
        for keyword in v.split(", "):
            keywords.append(keyword)
```

And how there's a table of keywords. I did it as a list and not a set because I
want all those duplicates in the keyword list. It's a step on the way to a
keyword histogram because we're going to count the duplicates like so:

```python
from sqlitedict import SqliteDict as sqldict
from collections import Counter

keywords = []
with sqldict("topics.db") as db:
    for i, (k, v) in enumerate(db.iteritems()):
        for keyword in v.split(", "):
            keywords.append(keyword)
histo = Counter(keywords)
histo.most_common()
```

And here's some of the sample output:

    [('Python', 158),
     ('Linux', 150),
     ('AI', 67),
     ('SEO', 66),
     ('Vim', 65),
     ('Windows', 62),
     ('Git', 46),
     ('LXD', 42),
     ('YouTube', 39),
     ('Microsoft', 39),
     ('WSL', 38),
     ('JupyterLab', 36),
     ('Jekyll', 33),
     ('Github', 29),
     ('Jupyter', 27),
     ('Journey', 26),
     ('vim', 26),
     ('git', 22),
     ('Script', 21),
     ('Software', 21),
     ('WSL2', 21),
     ('API', 21),
     ('Ubuntu', 20),
     ('Video', 19),
     ('Writing', 19),
     ('ChatGPT', 19),
     ('Journaling', 18),
     ('Website', 18),
     ('VSCode', 18),
     ('Automation', 18),
     ('Bing', 18),
     ('Github Pages', 17),
     ('Journal', 17),
     ('Life', 17),
     ('Jupyter Notebook', 16),
     ('Pipulate', 16),
     ('Unix', 16),
     ('Browser', 16),
     ('FOSS', 16),
     ('Code', 15),
     ('Content', 15),
     ('Windows 10', 15),
     ('Machine Learning', 15),
     ('OpenAI', 15),
     ('Google Analytics', 14),
     ('Markdown', 14),
     ('Tools', 14),
     ('JavaScript', 14),
     ('Systemd', 14),
     ('Server', 14),
     ('URLs', 13),
     ('Scripts', 13),
     ...

And it goes on that way for some time. It makes total sense to make a page
containing the meta descriptions for each of these pages. They'd be category or
topic pages without having to tag or categorize. A dynamic search system might
normally be what's chosen for this, but I'm using the Jekyll static site
generator built into Github Pages, so... so... the next step?

I can imagine plenty of intermediary steps, like populating a dictionary in
which the keys are keywords and the values are lists of the pages that contain
those keywords for later iteration through to build category pages. However
down that path leads multiple unnecessary steps and memory usage. Why not do it
all "in location" while you have the data in an efficient Python generator?

The only reason is for tutorial and clean-code sake. If I do it into a Python
object like a dictionary, I get the point across and can adapt it to actually
generating markdown pages in location when I copy/paste this into the ChopChop
blogslicer. But for now, let's use dicts like is intuitive.

An interesting thing of this approach is that the histogram becomes redundant
because the new dictionary will contain the same information by inference. But
I'll keep the histogram for explicitness. Ooh, ooh! I get to use collections
Counter and collections defaultdict in the same example!

Okay, follow this reasoning as to why this code ends up so short, clean and
readable. Python dictionaries (dicts) are the best data structure to keep track
of how many URLs associate with each keyword. So keywords become keys in a
dictionary and URLs become the value. But because there's multiple URLs per
keyword, it can't just be a string value. The dictionary value needs to be
a list. Every time we encounter a new keyword, we need an empty sub-list to
start appending URLs to. Get it?

And so the defaultdict custom data type from collections lets you do just that.
Every time you refer to a brand new key of the defaultdict object, it will (in
our case) already and automatically have an empty list as its value to which
you can immediately start appending, no muss, no fuss. You could do this with a
regular dict, but you'd have to check if the keyword's already in the dict and
if not, initialize it by setting its value to an empty list before you start
appending to it. More code. Ugly code. Thank you probably Raymond Hettinger.
This sort of thing (namedtuples, for example) have his signature on it.

```python
from sqlitedict import SqliteDict as sqldict
from collections import Counter, defaultdict

keywords = []
cat_dict = defaultdict(list)
with sqldict("topics.db") as db:
    for i, (k, v) in enumerate(db.iteritems()):
        for keyword in v.split(", "):
            keywords.append(keyword)
            cat_dict[keyword].append(k)
histo = Counter(keywords)
cat_dict
```

Some of its output:

    defaultdict(list,
                {'Github.io': ['make-more-use-of-github-io-for-blogging',
                  're-launch-mikelevinseo-com-on-github-io',
                  'jekyll-include-tags-for-github-io-youtube-embedding',
                  'adding-google-analytics-to-github-io-page-with-jekyll',
                  'journaling-as-performance-art'],
                 'Blogging': ['make-more-use-of-github-io-for-blogging',
                  'why-programming-is-easy-but-math-is-hard',
                  'b5-and-stay-alive',
                  'choosing-best-css-framework-for-github-pages-and-jekyll',
                  'reworking-site',

You can learn Python in a day, but it's these types of things (literally
"types" of things) like defaultdict, Counter and namedtuples that make things
so much more pleasant and clean. It takes years to get down all this Pythonic
nuance. Whereas the old PERL community used to get a kick from code obfuscation
contexts (finding the weirdest way to do a thing), the pragmatic Python
community doesn't waste time on such contests, but if they did it would be on
the one most obvious and right way to do a thing.

This is why the old Design Patterns book that was so popular in the Java world
is hardly even heard of in the Python world. Even though factory classes like
these 3 (namedtuple, defaultdict and Counter) are factory classes, Python
people generally don't have to think about the fact. Both of these lines in the
code are creating instances of factory classes.

```python
histo = Counter(keywords)
cat_dict = defaultdict(list)
```

Python naming conventions aren't entirely consistent. Some use of upper-case
object names usually implies factory classes and their instances are
lower-case. Counter uses the Java convention while defaultdict and namedtuple
don't.

A great reason to keep the histogram around is that it's already sorted
descending by keyword usage frequency. You can't (shouldn't) really rely on the
Counter instance's initial state as a dict to preserve order. Instead, we use
the list of tuples created by the .most_common() method of an instance of a
counter:

```python
from sqlitedict import SqliteDict as sqldict
from collections import Counter, defaultdict

keywords = []
cat_dict = defaultdict(list)
with sqldict("topics.db") as db:
    for i, (k, v) in enumerate(db.iteritems()):
        for keyword in v.split(", "):
            keywords.append(keyword)
            cat_dict[keyword].append(k)
histo = Counter(keywords)
histo = histo.most_common()

for keyword, freq in histo:
    print(keyword)
```

This definitely exposes the upper vs. lower case issue of keywords here. I
preserved the original case suggested by OpenAI, but when used for histogram
and category page generation purposes, there'd effectively be dupe pages if we
don't normalize the case. So I'll do that now.

```python
from sqlitedict import SqliteDict as sqldict
from collections import Counter, defaultdict

keywords = []
cat_dict = defaultdict(list)
with sqldict("topics.db") as db:
    for i, (k, v) in enumerate(db.iteritems()):
        for keyword in v.split(", "):
            keywords.append(keyword.lower())
            cat_dict[keyword].append(k)
histo = Counter(keywords)
histo = histo.most_common()

for i, (keyword, freq) in enumerate(histo):
    print(i, keyword)
```

This produces 5,323 keywords while without lower-casing produced 5,688. That's
not as many as I thought, but still it's probably on a lot of the important
ones like vim, git, wsl and such. Let's do a test with ChatGPT. This is
creating a prompt to copy/paste to chat.openai.com (not the API) so it doesn't
cost me anything:

```python
from sqlitedict import SqliteDict as sqldict
from collections import Counter, defaultdict

keywords = []
cat_dict = defaultdict(list)
with sqldict("topics.db") as db:
    for i, (k, v) in enumerate(db.iteritems()):
        for keyword in v.split(", "):
            keywords.append(keyword.lower())
            cat_dict[keyword].append(k)
histo = Counter(keywords)
histo = histo.most_common()

for i, (keyword, freq) in enumerate(histo):
    print(f"{keyword}, ", end="")
    if i> 100:
        break
```

Me: Write a story about someone for whom the following list is their most frequent topics of interest: python, linux, vim, git, ai, seo, windows, lxd, wsl, youtube, microsoft, jupyterlab, journey, github, jekyll, jupyter, script, video, software, wsl2, api, markdown, life, systemd, ubuntu, github pages, journal, writing, website, journaling, automation, chatgpt, code, unix, vscode, bing, repo, tools, jupyter notebook, file, pipulate, browser, foss, files, content, windows 10, machine learning, openai, google analytics, nbdev, programming, project, scripts, javascript, tech, container, server, NeoVim, urls, editing, windows 11, containers, nas, database, list, mac, google, pandas, moz, blog, mikelev.in, documentation, learning, technology, mike levin, browser automation, research, success, videos, skills, command, free, hardware, google photos, blogging, lpvg, upgrade, environment, goals, tutorial, notebook, title, explore, consciousness, 2022, future, search, docker, moz pro, copilot, proprietary, new york city

ChatGPT: John was a tech enthusiast, constantly exploring new tools and techniques to improve his programming skills. He had a list of topics that he was most interested in and often found himself talking about them with anyone who would listen.

Python, Linux, Vim, Git, AI, SEO, Windows, LXD, WSL, YouTube, Microsoft, JupyterLab, and Jupyter were just a few of the topics that John was most passionate about. He had spent countless hours learning about these subjects and was always looking for new ways to apply them to his work.

John loved to write code and was always looking for new ways to automate his tasks. He spent most of his time on his computer, exploring new software and tools to make his work easier and more efficient. He was particularly interested in the latest advancements in machine learning and AI, which he hoped to apply to his work someday.

John was also a huge fan of journaling and often used Jupyter notebooks to document his thoughts and ideas. He used GitHub to store all of his code and projects, and he loved exploring new ways to use this platform to collaborate with others.

When he wasn't working on his computer, John enjoyed exploring the city, taking walks in the park, and trying new foods. He loved to document his adventures in his journal and often wrote about his experiences on his blog.

As 2022 approached, John was excited to explore new technologies and tools. He had set ambitious goals for himself, including upgrading his hardware and exploring new programming languages like JavaScript. He was also looking forward to attending more tech conferences and meetups in New York City, where he could connect with like-minded individuals and learn from the best in the industry.

Overall, John's love for technology and programming was a driving force in his life. He was always seeking new ways to improve his skills and push the boundaries of what was possible. With his passion and dedication, John knew that he would continue to achieve success and make a name for himself in the tech world.

---

Not bad. This is definitely the sort of sub-project you can do as you go to
qualify the work you're doing. Can a reasonable (statistically average) person
given the same information come away with the same conclusions? ChatGPT really
wants me to focus on JavaScript. I mention it a lot, but not because I like it
or want to use it. It's because it's the unfortunate reality of the web.

One of the coolest things about this little project is how close it is to what
you would do for actually producing category pages.

Pages, that's right! It occurs to me as I look at the keyword list and see
inconsistent use of hyphens and characters that are no-no's in filenames, I
ought to slugify the keywords before the histogram process. It will further
dedupe and make the keywords friendly for filenames, which comes soon.

```python
from sqlitedict import SqliteDict as sqldict
from collections import Counter, defaultdict
from slugify import slugify

keywords = []
cat_dict = defaultdict(list)
with sqldict("topics.db") as db:
    for i, (k, v) in enumerate(db.iteritems()):
        for keyword in v.split(", "):
            keyword = slugify(keyword.lower())
            keywords.append(keyword)
            cat_dict[keyword].append(k)
histo = Counter(keywords)
histo = histo.most_common()

for i, (keyword, freq) in enumerate(histo):
    print(i, keyword)
```

And indeed, there's now 5,255 keywords. This hasn't addressed singular vs.
plural, but I won't worry about that now. The NLTK library has a stemmer that
will do that for me. I'll save that for later. I know I could and maybe should
do that now, but methinks rabbit holes are afoot there. Stemmed versions aren't
what you want to expose to the public, so I'd have to stem, then reverse out to
the most common form.

Happily doing all the lowercasing and slugging before the histogram is created
means the cat_dict uses the new form of the keywords as keys, and we can plug
each from the histogram into the category dictionary. Here's an easy way to
view the number of posts in each category:

```python
from sqlitedict import SqliteDict as sqldict
from collections import Counter, defaultdict
from slugify import slugify

keywords = []
cat_dict = defaultdict(list)
with sqldict("topics.db") as db:
    for i, (k, v) in enumerate(db.iteritems()):
        for keyword in v.split(", "):
            keyword = slugify(keyword.lower())
            keywords.append(keyword)
            cat_dict[keyword].append(k)
histo = Counter(keywords)
histo = histo.most_common()

for i, (keyword, freq) in enumerate(histo):
    slugs = cat_dict[keyword]
    print(i + 1, len(slugs), keyword)
```

Which produces:

```text
1 159 python
2 150 linux
3 92 vim
4 69 git
5 67 ai
6 66 seo
7 62 windows
8 42 lxd
9 41 wsl
10 39 youtube
11 39 microsoft
12 36 github
13 36 jupyterlab
14 35 journey
15 33 jekyll
16 29 jupyter
17 26 script
18 22 video
...
```

I want to jump right into writing out the category pages now with the meta
descriptions and all, but that would make the code too ugly too fast. Instead,
a few more chisel-strike baby-steps. We want to start using paths to where our
data resides instead of relative to our repo. That way we can move the code
around and it will still work.

```python
from sqlitedict import SqliteDict as sqldict
from collections import Counter, defaultdict
from slugify import slugify


DBDIR = "/home/ubuntu/repos/hide/MikeLev.in/_data/"

keywords = []
cat_dict = defaultdict(list)
with sqldict(DBDIR + "topics.db") as db:
    for i, (k, v) in enumerate(db.iteritems()):
        for keyword in v.split(", "):
            keyword = slugify(keyword.lower())
            keywords.append(keyword)
            cat_dict[keyword].append(k)
histo = Counter(keywords)
histo = histo.most_common()

for i, (keyword, freq) in enumerate(histo):
    slugs = cat_dict[keyword]
    print(i + 1, len(slugs), keyword)
```

I've already made the decision in my mind to use the include file capability of
the Jekyll Liquid template to pull in the lists of articles for each category.
That way I'll just make one category page layout and then use the include using
a different variable for each category. That way I can make rapid tweaks to the
category page without re-outputting all the articles whose lists live
separately in the includes.

Clean up after yourself first!

```python
from sqlitedict import SqliteDict as sqldict
from collections import Counter, defaultdict
from pathlib import Path
from slugify import slugify

REPO = "/home/ubuntu/repos/hide/MikeLev.in/"
DBDIR = f"{REPO}_data/"
INCDIR = f"{REPO}_includes/"

# Delete all previous category pages
for p in Path(INCDIR).glob("cat-*"):
    p.unlink()

keywords = []
cat_dict = defaultdict(list)
with sqldict(DBDIR + "topics.db") as db:
    for i, (k, v) in enumerate(db.iteritems()):
        for keyword in v.split(", "):
            keyword = slugify(keyword.lower())
            keywords.append(keyword)
            cat_dict[keyword].append(k)
histo = Counter(keywords)
histo = histo.most_common()

for i, (keyword, freq) in enumerate(histo):
    slugs = cat_dict[keyword]
    print(i + 1, len(slugs), keyword)
```

We're going to work directly in the Jekyll includes folder. This next step has
me building the full file-name that's going to be used for the include file. It
also only allows for category pages that would have at least 3 articles on it.
That produces about 600 pages. That's way less than the >5000 it started as.
It's still quite long, but that's okay because I want this to also help me spot
long-tailish niche topics that I just happen to be writing more about. New
things that show up here are "on the rise".

This version adds the actual file-writing. It only inserts the list of article
slugs into the include file. I'll add the meta description and title later. But
to make it at least render as a nice markdown unordered list when I'm testing,
I'll do the minimal markdown formatting to make a pretty page.

This cheaply recycles the slug as the anchor text. That's another thing that
will change when I blend in the descriptions. Every article has the original
title as well from which the slug was produced that has the proper capitalization
and punctuation. I'll use that as the anchor text later.

```python
from sqlitedict import SqliteDict as sqldict
from collections import Counter, defaultdict
from pathlib import Path
from slugify import slugify

REPO = "/home/ubuntu/repos/hide/MikeLev.in/"
DBDIR = f"{REPO}_data/"
INCDIR = f"{REPO}_includes/"

# Delete all previous category pages
for p in Path(INCDIR).glob("cat_*"):
    p.unlink()

keywords = []
cat_dict = defaultdict(list)
with sqldict(DBDIR + "topics.db") as db:
    for i, (k, v) in enumerate(db.iteritems()):
        for keyword in v.split(", "):
            keyword = slugify(keyword.lower())
            keywords.append(keyword)
            cat_dict[keyword].append(k)
histo = Counter(keywords)
histo = histo.most_common()

for i, (keyword, freq) in enumerate(histo):
    slugs = cat_dict[keyword]
    full_name = f"{INCDIR}cat_{keyword}.md"
    num_posts = len(slugs)
    if num_posts > 2:
        print(i + 1, len(slugs), full_name)
        with open(full_name, "w") as fh:
            for slug in slugs:
                fh.write(f"{slug}\n")
```

I'll call this morning project a success. It's not complete, but it sets the
stage for my next step being super effective on improving my site.


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/a-script-to-pull-keywords-from-moz-pro-keyword-research-ranking-keywords/">A Script To Pull Keywords From MOZ Pro Keyword Research Ranking Keywords</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/website-content-gap-analysis-based-on-keyword-serp-rankings/">Website Content GAP Analysis Based on Keyword SERP Rankings</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/git/'>Git</a></h4></li>
<li><h4><a href='/container/'>Containers</a></h4></li>
<li><h4><a href='/database/'>Database</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/seo/'>SEO</a></h4></li>
<li><h4><a href='/youtube/'>YouTube</a></h4></li>
<li><h4><a href='/vim/'>Vim</a></h4></li>
<li><h4><a href='/jupyter/'>Jupyter</a></h4></li>
<li><h4><a href='/wsl/'>WSL</a></h4></li>
<li><h4><a href='/ai/'>AI</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li>
<li><h4><a href='/microsoft/'>Microsoft</a></h4></li>
<li><h4><a href='/journaling/'>Journaling</a></h4></li></ul>