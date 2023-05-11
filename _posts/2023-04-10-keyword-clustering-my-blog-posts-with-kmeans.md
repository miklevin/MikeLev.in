---
date: 2023-04-10
title: Keyword Clustering My Blog Posts With KMeans
headline: Using KMeans Clustering to Group 500 Blog Posts and Extract Keywords for Topic Modeling
description: As a computer user, I appreciate the consistency of the user interface, which has remained largely unchanged since the 1960s. I'm grateful for the tools that have the perfect balance of usability and staying-power, which improve gradually and don't require me to press the reset button on my skills and career. This blog post explores how to use KMeans clustering to group 500 articles into 10 clusters based on their keyword metadata, extract keywords from each article, and identify topics in the posts.
keywords: Computer, User Interface, Usability, Staying-Power, KMeans Clustering, Natural Language Processing, Keyword Metadata, Clustering Algorithms, Topic Modeling Algorithms, TTY, Yake, Pandas
categories: panda, computer
permalink: /blog/keyword-clustering-my-blog-posts-with-kmeans/
layout: post
---


**Me:** Say you have 500 blog posts and they're on a diversity of topics. What you want to do is read each of these blog posts and categorize them by topic. The topics are not pre-selected, but we want them to be inferred from the posts themselves so that you can use the data to go back and add multiple tags and one main category per post, so we can make tag and category pages. What are some possible approaches to go about doing this?

**ChatGPT**: There are several possible approaches you could take to categorize the blog posts by topic. Here are a few suggestions:

1. Manual categorization: The most straightforward way to categorize the posts is to read each one and manually assign it to one or more topics. You could create a list of possible topics beforehand and then assign each post to the most appropriate one(s). While this method can be time-consuming, it allows for the most accurate categorization since you are reading and interpreting the content yourself.
1. Keyword extraction: You could use natural language processing (NLP) techniques to extract keywords from each post and then group them based on the keywords they have in common. There are several NLP tools and libraries available, such as NLTK and spaCy, that can help you extract keywords. Once you have a list of keywords for each post, you could group them based on the similarity of the keywords they contain. This method can be faster than manual categorization, but it may not be as accurate since it relies on algorithms to determine the topics.
1. Clustering: Another approach is to use clustering algorithms to group the posts based on their similarity. This method involves using machine learning algorithms to group the posts together based on features such as word frequency, length, and other metrics. Clustering algorithms such as k-means and hierarchical clustering can be used to group the posts into clusters based on these features. This approach can be faster than manual categorization and more accurate than keyword extraction, but it requires more technical expertise to implement.
1. Topic modeling: Topic modeling is another machine learning technique that can be used to categorize the posts based on their content. Topic modeling algorithms, such as latent Dirichlet allocation (LDA), can identify topics in the posts by analyzing the frequency and co-occurrence of words. This approach can be more accurate than keyword extraction and clustering, but it also requires more technical expertise to implement.

Overall, the best approach will depend on the specific needs and resources of your project. A combination of these methods might provide the most accurate and efficient categorization of the posts.

The time has come to cluster keywords.

- This could be a keyword clustering project
- Or this could be a keyword extraction project
- Or it could be a hybrid of both, because you can cluster on the extracted keywords

But let's just face it, we could just ask OpenAI to extract and cluster or
whatever without us really needing to understand much except how to write an
English prompt for the request.

- Do I pay to have OpenAI API? Why if there's other ways?

Okay, so I produced a video on my first attempt. It wasn't bad. It did
something that must have been like clustering with an impressive but unusable
visualization.

{% include youtubePlayer.html id="wTsn_azwv4c" %}

But now I'm going to make my second attempt. Instead of just starting from
scratch with research, I'm going to go to the code from the last time I did a
project like this.

Me: How do you use Kmeans to cluster keywords?

ChatGPT: K-means clustering is a popular unsupervised machine learning algorithm used to group data points into clusters based on their similarity. Here's how you can use K-means to cluster keywords:

