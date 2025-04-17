---
title: "Escaping GitHub Pages: The Quest for Raw Log Files and Deeper SEO Insights"
permalink: /futureproof/github-pages-logfiles/
description: I'm drawing a line from the basic idea of sequenced actions, like a Turing machine or even wax-on/wax-off, to my current need for deeper website insights than GitHub Pages provides. To truly understand causation and correlation in my site traffic, especially with AI bots and crawlers, I need raw log files. Therefore, I'm embarking on self-hosting using NixOS, starting with ordering a new router, viewing this technical setup itself as a manageable, sequenced process that will ultimately enable much richer data analysis, helping me better understand performance, spot outliers, and strategically manage my site's structure and content.
meta_description: Details the transition from GitHub Pages to self-hosting with NixOS for accessing web server log files to analyze SEO performance and bot traffic.
meta_keywords: self-hosting, log files, web server logs, NixOS, GitHub Pages, Jekyll, SEO analysis, bot traffic, web crawlers, real-time data, site analytics, configuration management, sysadmin, devops, click-depth, Google Search Console, GSC, RAG, outliers, sparklines, Turing machine, static hosting, data analysis, Linksys WRT45GS, OpenWrt
layout: post
sort_order: 1
---

## Introductory Context

This article explores the author's decision-making process around moving their
website hosting away from a simple, free service (GitHub Pages) to managing
their own server (self-hosting). The primary motivation is to gain access to
detailed website visitor logs, which are records of every request made to the
server. These logs provide much richer data than typical analytics dashboards,
especially for understanding the behavior of automated visitors like search
engine crawlers and AI bots, which is increasingly important for optimizing a
website's visibility and performance (a field often related to Search Engine
Optimization or SEO).

The author discusses the technical challenges and overhead traditionally
associated with self-hosting but highlights a modern approach using a system
called NixOS, which promises to simplify server configuration. The text delves
into the philosophical underpinnings of automated processes, drawing parallels
between computing concepts like the Turing machine and the practical steps
involved in managing a website and analyzing its data, ultimately framing the
move to self-hosting as a necessary step for deeper understanding and control.

---

## Learning Complex Skills Through Simple Steps

Think about learning a complex skill. Often, the best way is to break it down
into simple, repeatable actions. Remember Mr. Miyagi's "wax-on, wax-off"? Those
seemingly unrelated motions built the foundation for karate mastery. This
principle – simple, sequenced steps building towards a larger goal – isn't just
for martial arts; it's everywhere. It's how an old player piano turns holes
punched in paper into music, how a knitting loom weaves threads into fabric
following a pattern, and even how modern 3D printers build objects layer by
intricate layer.

## The Turing Machine: Sequenced Steps as Computing Foundation

This powerful idea of sequenced steps and automated processes is the bedrock of
modern computing. Alan Turing famously described a theoretical device, the
Turing machine, which laid the groundwork for how we understand computers today.
While it might sound technical, the core idea is that a machine following a
basic set of instructions on a strip of tape could, in principle, compute
*anything* computable. Turing put practical mechanics behind abstract ideas
about algorithms.

### Humans as Computing Devices

And here's where it gets personal: this model isn't just for machines. In a way,
each of us operates like our own unique computing device. We process
information, follow sequences (habits, plans, reactions), and translate
intentions into actions. The Turing machine metaphor, with its image of an
infinitely long tape, resonates deeply with me when thinking about life. While
our lives aren't literally infinite, viewing our journey as a tape unfolding
moment by moment certainly puts things in perspective. We are constantly
'reading' our current situation and 'writing' our next action.

If the term "Turing machine" is new to you, looking it up is worthwhile – Alan
Turing's insights are fundamental to the Information Age. But the key takeaway
is this: anything with a minimum feature set can operate like a computer – even
you.

### Achieving Complex Goals Through Sequenced Actions

So what's the point? It means that if you set your mind to achieving something,
even something complex, there are ways to get there. It might not be obvious or
direct, but you can start layering processes – mechanical, deliberate steps –
that organize your actions and materials over time. Simply by arranging things
in a certain sequence, meaning emerges, and a form of computation begins. This
automation is a product of *your* agency, whether you're programming a computer,
following a knitting pattern, or building a new habit. That's why connecting
this to tangible examples like knitting looms or player pianos early on is
helpful – the mere sequencing of points and lines automates processes in a way
that creates meaningful results for humans.

