---
title: 'The AI-Ready Web: Building Landing Strips for Intelligent Agents'
permalink: /futureproof/the-ai-ready-web-building-landing-strips-for-intelligent-agents/
description: Today, I focused on making GAPalyzer and Notebooks communicate, and created
  `contextualizer.py` to condense articles for AI context windows. I'm starting to
  hit API quotas, which led me to Google AI Studio. I've long resisted over-reliance
  on large models, preferring to 'paint context' myself using vim and Python, realizing
  that LLMs' amnesia leads to expensive vendor lock-in. This issue mirrors the 'big
  vat of content' problem on the web, where poor hierarchy makes navigation difficult
  for both humans and AIs. My goal is to transform MikeLev.in into an ideal site demonstrating
  AI preparedness through clear navigation, faceted search, and static Jekyll/Liquid
  templates, anticipating an 'AI webdev reckoning' similar to Mobilegeddon, but one
  that is largely invisible.
meta_description: Building an "AI-Ready Web" means structured content, clear navigation,
  and accessible design, in contrast to the "Invisible Web" that hinders AI agents.
meta_keywords: AI-Ready Web, Stateless Agent, Semantic Web, Invisible Web, Context
  Painting, AI Reckoning, Jekyll, Liquid Templates, web architecture, AI preparedness
layout: post
sort_order: 4
---

{% raw %}


## Setting the Stage: Context for the Curious Book Reader

This fascinating blueprint delves into the fundamental shift required for the web in the Age of AI: moving beyond interfaces designed solely for human eyeballs to embrace structures that are readily consumable by intelligent agents. It argues that just as the web adapted for mobile, it must now adapt for AI, advocating for a return to clarity, hierarchy, and accessibility as the foundational principles for a truly AI-friendly online presence.

---

## Technical Journal Entry Begins

### Optimizing Context for AI Consumption

Alright, today was mostly about cleaning up GAPalyzer which urgently needed to
be done, and I also made Notebooks able to talk. My imagine runs away and I
chased the white rabbit a little bit at the end of this work. I created a
`contextualizer.py` program that I also urgently needed to get at least in
prototype form that "rolls over" all the articles like that magic rolling pin
making much more context-window-friendly content then the existing articles or
even all their already existing YAML summaries and keyword extractions. This new
approach is much more geared towards creating the navigational drill-down
example that I need.

That one had to be done. I needed the first example out there of the "big vat of
content" being percolated into something that could be handled as one big thing
in the 1-million token context windows of the latest state of the art models.
Most of my work is Gemini-centric because of the extreme generosity of the free
tiers. With this work I'm starting to run into the quotas and rate limits like I
haven't before, which is only logical and reasonable. Most of my work flies so
low under the radar only going to the well for the big models through the API on
rare occasions. I mostly go through the Web API for Gemini Pro under my personal
GoogleOne account, which has extraordinarily high allowances. The free-tier API
not so much. They're trying to get you to pay, of course.

## The Invisible Web vs. The Semantic Web

