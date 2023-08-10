---
date: 2022-05-01
title: Pushing Blogslicer to PyPI (From Jupyter Notebook)
headline: Successfully Releasing Packages Built in Jupyter Notebooks to PyPI with nbdev
description: I successfully created a pattern for releasing packages built in Jupyter Notebooks into PyPI, using nbdev from Fast.ai. I pushed my package, Blogslicer, to PyPI, but still have more work to do before I can add it to my blog release script. Read more to find out how I did it!
keywords: PyPI, Jupyter Notebook, nbdev, Fast.ai, Blogslicer, package, command-line, parameterized, release, script, version, docs, library, commit, upload, python, interpreter
categories: pypi, jupyter, python, nbdev, linux
permalink: /blog/pushing-blogslicer-to-pypi-from-jupyter-notebook/
layout: post
group: blog
---


I hate smart quotes. I don't think they're good for SEO (search engine
optimization). I adhere to a principle called "The Weakest Link In The Chain".
Unfortunately such a good metaphor has been tarnished by that awful game show
of the same name years back, but the concept will last longer than memories of
that atrocity, so I will keep using it.

Every Little Thing gets done, or ELTgd, as I'm currently acronym'ing it. I get
smart quotes when I copy/paste out of other more word-processing oriented
software into vim where I blog. There's many ways I could address fixing this,
but I have a release script that slices & dices my single-long-page text files
that I blog in (one journal for life, one journal per website) into separate,
individually optimized pages.

I actually don't sweat the optimization too much. I let my confidence that I
will gradually massage and organize sites over time allow me to write at
full-speed. And I do write fast. My typing speed isn't really that fast.
Neither is my thinking speed. It's just that both are decent speed and in sync
with each other, so I write just a bit slower than I can talk, and that means I
can publish a lot... a whole lot, and so I do... now... as a result of
operation ELTgd.

This particular blog post on Pythonic Ally is to see how quickly I can get a
package called "dumbquotes" into PyPi. For you see, the next step in my
blogslicer (also soon to be in PyPI) is to strip out smart quotes, and I don't
see why that can't and shouldn't be a separate package of potentially broader
use than blogslicer if made separate.

Okay, so before I do dumbquotes, I want to get blogslicer into PyPi.org. I use
a developer tool called nbdev from the illustrious Australian and all around
cool guy, Jeremy Howard of Fast.ai. If you're into Machine Learning, I suggest
all his stuff over the competing Google TensorFlow because with TensorFlow, all
things lead to the vendor-trap. But with fast.ai, all roads lead to generic
GPU-based less vendor dependt goodness.

But I digress. I've already refined blogslicer a bit in Github. Making it pip
installable should be a breeze. 1, 2, 3... 1?

Quickly edit the index.ipynb which gets turned into the README.md which becomes
the Github repo homepage documentation. Important! Okay, done but my trick for
switching between Notebook mode and command-line mode arguments is causing an
error on:

```python
#hide
from blogslicer.core import *
```

So I'm just commenting out that import and tabling the issue for now. Next?
Look at my release system. Even though I don't NEED to bump the version, that
is usually my next step. And I'm doing everything manually first. Then I'll put
it into my release script.

```bash
$ nbdev_bump_version
Old version: 0.0.1
New version: 0.0.2
```

Okay, that went off without a hitch. Next!

```bash
$ nbdev_build_docs
```

...oops! A glorious error, probably related to the above problem importing
blogslicer.core into the index.ipynb. nbdev has its weirdness. It'll just be a
matter of practice, but I'll skip it for now. Next!

```bash
$ nbdev_build_lib
Converted 00_core.ipynb.
Converted index.ipynb.
```

Okay, that ran without a hitch and that's the important one. Next!

```bash
nbdev_clean_nbs
```

No output, but that means it ran well. Always a good idea before:

```bash
git commit -am "Preparing for first PyPI release"
(output removed)
(py310) ubuntu@LunderVand:/mnt/c/Users/mikle/github/blogslicer$ git push
(output removed)
```

Next!

```bash
$ mkdir dist
$ python3 -m build
(lots of output removed)
Successfully built blogslicer-0.0.2.tar.gz and blogslicer-0.0.2-py3-none-any.whl
```

And finally...

```bash
$ twine upload dist/*
Uploading distributions to https://upload.pypi.org/legacy/
Uploading blogslicer-0.0.2-py3-none-any.whl
100% ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 12.6/12.6 kB • 00:00 • 461.3 kB/s
Uploading blogslicer-0.0.2.tar.gz
100% ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 13.7/13.7 kB • 00:00 • 718.8 kB/s

View at:
https://pypi.org/project/blogslicer/0.0.2/
```

Success! But without the documentation successfully built, both the Github repo
page and PyPi package page contain a generic nbdev template. Ugh! That can't
stand. Okay, diagnose that quickly. No rabbit holes!

Okay, I was able to uncomment the index.ipynb package import by changing the
Jupyter environment check to control where the arguments come from like so:

```python
if hasattr(__builtins__, "__IPYTHON__") or __name__ != '__main__':
    from IPython.display import display, Markdown

    h1 = lambda text: display(Markdown(f"# {text}"))
    h2 = lambda text: display(Markdown(f"## {text}"))
    h3 = lambda text: display(Markdown(f"### {text}"))

    folder_name = "../pythonically"
    blog_title = "Pythonic Ally Blog"
    blog_slug = "blog"
    author = "Mike Levin"
else:
    h1 = lambda text: print(f"# {text}")
    h2 = lambda text: print(f"## {text}")
    h3 = lambda text: print(f"## {text}")

    aparser = argparse.ArgumentParser()
    add_arg = aparser.add_argument
    add_arg("-p", "--path", required=True)
    add_arg("-t", "--title", required=True)
    add_arg("-s", "--slug", required=True)
    add_arg("-a", "--author", required=True)
    args = aparser.parse_args()

    folder_name = args.path
    blog_title = args.title
    blog_slug = args.slug
    author = args.author
```

I know it worked without breaking the command-line (using "python" in the
command) input because you're reading this. And so I've finally completed my
pattern for creating packages in Jupyter Notebooks (really, JupyterLab) and
having them also work as parameterized command-line tools releasable into PyPI.
I still have a little work to go to make it work without the python interpreter
prefix. I've got some research to do on how pip installing results in
CLI-runnable commands.

So now onto dumb-quotes. I'm going to hold off on putting the actual PyPI
release into my everyday frequently used blog release script. I thing that may
cause more harm than good. But definitely a topic for later is bringing the
PyPI package up-to-date with my fast-and-furious daily code tweaking.

Okay, so one more time, but from scratch (blogslicer was already well
underway).


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/making-youtube-embeds-100-width-but-fixed-aspect-ratio-height/">Making YouTube Embeds 100% Width But Fixed Aspect Ratio Height</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/pushing-blogslicer-to-pypi-from-jupyter-notebook/">Pushing Blogslicer to PyPI (From Jupyter Notebook)</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/pypi/'>PyPI</a></h4></li>
<li><h4><a href='/jupyter/'>Jupyter</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/nbdev/'>nbdev</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li></ul>