---
date: 2022-05-01
title: Writing a Bash Loop Script for Jekyll
headline: Successfully Completed Bash Loop Script for Jekyll to Edit 10 Sites Simultaneously
description: I wrote a Bash loop script for Jekyll to edit 10 sites at once, centralizing the identical files. I tested the script by adding line-height to style.scss, and it was successful. I then pushed the changes to all of my sites using git commands, and I'm excited to share the results with you!
keywords: Bash, Loop, Script, Jekyll, Edit, Sites, Centralizing, Identical, Files, Line-Height, Style.scss, Push, Changes, MikeLevin, Pythonically, Linuxpythonvimgit, Mikeateleven, Tardigradecircus, Removablefinger, Mike-Levin, Lundervand, Pipulate, Whatsametafor, Guerillatech, Git, Add, Commit
categories: python, jekyll, linux, change, loop, pipulate, git
permalink: /blog/writing-a-bash-loop-script-for-jekyll/
layout: post
group: blog
---


Editing 10 sites at once that are all actually in-play requires editing a lot
of files at once, quite often identical. So long as they are identical, I
should really centralize them. I can always break them into 10 different
individually managed files anytime I want. But until then, cross-cutting
changes will be a breeze. I'm already using a "helper" repo for this purpose...
almost. I just need to carry through on the concept. Every little project gets
done! 1, 2, 3... 1?

List the files you'll be doing this with and put a copy in place.

- \_config.yml (will break much of MikeLev.in, but fix as you go)
- \_includes/youtubePlayer.html
- \_layouts/post.html
- assets/css/styles.scss

I'll even be able to do \_layouts/default.html once I understand how to break
out the Google Analytics ID with an include similar to the way I do the YouTube
wrapper, but it's one more layer lower in the rendering process so I have to
think it through. Go ahead with those other ones and keep a sharp eye om
MikeLev.in because it's so different from the others.

```bash
for SITE in MikeLevin pythonically whatsametafor linuxpythonvimgit mikeateleven tardigradecircus removablefinger mike-levin lundervand pipulate guerillatech
do
    rm ./$SITE/_posts/*
    cp ./helpers/_config.yml ./$SITE/
    cp ./helpers/style.scss ./$SITE/assets/css/
    cp ./helpers/post.html ./$SITE/_layouts/
    cp ./helpers/youtubePlayer.html ./$SITE/_includes/
done
```

Okay wow, that'll change things. Think! Ready, fire, aim! Why not? It's Sunday
morning and I have time to fix anything that breaks. Here's my entire current
release script, which I call gall.sh... LOL! I've got some gall.

```bash
#    _     _           _
#  _| |__ | | __ _ ___| |_
# (_) '_ \| |/ _` / __| __|
#  _| |_) | | (_| \__ \ |_
# (_)_.__/|_|\__,_|___/\__|

clear

for SITE in MikeLevin pythonically linuxpythonvimgit mikeateleven tardigradecircus removablefinger mike-levin lundervand pipulate whatsametafor guerillatech
do
    rm ./$SITE/_posts/*
    cp ./helpers/_config.yml ./$SITE/
    cp ./helpers/style.scss ./$SITE/assets/css/
    cp ./helpers/post.html ./$SITE/_layouts/
    cp ./helpers/youtubePlayer.html ./$SITE/_includes/
done

figlet slicing blogs...
cd blogslicer
nbdev_clean_nbs
nbdev_build_lib
git commit -am "Updating all"
git push

python ./blogslicer/core.py -a "Mike Levin" -p "../MikeLevin" -t "Mike Levin's Blog" -s "blog"
python ./blogslicer/core.py -a "Mike Levin" -p "../pythonically" -t "Pythonic Ally Blog" -s "blog"
python ./blogslicer/core.py -a "Mike Levin" -p "../whatsametafor" -t "What's A Meta For Blog" -s "blog"
python ./blogslicer/core.py -a "Mike Levin" -p "../linuxpythonvimgit" -t "Linux, Python, vim & git Blog" -s "blog"
python ./blogslicer/core.py -a "Mike Levin" -p "../mikeateleven" -t "Mike's At Eleven Blog" -s "blog"
python ./blogslicer/core.py -a "Mike Levin" -p "../tardigradecircus" -t "Tardigrade Circus Blog" -s "blog"
python ./blogslicer/core.py -a "Mike Levin" -p "../removablefinger" -t "Removable Finger Blog" -s "blog"
python ./blogslicer/core.py -a "Mike Levin" -p "../mike-levin" -t "Mike-Levin.com Blog" -s "blog"
python ./blogslicer/core.py -a "Mike Levin" -p "../lundervand" -t "Lunervand Blog" -s "blog"
python ./blogslicer/core.py -a "Mike Levin" -p "../pipulate" -t "Pipulate Blog" -s "blog"
python ./blogslicer/core.py -a "Mike Levin" -p "../guerillatech" -t "Guerilla Tech Blog" -s "blog"
cd ..

figlet vim
cp ~/.vimrc ./vim/
cd ./vim
git commit -am "Updating all"
git push
cd ..

figlet helpers
cp ./all.sh ./helpers/
cp ./gall.sh ./helpers/
cp ./defaults.sh ./helpers/
cp ./homepages.sh ./helpers/
cp ./styles.sh ./helpers/
cd helpers
git commit -am "Updating all"
git push
cd ..

figlet journal
cd journal
git commit -am "Updating all"
git push
cd ..

figlet mikelevinseo -w 120
cd mlseo
jupyter nbconvert --to markdown index.ipynb
sed -i -e '1,5d' index.md
mv index.md ./docs
git add ./docs/*
git commit -am "Updating all"
git push
cd ..

for SITE in MikeLevin pythonically linuxpythonvimgit mikeateleven tardigradecircus removablefinger mike-levin lundervand pipulate whatsametafor guerillatech
do
    figlet $SITE -w 120
    cd $SITE
    git add _includes/*
    git add _posts/*
    git commit -am "Updating all"
    git push
    cd ..
done

figlet Done!
```

Okay, in my first testing of this capability, I'm going to add some line-height
around my prev/next arrows by putting this:

    line-height: 3;

...into style.scss

Success! The URLs of my old MikeLev.in site didn't even break. Oh wow, this is
going to be nice.

Think through next steps. Every Little Project Gets Done!

<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/adding-prev-next-arrows-to-github-pages-jekyll-blog-posts/">Adding Prev/Next Arrows to Github Pages Jekyll Blog Posts</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/writing-a-bash-loop-script-for-jekyll/">Writing a Bash Loop Script for Jekyll</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/jekyll/'>Jekyll</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li>
<li><h4><a href='/change/'>Changes</a></h4></li>
<li><h4><a href='/loop/'>Loop</a></h4></li>
<li><h4><a href='/pipulate/'>Pipulate</a></h4></li>
<li><h4><a href='/git/'>Git</a></h4></li></ul>