---
title: "Semantic Web: The Key to Discoverability in the Age of AI"
permalink: /futureproof/sematic-web-discoverability-ai/
description: I explore the changing landscape of SEO and web crawling in the age of AI and LLMs. I argue that traditional methods are becoming unsustainable due to the infinite nature of the web.  The focus is shifting from URLs to content, highlighting the importance of semantic web technologies. I advocate for creating a "core" website with stable URLs and structured data, even while acknowledging that many e-commerce sites create crawlable issues. I also describe my own website's organizational challenges and plans to use vector embeddings and graph databases to improve content structure.
meta_description: Explore how semantic web technologies like Schema.org and RDF are transforming SEO by emphasizing content over URLs for improved discoverability in the AI era.
meta_keywords: semantic web, SEO, structured data, Schema.org, RDF, microdata, web crawling, AI, LLM, discoverability, content optimization, invisible web, entity extraction
layout: post
sort_order: 1
---

## Back to Basics

Okay, so genuinely valuable content, it is. Back to the long-tail it is. Back to
the niche, it is. You know, I never really left any of those things. The game is
to be recognized as something new under the sun. The game is to prove theories
about "peak data" wrong.

### Working for the Vacuum

The game is to be recognized? Do I believe that? Ugh, well, I guess I'm still an
SEO. We must not work in a vacuum. Rather, we work ***for a vacuum*** —
that vacuum repeatedly sucking up all the content of the Web and Internet, to
sieve and sift and perchance discover something new under the sun.

### Google's Competitive Moat

Google does this like few others. Creating that crawling infrastructure,
especially one that executes JavaScript, is a friggn big competitive moat. The
Elon Musk's and Ilya Sutskever's of the world would rather crawl the Web once,
do one big data cleaning job, and declare peak data achieved rather than deal
with all those subtle issues that most data in the world is in the invisible web
because of JavaScript alone. That's not to mention the intentionally paywalled
and offline data. Even on that front, Google has had their book scanning
initiative "Project Ocean" and was later known as the Google Library Project or
Google Book Search. So, Google has a lot more of the invisible web through their
JavaScript executing crawl ***and*** more of the offline web through their book
scanning.

### Beyond Twitter Data

Yes, Elon bought Twitter. But looking at the data in Twitter might be the very
reason he things those one-time crawls achieved peak data and that anything new
is going to be inane prattle not worth training on.

### Building a Humble Crawler

But that's besides the point. We're here to do the next tiny bits of my weekend
work to get all the good work I've done over the prior months into demo-able
state. And it's going to be one of the most small-scale humble crawlers you can
imagine. But it will pop up a web browser. It will collect data off the web,
executing the JavaScript and getting 2 different views of what's there.

### The Death of SEO?