## The Limitations of GitHub Pages for Data Analysis

While correlation does not mean causation, I do need to correlate better. I do
my web publishing very much on the cheap using the static HTML file publishing
system built into GitHub called GitHub Pages, previously called github.io and
still hosted on that domain by default. But you can add your own custom domain
and make it indistinguishable from a site hosted anywhere, except that you can't
incorporate "dynamic" server-side features. You can use client-side JavaScript,
and I have in fact used that to implement a site-search feature. But what you
can do with client-side JavaScript does top-out, and you don't get access to
your own web log-files.

## The Critical Need for Log Files in the Age of AI

Access to those log-files right now is so important when studying causation and
looking for correlation. When people talk about RAG with AI, it means that the
AI might be using some other tool (increasingly through the MCP protocol) to do
something such as search the web. Now that web-search might be using the API of
some service like how Microsoft Bing "sells" search results for integration with
your own product. Or it might be a real-time visit of your site! It could be a
synthesis of the two, where the AI learns about your site from a web-search and
then visits the site it found, either to look at that very page first-hand or to
do subsequent crawling to find more on pages linked off of that page (small-word
theory crawling).

### Tracking Bot Behavior Through Log Files

But I need to see these bots come into my site. I need to understand how much of
what bots know is a result of the big crawl-and-index process reproducing a copy
of the entire Web the best the can, undertaken by few these days besides Google
and Microsoft, versus how much is real-time crawls. There are some hybrid
synthesis of these such as keeping a cache of whatever you crawled as a result
of user inquiries, gradually "mapping out" the Internet, like Dungeons & Dragons
players mapping a dungeon during an adventure. But no matter which scenario is
used, their bots and crawlers leave their calling-card in the web log files, and
I need to watch it like sports, getting to know my favorite players.

## The Addiction of Real-Time Data Analysis

Anyone who has gone through the data-addiction cycle with AdWords, Google
Analytics or Google Search Console knows what I'm talking about. Stock tickers
are probably another good example. Watching the flow of data can be addicting,
especially if you learn to read the patterns and it has meaning to you, and you
have to take some sort of action based on it. The faster and more real-time that
data-flow, the better (and the more addicting). Hopefully, this feeds a positive
feedback loop that improves your life — and not send you down the addiction
spiral. But either way, Google Search Console, the main source of my data only
updates once per day and doesn't give me the full log-file picture, so is less
than satisfying and hardly even addictive. We are going to fix that with
self-hosting.

## NixOS: Making Self-Hosting Manageable

I've resisted self-hosting for a long time given the distraction that being your
own sysadmin, netadmin and devops person. Every piece of hardware you maintain
is a little piece of your soul, and you can only divvy out so many pieces. But I
do believe nix and NixOS is changing that for me, and perhaps the rest of the
world. This is different from containers like Docker. It's different from
virtual machines. It's simply defining your entire system with a text file.
Given the massive popularity of Docker and containers over the past decade, it's
easy to confuse such a simple approach of defining your entire system with a
simple textfile as being some sort of containerization, but it's not. It's just
as if you built some sort of BASH script to build your system from scratch with
dealing with all of the things that could go wrong being baked-in as part of the
intelligent system building process.

### Hardware Requirements for Home Hosting

So I'm ordering the least amount of additional hardware that I possibly can in
order to achieve this home hosting, without slowing down my home network. And
that means a new router. I actually have one of those old school Linksys WRT45GS
home wifi routers, legendary in the tech space as one of the first instances
where a company violated the GNU GPL2 (general public license) and was forced to
give their code that was based on it to the public, making this little blue
router ground-zero for the OpenWrt project, and router hacking outside the high
fallutin CISCO IOS programming circles in general.

### Simplifying System Administration with Nix

So sysadmin, netadmin and devops all rolled into one has become something of a
wax-on/wax-off process. I don't have a hundred different diverse technologies to
learn and master. I have just Nix. I should be able to configure my new router
in Nix. It will ship with its own pre-installed OS and software, but one of the
best skills you can have is to wipe whatever came pre-installed on whatever you
bought and install from sources you control. Nuke the place from orbit, it's the
only way to be sure.

