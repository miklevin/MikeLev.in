---
date: 2023-05-10
title: Now The Github miklevin/yamlchop Repo has a README.md
headline: "I Share My Best Tricks: Now The Github miklevin/yamlchop Repo Has a README.md"
description: I'm an SME at MOZ and I'm sharing my best tricks for managing hundreds of lightweight blog posts using the yamlchop repo on Github. I'm using the yamlchop/chop.py tool to split them into individual files and OpenAI to generate headlines, meta descriptions, and keywords. With this system, I'm able to create previous and next arrows with the exact wording of my title tags in the links.
keywords: SME, Web, Kung Fu, ASCII art, Diagramming, Venn-nvim, MermaidJS, Jekyll, Static Site Generator, Github, YAML, Markdown, HTML, OpenAI, SEO, Previous Next Arrows, Rambling, Mikelev.in
categories: ai, jekyll, yaml, html, seo, static site generator, git
permalink: /blog/now-the-github-miklevin-yamlchop-repo-has-a-readme-md/
layout: post
---


I am an **SME** at MOZ. That is a "subject matter expert". So apparently, I had
better be expert at some subject matter, and preferably not too much that
overlaps with my peers who are much better pedigreed than I am. What I have
going for me is having been there and done that, since the rise of the Web.

I've been around the block for a few times, and my credibility is going to come
from what I am capable of doing and what I have done lately. So it couldn't
hurt to take some of my better kung fu which I no longer need to keep secret,
because I'm not in the proprietary competitive advantage knowledge world so
much anymore. I can share. I can share my best tricks! And so I shall.

You can share all you want, but if it's too techy and not visual enough, it's
not going to amount to much. And that's why I've been working on the ASCII art
diagramming ability. Fast diagrams without the muss and fuss of Illustrator,
and as it turns out even MermaidJS.

So let me now take some of those wonderful ascii diagrams I made on that last
post and move them into the yamlchop repo on github. I got the venn-nvim plugin
working yesterday, have a bunch of really insightful key diagrams done in my
journal today, and same day, I can move some of the good ones to the repo.
That's the kind of new efficiency I'm looking for. Pull those diagrams up into
this post...

## What is this?

So you know the Jekyll static site generator (SSG) in Github called `github.io`
or `Github Pages`? It takes a repo with simple text files with YAML
front-matter and Markdown content to publish slick low tech-liability HTML
pages like so:

    ┌──────────────────────┐          ┌────────────────────────────────┐
    │title: My Blog Post   │          │<html>                          │
    │date: 2021-05-09      │          │  <head>                        │
    │---                   │  Jekyll  │    <title>My Blog Post</title> │
    │                      │─────────►│  </head>                       │
    │# My Blog Post        │          │  <body>                        │
    │                      │          │    <h1>My Blog Post</h1>       │
    │This is my blog post. │          │    <p>This is my blog post.</p>│
    └──────────────────────┘          │  </body>                       │
                                      │</html>                         │
                                      └────────────────────────────────┘

This is a good system, but over time you might accumulate hundreds of these
files, and it can be a pain to manage them all:

      File 1    File 2    File 3    File 4    File 5    File 6
     ┌──────┐  ┌──────┐  ┌──────┐  ┌──────┐  ┌──────┐  ┌──────┐ 
     │Page 1│  │Page 2│  │Page 3│  │Page 4│  │Page 5│  │Page 6│ 
     │      │  │      │  │      │  │      │  │      │  │      │ 
     │      │  │      │  │      │  │      │  │      │  │      │ 
     └──────┘, └──────┘, └──────┘, └──────┘, └──────┘, └──────┘

The contents of these files are so lightweight, it's a shame to have to manage
them all individually. What if you could keep them all in one big file like
this:

     File 1
    ┌──────────────────────────────────────────────────────────┐
    │┌──────┐  ┌──────┐  ┌──────┐  ┌──────┐  ┌──────┐  ┌──────┐│
    ││Page 1│  │Page 2│  │Page 3│  │Page 4│  │Page 5│  │Page 6││
    ││      │  │      │  │      │  │      │  │      │  │      ││
    ││      │  │      │  │      │  │      │  │      │  │      ││
    │└──────┘  └──────┘  └──────┘  └──────┘  └──────┘  └──────┘│
    └──────────────────────────────────────────────────────────┘

