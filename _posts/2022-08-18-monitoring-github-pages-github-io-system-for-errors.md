---
date: 2022-08-18
title: Monitoring Github Pages github.io System For Errors
permalink: /blog/monitoring-github-pages-github-io-system-for-errors/
headline: Creating a Unique Website Experience with Github Pages and Jekyll Liquid Markdown
description: "I'm creating a unique and awesome website experience for users, using a framework, slice.py, skite.py and more. I'm making pseudo-dynamic pages and working on the blog.md page, learning the workflow and making changes to output markdown into Github Pages Jekyll Liquid markdown `_includes` folder. After figuring it out, I'm ready to share my journey and the lessons I've learned."
keywords: "Github, Pages, github.io, System, Errors, Unique, Awesome, Website, Experience, Users, Framework, slice.py, skite.py, Pseudo-dynamic, Pages, blog.md, Workflow, Changes, Output, Markdown, Jekyll, Liquid, `_include`s, Folder, Journey, Lessons, Learned, CMS, Sub-system, Editing, Git, Commands, Frontmatter, posts-main.md, Desktop, Linux, System,"
categories: git, journey, jekyll, linux
layout: post
---

Okay, continuing operation ELTgd. Put that framework in place on my website for
a unique and awesome experience. Make sure it serves the user as much as me.
It's a big part of building my tribe and fanbase and securing my retirement
gig. A perpetual ability to earn and a practical alternative to savings. Evolve
the CMS quick. 1, 2, 3... 1?

Make slice.py and skite.py easy and fast to advance. Less stuck in concrete and
more flexible and fluid. It's all about the MikeLev.in site right now. Allow
the other sites to break for a bit. You can bring them back to life easily
under the new new system. I believe it was only June that I made the Prev/Next
link CMS sub-system to Github Pages github.io Jekyll Liquid Ruby static site
generator. Copy/paste skite.py and slide.py. Yeah, git but sometimes you need
multiple version in the same repo. I should think about branches, but for
now...

This also sets the stage for pages that are pseudo-dynamic. They're really
static, but something on a scheduler can always update a page.

Okay, the args passing can be simplified, but don't touch it for now. That's
the easiest place to break things. Instead find where blog.md is output and
simply comment it out. Output the same file to \_includes/posts-main instead.
That way you can have a system:

- posts-main.md
- posts-main-linux.md
- posts-main-python.md
- posts-main-vim.md

And then replace main with "old" for the old blog and such. I can eventually
move the old blog over to this system too. That way all the post includes sort
together alphabetically and I can have a different one for every category.

Okay, edit out the git commands so I can rapidly iterate right here releasing
this blog.

Okay now edit out the inserting of the frontmatter

Okay, now create a new blog.md that uses that as an include.

Yup. Now edit the git commands back in and add one for \_includes/\*

Wow, okay that was remarkably easy. ELTgd!

Say a few words about that!

Hello World! You've found a site like no other. I have got to great lengths to
improve my technical abilities in ways that will be forever relevant and of
value in just about any industry, any era and yes, even any life.

Life changes and you can't predict everything. So your tools should be of the
sort that serve you in that sort of situation, meaning any sort of situation.
Can you imagine using VSCode for your journal, resume, todo lists and the like?

Okay, the wait is agonizing for these updates. I at least found the Github
deployment link: https://github.com/miklevin/MikeLev.in/deployments
When it reads "7 hours ago" I know the latest changes have not been pushed out.
I know I can look at the published page itself, but this is more reassuring in
case an error occurs or something. I used to just watch my email for the Github
Pages error messages. This is apparently a big change because it's taking
forever to render.

Okay, think through next steps. This is an amazing approach. It means that
anything I want more-or-less dynamic in nature, I can have macros in vim like I
do for this blogging system, or I can put on a Linux daemon scheduler per all
my recent videos on the topic. It'll be a real connecting of the dots for my
YouTube audience, LOL! They didn't see that coming. Hot topics.

Oh, no wonder it's taking so long! The page build was not successful. Hmmm, can
I not use markdown in an include?

Follow the links! Make sure you can see the errors.

Drill down on Repo.

Find the red-X on the hash. Click it.

Find the red-X AGAIN. Expand it and drill-down on details.

Okay, it was the html comment tags I was using to keep old liquid layout logic
around for reference in my default.html. Not worth it due to rendering errors.
Deleted them. Re-rendering.

Okay, many fewer errors which made it easier to find this one:

    Liquid Exception: Could not locate the included file 'posts-main.html' in any
    of ["/github/workspace/_includes",
    "/usr/local/bundle/gems/jekyll-theme-primer-0.6.0/_includes"]. Ensure it exists
    in one of those directories and is not a symlink as those are not allowed in
    safe mode. in blog.md

Oh! I named it posts-main.md and not posts-main.html. Fix that and re-render.

Okay, I think there's 2 locations that need to me monitored on Github after a
Pages push. The repo's main page will show the red x and the /deployments page
from that repo will show the deployment status (7 hours ago, etc.). So all you
do is go to the repo page and make sure there's no red x, then slap
/deployments at the end of the URL and you can see whether and how long ago it
was deployed. If not something like 1 min ago, then go back and check for the
red x. I can smooth this workflow out soon, but for now... ugh... for now.

Success!

Game changer, for sure.

Output markdown into Github Pages Jekyll Liquid markdown \_includes folder from
applications on your desktop or from a Linux system daemon scheduled service on
a Linux server. You're already doing the former with this blogging system and
the sooner you get to the later the better.

The site's starting to actually look good. Put a "git button" in. It looks
incomplete without it. And that's what responsive design is for anyway. All
those big buttons disappear as it gets smaller, but remain mobile-friendly
clickable links. So expanding main nav... oh that's in \_layouts/default.html,
but I see now it should be externalized into \_includes/mainnav.html.

Nice. Now I can cd into \_includes type:

    vim *nav.html

Okay, now actually put a git.md in place, LOL!


## Categories

<ul>
<li><h4><a href='/git/'>Git</a></h4></li>
<li><h4><a href='/journey/'>Journey</a></h4></li>
<li><h4><a href='/jekyll/'>Jekyll</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li></ul>