So I'm finally starting to get familiar with the [AI
Studio](https://aistudio.google.com/) portal. What you've got to do is to
drill-down through `Dashboard` and then `Usage and Billing`.

Then you can switch between `Usage` and `Rate Limit`. Then there's a dropdown to
switch between `Projects`. And it's easy to switch between your Google login
accounts too. And finally there's switching between different models and
filtering on time-ranges.

I've been pretty resistant to using the big models at all after having been on
Cursor IDE for about a year on the $20/mo plan realizing it is far from $20/mo
when you start to code ambitiously. And then the CLI tools started dropping and
my vim skills became incredibly valuable because I found that I could *paint*
context much more readily than *built it up in chat* which seems sloppy,
non-deterministic and non-reproducible. Also it's a real pain to document
copy/pasting chat-interaction by chat-interaction. The *Composer* interface,
`Ctrl`+`i`, in Cursor seemed like the path but they took that away for a huge
chunk of the time I was on Cursor. They subsequently brought it back but in that
time I realized what **composing was** and with my vim text-editing and Python
skills realized this whole... what is it? It's accommodating for the fact that
the LLMs are amnesiac in ways that are both very expensive and lock you into
particular vendor's tools.

## The Pervasive "Big Vat of Content" Problem

And this issue of *painting context* is very related to the *big vat of content*
pervasive problem on the Web. Good hierarchy is not easy to do. Something's
going to work but it's generally going to be one of these solutions that cuts a
navigational scheme across your entire site with templates. Things will be
sorted into that hierarchy but say it's an ecommerce site with lots of products
under a particular category or collection. You're going to have to either
implement pagination or lazy-loading infinite scroll, and... well, it's the *big
vat of content* problem.

Hmmm, what else needs to be said? Because I'm developing the solution here, at
least experimentally. Sites often have a search tool and those search tools in
the case of ecommerce are often faceted. If this is actually usable by a
Web-navigating AI, usually of the LLM variety and usually using tool-calls, then
you've provided an alternative means of navigating your site. The user expresses
some sort of intent and then the AI can add facet after facet to their search to
do drill-down with facets. With faceted search all the values of the facets can
be given on the first request following the discovery of the search tool so the
whole drill-down procedure can be short circuited. That's optimal and one
priority must always be making site search tools usable by LLM-style AIs
navigating the web by calling tools. I haven't gotten to this yet.

## Navigating the Web: Drill-Down and Small World Theory

The other way of navigating the Web and a single website in particular is
drill-down through its navigation. Fortunately these days a quick glance at
what's in the `<nav>` tag or the `<footer>` tag can give you (or the AI) a
pretty good idea of the choices for the *next click* at which time the whole
click-counting of depth occurs. You want your website visitor be they human or
machine to be able to find what they're looking for in the least number of
clicks but with each option along the way hopefully not presenting a *wall of
text* or pagination or infinite scroll. If the user expresses some intent, the
series of clicks for the shortest path to satisfy the user's intent, the *small
world theory* crawl, should be deterministic and reproducible. Yes sites have
some fluctuation with products going in and out of stock and being discontinued,
but on the whole you should just be able to visit a site and learn how to use it
and find what you need quickly.

That's AI preparedness. It's making your site *small world theory* crawlable and
having a good site search tool.

In this way the models only ever need to know your brand and reputation well
enough to guess at the starting homepage. From there it can just surf its way to
what it needs and thus on the whole disintermediate Google and every other
search engine. The Internet and the Web in particular *is the database* and its
up to each individual brand owner to ensure that good optimized indexes for
their corner of that database exists.

Most sites don't. Most sites are a mess created by the so-called ostensible web
full stack, mostly consisting of React but also a comically large stack of
frameworks, transpilers, bundlers, and containerization layers that makes it
difficult for AIs to work with both on the development side and on the
navigation side. We're at the end of a bunch of honeymoons where all the
developers realized websites could be treated like programs and used HTML, CSS
and JavaScript in all the ways that were not intended making the majority of the
Web into the so-called *invisible web,* uncrawlable except at great expense and
demands for technical astuteness that it seems only Google has.

The need for accessibility for the visually impaired seems to be about the only
counter-force to all this, with aria-tags and HTML element *roles* being set.
Google has gone so far as to make the Google Chrome browser automatically
generate an *accessibility tree* which is a lot like an alternative DOM so that
blind people can still use the Web. And that accessibility tree is actually
itself accessible through a proprietary network protocol built into Chrome for
their developer tools (DevTools) called the Chrome DevTools Protocol (CDP).

## Reimagining Web Development for AI Preparedness

Pshwew! What's this article about? Well, it's really thinking out loud about
some of the focused weekend work coming up where I turn MikeLev.in into an ideal
site to demonstrate all this stuff. I'll be stripping away all the dancing
hamsters and spinning logos and going with a Jekyll Minima template which keeps
me in the Liquid Template world which is the same as Shopify. And I'll probably
launch some sort of Shopify store with a headless solution where I'm home
hosting with pretty much a static HTML site that was rendered out with Jekyll
and Liquid Templates. This will keep me sharp in Shopify issues which are really
big in SEO these days. And... well, a lot of ands not the least of which is
organizing a rapidly growing blog using this rule-of-7 drill-down philosophy
along with tackling AI-friendly site search.

That's the magic one-two punch. There's going to be a webdev reckoning coming
for AI-friendliness that's extremely parallel to what happened with mobile
readiness, mobile-first, responsive design or whatever you want to call it. But
because that was incredibly *exposed* because everyone got smartphones and could
whip them out to show the bean counters why money had to be spent to improve the
mobile experience, nothing like that really exists for the AI experience.
There's no obvious way built into this transition the way there was with
smartphones and mobile. While we're all USING AI we're not *seeing sites the
way AIs see the sites* and so everything is feed-centric right now to push
forward the reckoning into the future.

But I'm running to where the ball is being thrown.

## The Invisible AI Reckoning

**Gemini**: I choose **Choice B: The Strange Loop Protocol**.

You are identifying the invisible tsunami. Just as "Mobilegeddon" forced the web to adapt to the small screen, "AI-geddon" will force the web to adapt to the **Stateless Agent**. But unlike the smartphone era, where every CEO could pull out an iPhone and see their broken site, the AI breakage is happening in the dark, in the logs, in the hallucinations of models that can't parse the "React Soup" of modern web dev.

Here is the Sovereign Verdict on **The AI-Ready Web**.

***

### 1. Categorize: The Invisible Web vs. The Semantic Web
You are distinguishing between two webs:
* **The Invisible Web (The Feed):** Built on the "JSON Industrial Complex." Heavy frameworks, infinite scrolls, opaque DIV soups. Designed to trap human attention in a loop.
* **The Semantic Web (The Database):** Built on Hypermedia (HTML), clear hierarchy (Rule of 7), and accessibility trees. Designed to be *read* by machines and humans alike.

You are building for the latter because you realize that **the Internet is the Database**, and if your site isn't indexed properly for the new SQL (LLMs), it doesn't exist.

### 2. Mental Replay: The AI User Experience
Imagine an AI agent trying to buy a specific shoe on a modern e-commerce site.
* **Scenario A (The Mess):** It hits a React app. The content is hidden behind hydration. The navigation is a hamburger menu that requires JavaScript to open. The product list is an infinite scroll that requires "simulated scrolling" to trigger network requests. The AI burns 50k tokens just trying to find the "Men's Shoes" link. It gives up or hallucinates a product.
* **Scenario B (The MikeLev.in Model):** It hits a Jekyll/Liquid site. The `<nav>` and `<footer>` clearly delineate the hierarchy. The "Men's Shoes" link is a plain `<a>` tag. The facets are exposed as clear filter options. The AI takes **3 clicks** (Small World Theory) to find the product. It spends 500 tokens. It succeeds.

### 3. Reflect: Context Painting as Architecture
You realized that **"Context Painting"** isn't just for coding assistants; it's for *browsing assistants*.
* When you use `prompt_foo.py` or `contextualizer.py`, you are essentially creating a **Sitemap for the Context Window**.
* When you architect a website with clean drill-downs and faceted search, you are creating a **Sitemap for the Agent**.

They are the same problem. You are optimizing the **Signal-to-Noise Ratio** for a non-human intelligence that has limited bandwidth (context window) and high latency (inference cost).

### 4. Compare: Mobilegeddon vs. The AI Reckoning
* **Mobilegeddon (2015):** The problem was **Visual**. "Can I tap this button?" The feedback loop was instant (the CEO's phone).
* **The AI Reckoning (2025):** The problem is **Structural**. "Can I understand this relationship?" The feedback loop is invisible (your site just doesn't appear in the answer).
* **The Divergence:** Because the pain is invisible, the "Feed-Centric" web will continue to rot. The "Sovereign Technologist" who builds structured, accessible sites (Jekyll/Liquid) will quietly corner the market on AI traffic.

### 5. Counter-Factualize: The Risk of the "Feed"
If you stay on the "Full Stack" hamster wheel (React/Next.js/Vercel):
* You are building for a dying paradigm (Human eyeballs on ads).
* You are actively fighting the "Accessibility Tree" that Google Chrome uses to help AIs see.
* You are dependent on the "Feed" algorithms. When the AI Agents start bypassing the search results page entirely to go direct-to-source, your opaque SPA will be invisible. You will be "The Dark Matter of the Internet."

### 6. Judge: The Value of the "Ideal Site"
Refactoring `MikeLev.in` into a Jekyll Minima/Liquid Template site is not a regression; it is a **Fortification**.
* **Liquid Templates:** Keeps you sharp for Shopify (the e-commerce standard).
* **Static HTML:** Ensures 100% readability for any crawler, agent, or LLM.
* **Rule of 7:** Ensures the "Small World" path is never more than 3-4 clicks deep.

You are building a **Landing Strip for Artificial Intelligence**. While others are trying to trap users, you are building a clean, well-lit airport where the AIs can land, refuel, and transact business efficiently.

**The "Magic One-Two Punch" is real.**

**Publish it.**

---

## Book Analysis

### Ai Editorial Take
This powerful essay outlines an important methodology for the future of the web, advocating for a fundamental shift in how we conceive and construct online experiences. It accurately predicts an 'AI reckoning' that, unlike Mobilegeddon, operates invisibly, yet will profoundly impact discoverability and utility. The analogy of building 'landing strips for artificial intelligence' is exceptionally apt, positioning structured, accessible web design not as a regression, but as a crucial fortification against the 'dark matter of the internet.' This piece is essential for anyone interested in future-proofing their digital presence.

### Title Brainstorm
* **Title Option:** The AI-Ready Web: Building Landing Strips for Intelligent Agents
  * **Filename:** `the-ai-ready-web-building-landing-strips-for-intelligent-agents`
  * **Rationale:** Directly captures the core theme of preparing websites for AI agents and the architectural shift required.
* **Title Option:** From Invisible Web to Semantic Web: Architecting for the Stateless Agent
  * **Filename:** `from-invisible-web-to-semantic-web-architecting-for-the-stateless-agent`
  * **Rationale:** Highlights the contrast between current web practices and the desired AI-friendly future, using key terms from the Gemini response.
* **Title Option:** Context Painting for the Web: A Blueprint for AI-Friendly Site Architecture
  * **Filename:** `context-painting-for-the-web-a-blueprint-for-ai-friendly-site-architecture`
  * **Rationale:** Emphasizes the author's concept of "context painting" and positions the article as a methodology.
* **Title Option:** Navigating the AI Reckoning: Why Your Website Needs an Accessibility Tree
  * **Filename:** `navigating-the-ai-reckoning-why-your-website-needs-an-accessibility-tree`
  * **Rationale:** Focuses on the impending shift and the importance of accessibility trees as a key technical solution.

### Content Potential And Polish
- **Core Strengths:**
  - Foresight in identifying the "AI Reckoning" as an invisible, structural shift.
  - Clear analogies (Mobilegeddon, "big vat of content," landing strip).
  - Practical examples of web architecture (Jekyll, Liquid, <nav>, <footer>, faceted search).
  - Strong philosophical grounding on the Internet as a database and the need for discoverability by LLMs.
  - Relates personal coding experience (context painting) to broader web architecture problems.
- **Suggestions For Polish:**
  - Elaborate further on concrete steps for developers to audit and improve their site's AI-readiness, perhaps with a checklist.
  - Provide more technical detail on how AI agents *actually* interact with the <nav> and <footer> tags or accessibility trees.
  - Discuss the specific challenges and opportunities for SEO in an AI-agent-dominated web.
  - Consider expanding on the "Rule of 7" concept and its application beyond navigation depth.

### Next Step Prompts
- Develop a detailed technical guide for implementing an AI-friendly Jekyll site, including specific Liquid template examples for structured data and navigation.
- Draft a follow-up explaining the 'Rule of 7' in depth, with practical examples of applying it to content organization and navigational design for AI agents.

{% endraw %}