1. Gather your keywords: First, you need to gather the keywords that you want to cluster. These could be from any source, such as a website, social media platform, or search engine. Make sure you have enough keywords to get meaningful clusters.
1. Prepare the data: Convert the keywords into a numerical format that can be used by K-means. One common method is to use term frequency-inverse document frequency (TF-IDF) to represent each keyword. This calculates a score for each keyword based on how frequently it appears in a document, and how unique it is across all documents.
1. Choose the number of clusters: Decide on the number of clusters you want to create. This is a hyperparameter that you need to set before running the algorithm. One way to do this is to use the elbow method, which involves plotting the sum of squared distances of data points to their closest cluster center for different values of k, and choosing the value of k where the curve bends like an elbow.
1. Run K-means: Run the K-means algorithm on the data, specifying the number of clusters you chose in step 3. K-means will randomly assign the initial centroids, and then iteratively update them until convergence.
1. Interpret the results: Once the algorithm has converged, you can interpret the clusters that it has created. Each cluster will contain keywords that are similar to each other based on their TF-IDF scores. You can also visualize the clusters using a scatter plot, where each point represents a keyword and its coordinates are the two dimensions of the TF-IDF space.
1. Refine the results: You may want to refine the clusters by tweaking the hyperparameters or pre-processing the data differently. You can also use other clustering algorithms, such as hierarchical clustering or DBSCAN, to compare the results. Finally, you can use the clusters to perform tasks such as topic modeling, keyword analysis, or content recommendation.

---

Okay, so this is now my new starting point:

```python
from sqlitedict import SqliteDict as sqldict
 import yake


 with sqldict("descriptions.db") as db:
     for key, value in db.iteritems():
         keywords = yake.KeywordExtractor().extract_keywords(value)
         print(keywords)
         print()
```

I'm going to use yake's default settings. Now let's move onto the Kmeans stuff.

Hmmm. Each time I approach clustering, I think it's premature. I think I ought
to just layer in keywords in the Jekyll top matter.

Wow, okay I am really layering up this blogging system thing. In addition to
putting the extracted keywords into the top matter, I'm also inserting it into
the published HTML using the \_layouts/default.html template. Or at least I
think so. I'm pushing it out now.

Me: Say you have 500 articles, each having keyword meta data. How can you use KMeans to group the articles into 10 groups based on the keywords?

ChatGPT: To use KMeans to group the articles into 10 clusters based on their keyword metadata, you can follow these steps:

1. Extract the keywords from each article and create a matrix with each row representing an article and each column representing a keyword. You can use techniques like TF-IDF to represent the importance of each keyword in each article.
1. Apply KMeans clustering algorithm to the matrix with 500 rows and N columns (N being the number of unique keywords across all articles). You can choose the value of K as 10 to get 10 clusters.
1. Once the clustering is complete, you can analyze the resulting clusters to understand the topics and themes that emerge from the grouping.
1. Finally, you can assign each article to the cluster it belongs to and store the cluster information in a database or file for further analysis.

Here's some sample Python code that demonstrates how to perform KMeans clustering on the keyword matrix:

```python
from sklearn.cluster import KMeans
from sklearn.feature_extraction.text import TfidfVectorizer
import pandas as pd

# Load the articles into a dataframe with a column for the keywords
df = pd.read_csv('articles.csv')

# Extract the keywords and create a matrix
vectorizer = TfidfVectorizer(stop_words='english')
X = vectorizer.fit_transform(df['keywords'])

# Apply KMeans clustering with 10 clusters
kmeans = KMeans(n_clusters=10)
kmeans.fit(X)

# Assign each article to its cluster
df['cluster'] = kmeans.labels_

# Print the number of articles in each cluster
print(df['cluster'].value_counts())
```

This code assumes that the article data is stored in a CSV file with a column for the keywords. It uses the TfidfVectorizer from the scikit-learn library to convert the keywords into a matrix, and then applies KMeans clustering with 10 clusters. Finally, it assigns each article to its cluster and prints the number of articles in each cluster.

