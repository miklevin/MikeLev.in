---
date: 2023-01-15
title: Sorting by Histogram Intersections with KMeans Clustering
headline: Exploring KMeans Clustering with Histogram Intersections and the Elbow Method
description: I'm exploring the KMeans clustering algorithm to better understand how it works. To do this, I'm using the Elbow method to determine the optimal number of clusters and then using the KMeans fit method to sort the data into the chosen number of clusters. I plotted a scatter graph with x and y values, and used the kmeans.labels_ parameter to color code the points and clearly show the clusters that had been formed.
keywords: KMeans Clustering, Elbow Method, 2-dimensional numpy array, Labels, Buckets, Bin, Scatter Graph, x and y values, Color Code, Clusters, Plotting
categories: 
permalink: /blog/sorting-by-histogram-intersections-with-kmeans-clustering/
layout: post
---


I am trying to wrap my mind around a bare minimum example of KMeans for
clustering. This is one of those giant steps forward if I master it. Get
yourself written by a radioactive spider. This one has some challenges. The
challenges do not include the initial import, which is pretty straight forward.
We don't need much:

```python
import numpy as np
import matplotlib.pyplot as plt
from sklearn.cluster import KMeans
```

Next we just make a 2-dimensional numpy array.

```python
da = np.random.rand(100, 2)
```

This too is easily understood and a pretty neat trick for making experimental
arrays of data to work on. If you imported the Pandas library you could for
example stamp out quick DataFrames for playing around like this:

```python
pd.DataFrame(np.random.rand(100, 4))
```

The fact we're going with 2-column for this investigation is important because
we are comparing how close column-1 is to column-2 and then grouping the
results by closeness. There is no avoiding a column-3 though because each group
is going to need its own numeric label. You can't have things belonging to
things if they have no label to tag that thing, which brings us to the next
step I'm trying to wrap my head around.

Okay, by doing this line on the import, we have a KMeans "factory class" just
like we have when we used Counter or namedtuple from collections. We are
staging ourselves to set up a kmeans instance of a KMeans factory class.

```python
from sklearn.cluster import KMeans
```

At the moment you create such an instance, you need to know a few things. It's
not much because the "fitting" of the data to a target number of buckets has
not occurred yet. However, there is a very related concept you do have to deal
with right up front and this is one of my tripping-up points. Labels you know
imply the spoken word. I'm labeling this sub-group as this and that sub-group
as that. And your original data often already has such labels. This row of data
came from file-A on the drive and that row of data came from file-B on the
drive, and so on. Every row might have its own human-readable label, but we
have to put that aside for a moment. We can always "map back" to such human
labels but for the purposes of machine learning, and the sort of clustering
we're doing here is a form of machine learning, we must concede this step to
the machine and let it work with numbers.

Therefore at this critical juncture of learning KMeans, we must grapple with
the strange fact that at the moment we instantiate a new instance of the KMeans
class, the "n_clusters" parameter is actually asking you how many
auto-generated labels you would like, sequentially numbered from 0 to N, you
would like to be generated and mapped to each row of the array being fed.
You're "giving a name" to every row, as numerical and similar to auto-indexes
as these labels may be. But KMeans likes to call this index labels, and so be
it. We yield and lean into the strength of the tools. So when we say:

```python
da = np.random.rand(100, 2)
```

...we now are sitting on a 2-column numpy array. We are going to be making some
sort of statement about each one of those rows and in order to talk about then
and address them, we create the factory instance of that KMeans class telling
it to assign every row in the class a number from 0 to N. We can then access
those labels through the .labels\_ property of the kmeans instance, like so:

```python
kmeans = KMeans(n_clusters=8, n_init="auto").fit(da)
labels = kmeans.labels_
```

And so, this will always be true:

```python
len(labels) == len(da)
```

Get it? In a way some grouping has already been done. Your N-number of desired
labels will be spread out over your numeric array. It's sort of like setting
your fixed frame of reference or the window into the graph you're eventually
going to be plotting which will say something like:

Row 1, which we refer to by it's Label A value, maps to Bucket (or Bin) B.

Wait, what? So we chunk up our source data into Label-groups and that's not our
clustering yet? We still have to sort them and drop them into their Buckets? So
there's still a number of destination buckets to define? Yes indeedy, and
that's the "fitting" part of this model.