## Planning for Log File Analysis

But once this work is done, I will have access to my log-files again, and that's
where a lot of the experiments begin. While my site isn't that big yet, the
original log-file lists in many cases might be too massive to work with directly
by a human or by an LLM. So we have to think in terms of distilling it down
right from the start, but meaningful list reduction. But not before we figure
out how to watch it as a real-time stream. In the Linux world, there's the `top`
and `bottom` commands, and those are options. But they don't get that
*"scrolling data"* feeling, so I'll have to solve that. It'll probably just be
something in JavaScript. Maybe it will be time to develop some of those HTMX
skills.

### Balancing Data Reduction with Outlier Preservation

But even when I do get to the actual list-reduction part of the work, I have to
be careful with too much filtering. Sometimes we want to reduce the data into
distinctly separate types of lists, one for normal distribution aggregations
with threshold filtering, and the other two specifically capture in the outliers
that are often filtered out, especially with `mean` averages — averages that
deliberately cut off the outliers at the top and the bottom to smooth out the
aggregate values into pretty lines. The questions I plan to ask both concern
normal distributions and surprising details in the fringes. 

### Creating LLM-Ready Data Visualizations

I am going to try to create a list that is just at the edge of my ability to
scan and still notice and extract meaningful patterns. This will put me in a
better communication with the LLM that is trying to do much the same.
Specifically, I will produce lists that are copy/paste ready for LLMs. I've done
a lot of this already with the experiments with GSC linear regression slope
calculations that I've talked about over the last few days. Giving the LLMs
little Excel-style sparklines is what I'm talking about.

## Finding Surprises in the Data

That which is surprises is often the most effective. Scan your data closely
enough so that you might be surprised. This is often what the sparklines are
about. You can see sudden interruptions in some metric for some very granular
query/page combination that you would normally miss. These sudden changes in
impressions, clicks or search positions for a particular keyword on a particular
URL often get buried and are unnoticeable on the Web UI big trend lines of GSC.
Drilling down to the top winners and losers and gleaning their stories is
important. We are in particular looking for accelerators. We want to step into
the path of existing search patterns with a rinse and repeat methodology.

### Identifying and Promoting Top Performers

Things that work, and really speak to you and hit just the right way will speak
to you in the data and continue to do so over time. These, we need to
continuously promote and distill them onto shorter lists, the producers. We can
also just manage them by sorting descending by the performance metric that
brings them to our attention on longer lists. The idea is for me to encounter
them more often for them to be more frequent candidates for special attention.
Perhaps we pair it up with similar, complementary data. Sometimes those special
pairings of topics will amplify. 

## Understanding User Behavior Through Data

The idea is to put your mind into the mind of your site visitors. What trends
are appearing that are not explicitly spelled out? Look at the real-time
scrolling data, and go back and forth to the sorted sparkline lists. Look at
your big traffic producers, but then also look at the outliers. Did some page
suddenly appear for the first time? Did you suddenly lose positioning on some
other term? Listen to whether your subconscious is trying to tell you something
that hasn't surfaced to your conscious awareness yet.

### Dynamic Content Management Through List Analysis

There will be churn between your different lists. They should not have exactly
the same appearance, nor should they be totally static. The story of your site
is dynamic and you should be able to tweak that story and adjust from either end
or the middle if you like. Especially as lists get reduced, and it no longer is
in chronological timestamp acquired log format. See, the log-files come in
chronological order, but every aggregate list and outlier-spotting list you
create has some other order. Scanning through that content-performance in that
order tells a story, but is it the right one? Should there be different keywords
in the middle?

## Strategic Site Structure and Click-Depth Management

We control the click-depths of each and every individual page. If a page can be
reached with one click from your homepage, that is a very deliberate designed
decision. If it takes 5 clicks to reach some content, that is deliberate and
designed too. 5 clicks is actually very deep, and many sites will have hundreds
of thousands or even millions of pages by 5 clicks deep. Pagination accidentally
drives pages that should be at shallow click-depths much deeper than they should
be found. Sometimes what should be premium shallow click-depth content on your
site, typically product detail pages (PDPs) for an commerce site end up as many
clicks deep as it took pagination clicks to reach them (10+).

### Content Archiving and Promotion Strategies