Okay, after much experimentation I have this new version which nearly does what
I want.

```python
import yake
import pandas as pd
from sklearn.cluster import KMeans
from sqlitedict import SqliteDict as sqldict
from sklearn.feature_extraction.text import TfidfVectorizer


pd.set_option('display.max_columns', None)
pd.set_option('display.max_rows', None)


def dehyphen_and_dedupe(keywords):
    """Preserves order of keywords, but removes duplicates and hyphens"""
    keywords = [x.replace("-", " ") for x in keywords]
    seen = set()
    # A fascinating way to add to a set within a list comprehension
    seen_add = seen.add
    keywords = [x.lower() for x in keywords if not (x in seen or seen_add(x))]
    return keywords


table = []
with sqldict("keywords.db") as db:
    for key, keywords in db.iteritems():
        keywords = [x[0] for x in keywords]
        keywords = dehyphen_and_dedupe(keywords)
        table.append((key, keywords))

df = pd.DataFrame(table, columns=["title", "keywords"])

# Extract the keywords and create a matrix
vectorizer = TfidfVectorizer(stop_words='english')
X = vectorizer.fit_transform([", ".join(x) for x in df['keywords']])

filter_us = """.
blog
importance
important
person
people
discussing
discusses
describes
author
suggests
talks
argues
reflects""".split("\n")

# A function that takes as input a list of tuples that is a keyword histogram
# and returns a list of the winning keywords. Winning keywords are those that
# are longer and whose stem words have the highest frequency.

def get_winning_keywords(keywords):
    # Sort the keywords by length
    keywords = sorted(keywords, key=lambda x: len(x[0]), reverse=True)
    # Get the stem words
    stems = [x[0].split(" ")[0] for x in keywords]
    # Get the frequency of each stem word
    stem_freq = {x: stems.count(x) for x in stems}
    # Get the winning stem words
    winning_stems = [x for x in stem_freq if stem_freq[x] == max(stem_freq.values())]
    # Get the winning keywords
    winning_keywords = [x for x in keywords if x[0].split(" ")[0] in winning_stems]
    # Return those with the highest frequency but favor 2-word keywords
    winning_keywords = sorted(winning_keywords, key=lambda x: x[1] * (len(x[0].split(" ")) + 1), reverse=True)
    return winning_keywords[:5]


# A function that takes as input a list of keywords and returns the longest
# common sequence of words that is a keyword.
def get_longest_common_sequence(keywords):
    # Get the longest common sequence of words
    longest_common_sequence = []
    for i in range(1, len(keywords)):
        for j in range(0, len(keywords) - i + 1):
            sequence = keywords[j:j + i]
            if all([x in keywords for x in sequence]):
                longest_common_sequence = sequence
    return longest_common_sequence


def cluster_test(n):
    # Apply KMeans clustering with 10 clusters
    kmeans = KMeans(n_clusters=n, n_init="auto")
    kmeans.fit(X)

    # Assign each article to its cluster
    df["cluster"] = kmeans.labels_

    for i, dfc_tuple in enumerate(df.groupby('cluster')):
        key, dfc = dfc_tuple
        dfx = dfc.explode("keywords")
        top_picks = list(dfx[["keywords", "cluster"]].groupby("keywords").count().sort_values("cluster", ascending=False).to_records())
        top_pics = [x for x in top_picks if x[1] > 3]
        top_picks = [x for x in top_picks if len(x[0].split(" ")) > 1]
        # top_picks = [x for x in top_picks if "author" not in x[0]]
        top_picks = [x for x in top_picks if not any([y in x[0] for y in filter_us])]
        top_picks = get_winning_keywords(top_picks)
        top_picks = [x[0] for x in top_picks]
        top_picks = get_longest_common_sequence(top_picks)
        print(i + 1, dfc.shape[0], top_picks)
    print("")


for n in range(5, 25):
    cluster_test(n)
```

The last 2 lines tries to cluster all the articles on the blog into from 5 to
25 clusters. The results of each cluster attempt is output to the console. This
produces lots of output, but here's the from the loop when n = 10:

