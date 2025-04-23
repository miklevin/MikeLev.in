---
title: "Optimizing Jekyll Rendering: From Nested Loops to Flattened Lookups"
permalink: /futureproof/foo/
description: "Our Jekyll site's rendering time became unmanageable due to an inefficient O(n²) nested loop approach for calculating related posts based on keywords. Drawing inspiration from a previous optimization involving a flattened post index (`flat_index`), we initially tried pre-processing all keywords into lookup tables but found it overly complex in Liquid. The breakthrough came with a simplified O(n) method: we leverage the existing `flat_index`, process only the *current* post's keywords, and iterate through the `flat_index` just once to find and score matches, drastically improving performance with minimal complexity."
meta_description: Optimize Jekyll build performance by speeding up related posts generation. Learn to replace slow O(n²) nested loops with an O(n) flattened lookup in Liquid.
meta_keywords: Jekyll, performance, optimization, rendering, build time, related posts, Liquid, template, O(n^2), O(n), nested loops, flattened index, flat_index, lookup, keyword matching, pre-processing, algorithm, static site generator, performance bottleneck, template optimization
layout: post
sort_order: 3
---

## Improving Jekyll Page Generation Speed

This article delves into the technical challenge of improving the speed at which a website built with a tool called Jekyll generates its pages. Jekyll is a "static site generator," meaning it builds all the website pages upfront, rather than creating them dynamically when a visitor arrives and is what powers GitHub Pages, also known as github.io. While static sites are efficient for visitors, this initial build process, or "rendering," can become very slow for large websites, impacting developer productivity.

## The Challenge of Related Posts

The specific problem tackled here involves a common website feature: displaying a list of "related posts" at the bottom of an article, typically based on shared tags or keywords. The author details their journey in optimizing the underlying code (written in a templating language called Liquid) used by Jekyll to calculate these relationships. The focus is on shifting from an algorithmically inefficient method that slowed down dramatically as the site grew, to a much faster approach by pre-organizing data and simplifying the lookup process.

---

## Rendering Performance Bottlenecks

When you're dealing with large Jekyll sites, rendering performance can become a critical bottleneck. Our journey began with a site that was taking far too long to render because of inefficient template code, specifically in the related posts section.

## The Initial Problem

The original related posts implementation used a nested loop approach that performed poorly:

1. For each post on the site
2. For each keyword in the current post
3. For each keyword in every other post
   - Calculate matches
   - Score and sort

This O(n²) approach created a performance nightmare as the site grew. Each additional post added exponential processing time.

## Our First Solution: Looking to Earlier Success

We had already solved a similar problem with post navigation arrows. The key insight was pre-processing: instead of calculating relationships on the fly, we created a flattened index once:

```liquid
{%- assign flat_index = "" | split: "" -%}
{%- for day in grouped_posts -%}
  {%- assign day_posts = day.items | sort: 'sort_order' | reverse -%}
  {%- for post in day_posts -%}
    {%- assign flat_index = flat_index | push: post -%}
  {%- endfor -%}
{%- endfor -%}
```

This flat_index made finding previous/next posts a simple position-based lookup instead of repeated searches through the entire post collection.

## First Attempt: Pre-processing Keywords

Our first optimization attempt applied the same principle to related posts:

1. Pre-process all posts' keywords into a structured format
2. Create lookup tables for easier access
3. Use these tables to find related posts

We created tables like:
- `keyword_to_posts`: Direct mapping from keywords to post URLs
- `post_info_map`: Post metadata cache to avoid repeated lookups

However, this approach still had issues:
- Complex array manipulations like `remove_at` and `insert_at` in Liquid proved inefficient
- Too many nested loops and expensive operations

## The Winning Solution: Simplified Flattened Approach

The final optimization simplified everything while maintaining the same output:

1. Pre-process only the current post's keywords
2. Make a single pass through flat_index that was already in memory
3. For each post, calculate keyword matches directly
4. Score and sort the matches

The key improvements were:
- Eliminating all complex data structures
- Removing expensive array operations
- Leveraging the existing flat_index
- Processing each post exactly once

```liquid
{%- for post in flat_index -%}
  {%- if post.url != page.url and post.meta_keywords -%}
    {%- assign common_tags_count = 0 -%}
    // Calculate matches directly
    // Score and add to results if matches found
  {%- endif -%}
{%- endfor -%}
```

## The Database Analogy

Our optimization journey mirrors database evolution:
1. Initial approach: Like a full-table scan with nested queries
2. First attempt: Like an indexed sequential access method (ISAM) with too much overhead
3. Final solution: Like a properly indexed table with a single efficient scan

We essentially went from an O(n²) algorithm to an O(n) algorithm by:
1. Eliminating redundant work
2. Pre-calculating what could be reused
3. Simplifying the data structures

## Lessons Learned

1. **Pre-process once, use many times**: Calculate common data once at template start
2. **Simpler is faster**: Complex data structures can slow down Liquid templates
3. **Watch for O(n²) patterns**: They're performance killers as sites grow
4. **Use existing data**: The flat_index was already in memory and optimized
5. **Minimize operations**: Each loop, assignment, and filter has a cost

This approach resulted in dramatically faster render times while maintaining the exact same output. The site went from "painful to build" to "quick and responsive" - a perfect example of how algorithmic improvements can have much greater impact than infrastructure changes.

---

## AI Analysis

* **Title/Headline Ideas:**
    * Optimizing Jekyll Related Posts: From O(n²) Nightmare to O(n) Flattened Lookups
    * Slash Jekyll Build Times: A Case Study in Liquid Template Optimization
    * Faster Jekyll Renders: Fixing Related Posts with a Flattened Index Approach
    * Beyond Nested Loops: An Efficient Algorithm for Jekyll Related Posts
    * Pre-process Once, Render Fast: Optimizing Jekyll's Related Posts Logic

* **Strengths:**
    * Clearly identifies a specific, common performance bottleneck (related posts calculation).
    * Details the evolution of the solution, showing the iterative thought process (initial problem -> first attempt -> final solution).
    * Provides concrete (though partial) code examples in Liquid to illustrate the approaches.
    * Uses a relatable database analogy to explain the algorithmic improvement.
    * Concisely summarizes the key takeaways and lessons learned.

* **Weaknesses:**
    * Assumes significant prior context about the `flat_index` used for navigation, making it slightly harder to grasp its reuse without that background.
    * Lacks concrete performance metrics (e.g., "reduced build time from X minutes to Y seconds") to quantify the improvement.
    * The description of *why* the first attempt's array manipulations were inefficient in Liquid could be more specific.
    * Code snippets are illustrative but incomplete (e.g., "// Calculate matches directly"), requiring some inference.

* **AI Opinion:**

    This article provides valuable, practical insights for developers working with Jekyll, especially on larger projects where build performance is critical. It effectively documents a real-world optimization process for a common feature (related posts). While highly technical and assuming familiarity with Jekyll, Liquid, and algorithmic concepts like Big O notation, its strength lies in clearly presenting the problem, the reasoning behind different approaches, and the final, more efficient solution pattern (leveraging a pre-calculated flattened index). Despite its narrow focus, typical of a technical log, it serves as a useful case study demonstrating how algorithmic thinking can significantly impact performance in static site generation.