If your content doesn't need the short click-paths anymore either for the search
benefit of users and bots, than that premium real estate of short click-paths
shouldn't be squandered on it. But if you want to keep it on your site anyway
for the positive user experience of it actually still being available, and for
search engines to find it through the long-tail niche queries that lead to it,
then you are effectively driving it into a still-linked "archive". This
typically can be at a click-depth of 4 or 5 and still (just barely) work for
you. You will occasionally promote things up from out of the archive, and drive
retired premium stuff down into it.

## Website as a Strategic Game Board

Every page on your site can be considered pieces in a game. Items on the board
that can be shuffled around and moved with various degrees of ease or
difficulty, risk and reward. In a similar fashion, almost everything can be seen
as a complex chemical chain reaction of events in that game. You produced
such-and-such content, it produced the following new or recurring visits among
users or bots. Those users or bots are now aware of your site, or are aware of
it in a new light. The "attention" of the *attention economy* was just divvied
out in a slightly different way than it was before as a result of your actions.

### Finding Meaningful Patterns in Massive Data

Yet it's so much data we're dealing with on large, existing sites. It's easy for
these tiny but cumulatively meaningful stories to get lost in the shuffle. But
this is what my experiments will allow me to do effectively in this new age of
AI SEO we're entering. We control the surface area of our site. How many pages?
What is the site structure? The topography? The topical clusters and
cross-linking between pages? The hub and spoke structures we draw in the site
with the link graph. It's all artistically designed and part of the new language
of talking to bots. I mean, it's always been that way. It's just dramatically
more so because of the rising intelligence of the parts of the system. So we
must even more deliberately control what we project with our sites.

## Starting Small: The Path to Better Analytics

And so this all sounds like boiling the ocean even to me as I describe it here.
But it's not. It's a series of small chipping away projects that starts with
better control over my Jekyll publishing process that I do with GitHub pages.
That's done, and my comfort level is such that I can move where a Jekyll site is
actually published off of GitHub pages and onto home hosting. I have the part
ordered to give me the piece I need.

## Gemini 2.5's Take

* **Title/Headline Ideas:**
    * From Turing Tapes to Tail Logs: Why I'm Self-Hosting with NixOS
    * Escaping GitHub Pages: The Quest for Raw Log Files and Deeper SEO Insights
    * Wax On, Log Off: Embracing Self-Hosting Complexity for Better Bot Analysis
    * Beyond Static Limits: Setting up NixOS for Real-Time Web Analytics
    * Decoding Site Traffic: My Journey to Self-Hosting, NixOS, and Log File Analysis

* **Strengths:**
    * Provides a detailed, authentic view into the author's thought process and technical decision-making.
    * Connects abstract concepts (Turing machines, sequenced actions) to concrete technical goals (self-hosting, log analysis).
    * Includes specific technical details (NixOS, Jekyll, GitHub Pages, Linksys WRT45GS, GSC) valuable for readers familiar with these technologies.
    * Highlights contemporary concerns regarding AI bots (RAG) and their impact on web analytics.
    * Captures the personal challenges and motivations behind a technical transition.

* **Weaknesses:**
    * Assumes significant prior knowledge of concepts like Turing machines, NixOS, RAG, static site generators, web server logs, and SEO analytics.
    * The structure meanders between philosophical points, technical justifications, hardware details, and data analysis plans, potentially confusing for newcomers.
    * Heavy use of jargon (MCP protocol, GSC, PDPs, sparklines, click-depth) without explicit definitions within the text.
    * Lacks a clear, concise introduction *within the text itself* to orient readers unfamiliar with the author's context or the technologies discussed.
    * The journal-like, stream-of-consciousness style might obscure the core arguments for some readers.

* **AI Opinion:**
    This article offers a valuable, albeit dense, look into the practical motivations and technical considerations behind moving from a managed static hosting solution to self-hosting, specifically driven by the need for detailed log file analysis in the modern web environment (including AI interactions). Its strength lies in its authenticity and specific technical focus (particularly NixOS as an enabler). However, its clarity is likely high only for readers already familiar with web development, server administration, and advanced SEO concepts. For a general audience, the heavy jargon, assumed knowledge, and somewhat rambling structure would make it difficult to follow without external context. It serves best as a technical log or a detailed case study for a niche audience rather than a general explanation or tutorial.