```console
1 54 ['quantum mechanics', 'quantum computing', 'quantum teleportation experiment', 'quantum cryptography experiment']
2 18 ['python package called', 'python programming language', 'python interpreter prefix', 'python celery package']
3 65 ['source seo software', 'seo software', 'source seo', 'seo in nyc']
4 38 ['jekyll configuration files', 'jekyll liquid directives', 'jekyll template system', 'jekyll site directory']
5 55 ['linux containers', 'linux graphics', 'linux terminal', 'linux server']
6 53 ['jupyter notebook', 'jupyter on lxd', 'jupyter desktop', 'jupyter server']
7 34 ['google photos', 'google search', 'google search console', 'google photos api']
8 31 ['content management system', 'content from instapaper', 'content for search', 'content and links']
9 31 ['make alice smaller', 'make russian jets', 'make lxdwin', 'make money']
10 163 ['python program', 'python virtual environment', 'python requests library', 'python dictionary']
```

There's quite a bit going on in the magic here, but the most important to
notice is that 10 cluster groups were created, and each group has a list of
keywords that are the most common in that group. These are the top 5 from
keywords from each group which can probably be used to crate a category label.
It's very close.

The output actually shows how the top keyword choices turn out with anywhere
from 5 to 25 keyword clusters.

Fast-forward a few hours. The code is done, but I have not fully incorporated
it into the chopchop.py file under the Journal slicer yet. But site generation
will use the new MikeLev.in/\_data/topics.db and create in the Jekyll front
matter a new:

    category: [keyword]

Entry. That's huge. I can now make category pages, display the category (and
link) on the blog pages.

**Me:** Say you have 500 blog posts and they're on a diversity of topics. What
you want to do is read each of these blog posts and categorize them by topic.
The topics are not pre-selected, but we want them to be inferred from the posts
themselves so that you can use the data to go back and add multiple tags and
one main category per post, so we can make tag and category pages. What are
some possible approaches to go about doing this?

{% include youtubePlayer.html id="k42zpIfCxlw" %}

**ChatGPT**: There are several possible approaches you could take to
categorize the blog posts by topic. Here are a few suggestions:

1. Keyword extraction: I used Yake (Yet Another Keyword Extractor)
   - pip install yake
1. Clustering: I used KMeans.
   - I experimented with different numbers of clusters, and I found that 10
     clusters was the best.
   - I support number of clusters as a parameter to the function.
   - I also found the non-deterministic nature of KMeans to be a problem, so I
     provide a constant instead of the default random seed.
   - I experimented with different numbers for the random seed.
1. Category Labeling: After KMeans adds a cluster ID to each post, I use
   pandas to group the posts by cluster ID and then get the most common
   category for each cluster.
   - I use the most common category as the cluster label.

Don't be scared of vim. It's going to look intimidating at first, but once
graphical software lets you down 2 or 3 times in your life (a decades-long
lesson), you will appreciate a great, unchanging UI. It's more or less been
this way from the 1960s to now. Some of that tech, like TTY dates back even
further. Not everything computers use was invented for computers. Teletype came
first. It was invented in the 1800s. It was a machine that could send and
receive telegrams.

Some oldies are goodies. Not everything. But every once in awhile, a "harmonic"
or something is hit, and you have a tool with just the right amount of
usability and staying-power (for whatever reason). They improve gradually, but
righteously. Such tools are not entirely static, but they change so slow and so
much for the better, it won't "nuke" you. No big reset button pressed on you
and your skills and your career and your self-image and your sense of
self-worth.

<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/rid-yourself-of-imposter-syndrome-and-start-living-your-best-life/">Rid Yourself of Imposter Syndrome and Start Living Your Best Life</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/project-deteriorates-into-tools-discussion-again/">Project Deteriorates Into Tools Discussion Again</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/panda/'>Pandas</a></h4></li>
<li><h4><a href='/computer/'>Computer</a></h4></li></ul>