---
date: 2023-05-04
title: Why Markdown? Why YAML? Why They're Great Together!
headline: I'm Combining Markdown and YAML to Create a Text File for Life!
description: In this article, I discuss why I chose to use Markdown and YAML together for my 1-textfile-for-life system. I explain why Markdown is popular and why YAML is a great serialization format that is human-readable. I also discuss the benefits of using a static site generator like Jekyll and how YAMLchop can help with creating a 1000-page site from 1 file. Finally, I explore how to render the markdown.
keywords: Markdown, YAML, Python, RST, Daring Fireball, Content Management Systems, Github, README.md, README.rst, Serialization, JSON, XML, EDI, Electronic Data Interchange, Binary, JavaScript, Web Development, YAML Ain't Markup Language, Structure, Curly-Braces, EDS, GNU, Unix, Gatekeeping, Proprietary Formats, Vendors, Human-Readable, JSON Data Format
categories: python, git, linux, vendor, yaml, javascript, gnu, web development, json
permalink: /blog/why-markdown-why-yaml-why-they-re-great-together/
layout: post
---


It was a pretty big decision for me professional-wise to work on a MOZ draft
article here in my journal. It's not the fact that it gets published, but it's
the fact that it's here in my 1-textfile-for-life where I'm focusing all my
hocus pocus. While it's merely a text file devoid of any inherent features per
say, it's full of formatting and process.

Markdown, lovely markdown. Sure, Python's RST (reStructuredText) existed before
it, but there's always somewhat better tech that comes first, before the one
that gets some small detail correct or is marketed better, and usually a
combination of both. RST didn't have [Daring
Fireball](https://daringfireball.net/projects/markdown/)

Most content management systems worth their salt support Markdown these days,
even where RST was first supported. The Github README.md's are like that. I
mean, who ever hears of a README.rst anymore, even though that's where the cool
feature of putting a README file that turns into the Github homepage for the
repo came from. And so it is with the wonderful perfect storm combination of
Markdown and YAML.

I talk a lot about YAML. It lives very well with markup languages, even thought
it is not a markup language. In fact, the very name is one of those ubergeeky
self-referential acronyms like GNU standing for GNU is not Unix. YAML stands
for YAML Ain't Markup Language. Hahaha!

Have you heard the term serialization? It's a fancy way of saying "save to
file". If your data is already text, saving to a file is a no-brainer. But if
your data is, well... data, then you have some more stringent rules you have to
follow in order to preserve whatever the "structure" of the data is. We've all
had an opportunity to see the JSON data format of late because it too has taken
the world by storm. It's full of structure. Those curly-braces imply it.

Serializing is the process of saving the data while preserving the structure.
When you look at JSON data, it looks exactly like text with curly brackets, so
it's very easy to imagine you can just save that to a file. And you can!
Because JavaScript is so popular because of Web development, the serialization
realization swept across the world, replacing such prior tech as XML, and an
even older high falutin' tech called EDI (Electronic Data Interchange) that
wasn't even text, but binary. Data interchange can choose to be text or binary,
so the serialization process can result in files even less human-readable than
JSON.

But YAML is a serialization format that is human-readable. Such formats as YAML
come into existence for the very reason that gatekeeping is a thing. Vendors of
prorietary formats want to keep you locked into their products, so they make
their formats as difficult to read as possible. In the days of EDS, you
basically had to be an engineer to do what junior webdev folks routinely do
today. XML knocked EDI down a peg, and JSON knocked XML down a peg. YAML is
precisely in that same spirit. But there's a markdown vs. data thing going on.

What is data? What is information? Well, basically everything! So why can't we
use JSON for everything since it became so popular? The answer is that you can
only stuff so much into a single field. Say you have an entire webpage of
content that goes into the "content" field of a JSON object. That's a lot of
text. Imagine scrolling through that in a text editor. 

As friendly as JSON is, it suddenly becomes unfriendly, and you have all sorts
of encoding issues. You can't use the same characters in the content that you
use in the JSON serialization. So you have to escape them. And then you have to
unescape them when you want to read them. And then you have to escape them
again when you want to save them. And then you have to unescape them again when
you want to read them. And it all looks ugly to boot!

And so I dealt with all this mess. I took the two perfect modern formats that
work great together, and in fact are already being used in precisely this
capacity already (I didn't invent this) as the basics for the Jekyll static
site generator (SSG). Static site generators are awesome. If a site doesn't
need real-time dynamic features (i.e. a database), then you can just generate
the HTML files of the site and serve them up. It's fast, it's secure, and it's
generate the content, and then use the SSG to generate the HTML files.

The Jekyll SSG is written in Ruby, and it's the most popular SSG out there. I
almost didn't use it because I'm not a Ruby person. But I don't have to look at
or see the Ruby code. Would I not use the Web because I hate JavaScript? No!
You lean into the strengths of your tools, and even when there's reprehensible
innards, you can still use the tool. These are not the types of tools that "get
into your muscle memory", except perhaps the Liquid templating language that
Jekyll uses. But even that is not a big deal.

Anyhoo, is this digression? NO! I love Markdown and I love YAML. Did I say why
YAML beats JSON for this purpose? No? Okay, imagine JSON without the curly
braces because 9 out of 10 times, you can infer them. That's YAML. And if that
bothers you and you want more explicitness, that's TOML. TOML is YAML, still
without the curly braces, but with a bit more structure. But for me, YAML hits
the sweet spot. It just looks like a stacked list. This is a dictionary with an
embedded list:

```yaml
adict:
  - item1
  - item2
  - item3
```

Get it? It's so friggin easy and beautiful. And so that's the YAML part of my
new YAMLchop repo. What about the chop part of YAMLchop?

Well, whereas Jekyll would have you create 1000 little text files for a
1000-page site, YAMLchop would only have you create 1 text file, with lots of 
separators delimiting the pages. And then YAMLchop would chop it up into 1000
files. And then it would generate the HTML files formatted exactly the way
Jekyll wants it. BAMO WAMO! 1000-page site, with you only having to manage and
maintain 1 file.

Okay, so despite my love for this system, the fact that to see it as rendered
markdown I actually have to publish the site is a problem. But there's no doubt
that I work better here than in Google Docs. It's awful to work on those
proprietary systems like Microsoft Word and Google Docs when your actual
competitive advantage comes from a text editor like vim or emacs. So tiny
chisel-strike project to address this?

Hmm, first-off, keep your Bing/Bard observations published where they are now.
If damage is done, I might as well keep it there. But that leaves the challenge
of rendering the markdown and pushing it into Google Docs. Think it through!

<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/an-ode-to-the-status-quo/">An Ode to The Status Quo</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/added-support-for-arbitrary-jekyll-yaml-fields/">Added Support for Arbitrary Jekyll YAML Fields</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/git/'>Git</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li>
<li><h4><a href='/vendor/'>Vendors</a></h4></li>
<li><h4><a href='/yaml/'>YAML</a></h4></li>
<li><h4><a href='/javascript/'>JavaScript</a></h4></li>
<li><h4><a href='/gnu/'>GNU</a></h4></li>
<li><h4><a href='/web-development/'>Web Development</a></h4></li>
<li><h4><a href='/json/'>JSON</a></h4></li></ul>