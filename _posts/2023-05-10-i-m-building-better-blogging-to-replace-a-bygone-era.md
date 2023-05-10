---
date: 2023-05-10
title: I'm Building Better Blogging to Replace a Bygone Era
headline: Building a New Era of Better Blogging with NeoVim and ASCII Art
description: I'm building better blogging to replace a bygone era of CMSes like WordPress, MovableType, and Squarespace. I'm testing my first plugin in NeoVim to make ASCII art easier and exploring the wonders of static site generators to remove dependence on back-end tools. I'm also looking at the power of YAML, Markdown, and Liquid template systems to create perfectly optimized pages for SEO.
keywords: date, Wed, May, 10, 2023, ASCII Art, NeoVim, Diagrams, Mermaid JS, Rendering, Engine, JavaScript, Online Service, Integration, Github, Gems, CDN, SVG, Pre-Rendering, Markdown, Language, Static Site Generators, WordPress, Joomla, Drupal, CMSes, Google Blogger, Blogspot, MovableType, Squarespace, Web Hosts, Server-Side, Dynamic, Client-
categories: git, wordpress, javascript, vim
permalink: /blog/i-m-building-better-blogging-to-replace-a-bygone-era/
layout: post
---


TLDR: Here's a repo you should go look at that chops long files into short ones
for the Github Pages static site generator Jekyll:
[miklevin/yamlchop](https://github.com/miklevin/yamlchop/). It could change
your life.

## First a Word About Diagramming

Now that I have an ASCII Art plugin in NeoVim, I need to crank out a few
diagrams to assure myself this isn't some big new gotcha undertaking like
Mermaid JS turned out to be. Mermaid had the following flaws:

- Required some sort of rendering engine, be it JavaScript or online service.
- There were multiple ways to integrate it from Github gems and CDN includes to
  SVG pre-rendering, and none of them were great.
- There were multiple ways to say you were making one from the triple backticks
  of Jekyll fencing to the Liquid template curly-percent braces to divs with
  class attributes. Ambiguity, much?
- There was a new markdown language to learn and understand.

All that when you can just draw in ASCII Art and be done with it.

But ASCII art can be tedious so I'm testing my first plugin in NeoVim, and even
vim for that matter. Not even fuzzy-matching and NerdTree enticed me. ASCII art
got me using plugins. And so for YAMLChop/chop, we've got a few key concepts.
First, people must understand the wonders of static site generators. They
remove dependence on WordPress, Joomla, Drupal, and all the other CMSes that
have been around for decades. 

## The Bygone Era of CMSes

Google Blogger/Blogspot-inspired CMSes like WordPress, MovableType and
Squarespace were great for their time, but you have to pay for web hosts and
all the server-side dynamic site features running such a site requires on the
back-end for composing and publishing, even if your published site is
completely static or client-side dynamic without one wit of server-side
processing needed. Worse yet, you're locked into a particular ecosystem and
technology. Migrations are hard and often end up changing your URLs, the
kiss-of-death for sites with existing traffic.

Blogger died. Remember that? Typepad and MovableType were as big as Wordpress
back in the day and are still around, but do you want to be on them? I don't.
Then there's the completely proprietary hosted stuff that makes building
websites wonderfully easy, but now you're locked into a particular vendor and
their ecosystem. You can't just move your site to another host.

## Static Site Generators

Well, my situation wasn't that bad. I was on WordPress, so I was able to do a
1-time export of my site to markdown files. These markdown files could just
basically be arranged into the right location and get automatically republished
without any of the back-end tools. That's where static site generators like
Jekyll, Hyde and Hugo come in. They "render" your site from stripped-down easy
to edit plain textfiles with minimal markup (mark***down***) into a full
website. It's like printing a document. Each time you update a text file
representing published content, you re-render (print) and the new site is
published.

     ┌──────────┐───►┌──────────┐
     │  Content │    │On-the-fly│
     │Management│    │ Generate │
     │  System  │    │ Websites │
     └──────────┘◄───└──────────┘

The older model of websites portrayed in this diagram (WordPress) are more
expensive because they generate the website "on-the-fly" (aside from caching).
WordPress and its ilk need for example some sort of database to be there,
completely walking away from like the main and original advantage and strength
of the web, just serving up HTML files, which are really just text files, from
the drive. It's fast! It's low tech-liability. And there's no vendor or product
lock-in.

## Slicing & Dicing Files

Back in those days I made my first slice and dice system based on something
called XML. It was 1998 and I was at a company called Prophet 21 that made
order processing and inventory software. I was their mere webmaster, and I was
coming from a place where I had just programmed a whole order processing and
inventory system from scratch in VBScript. Google was brand new on the scene
and I realized the web was the future, and the massive value of manipulating
links, especially in blogging software. So I made one that transformed XML
files with a stylesheet language that existed for that purpose, and I could
have taken over the world if I was more motivated, clever, and simplified this
rather awkward but awesome tech.

XML failed (for all intents and purposes) because it didn't make things that
much simpler than just raw HTML, especially as CSS came into the picture
allowing the stylizing process to be layered in as a separate concern (file).
So I moved onto other things like pretending to be some high fallutin vice
president of a public relations firm in New York City, but my heart was still
in slicing & dicing files. A file looked and would output something like this:


              ONE SOURCE FILE                   MULTIPLE OUTPUT FILES
     ┌──────────────────────────────┐      ┌──────────────────────────────┐ 
     │ <root>                       │      │   <slice>                    │
     │   <slice>                    │      │     <dice>Contents 1</dice>  │ 
     │     <dice>Contents 1</dice>  │─────►│     <dice>Contents 2</dice>  │ 
     │     <dice>Contents 2</dice>  │      │     <dice>Contents 3</dice>  │ 
     │     <dice>Contents 3</dice>  │      │   </slice>                   │ 
     │   </slice>                   │      └──────────────────────────────┘
     │   <slice>                    │      ┌──────────────────────────────┐
     │     <dice>Contents 4</dice>  │      │   <slice>                    │ 
     │     <dice>Contents 5</dice>  │      │     <dice>Contents 4</dice>  │ 
     │     <dice>Contents 6</dice>  │─────►│     <dice>Contents 5</dice>  │ 
     │   </slice>                   │      │     <dice>Contents 6</dice>  │
     │ </root>                      │      │   </slice>                   │ 
     └──────────────────────────────┘      └──────────────────────────────┘ 

Now imagine that being able to be extended over segments of your site of any
page-length. All that site section's content could go in one file. It has a
strong filename convention, so you can easily find the file you want to edit
and it lives in a folder of only as many files as you have site sections.

## But wait, there's more!

![But Wait There's More Billy Mays](/assets/images/but-wait-theres-more-billy-mays.jpg)

Those arrows I talk about so much in previous posts here had (still have) so
much utility. Even today it's hard to construct such previous/next navigational
devices that make it so clear what the next topic you're going to be reading
about when you "flip pages" is going to be. The non-linear aspect of the web
makes it hard to do this. You can't just say "next" and "previous" because
there's no guarantee that the next page is going to be the next page in the
sequence of pages you want to read. 

## Yes, I Fixed The Non-Linear Aspect of The Web

I fixed that terrible user experience aspect of the Web (back in 1999) and it
didn't hurt that this very process *coincidentally* happened to produce
***perfectly optimized pages for SEO***. Get it? All the right keywords in all
the right anchor text. Page B is ***buoyed*** by the links from page A and C.
And likewise with A and C. Only the beginning and end of sequences aren't
buoyed twice, but page A usually gets the link to drop you into the sequence,
and you could always put a table of contents or index after C. It was a perfect
system. It still is.


           TOPIC A                      TOPIC B                     TOPIC C
    ┌───────────────────┐   B   ┌───────────────────┐   C   ┌───────────────────┐ 
    │ <slice>           │──────►│ <slice>           │──────►│ <slice>           │ 
    │   <dice>P1</dice> │       │   <dice>P4</dice> │       │   <dice>P7</dice> │ 
    │   <dice>P2</dice> │       │   <dice>P5</dice> │       │   <dice>P8</dice> │ 
    │   <dice>P3</dice> │   A   │   <dice>P6</dice> │   B   │   <dice>P9</dice> │ 
    │ </slice>          │◄──────│ </slice>          │◄──────│ </slice>          │ 
    └───────────────────┘       └───────────────────┘       └───────────────────┘ 
    
The main problem with this system is that I am me. I did not promote it. I did
not turn it into a product. It was not Ruby on Rails. It was not Drupal. It was
a time long before Jekyll and Hyde. And XML/XSLT was too complex and convoluted
for the masses, though little did I know it at the time. I even wrapped it in a
nice web user interface (built in ASP) that allowed you to edit the content
right in the browser without dealing with XML. But being based on asp as it was
right when Ruby on Rails was coming out and me not being clued in, well...
fizzle.

There were technical reasons too this was not great. The only XML parser with
the xsl-document directive I needed was in a Java product called Saxon, and I
was just starting to hate Java very public static void. My system may have been
ahead of its time, but like so many things that are, it was not meant to be. It
was nothing like the Python world of today that suits my vibe, and combines
YAML and Markdown in such a perfect-storm way.

## YAML & Markdown, A Match Made in Heaven
    
I'm getting tired of writing about history, and you're probably getting tired of
reading about it. I'll try to wrap up quickly. XML mixed markdown and content in
a way that was detrimental to the whole process. Over time, Daring Fireball
broke out Markdown as a simplified HTML in the same way the Python folks did
with ReStructuredText (RTF) before him, but he marketed it well with a seminal
blogpost that got a lot of traction.

Fast forward a bunch more years and JSON hit, popularizing easy-data formats but
it was (and still is) like XML in the fact it's got all those curly braces that
make it hard to type, hard to look at, and was not really to Data what Markdown
was to HTML, though people will tell you it was/is. No, YAML came along to be
that. 

Is YAML a markup language? No, it's a data serialization language but everyone's
going to tell you it's a markup language. That's why they named it YAML, to
remind you YAML Ain't Markup Language. It is not Yet Another Markup Language as
some folks will say. That's because they misunderstand the often arbitrary and
subtle but still remarkably important difference between data and markup.
    
Oh, were you tired of reading? Too bad. Let's hit this history lesson home. When
people wanted to give up their CMSes in favor of just using a static site
generator, they put YAML at the top of the file and called it `front matter` and
put Markdown at the bottom and called it content. Just add a template and style
sheet system copied from the Python world again of course in the form of Jinja2,
but called Liquid, because the Ruby community has Drupal-envy, and you've got
Jekyll.

Of course the Python community said "Hey, we can do that too!" and you got Hyde
to go with Jekyll. But then Hyde was abandoned because slamming such systems
out in Python is easier than supporting them in the long-term. There's also
Pelican and probably a bunch of others because everyone's favorite sport in
Python is to just keep slamming out infinite varieties of such things because
Python gets you like 80% of the way there by just being Python. But this is
what they're all basically doing:
    
    ┌─────────────────┐          ┌────────────┐ 
    │YAML Front Matter│          │ HTML + CSS │ 
    │---              │  Jekyll  │ Head       │ 
    │Markdown Content │─────────►│ Body       │ 
    │                 │          │ yadda      │ 
    │                 │          │ yadda      │ 
    └─────────────────┘          └────────────┘ 

Which is so simple, we can fill in real data even on a little diagram like this,
haha!

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

Think on this. Absorb the beauty of static site generators. By doing this ahead
of time, your webserver could be old fashioned Apache or Nginx or even IIS.
There are no technical back-end requirements. We all host it on Github because
thank you uncle Microsoft, but we don't have to. The files can be plopped
anywhere. 

Also, the amount of work you put into creating and managing content goes down
too. You can type a text file, right? For the mere cost of learning how to be
competent in a text editor, something you should be doing anyway for 1000
different reasons, you no longer are dependent on WordPress, Drupal,
Squarespace, or any one of dozens of other CMSes that are going to be
abandoned, make you pay and pay, or have so many PHP security holes that you're
going to get hacked.

## Lower Your Tech Liability with Text Files

If you can type into a text file, you can maintain a whole site with static
site generators. There is a template system you need to use. The template
systems like Liquid are admittedly the weakness here (which I don't really
diagram), but they have these curly-brace syntax that goes back to before there
were really even CMSes.

My first experience with such things was a Microsoft product called IDC/HTX,
probably cica 1997 and was Microsoft's precursor response to PHP. It used pointy
brackets with the percents instead of curly braces, but all these template
languages are the same. This was before even Active Server Pages where the .idc
files were database connectors and the HTX files were these template things. It
was really raw primitive stuff, but shows that the template languages are all
pretty much the same and transforms could always move you from one to another:
Jinja2, Liquid, Marko, whatever. It's the least lock-in you could hope for.

And on a final note, this static site generator trick was perfect for my old
XML/XSLT-based slice & dice system, but for all those individual text files you
needed everywhere. Another organization nightmare!

      File 1    File 2    File 3    File 4    File 5    File 6
     ┌──────┐  ┌──────┐  ┌──────┐  ┌──────┐  ┌──────┐  ┌──────┐ 
     │Page 1│  │Page 2│  │Page 3│  │Page 4│  │Page 5│  │Page 6│ 
     │      │  │      │  │      │  │      │  │      │  │      │ 
     │      │  │      │  │      │  │      │  │      │  │      │ 
     └──────┘, └──────┘, └──────┘, └──────┘, └──────┘, └──────┘

Why, when you can just make them 1 file like this:

     File 1
    ┌──────────────────────────────────────────────────────────┐
    │┌──────┐  ┌──────┐  ┌──────┐  ┌──────┐  ┌──────┐  ┌──────┐│
    ││Page 1│  │Page 2│  │Page 3│  │Page 4│  │Page 5│  │Page 6││
    ││      │  │      │  │      │  │      │  │      │  │      ││
    ││      │  │      │  │      │  │      │  │      │  │      ││
    │└──────┘  └──────┘  └──────┘  └──────┘  └──────┘  └──────┘│
    └──────────────────────────────────────────────────────────┘

And you just internally organize it with... well...

     ┌────────┐
     │YAML    │
     │---     │          I'm building better blogging     
     │Markdown│          To replace a bygone era          
     │        │          Where your CMS is flogging       
     │        │          You to take up something clearer,
     │--------│          So you catalog your cat tails    
     │YAML    │          In one file for the hashing      
     │---     │          Using YAML for the data          
     │Markdown│          And then Jekyll for the lashing. 
     │        │
     │        │
     │--------│
     │YAML    │
     │---     │
     │Markdown│
     │        │
     │        │
     │--------│
     │YAML    │
     │---     │
     │Markdown│
     │        │
     │        │
     │--------│
     │YAML    │
     │---     │
     │Markdown│
     │        │
     │        │
     │--------│
     │YAML    │
     │---     │
     │Markdown│
     │        │
     │        │
     └────────┘

A conclusion? Hitting it home? Well, this is an article about ASCII diagrams,
isn't it? Because nobody but me is ever going to [use this
system](https://github.com/miklevin/yamlchop/), because it's time has come and
gone.

Or is it that it's time is just arriving as people clobbered by the confusion
of the modern world could find a bit of peace and respite in one file for life
in which they can do personal journaling, or optionally publish. Or do as I do,
two versions, one for the public and one for yourself.

Oh, and sure you can still publish websites with this, keeping each site
section as one file and manage a sprawling vast website with all sorts of
prescribed linear user experiences lurking within, waiting to please your
visitors with that wonderful keyworded previous/next arrow navigation that is
as relevant today as it ever was, albeit not quite so super-juicy a secret
weapon for SEO as it once was.

<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/switch-hardware-regularly/">Switch Hardware Regularly</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/now-the-github-miklevin-yamlchop-repo-has-a-readme-md/">Now The Github miklevin/yamlchop Repo has a README.md</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/git/'>Git</a></h4></li>
<li><h4><a href='/wordpress/'>WordPress</a></h4></li>
<li><h4><a href='/javascript/'>JavaScript</a></h4></li>
<li><h4><a href='/vim/'>Vim</a></h4></li></ul>