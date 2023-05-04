---
date: 2023-02-04
title: How To Cluster Keywords From Google Suggest API
headline: "Exploring Google Photos: Clustering Keywords with Python for SEO-Friendly Names"
description: I'm exploring all the amazing features Google Photos has to offer, from converting HEIC to JPG to downloading, editing videos, and more. To come up with SEO-friendly names for my project, I wrote code to cluster keywords into groups and created a dictionary mapping each keyword to its group. I also wrote a function to find the most common two-word combination for each group and mapped that to the group name, creating a csv file with the results.
keywords: Google Photos, HEIC, JPG, Video, SEO, Python, Code, Cluster, Dictionary, Group, CSV, Project, Query, Suggest API, Download, Edit, Convert, Backup, Crash, Freeze, Delete, Keyboard Shortcuts, Logo, Limit, Link, Movie Maker, Memories, Map, Magic Eraser, Collage, Metadata, Mirror Flip, Storage, Email, Gift, Game, Gallery, Gift Cards, QR Scanner, Quota Management, Quality Settings,
categories: csv, python, google photos, email, seo
permalink: /blog/how-to-cluster-keywords-from-google-suggest-api/
layout: post
---


Wow, massive progress on the Google Photos API project. This may be something I
roll out to the public as a sort of overture. If I did, now would I go about
the SEO-friendly naming? Switch to anonymous mode in the browser and bring up
the Google main homepage.

- app
- login
- search
- album
- storage
- download
- sign in
- back up
- locked folder

Okay, we can use this little bit of Python code to get all the suggestions:

```python
import string
import requests

base_url = "http://suggestqueries.google.com/complete/search?client=firefox&&q="
query = "google photos"
url = f"{base_url}{query}"
response = requests.get(url)
table = []
for suggestion in response.json()[1]:
    table.append(suggestion)
lowercase_letters = string.ascii_lowercase
for letter in lowercase_letters:
    query = f"google photos {letter}"
    url = f"{base_url}{query}"
    response = requests.get(url)
    for suggestion in response.json()[1]:
        table.append(suggestion)
```

Hmmm. It appears to me that the order in which things came back and the actual
query are both of importance too. Let's preserve all that:

```python
import string
import requests

base_url = "http://suggestqueries.google.com/complete/search?client=firefox&&q="
query = "google photos"
url = f"{base_url}{query}"
response = requests.get(url)
table = []
for i, suggestion in enumerate(response.json()[1]):
    row = (query, i + 1, suggestion)
    table.append(row)
lowercase_letters = string.ascii_lowercase
for letter in lowercase_letters:
    query = f"google photos {letter}"
    url = f"{base_url}{query}"
    response = requests.get(url)
    for i, suggestion in enumerate(response.json()[1]):
        row = (query, i + 1, suggestion)
        table.append(row)
```

