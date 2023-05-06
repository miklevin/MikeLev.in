---
date: 2022-05-02
title: Templatizing Google Analytics MEASUREMENT ID in Jekyll Github Pages
headline: Creating a Templatized System for Google Analytics MEASUREMENT ID in Jekyll Github Pages
description: "I have developed a system using Jekyll and Liquid template language to templatize the Google Analytics MEASUREMENT ID for my websites. To keep track of them, I wrote Python scripts to parse through the lines in sites.txt and create a `_config.yml` file for each website. With this system, I have a master list of my sites and a quick way to update the information."
keywords: "Google Analytics, MEASUREMENT ID, Jekyll, Github Pages, Liquid template language, Python, sites.txt, `_config.yml`, blogging, make_helpers.py, gaids.txt, loop, master list, update"
categories: github pages, python, jekyll, loop, google analytics, blogging
permalink: /blog/templatizing-google-analytics-measurement-id-in-jekyll-github-pages/
layout: post
---


Okay, wow. To say that I'm profoundly happy with my new blogging and release
system would be an understatement. Over the past week everything from slicing
and dicing the single-long-journal text-files that I keep, to stylizing them
into HTML with the Jekyll template system, to the arrows that let you navigate
between posts, to the release system and how it integrates into vim.

It's all just so sweet. In tribute to Alan Rickman:

> Now I have a machine gun... Ho, Ho, Ho.

Yep, this stuff certainly belongs on MikeLevinSEO.com. I don't know how I ever
started out with WhatsaMetaFor.io and PythonicAlly.com. Those sites are for
such different things. This is where I talk Jekyll, blogging software and
stuff. Okay, next steps? The one common component across sites that I still
have in-place on a per-site basis that should be templatized is default.html.

The default.html is very special in the Jekyll blogging system. It is where
most of the customization action occurs. It's humorous to me that the template
system for Jekyll is called Liquid and its logo is just like the vial the Dr.
Jekyll drinks to become Mr. Hyde. I wonder how many people get the reference. I
really have to read that book. Anyhoo...

The thing I had better read first is the Liquid Documentation. Interesting!
It's a Shopify technology. https://shopify.github.io/liquid/basics/introduction/

There's Objects and Tags. Strange terminology "Tags" for something that
contains conditional logic that's used for blogging systems that has an
entirely other meaning for tags. Colliding namespaces. Whatever. Ugh, another
weird terminology is "Filters" which use the pipe-symbol (|) to pipe together
bits of logic. Okay, I get it. A pipe is a filter. Ugh, system-inventors and
their convoluted bucking of the Unix terminology they're stealing from. Okay.

What I really need to do now is to use the exact same default.html across all
sites. I need to make sure that the Liquid curly-percent-braces notation, what
they call Tags, can be used at this phase of templating. I see that I have SEO
tags in there which is doing exactly this. It's also what I'm using for my
youtubePlayer.html tag. That gives me the way, for sure. But I turn it upside
down.

Take one of the default.html's which has a particular site's Google Analytics
code on it and put it into my helper/template folder... okay, done. Now load
that into vim and replace occurrences of the MEASUREMENT ID with an include
command just like is used for the YouTube embed:

    {{ "{% include youtubePlayer.html id=foo " }}%}

Normally, the variable bit would be where foo appears. However it seems
perfectly reasonable to use a tag like this in default.html the same way the
SEO tag is used, but like this:

    {{ "{% include gaid.txt " }}%}

Oops, that's a good idea, but an even better idea is to see what can be done
with the \_config.yml file. https://stackoverflow.com/questions/12062766/jekyll-use-config-yml-values-in-the-html

It appears that every template has a site variable that contains things from
the config file and you can arbitrarily set stuff in there like my_setting:
"string". So first I want to test it on a single site instance. Then I want to
incorporate it into that make_helpers.py file I just made today at the
beginning of the release process.

Okay, and it worked like a charm! I wish it was easier to paste Jekyll
templates in here. The Liquid template language would all have to be escaped
and neutralized, which I can see from the couple of places I did it above is a
pain. I could probably write a Python function to do it during the slice & dice
procedure, but I still like to publish long-page versions and it feels like a
deep rabbit hole. Back out! 80/20-friggin' rule.

Okay, now that default.html is copied into my common helpers/templates folder,
I can start thinking about spinning out a custom \_config.yml for each site.

I would love to use my sites.txt file and keep only one master list of the
sites in the release system, but I don't feel like parsing lines in the bash
script. Doing it in Python's a breeze. Okay, done.

I had to make another file with more detail than sites.txt. I call it
gaids.txt:

    G-RX2D1N1P2Y MikeLev.in             Mike Levin
    G-RNSSPXFB53 MikeLevinSEO.com       Mike Levin SEO
    G-K5EQ2QQG5D PythonicAlly.com       Pythonically
    G-ZNMVJFLRD2 LinuxPythonvimgit.com  Linux, Python, vim & git
    G-L7L2XR3J2G MikeAtEleven.com       Mike At Eleven
    G-9YEC9X0GDW TardigradeCircus.com   Tardigrade Circus
    G-L3QGENNVJ3 RemovableFinger.com    Removable Finger
    G-K86B8JW5Q5 Mike-Levin.com         Mike Levin Dot Com
    G-TJRX2PSWKT LunderVand.com         LunderVand
    G-HL9DEK1TSG WhatsaMetaFor.io       What's A Meta For
    G-N4RYB5DCV4 GuerillaTech.com       Guerilla Tech
    G-YXNMZY6Z6F TicTacUFOSightings.com Tic Tac UFO Sightings
    G-1JFHT28DRL PythonicAlly.org       Your Pythonic Ally
    G-45KYH6XTTX Pipulate.com           Pipulate
    G-0H19QDRNTL Levinux.com            Levinux

And this file works against that:

```python
with open('gaids.txt') as fh:
    for line in fh:
        if line:
            gaids = line.rstrip().split()
            code = gaids[0]
            apex = gaids[1]
            title = ' '.join(gaids[2:])
            title = f'{title} | {gaids[1]}'
            aconfig = f'''theme: jekyll-theme-hacker
author: Mike Levin
permalink: /:slug/
gaid: {code}
title: {title}'''
            print(aconfig)
            print()
            with open(f'../{apex}/_config.yml', 'w') as fw:
                fw.write(aconfig)
```


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/bash-script-loading-external-files/">Bash Script Loading External Files</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/templatizing-google-analytics-measurement-id-in-jekyll-github-pages/">Templatizing Google Analytics MEASUREMENT ID in Jekyll Github Pages</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/github-pages/'>Github Pages</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/jekyll/'>Jekyll</a></h4></li>
<li><h4><a href='/loop/'>Loop</a></h4></li>
<li><h4><a href='/google-analytics/'>Google Analytics</a></h4></li>
<li><h4><a href='/blogging/'>Blogging</a></h4></li></ul>