You won't hear it said, but the labeling of rows at the moment you initiate a
new factory-class of KMeans is the easy calculation and must be gotten out of
the way at initialization of a new kmeans instance. What comes next however is
the part that takes the work. It's a bit frustrating from a novice point of
view, because now you have 2-levers to pull and they seem similar.

Okay, to understand the next step, we've got to deconstruct a few things.
First, numpy arrays are like Pandas DataFrames in that you look at an instance
of da the way you would a df, and they both have square bracket index
interfaces. In fact, it has the iloc interface by default.

```python
da[:,:]
```

And so since we asked for 2 columns each containing random numbers between 0
and 1, we can select about half of them with a bit-filter just as you would in
Pandas:

```python
da[:,0] > .5
```

And also as with Pandas, such a bit mask can be used as a boolean mask key to
select a subset of a larger frame:

```python
da[da[:,0] > .5]
```

...whose len() is 47, confirming this selects about half the rows.

```python
kmeans = KMeans(n_clusters=3, n_init="auto").fit(da)
labels = kmeans.labels_
```

Now there's a chicken and egg problem here. n_clusters=3? Really? Who's to say?
Isn't coming up with a value for N the first challenge? This page seems to
think so: https://www.w3schools.com/python/python_ml_k-means.asp

When you ask for N clusters, N can be no larger than the number of rows in your
sample data. You can't distribute 10 items over 11 bins and end up with an item
in each bin, so you lower the max number of potential bins to no bigger than
the number of items being sorted.

The fact you've got to chose your number of clusters at the outset is its own
pre-problem problem. You can ballpark numbers, but how do you know you're
choosing the right number of clusters

https://www.w3schools.com/python/python_ml_k-means.asp

When we call the fit method of a kmeans instance, we already need to have set
our N cluster and that's very chicken-and-egg. We can do a pre-spin and look at
what the output WOULD be if we asked for that number of clusters.

I currently have this example, but I think it's missing a big part of the
point:

```python
import matplotlib.pyplot as plt
import numpy as np
from sklearn.cluster import KMeans

# Generate data
np2a = np.random.rand(100, 2)
buckets = 30

# Fit KMeans model
kmeans = KMeans(n_clusters=3, n_init="auto").fit(np2a)
labels = kmeans.labels_

print(len(kmeans.labels_))

# Create histograms for each cluster
c1, _ = np.histogram(np2a[labels == 0], bins=buckets)
c2, _ = np.histogram(np2a[labels == 1], bins=buckets)
c3, _ = np.histogram(np2a[labels == 2], bins=buckets)

# Calculate histogram intersection
# hist_intersection = np.minimum(c1, np.minimum(c2, c3))
hist_intersection = np.minimum(c1, c3)

# Plot the histogram intersection
plt.bar(range(buckets), hist_intersection)
plt.show()
```

Back up, turn a little and retry. Okay, I've turned their sample code into:

```python
from random import randint
import matplotlib.pyplot as plt

range_size = randint(10, 50)

x = [randint(1, 10) for x in range(range_size)]
y = [randint(1, 10) for x in range(range_size)]

plt.scatter(x, y)
plt.show()
```

And then:

```python
from sklearn.cluster import KMeans

data = list(zip(x, y))
inertias = []

for i in range(1, 11):
    kmeans = KMeans(n_clusters=i, n_init="auto")
    kmeans.fit(data)
    inertias.append(kmeans.inertia_)

plt.plot(range(1, 11), inertias, marker="o")
plt.title("Elbow method")
plt.xlabel("Number of clusters")
plt.ylabel("Inertia")
plt.show()
```

And finally:

```python
kmeans = KMeans(n_clusters=2, n_init="auto")
kmeans.fit(data)

plt.scatter(x, y, c=kmeans.labels_)
plt.show()
```


<div class="post-nav"><div class="post-nav-prev"><span class="arrow">&nbsp;&rarr;</span><a href="/blog/the-critical-juncture-with-ai-my-next-steps/">The Critical Juncture With AI & My Next Steps</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/planning-big-crawl-jobs-on-a-little-laptop-chunking/">Planning Big Crawl Jobs On a Little Laptop (Chunking)</a><span class="arrow">&larr;&nbsp;</span></div></div>
## Categories

<ul></ul>