The output looks like this:

    [('google photos', 1, 'google photos'),
     ('google photos', 2, 'google photos app'),
     ('google photos', 3, 'google photos login'),
     ('google photos', 4, 'google photos search'),
     ('google photos', 5, 'google photos album'),
     ('google photos', 6, 'google photos storage'),
     ('google photos', 7, 'google photos download'),
     ('google photos', 8, 'google photos sign in'),
     ('google photos', 9, 'google photos backup'),
     ('google photos', 10, 'google photos locked folder'),
     ('google photos a', 1, 'google photos app'),
     ('google photos a', 2, 'google photos album'),
     ('google photos a', 3, 'google photos app download'),
     ('google photos a', 4, 'google photos archive'),
     ('google photos a', 5, 'google photos app android'),
     ('google photos a', 6, 'google photos all your photos organized'),
     ('google photos a', 7, 'google photos api'),
     ('google photos a', 8, 'google photos alternative'),
     ('google photos a', 9, 'google photos account'),
     ('google photos a', 10, 'google photos apk'),
     ('google photos b', 1, 'google photos backup'),
     ('google photos b', 2, 'google photos backup and sync'),
     ('google photos b', 3, 'google photos book'),
     ('google photos b', 4, 'google photos backup download'),
     ('google photos b', 5, 'google photos backup stuck'),
     ('google photos b', 6, 'google photos blur background'),
     ('google photos b', 7, 'google photos by size'),
     ('google photos b', 8, 'google photos backup iphone'),
     ('google photos b', 9, 'google photos browser'),
     ('google photos b', 10, 'google photos backup slow'),
     ('google photos c', 1, 'google photos collage'),
     ('google photos c', 2, 'google photos customer service'),
     ('google photos c', 3, 'google photos cost'),
     ('google photos c', 4, 'google photos christmas cards'),
     ('google photos c', 5, 'google photos canvas prints'),
     ('google photos c', 6, 'google photos calendar'),
     ('google photos c', 7, 'google photos cloud'),
     ('google photos c', 8, 'google photos calendar maker'),
     ('google photos c', 9, 'google photos cast to tv'),
     ('google photos c', 10, 'google photos convert heic to jpg'),
     ('google photos d', 1, 'google photos download'),
     ('google photos d', 2, 'google photos desktop'),
     ('google photos d', 3, 'google photos duplicates'),
     ('google photos d', 4, 'google photos download all'),
     ('google photos d', 5, 'google photos desktop app'),
     ('google photos d', 6, 'google photos digital frame'),
     ('google photos d', 7, 'google photos delete all'),
     ('google photos d', 8, 'google photos delete from device'),
     ('google photos d', 9, 'google photos download as jpg'),
     ('google photos d', 10, 'google photos drive'),
     ('google photos e', 1, 'google photos email'),
     ('google photos e', 2, 'google photos editor'),
     ('google photos e', 3, 'google photos export'),
     ('google photos e', 4, 'google photos eraser'),
     ('google photos e', 5, 'google photos edit video'),
     ('google photos e', 6, 'google photos empty trash'),
     ('google photos e', 7, 'google photos encrypted'),
     ('google photos e', 8, 'google photos editing tools'),
     ('google photos e', 9, 'google photos extra storage'),
     ('google photos e', 10, 'google photos editor app'),
     ('google photos f', 1, 'google photos for mac'),
     ('google photos f', 2, 'google photos free storage'),
     ('google photos f', 3, 'google photos free up space'),
     ('google photos f', 4, 'google photos face recognition'),
     ('google photos f', 5, 'google photos find duplicates'),
     ('google photos f', 6, 'google photos flip image'),
     ('google photos f', 7, 'google photos frame'),
     ('google photos f', 8, 'google photos for iphone'),
     ('google photos f', 9, 'google photos from phone to computer'),
     ('google photos f', 10, 'google photos family sharing'),
     ('google photos g', 1, 'google photos gifts'),
     ('google photos g', 2, 'google photos game'),
     ('google photos g', 3, 'google photos gallery'),
     ('google photos g', 4, 'google photos gift card'),
     ('google photos g', 5, 'google photos gif'),
     ('google photos g', 6, 'google photos google drive'),
     ('google photos g', 7, 'google photos gorilla mistake'),
     ('google photos g', 8, 'google photos gmail'),
     ('google photos g', 9, 'google photos gif maker'),
     ('google photos g', 10, 'google photos going away'),
     ('google photos h', 1, 'google photos hidden album'),
     ('google photos h', 2, 'google photos help'),
     ('google photos h', 3, 'google photos hidden album iphone'),
     ('google photos h', 4, 'google photos how to select all'),
     ('google photos h', 5, 'google photos holiday cards'),
     ('google photos h', 6, 'google photos heic to jpg'),
     ('google photos h', 7, 'google photos heic'),
     ('google photos h', 8, 'google photos how much free storage'),
     ('google photos h', 9, 'google photos hide person'),
     ('google photos h', 10, 'google photos how to delete all'),
     ('google photos i', 1, 'google photos icon'),
     ('google photos i', 2, 'google photos iphone'),
     ('google photos i', 3, 'google photos in my phone'),
     ('google photos i', 4, 'google photos identify faces'),
     ('google photos i', 5, 'google photos in google drive'),
     ('google photos i', 6, 'google photos iphone sync'),
     ('google photos i', 7, 'google photos invert colors'),
     ('google photos i', 8, 'google photos image search'),
     ('google photos i', 9, 'google photos image hosting'),
     ('google photos i', 10, 'google photos icloud'),
     ('google photos j', 1, 'google photos json files'),
     ('google photos j', 2, 'google photos june 2021'),
     ('google photos j', 3, 'google photos json merge'),
     ('google photos j', 4, 'google photos jpg'),
     ('google photos j', 5, 'google photos join album'),
     ('google photos j', 6, 'google photos jpeg'),
     ('google photos j', 7, 'google photos join videos'),
     ('google photos j', 8, 'google photos jobs'),
     ('google photos j', 9, 'google photos join shared album'),
     ('google photos j', 10, 'google photos just says preparing backup'),
     ('google photos k', 1, 'google photos keeps crashing'),
     ('google photos k', 2, 'google photos keyboard shortcuts'),
     ('google photos k', 3, 'google photos keeps backing up'),
     ('google photos k', 4, 'google photos keeps saying preparing backup'),
     ('google photos k', 5, 'google photos keywords'),
     ('google photos k', 6, 'google photos keeps deleting photos'),
     ('google photos k', 7, 'google photos keeps uploading'),
     ('google photos k', 8, 'google photos keeps closing'),
     ('google photos k', 9, 'google photos keeps freezing'),
     ('google photos k', 10, 'google photos keeps crashing iphone'),
     ('google photos l', 1, 'google photos login'),
     ('google photos l', 2, 'google photos locked folder'),
     ('google photos l', 3, 'google photos login another account'),
     ('google photos l', 4, 'google photos login recovery'),
     ('google photos l', 5, 'google photos logo'),
     ('google photos l', 6, 'google photos limit'),
     ('google photos l', 7, 'google photos locked folder ios'),
     ('google photos l', 8, 'google photos link'),
     ('google photos l', 9, 'google photos locked folder on pc'),
     ('google photos l', 10, 'google photos lawsuit'),
     ('google photos m', 1, 'google photos movie maker'),
     ('google photos m', 2, 'google photos memories'),
     ('google photos m', 3, 'google photos map'),
     ('google photos m', 4, 'google photos magic eraser'),
     ('google photos m', 5, 'google photos mac'),
     ('google photos m', 6, 'google photos make collage'),
     ('google photos m', 7, 'google photos metadata'),
     ('google photos m', 8, 'google photos mirror flip'),
     ('google photos m', 9, 'google photos more storage'),
     ('google photos m', 10, 'google photos move from one account to another'),
     ('google photos n', 1, 'google photos not backing up'),
     ('google photos n', 2, 'google photos not syncing'),
     ('google photos n', 3, 'google photos not showing all photos'),
     ('google photos n', 4, 'google photos not uploading'),
     ('google photos n', 5, 'google photos not detecting faces'),
     ('google photos n', 6, 'google photos not working on iphone'),
     ('google photos n', 7, 'google photos not working'),
     ('google photos n', 8, 'google photos notifications'),
     ('google photos n', 9, 'google photos not syncing iphone'),
     ('google photos n', 10, 'google photos not updating'),
     ('google photos o', 1, 'google photos on iphone'),
     ('google photos o', 2, 'google photos online'),
     ('google photos o', 3, 'google photos order prints'),
     ('google photos o', 4, 'google photos on tv'),
     ('google photos o', 5, 'google photos on roku'),
     ('google photos o', 6, 'google photos on mac'),
     ('google photos o', 7, 'google photos on samsung tv'),
     ('google photos o', 8, 'google photos or icloud'),
     ('google photos o', 9, 'google photos original vs storage saver'),
     ('google photos o', 10, 'google photos on this day'),
     ('google photos p', 1, 'google photos print'),
     ('google photos p', 2, 'google photos price'),
     ('google photos p', 3, 'google photos private folder'),
     ('google photos p', 4, 'google photos preparing backup stuck'),
     ('google photos p', 5, 'google photos photo book'),
     ('google photos p', 6, 'google photos partner sharing'),
     ('google photos p', 7, 'google photos processing video'),
     ('google photos p', 8, 'google photos picture frame'),
     ('google photos p', 9, 'google photos phone number'),
     ('google photos p', 10, 'google photos privacy'),
     ('google photos q', 1, 'google photos qr code'),
     ('google photos q', 2, 'google photos quality'),
     ('google photos q', 3, 'google photos questions'),
     ('google photos q', 4, 'google photos quota'),
     ('google photos q', 5, 'google photos quality settings'),
     ('google photos q', 6, 'google photos qr scanner'),
     ('google photos q', 7, 'google photos quota management'),
     ('google photos q', 8, 'google photos quality settings iphone'),
     ('google photos q', 9, 'google photos qnap'),
     ('google photos q', 10, 'google photos quick delete'),
     ('google photos r', 1, 'google photos remove duplicates'),
     ('google photos r', 2, 'google photos recovery'),
     ('google photos r', 3, 'google photos review'),
     ('google photos r', 4, 'google photos remove person'),
     ('google photos r', 5, 'google photos reverse image search'),
     ('google photos r', 6, 'google photos restore'),
     ('google photos r', 7, 'google photos reverse search'),
     ('google photos r', 8, 'google photos remove background'),
     ('google photos r', 9, 'google photos reduce file size'),
     ('google photos r', 10, 'google photos resize image'),
     ('google photos s', 1, 'google photos search'),
     ('google photos s', 2, 'google photos storage'),
     ('google photos s', 3, 'google photos sign in'),
     ('google photos s', 4, 'google photos select all'),
     ('google photos s', 5, 'google photos slideshow'),
     ('google photos s', 6, 'google photos storage pricing'),
     ('google photos s', 7, 'google photos shared album'),
     ('google photos s', 8, 'google photos storage limit'),
     ('google photos s', 9, 'google photos storage full'),
     ('google photos s', 10, 'google photos support'),
     ('google photos t', 1, 'google photos trash'),
     ('google photos t', 2, 'google photos to gallery'),
     ('google photos t', 3, 'google photos to icloud'),
     ('google photos t', 4, 'google photos to shutterfly'),
     ('google photos t', 5, 'google photos transfer to another account'),
     ('google photos t', 6, 'google photos trash bin'),
     ('google photos t', 7, 'google photos to amazon photos'),
     ('google photos t', 8, 'google photos to google drive'),
     ('google photos t', 9, 'google photos to iphone'),
     ('google photos t', 10, 'google photos takeout'),
     ('google photos u', 1, 'google photos unlimited storage'),
     ('google photos u', 2, 'google photos upload'),
     ('google photos u', 3, 'google photos update'),
     ('google photos u', 4, 'google photos unblur'),
     ('google photos u', 5, 'google photos unlimited storage hack'),
     ('google photos u', 6, 'google photos unable to edit check connection'),
     ('google photos u', 7, 'google photos upload stuck'),
     ('google photos u', 8, 'google photos unsync from iphone'),
     ('google photos u', 9, 'google photos upload from phone'),
     ('google photos u', 10, 'google photos undo delete'),
     ('google photos v', 1, 'google photos vs icloud'),
     ('google photos v', 2, 'google photos vs amazon photos'),
     ('google photos v', 3, 'google photos video editor'),
     ('google photos v', 4, 'google photos vs google drive'),
     ('google photos v', 5, 'google photos vs gallery'),
     ('google photos v', 6, 'google photos vs onedrive'),
     ('google photos v', 7, 'google photos video'),
     ('google photos v', 8, 'google photos vs icloud reddit'),
     ('google photos v', 9, 'google photos view locked folder'),
     ('google photos v', 10, 'google photos vs samsung gallery'),
     ('google photos w', 1, 'google photos website'),
     ('google photos w', 2, 'google photos windows app'),
     ('google photos w', 3, 'google photos widget'),
     ('google photos w', 4, 'google photos web version'),
     ('google photos w', 5, "google photos won't download"),
     ('google photos w', 6, 'google photos where are my photos'),
     ('google photos w', 7, "google photos won't backup"),
     ('google photos w', 8, "google photos won't upload"),
     ('google photos w', 9, 'google photos where is locked folder'),
     ('google photos w', 10, 'google photos whatsapp'),
     ('google photos x', 1, 'google photos xbox'),
     ('google photos x', 2, 'google photos xda'),
     ('google photos x', 3, 'google photos xposed'),
     ('google photos x', 4, 'google photos xiaomi'),
     ('google photos x', 5, 'google photos xmp'),
     ('google photos x', 6, 'google image search'),
     ('google photos x', 7, 'google images xmas'),
     ('google photos x', 8, 'google images x'),
     ('google photos x', 9, 'google images xbox 360'),
     ('google photos x', 10, 'google+ photo download'),
     ('google photos y', 1, 'google photos year in review'),
     ('google photos y', 2, 'google photos youtube'),
     ('google photos y', 3, 'google photos year in review video'),
     ('google photos y', 4, 'google photos years ago'),
     ('google photos y', 5, 'google photos yearly subscription'),
     ('google photos y', 6, 'google photos you need an internet connection'),
     ('google photos y', 7, 'google photos year recap'),
     ('google photos y', 8, 'google photos your map'),
     ('google photos y', 9, 'google photos yearbook'),
     ('google photos y', 10, 'google photos yao cheng'),
     ('google photos z', 1, 'google photos zoom out'),
     ('google photos z', 2, 'google photos zoom in more'),
     ('google photos z', 3, 'google photos zoom effect'),
     ('google photos z', 4, 'google photos zip'),
     ('google photos z', 5, 'google photos z'),
     ('google photos z', 6, 'google photos zip download'),
     ('google photos z', 7, 'google photos zoom'),
     ('google photos z', 8, 'google photos zip file'),
     ('google photos z', 9, 'google photos zapier'),
     ('google photos z', 10, 'google photos zero kb')]