And then you can use yamlchop/chop.py to split them out into individual files
like:

      ┌────────┐
      │YAML    │      ┌──────┐
      │---     │      │      │
      │Markdown│─────►│ HTML │
      │        │      │      │
      │        │      └──────┘
      │--------│ 
      │YAML    │      ┌──────┐  
      │---     │      │      │  
      │Markdown│─────►│ HTML │  
      │        │      │      │ 
      │        │      └──────┘ 
      │--------│
      │YAML    │      ┌──────┐ 
      │---     │      │      │ 
      │Markdown│─────►│ HTML │ 
      │        │      │      │ 
      │        │      └──────┘ 
      │--------│
      │YAML    │      ┌──────┐ 
      │---     │      │      │ 
      │Markdown│─────►│ HTML │ 
      │        │      │      │ 
      │        │      └──────┘ 
      │--------│
      │YAML    │      ┌──────┐ 
      │---     │      │      │ 
      │Markdown│─────►│ HTML │ 
      │        │      │      │ 
      │        │      └──────┘ 
      │--------│
      │YAML    │      ┌──────┐ 
      │---     │      │      │ 
      │Markdown│─────►│ HTML │ 
      │        │      │      │ 
      │        │      └──────┘ 
      └────────┘

## It Uses AI, Right? Okay, Sure.

During this process, if there are any posts for which you have given a title
(the indication to release), OpenAI will step in and write a headline, a meta
description, and a keyword field with extracted keywords. You'll need an
`openai.txt` file with your API key in it in the yamlchop repo folder.
`.gitignore` will keep it from getting committed.
    
     ┌──────────────────────┐     ┌──────────────────────┐
     │title: My Blog Post   │     │title: My Blog Post   │
     │date: 2021-05-09      │     │date: 2021-05-09      │
     │---                   │     │headline: [OpenAI]    │
     │                      │────►│description: [OpenAI] │
     │# My Blog Post        │     │keywords: [OpenAI]    │
     │                      │     │---                   │
     │This is my blog post. │     │                      │
     └──────────────────────┘     │# My Blog Post        │
                                  │                      │
                                  │This is my blog post. │
                                  └──────────────────────┘
    
## Tell Them About the Arrows!

Since the pages have a natural sequential order, that can help with Web
navigation. Imagine the previous next arrows you could build, given these
relationships:

        TOPIC A            TOPIC B            TOPIC C    
     ┌──────────┐   B   ┌──────────┐   C   ┌──────────┐ 
     │          │──────►│          │──────►│          │ 
     │          │       │          │       │          │ 
     │   HTML   │       │   HTML   │       │   HTML   │ 
     │          │   A   │          │   B   │          │ 
     │          │◄──────│          │◄──────│          │ 
     └──────────┘       └──────────┘       └──────────┘ 

In other words, our blog posts get previous and next arrows that have the exact
wording of your title tag in the links leading to each page. From a search
engine optimization standpoint, this is pretty sweet. You can see an example
and read lots of rambling at
[https://mikelev.in/blog/](https://mikelev.in/blog/).

## How do I use it?

1. Create a file called `journal.md` in the `_drafts` folder of your Jekyll
   site. This is where you'll keep all your pages.

2. Add a YAML front-matter block to the top of the file, like this:

        ---------------------- 80 -->
        date: 2021-05-09
        [triple -]

3. Add a Markdown block to the bottom of the file, like this:

        # My Blog Post

        This is my blog post.

4. Repeat steps 2 and 3 for each page you want to add to your site.

5. Only give YAML title fields to the posts you want published. Everything
   else will be considered a draft. OpenAI will write your headline, meta
   description and extract keywords for you and organize categories.

6. Run: `python ~/repos/yamlchop/chop.py -f ~/[path_to_jekyll_repo]/_drafts/journal.md`

7. This will git commit and push your change.

If anything needed OpenAI fields written, the automatic git commit and push
that publishes the site will not occur until the next time you run that
command, assuming you wish to have a chance to review and edit the OpenAI
fields.

## License

This software is provided under a very liberal MIT license that only requires
you to include the license text in any redistribution. See the LICENSE file for
details.

<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/i-m-building-better-blogging-to-replace-a-bygone-era/">I'm Building Better Blogging to Replace a Bygone Era</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/the-price-of-admission-to-prize-rich-environments/">The Price of Admission to Prize-rich Environments</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/ai/'>AI</a></h4></li>
<li><h4><a href='/jekyll/'>Jekyll</a></h4></li>
<li><h4><a href='/yaml/'>YAML</a></h4></li>
<li><h4><a href='/html/'>HTML</a></h4></li>
<li><h4><a href='/seo/'>SEO</a></h4></li>
<li><h4><a href='/static-site-generator/'>Static Site Generator</a></h4></li>
<li><h4><a href='/git/'>Git</a></h4></li></ul>