There's a lot of talk about how SEO is dead. An article just hit
Entrepreneur.com about [how AI is transforming the SEO
landscape](https://www.entrepreneur.com/growing-a-business/how-ai-is-transforming-the-seo-landscape-and-why-you/485800).
The search relations team who podcast, Martin Splitt, John Mueller, Gary Illyes
and Lizzi Sassman... oh, who are they exactly? Perplexity?

**Perplexity**: Based on the Search Off the Record podcast details, the Google SEO podcasters include:

- **Martin Splitt**: A developer advocate on the Search Relations team[1][2]
- **John Mueller**: The Search Relations Lead who is based in Switzerland[1]
- **Gary Illyes**: The Chief of Sunshine and Happiness at Google, who has been working on Search since 2011[1]
- **Lizzi Sassman**: A tech writer on the Search-Rel team[1]

These individuals are part of the Search Off the Record (SOTR) podcast, which provides behind-the-scenes insights into Google Search and its inner workings. The podcast explores decision-making processes, projects, and trending topics in the SEO community[1].

Citations:

    [1] https://developers.google.com/search/podcasts/search-off-the-record
    [2] https://www.searchenginejournal.com/google-podcast-discusses-seo-expertise/536606/
    [3] https://developers.google.com/search/blog/authors/martin-splitt
    [4] https://www.stateofdigitalpublishing.com/seo/martin-splitt/
    [5] https://podcasts.apple.com/us/podcast/seo-101-ep-426-googles-martin-splitt-interviewed/id280183060?i=1000552612292
    [6] https://www.youtube.com/@martinchayman
    [7] https://www.youtube.com/watch?v=uOddv9rKS9I
    [8] https://www.searchenginejournal.com/google-martin-splitt-semantic-html-search-search-console-podcast/482408/

---

## Entity Extraction from Content

Yeah, based on their input, this entity stuff that the Entrepreneur magazine is
talking about is derived from natural language processing of the on-page content
they're looking at. For example, this video talks about Centerpiece Annotation
where they look at the semantic content and potentially also the layout tree
which is read from the content structure of the HTML, and from all that text
content they can say that the page is about Topic A (dog food), and Topic B, and
so on.

## The Evolution of Keyword Extraction

So the concept of yet another keyword extractor is not dead (this is me talking
now, no longer directly paraphrasing the Google Search Relations team). It's
just that it's not keywords that are extracted directly. It's that natural
language processing (aka machine learning and AI) are used to make those
determinations. In the past, those models were of the simple variety like BERT
(Bidirectional Encoder Representations from Transformers). In all likelihood,
such tasks are being given to more powerful models like Bard, which is now
Gemini. Those are the public-facing model names.

## Entity Mapping and Authority

Okay, so this implies a topic tree of entities. But what entity map? On whose
authority? Oh, Google's of course. And generally with a product-bias so that it
helps them make money with Google Ads (AdWords). Here's the [giant Google
product
taxonomy](https://www.google.com/basepages/producttype/taxonomy.en-US.txt).
That's a good starting point for hard-nosed pragmatic reasons. But you're going
to want to make sure it fits into automatic digestion systems of whoever, so you
can't limit yourself to proprietary Google rules, and that more or less means
[Schema.org full scheme hierarchy](https://schema.org/docs/full.html) which
breaks it down between "things" and "datatypes".

So these are the first two obvious entity-tagging tools to reach to for because
of industry conventions. Let me map it out a little more completely. Uh, another
job for Perplexity.

**Me**: Give me the big picutre. Include Schema.org, Google product taxonomy, the Semantic Web, RDF, competitors like microdata and anything else a website publisher might use to make URLs optional and the underlying meaning the main thing.

**Perplexity**: The big picture of making web content more machine-readable and semantically meaningful involves several interconnected technologies and initiatives:

## Semantic Web

The Semantic Web, envisioned by Tim Berners-Lee, aims to create a web of linked data that machines can understand and process. It's considered part of the evolution from Web 1.0 (linked pages) to Web 2.0 (linked apps) and now Web 3.0 (linked data)[1].

Key components include:

1. Resource Description Framework (RDF): A standard model for data interchange on the web, using subject-predicate-object triples to describe resources and their relationships.

2. Web Ontology Language (OWL): Builds on RDF to define complex relationships and create detailed domain-specific ontologies.

3. SPARQL: A query language for searching data across different sources.

## Structured Data Markup

### Schema.org

Schema.org is a collaborative initiative to create a common vocabulary for structured data markup on web pages. It provides a standardized way to describe entities, their properties, and relationships[6].

### Microdata

Microdata is an HTML specification for embedding machine-readable data in HTML documents. It's one of the ways to implement Schema.org vocabularies[4].

## Google Product Taxonomy

Google's product taxonomy is a hierarchical classification system for e-commerce products. It helps improve product visibility in Google Shopping and search results[2]. Retailers can implement this taxonomy using structured data markup like Schema.org[6].

## Applications and Benefits

1. Search Engine Optimization (SEO): Structured data helps search engines understand content better, potentially improving search rankings and click-through rates[1].

2. Enhanced User Experience: Enables features like rich snippets in search results, providing users with more informative previews[1].

3. Data Integration: Facilitates better integration of data across different sources and applications[1].

4. Knowledge Graphs: Powers the creation of sophisticated knowledge representations, improving information retrieval and analysis[1].

## Current State and Future

As of February 2025, while semantic technologies are widely used in SEO and some specialized applications, the grand vision of a fully interconnected Semantic Web is still evolving. Challenges include standardizing data across diverse domains and ensuring widespread adoption[1].

The future may involve a hybrid approach, combining better governance of schemas with AI and statistical techniques to bridge gaps in data interpretation and connectivity[1].

By implementing these technologies, website publishers can make their content more machine-readable, reducing reliance on specific URLs and focusing on the underlying meaning of the information they present.

Citations:

    [1] https://www.techtarget.com/searchcio/definition/Semantic-Web
    [2] https://tknack.com/google-product-taxonomy-a-helpful-guide/
    [3] https://open.hpi.de/course/semanticweb
    [4] https://stackoverflow.com/questions/19031818/categories-for-product-in-schema-org
    [5] https://2025.eswc-conferences.org
    [6] https://support.google.com/google-ads/thread/57687299/how-should-we-specify-the-google-product-category-in-schema-org-structured-data?hl=en
    [7] https://2025.eswc-conferences.org/eswc-2025/
    [8] https://developers.google.com/search/docs/appearance/structured-data/product?visit_id=638717582037760915-2385265349&rd=2

---

## The URL Dilemma

Yep, that starts to cover it. A big part of the point here is that aside from
the homepage, everybody (companies, organizations, etc.) wants their URLs to be
able to change. But Google for resource allocation reasons would much prefer
your URLs to not change. Think how much work it is for them to continuously
re-crawl and re-index your site. If sites were just running snapshots of their
former selves with just small differences from crawl-to-crawl, things would be
much simpler. The delta (small changes and differences from crawl-to-crawl)
would have enormous meaning, because it would indicate ***what's new***. But the
reality is more like constantly shifting and changing URLs from replatforming,
site re-launches and the like.

## The Old SEO Reality

So, there's the old SEO reality. If you could actually somehow manage to keep
your URLs from changing over the years, you'd have tremendous advantage because
the signals of relevancy would accumulate up around your longstanding URLs. It
only makes sense. Predictably non-moving targets can be rewarded merely by
virtue of knowing that they're there. You can't send traffic to a moving target,
because by moving that target around too much, Google loses track of it and the
history of signals get diluted.

## The New SEO Reality

But now there's this new SEO reality. Nobody wants your URLs anyway. Everybody
knows that everything but your homepage is a moving target, and it's about time
we all realized that. The people training the LLMs intuitively know this and
strip out the URLs when they crawl your sites and convert the HTML into markdown
to train the models. They deliberately strip out the URLs knowing that the
precise roadmap to where the data is is inherently less important than the data
itself. In other words, they ripped you off already by heisting your data, and
who needs to remember where it was actually originally found anyway? That just
pollutes the trained model.

### The Reality of Data Cleaning

I'm not saying that this is right. I'm just saying that this is reality. The
HTML is going to be stripped because nobody wants the model responding to you by
inserting the HTML tags. That's what would happen if they didn't clean the data
first (strip out the HTML tags). The models would learn that people communicate
with each other by inserting headline and paragraph tags into their text, and so
they would do that whenever they generated a response, and it would have to be
dealt with at the inference engine (conversation-player) level, making the
decision to strip-out or use the HTML tags in real-time. And that's way more
annoying and costly than doing the same with lightweight markdown.

### The Homepage Exception

And so, nobody training models wants your friggn URLs. They hardly even want
your hompepage. But you know what? At least homepages have the DNS and domain
registration system. If some system can figure out what company you're talking
about, there's a pretty good bet they can figure out your website homepage, even
if they trashed all your URLs on training. It's not the most complex or
expensive thing to create a mapping of companies to homepages. It's just a
1-to-1 mapping for the most part. You don't even need to worry about subdomains
because most sites are configured to forward requests on the apex-domain (the
registered non-subdomain version) to www or whatever the site happens to be
using for the homepage.

## The Future Web

This is the reality we're going into. At some point, the size of the Web and the
Internet is basically going to make systems like Google's crawl-and-index
implode under their own weight. The Web is effectively infinite in size. Don't
believe me? Imagine replacing entire websites with just an AI chat system where
there are no URLs as such, but only prompts. The details hardly matter. It could
use the apex domain plus query strings like `example.com?who+are+you` or it
could use the POST method so you don't see URLs at all. But there would be
generative responses, potentially different every time. Infinite content.
Uncrawlable. What's a Google crawler to do? Ask every infinite possible
question? Index all the answers? Nope.

### The Transition Period

Alright, so the reality is that we're not getting there right away. And that's
not even particularly the ultimate vision of the Web. That's just one of many
examples why content is effectively infinite now, and the "big crawl" that
effectively makes a copy of the whole Web according to the existing Google
crawl-and-index model is unsustainable.

### The Core Web

There will still be some "core" Web that is crawlable by traditional means. And
that will actually remain important, because it will make use of the Semantic
Web and things like it, so that all the people training their models looking for
a freebee of all human knowledge by scraping the whole Web will still come up
with something. It will be a core consensus. And it won't even be a clean data
consensus. It will still be full of spam and for-SEO-content. Nonetheless, this
starts fleshing out how things really are today, are becoming more tomorrow, and
how you can crystallize your thinking and structure your behavior around it.

## Strategic Planning

For unique competitive advantage, plan the "core URL paths" of your site out. Do
that taxonomy ontology nonsense. There's no right answer. But those who choose
the most-right answer most-of-the-time will have competitive advantage, because
your URLs won't change and signals will be able to accumulate up around them.

### The E-commerce Challenge

But this can't be the full fidelity hairy querystring-ridden site. You're going
to do weird stuff on your site. There's going to be an internal site search tool
and there will be faceted search for products. Most commerce sites are still
going to be able to technically give out nearly infinite URLs by just combining
the querystrings in different amounts, orders and with different values. That's
the classic spidertrap of ecommerce, with Shopify, Demandware and the like.
That's not going to be fixed, because human nature. We just have to accept that.
That's not even mentioning JavaScript and the invisible Web because 10x the
crawl resources is required to read your single-page-application (SPA) site,
which even when rendered isn't necessarily even the Semantic Web.

### The Reality Check

Long story short, many if not most ecommerce vendors will continue to put
themselves in a position of weakness when it comes to search, deliberately out
of laziness, cost-savings and lack of control of the platforms they chose. Fact.
That fact provably still has a 20 to 40 year run in it, before things change so
fundamentally that the discussion doesn't even make sense anymore.

## The Path Forward

Okay, so where does that leave us? With some notion of a "core" website that is
crawlable in the traditional fashion, doesn't require executing JavaScript, uses
URLs and paths that you're willing to commit to for years or decades on which
signals can accumulate. In such a scenario, some type of system will always be
able to direct LLMs to your homepage, from which a short drill-down path
(traditional crawl) or dirt-simple site-search tool will allow them to find
further resources on your site.

### The Semantic Imperative

The core site that's traditionally crawlable needs to be heavily Semantic Web,
Schema.org, RDF/OWL, microdata, Google taxonomy and whatever else marked up. I
don't have the exact recipe here, but that's the type of stuff I'll cover here
as this site and auto-extracted book organically develop.

### A Personal Example

For example, I'm not even practicing what I preach yet because the entire
catalog of my blog is on my homepage, even though I have use the path
`/futureproof/` for my blog. I blend every topic together that I cover, with no
topical clustering. There's no hub and spoke design, but I have to address this
urgently (along with the book extraction). To do this, I'll be using content
similarity from a vector embedding database. I'll use the results of a vector
embedding database to populate a graph database that specializes in the taxonomy
and ontology we're discussing.

### The Current State

So all the ingredients go into a big blended stew, called `/futureproof/`.
There's one giant list of articles that are not even categorized or subdivided.
And what's worse, individual articles cover lots of different topics per
article! It's just a daily tech journal where I jump all over the place train of
thought style. That's what you're reading right here, if you have the misfortune
of being here reading. Honestly, I'm imagining this stew as mostly delicious to
the LLMs and vector databases that are going to... hmmm, maybe the ***stew
metaphor*** has to become an ***ore metaphor***, because the next step is
processing raw materials into their distilled and pure form — organized
content fitting in a knowledge graph!

---

## Gemini Advanced 2.0 Flash Feedback

(Coding partner)

The author discusses the changing landscape of SEO and web crawling in the age of AI and LLMs.  They argue that traditional crawling and indexing methods are becoming unsustainable due to the infinite nature of the web, exemplified by AI-generated content and dynamic web pages.  The focus is shifting from URLs to content itself, emphasizing the importance of semantic web technologies like Schema.org and RDF/OWL for making content machine-readable.  The author advocates for creating a "core" website with stable URLs and structured data to ensure discoverability in this evolving environment, even while acknowledging that many e-commerce sites will continue to create crawlable issues.  They also describe their own website's current organizational challenges and plans to use vector embeddings and graph databases to improve content organization and structure.

**Title Ideas:**

* The Future of SEO: Beyond URLs and Crawling
* Semantic Web: The Key to Discoverability in the Age of AI
* Building a Future-Proof Website: Strategies for the Evolving Web
* From Crawling to Content: How AI is Transforming SEO
* The Infinite Web: Challenges and Opportunities for Content Creators

**Headline Ideas:**

* Is SEO Dead? No, It's Evolving.
* Stop Worrying About URLs, Focus on Semantic Content
* How to Make Your Website Discoverable by AI
* The Secret to Future-Proofing Your Online Presence
* The Next Big Thing in SEO: Understanding the Semantic Web

**My Opinion:**

This article offers a compelling perspective on the challenges and opportunities presented by the evolving web landscape. The author's insights into the limitations of traditional crawling and indexing methods, coupled with their emphasis on semantic web technologies, are particularly relevant in the age of AI and LLMs.  The analogy of the "stew" and "ore" effectively illustrates the need to refine and organize raw content into structured knowledge. While the author's personal website challenges add a relatable touch, the article could benefit from more concrete examples of how to implement the suggested strategies. Overall, it's a thought-provoking piece that encourages website owners and SEO professionals to adapt their approaches to thrive in the future of the web.