Wow, okay there's enough data in there to prioritize based on popularity. We
don't need search volumes, search positions or really anything else to make a
lot of sense out of this.

Given this data, let's give some weighting to positions. We're going to be
adding new columns and such, and so for that, Pandas.

There's so many ways to tackle this, it's ridiculous. I'm going to go with a
scoring system, with various factors responsible for adding to a score. Highest
score wins. Each term has been suggested, and some more than once. Let that be
the first factor! Count occurrences.

```python
from collections import Counter

c = Counter()
for kw in table:
    c[kw[2]] += 1
```

Wow, fast-forward a few hours, and I have keyword clustering of Google Suggest.
Get that committed to the practice folder!

Okay, it's in there. The finished product that clusters keywords is in my
Github practice repo. I should really make a video about that. It's a good one.

I guess for the sake of completeness, I'll put it here:

```python
import re
import nltk
import string
import requests
import numpy as np
import pandas as pd
from pathlib import Path
from collections import Counter
from nltk.corpus import stopwords
from sklearn.cluster import KMeans
from nltk.tokenize import word_tokenize
from sklearn.feature_extraction.text import TfidfVectorizer


original_query = "google photos how to"

namespace = "suggest"
Path(namespace).mkdir(exist_ok=True, parents=True)

base_url = "http://suggestqueries.google.com/complete/search?client=firefox&&q="
url = f"{base_url}{original_query}"
response = requests.get(url)
table = []
for i, suggestion in enumerate(response.json()[1]):
    row = (original_query, i + 1, suggestion)
    table.append(row)
lowercase_letters = string.ascii_lowercase
for letter in lowercase_letters:
    query = f"{original_query} {letter}"
    url = f"{base_url}{query}"
    response = requests.get(url)
    for i, suggestion in enumerate(response.json()[1]):
        row = (query, i + 1, suggestion)
        table.append(row)

df = pd.DataFrame(table, columns=["seed", "position", "suggestion"])
filename = f"suggestions-{original_query.replace(' ', '_')}.csv"
df.to_csv(f"{namespace}/{filename}", index=False)
print("Done")

c = Counter()

stop_words = set(stopwords.words("english"))

inverter = {
    1: 10,
    2: 9,
    3: 8,
    4: 7,
    5: 6,
    6: 5,
    7: 4,
    8: 3,
    9: 2,
    10: 1,
}


def sort_counter_descending(counter):
    return sorted(counter.items(), key=lambda x: x[1], reverse=True)


def cluster_keywords(keywords, num_clusters):
    # Convert the keywords to a TF-IDF matrix
    vectorizer = TfidfVectorizer()
    X = vectorizer.fit_transform(keywords)

    # Perform k-means clustering on the TF-IDF matrix
    kmeans = KMeans(n_clusters=num_clusters, random_state=0)
    kmeans.fit(X)

    # Get the cluster assignments for each keyword
    cluster_assignments = kmeans.labels_
    return cluster_assignments


lowr = lambda x: x.lower()
alfa = lambda x: re.sub(r"[^a-zA-Z\s]", "", x)
sspc = lambda x: re.sub(" +", " ", x)
flat = lambda x: " ".join(x)
tkns = lambda x: word_tokenize(x)
nstp = lambda x: flat([y for y in tkns(lowr(x)) if y not in stop_words])

# Establish all counters
for kw in table:
    c[kw[2]] += 1

root_hist = Counter()
for kw in table:
    query, position, suggestion = kw

    # Give suggestions from seed term a boost.
    if query == original_query:
        c[suggestion] += 5

    # Boost each keyword based on its suggestion position.
    c[suggestion] += inverter[position]

    # Boost when highly specific yet still suggested
    delta = suggestion.replace(original_query, "").strip()
    delta_num_words = len(delta.split())
    if delta_num_words > 1:
        c[suggestion] += (delta_num_words - 1) * 3

    # Create histogram of cleaned deltas
    root = nstp(delta)
    if root:
        root_hist[root] += 1

for kw in table:
    query, position, suggestion = kw
    delta = suggestion.replace(original_query, "").strip()
    root = nstp(delta)
    c[suggestion] += root_hist[root] * 2

# sort_counter_descending(c)

# Example list of keywords
keywords = list(root_hist.keys())
num_keywords = len(keywords)

# Cluster the keywords into 3 clusters
print("Finding least number of clusters that produce only 2 empty groups.")
for i in range(2, int(num_keywords / 2)):
    num_clusters = int(num_keywords / i)
    print(f"Keywords: {num_keywords}")
    print(f"Number of Clusters: {num_clusters}")
    cluster_assignments = cluster_keywords(keywords, num_clusters)
    # print(cluster_assignments)
    num_zeros = np.count_nonzero(cluster_assignments == 0)
    max_group = np.amax(cluster_assignments)
    print(f"Max: {max_group}")
    print(f"Number of zeros: {num_zeros}")
    if num_zeros >= 3:
        denominator = i - 1
        print(f"Denominator to use: {int(denominator)}")
        break
num_clusters = int(num_keywords / denominator)
cluster_assignments = cluster_keywords(keywords, num_clusters)
print(cluster_assignments)
print("Done")

# Mab beloingings between keywords and thier clusters
cluster_dict = {}
for i, keyword in enumerate(keywords):
    cluster_dict[keyword] = cluster_assignments[i]
# cluster_dict

# Produce keyword groups using numbers as the group names.

sublist_dict = {}
for i, keyword in enumerate(keywords):
    group_number = cluster_assignments[i]
    if group_number in sublist_dict:
        # Encountered group number before. Append new keyword.
        sublist_dict[group_number].append(keyword)
    else:
        # First time group number is encountered make 1-val list.
        sublist_dict[group_number] = [keyword]
print("Done")

# Function to return a counter of 2-word combos
def common2(keywords):
    # Split each keyword into a list of words
    words_list = [keyword.split() for keyword in keywords]

    # Create a list of all 2-word combinations
    two_word_combinations = []
    for words in words_list:
        for i in range(len(words) - 1):
            two_word_combinations.append(f"{words[i]} {words[i + 1]}")

    # Count the occurrences of each 2-word combination
    two_word_counter = Counter(two_word_combinations)

    return two_word_counter

# This maps a most frequent 2-word combo to replace the numbered group names.
named_sublist_dict = {}
p = False
for group_number in sublist_dict:
    keywords = sublist_dict[group_number]
    best2s = common2(keywords)
    if p:
        print(f"Keywords: {keywords}")
        print(f"The best 2-word combos: {best2s}")
    if group_number not in named_sublist_dict:
        for candidate in best2s:
            if candidate not in named_sublist_dict:
                named_sublist_dict[group_number] = candidate
                if p:
                    print(f'"{candidate}" used for group number {group_number}.')
                break
print("Done")

# This uses the top 2-word combo as the name for each keyword group.
named_clusters = [
    (named_sublist_dict[x], sublist_dict[x])
    for x in sublist_dict
    if x in named_sublist_dict
]
dict_o_sets = dict([(x[0], set([x[0]] + x[1])) for x in named_clusters])

# This uses the top 2-word combo as the name for each keyword group.
named_clusters = [
    (named_sublist_dict[x], sublist_dict[x])
    for x in sublist_dict
    if x in named_sublist_dict
]
dict_o_sets = dict([(x[0], set([x[0]] + x[1])) for x in named_clusters])

word_values = dict(
    [
        (x[0].replace(original_query, "").strip(), x[1])
        for x in sort_counter_descending(c)
    ]
)

group_values = [
    (x, [word_values[y] for y in dict_o_sets[x] if y in word_values])
    for x in dict_o_sets
]
group_scores = [(x[0], round(sum(x[1]) / len(x[1]), 2)) for x in group_values if x[1]]
most_valuable_groups = dict(sorted(group_scores, key=lambda x: x[1], reverse=True))

table = []
for group_name in most_valuable_groups:
    score = most_valuable_groups[group_name]
    for keyword in dict_o_sets[group_name]:
        row = (group_name, keyword, score)
        table.append(row)

df2 = pd.DataFrame(table, columns=["Group Name", "Keyword", "Group Score"])

cluster_csv = f"cluster-{original_query.replace(' ', '_')}.csv"
df2.to_csv(f"{namespace}/{cluster_csv}", index=False)
print("Done")
```

It's worth noting that the keyword cluster csv files this outputs are perfectly
arranged to become pivot tables in Excel or Google Sheets. But don't forget to
look at the raw suggestions csv file too. There's a lot of insight in both. And
the scoring numbers I used are highly subjective. You may want to tweak them to
for best results.


<div class="post-nav"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/we-power-our-way-through-this-material-life-world">We Power Our Way Through This Material Life & World</a></div><div class="post-nav-next"><a href="/blog/using-google-photos-api-to-generate-main-archive-favorite-media-lists">Using Google Photos API to Generate Main, Archive & Favorite Media Lists</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/csv/'>CSV</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/google-photos/'>Google Photos</a></h4></li>
<li><h4><a href='/email/'>Email</a></h4></li>
<li><h4><a href='/seo/'>SEO</a></h4></li></ul>