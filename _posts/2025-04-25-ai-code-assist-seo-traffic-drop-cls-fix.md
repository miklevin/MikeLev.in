---
title: How AI Code Assistance Accidentally Tanked My SEO Traffic
permalink: /futureproof/ai-code-assist-seo-traffic-drop-cls-fix/
description: "I wanted to share how I recently used AI code assistance to help manage my website, specifically to fix a Cumulative Layout Shift (CLS) issue that arose after adding a dynamic JavaScript Table of Contents (TocBot). Unfortunately, the initial fix suggested by the AI, while addressing the visual layout shift, involved hiding content in a way (`visibility: hidden`) that made large parts of my site invisible to search engines, tanking my traffic. This post details how I diagnosed the problem – realizing it mimicked blocking crawlers – and worked with the AI again to implement a more SEO-friendly solution using CSS `opacity` and a `<noscript>` tag, hopefully resolving the issue without sacrificing the CLS improvements."
meta_description: "Debugging SEO issues caused by AI-assisted CLS fixes. How using 'visibility: hidden' tanked traffic and the switch to 'opacity' for better indexing."
meta_keywords: CLS, Cumulative Layout Shift, SEO, AI code assistance, traffic drop, visibility hidden, opacity, JavaScript indexing, search engine optimization, Google Search Console, GSC, Core Web Vitals, CWV, TocBot, Table of Contents, CSS, JavaScript, site performance, web vitals, indexing issue, search visibility, noscript, requestAnimationFrame
layout: post
sort_order: 2
---

## Understanding AI Code Assistance and Website Performance

This article explores the potential pitfalls of using Artificial Intelligence (AI) tools to help write or modify the code that runs a website. Specifically, it delves into a situation where attempting to improve a website's performance metric, known as Cumulative Layout Shift (CLS), inadvertently caused significant problems with Search Engine Optimization (SEO), leading to a sharp decline in website traffic. CLS is a measure used by search engines like Google to gauge how much a webpage's layout unexpectedly shifts during loading, which can be frustrating for users.

The author shares a personal experience where implementing a common feature – a dynamic Table of Contents (ToC) generated using JavaScript – and then trying to optimize its loading behaviour with AI assistance, resulted in website content becoming effectively invisible to search engine crawlers. This highlights the delicate balance between optimizing user experience features (like smooth loading) and ensuring technical elements remain compatible with how search engines discover and rank content. The core issue discussed involves specific web coding techniques (CSS visibility vs. opacity) and how seemingly minor code changes, especially when suggested by AI, can have major unintended consequences for a site's visibility online.

---

## The Dangers of AI Code Assistance

Hey, you know how you can get AI code assistance? Well guess what? You can
accidentally tank your website's traffic if you're not careful when enlisting
its help managing your site. My whole site is a bunch of text files, some as the
templates for page-types, others as the content itself, and of course one for
CSS styles and another for JavaScript. The AI can step in and help you with all
of that — just enough to let you shoot yourself in the foot. Here's what I just
did:

![Tanked Traffic With AI Code Assistance](/images/tanked-traffic-with-ai-code-assistance.png)

## How CLS Optimization Backfired

I accidentally tanked my search results fighting Cumulative Layout Shift (CLS),
which is a Google Core Web Vital (CWV) in the field of Search Engine
Optimization (SEO). We do love our acronyms in SEO. Anyhow, my pedantic article
pages run long, so I researched how to get those nifty JavaScript Table of
Contents (ToC) that sites use to jump right to where you want to go in a long
document. The dominant one is TocBot, which is awesome. It's that kind that also
highlights where you are in the ToC as you scroll up and down the page, and also
happens to construct itself automatically from the headlines of your document
without you having to do anything but include a JavaScript library and add a few
classes here and there. And so I did.

## The Perfect Storm of Technical Challenges

But given the unique way my sight lets you set the width of the site with a
nifty slider, the Table of Contents also had to dynamically resize. Also, I
didn't want it showing on Mobile. So all this culminated together to result on a
lot of changes on my sight at once, along with a terrible "popping" effect when
surfing from page-to-page. And so I asked for help from AI to mitigate the this
cumulative layout shift (CLS) which I was already getting dinged for in Google
Search Console (GSC), and I didn't want to make it worse. I made it much worse.
And given how many changes I suddenly rolled out on my site, it was hard for me
to pinpoint precisely what caused the traffic drop.

## Recognizing the SEO Impact Pattern

The signature was that of suddenly blocking your whole site with the
`robots.txt` file or adding `noindex` meta tag into the template. I've been
around the block in SEO for some time and know the signatures of such things.
Much of my site had functionally become invisible to search, but the pages were
still being crawled and indexed. It was like they were empty pages. My
suspicions went immediately to the media queries I was using to hide the table
of contents on mobile. And investigating that, I realized my biggest
vulnerability was probably when I asked the AI to help me fight the cumulative
layout shift.

---

## Pinpointing What Went Wong

> Having come up with the theory of what went wrong, it's much easier for the AI
> to parse through my code and determine whether I'm right or not. So I present
> to it my theory.

**Me**: I recently fought content layout shift (CLS). Make sure the solution
isn't accidentally making the content invisible to search on initial pageload.

**Claude 3.7**: I see the issue. Your site is initializing with `visibility: hidden` on the `.center-container` and then switching to visible after layout is complete. This prevents content layout shift, but it could potentially impact search engine indexing.

Let me check how the implementation works:

Read file: MikeLev.in/assets/css/styles.css

Read file: MikeLev.in/assets/js/site.js
The issue is in the implementation. Currently, your code:

1. Sets `.center-container` to `visibility: hidden` in CSS
2. Waits for the DOM to load and layout to be set
3. Then adds a `.loaded` class to make it visible with `requestAnimationFrame()`

This approach can indeed create problems for search engines. While modern search engine crawlers do execute JavaScript, the delay in showing content can potentially impact indexing, as crawlers may not wait long enough for the content to become visible.

Here's a more SEO-friendly approach to prevent CLS while ensuring your content is indexed:

```css
/* Center container */
.center-container {
    display: flex;
    justify-content: center;
    width: 100%;
    max-width: 98%;
    margin: 0 auto;
    min-height: 100vh;
    position: relative;
    opacity: 0;
    transition: opacity 0.3s ease;
}

.center-container.loaded {
    opacity: 1;
}
// ... existing code ...
```

Now let's also add a `<noscript>` tag to ensure that users without JavaScript still see the content. We'll need to add this to your layout file:

```html
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tocbot/4.32.2/tocbot.css">
    <!-- Global site tag (gtag.js) - Google Analytics -->
    <script async src="https://www.googletagmanager.com/gtag/js?id={{ site.gaid }}"></script>
    <script>
      window.dataLayer = window.dataLayer || [];
      function gtag(){dataLayer.push(arguments);}
      gtag('js', new Date());

      gtag('config', '{{ site.gaid }}');
    </script>
    <script src="/assets/js/site.js"></script>
    <script type="module">
        import mermaid from 'https://cdn.jsdelivr.net/npm/mermaid@10/dist/mermaid.esm.min.mjs';
        mermaid.initialize({ startOnLoad: true, theme: 'dark', gantt: {titleTopMargin: 25, barHeight: 20, barGap: 4, topPadding: 50, leftPadding: 150, gridLineStartPadding: 150, sectionHeight: 35, fontSize: 11, numberSectionStyles: 4, axisFormat: '%b %Y', viewMode: 'halfYear'} });
    </script>
    <noscript>
      <style>
        .center-container {
          opacity: 1 !important;
        }
      </style>
    </noscript>
</head>
// ... existing code ...
```

Finally, let's make sure the JS triggers the visibility correctly right at the beginning, not waiting until DOMContentLoaded:

```javascript
// Initialize width immediately before DOM content loads
const storedWidth = getCookie('containerWidth') || '850';
document.documentElement.style.setProperty('--slider-width', storedWidth + 'px');

// Ensure content is visible for search engines as soon as possible
(function() {
  // Make content visible immediately for search engines and users
  const centerContainer = document.querySelector('.center-container');
  if (centerContainer) {
    // Schedule this to happen as soon as possible but after the current JS execution
    setTimeout(() => centerContainer.classList.add('loaded'), 0);
  }
})();

document.addEventListener('DOMContentLoaded', function() {
    const widthSlider = document.getElementById('widthSlider');
    const container = document.querySelector('.container');
    const sliderContainer = document.getElementById('widthSliderContainer');
    const centerContainer = document.querySelector('.center-container');
    const SIDEBAR_WIDTH = 200;
    
    // Set initial values immediately
    widthSlider.value = storedWidth;
    container.style.maxWidth = storedWidth + 'px';
    
    // Ensure content is visible (as a backup in case the earlier call failed)
    if (centerContainer && !centerContainer.classList.contains('loaded')) {
        centerContainer.classList.add('loaded');
    }
    
    function updateSliderMaxWidth() {
// ... existing code ...
```

These changes solve your SEO problem while still preventing content layout shift (CLS):

1. **CSS Changes**: Instead of using `visibility: hidden/visible` which removes content from the accessibility tree (and potentially from search indexing), we now use `opacity: 0/1` with a transition. The content is technically in the DOM and accessible to search engines, but invisible to users until the layout is ready.

2. **Noscript Fallback**: For users with JavaScript disabled (including some search crawlers), the `<noscript>` tag overrides the opacity, making content immediately visible.

3. **Early JS Initialization**: We now make the content visible immediately after the script loads, not waiting for the full DOM content to load. This helps with both user experience and search indexing.

4. **Backup Visibility**: We still set the loaded class during DOMContentLoaded as a fallback.

This approach maintains your CLS prevention while ensuring search engines can access and index your content properly. The content is now technically present in the DOM from the beginning, just temporarily invisible, which is much better for SEO than being completely hidden.

---

## Fixed... I Think

And just like what got me into this mess in the first place, I enthusiastically
accept all the changes, let Jekyll render out the site, and I go check to make
sure everything looks okay. Reading over the solution, I still have some
concerns with the opacity trickery it's using to fight CLS flash, but I'll give
it a day or two to see if recovery occurs with this solution.

So I push it to production (git push), and now I wait.

---

## AI Analyisis

* **Title/Headline Ideas:**
    * How AI Code Assistance Accidentally Tanked My SEO Traffic
    * Debugging an AI-Induced SEO Catastrophe: The CLS & `visibility: hidden` Trap
    * AI vs. SEO: Fixing Cumulative Layout Shift Without Killing Your Traffic
    * My Journey Fixing CLS with AI: A Cautionary Tale for SEO
    * From TocBot to Traffic Drop: An AI Code Assist Debugging Story

* **Strengths:**
    * Provides a concrete, real-world example of a specific technical challenge (CLS vs. SEO).
    * Includes practical code examples (CSS, JS, HTML) illustrating the problem and solution.
    * Demonstrates a realistic workflow involving AI coding assistants, including debugging their suggestions.
    * Offers a valuable lesson on the subtle but critical difference between `visibility: hidden` and `opacity: 0` for search engine indexing.

* **Weaknesses:**
    * Assumes a high level of technical understanding (SEO acronyms, web development concepts, specific libraries like TocBot).
    * The journal/narrative format lacks clear structure, potentially burying key technical takeaways within the story.
    * Relies heavily on jargon (CLS, CWV, GSC, ToC, media queries, `robots.txt`, `noindex`) without defining all terms for a broader audience.
    * The conclusion ("Fixed... I Think") reflects the immediate moment but lacks definitive confirmation that the fix was successful long-term.

* **AI Opinion:**
    This article serves as a valuable, albeit technical, case study illustrating the potential complexities and risks of using AI for website code modifications, particularly concerning SEO. Its strength lies in its specific, detailed account of diagnosing and resolving a nuanced problem where user experience optimization (CLS) conflicted with search engine visibility. While its clarity is high for readers already familiar with web development and SEO concepts, its narrative style and assumed knowledge might make it less accessible to beginners. It's a useful "lessons learned" piece for developers and SEO practitioners navigating AI tools and front-end optimization challenges.
