---
date: 2022-05-01
title: Bash Script Loading External Files
headline: "Simplifying My Release System: Introducing blast.sh"
description: I've simplified my release system and renamed it blast.sh. This script helps me delete old files, slice blogs, update my vimrc, journal, and mlseo. After that, it publishes my 15 domains for SEO purposes and I'm done! Join me as I dive into the details of this helpful script.
keywords: Bash Script, External Files, Release System, 'blast.sh', Delete Old Files, Slice Blogs, Update Vimrc, Journal, MLSeo, Publish Domains, SEO Purposes, Registered Domains, Simplify, Script, Sites
categories: script, mlseo
permalink: /blog/bash-script-loading-external-files/
layout: post
---


Surprise again! All this content is moved over to MikeLevinSEO.com, where it
really belongs. I'm going to keep Pythonic Ally "free" for better posts. I'll
probably keep FizzBuzz and things like that over there. But I'll definitely be
moving things around a bit until they find their natural home amongst my sites.

I put all 15 of my registered domains that I keep for aspirational reasons and
for walking the walk if you're going to talk the talk SEO reasons. But it broke
my release system. I'm taking it as an opportunity to simplify the system. `

I've put the release system as the last of my vim buffers. So that means I
type:

```bash
:blast
```

...to get to it. It used to be called "gall.sh" which I liked because it was a
play on my "all.sh" file (for editing all) but I had the gall to publish them
all. As much as I liked that helper-file name, I ended up chaging it to
"blast.sh" because it has even better double entendre meaning.

So blast.sh is the release system that's actually broken right now.

Okay, and now it's fixed. It's much better than before:

```bash
#    _     _           _
#  _| |__ | | __ _ ___| |_
# (_) '_ \| |/ _` / __| __|
#  _| |_) | | (_| \__ \ |_
# (_)_.__/|_|\__,_|___/\__|

clear
figlet :blast

filename='./helpers/sites.txt'
n=1
while read line; do
echo "$n $line"
n=$((n+1))
done < $filename

echo ""
cd /mnt/c/Users/mikle/github

figlet Deleting Old Files... -w 120
n=1
while read line; do
rm ./$line/_posts/*
n=$((n+1))
done < $filename

cd blogslicer
nbdev_clean_nbs
nbdev_build_lib
git commit -am "Updating all"
git push

figlet Slicing Blogs...
filename='../helpers/sites.txt'
n=1
while read line; do
python blogslicer/core.py -a "Mike Levin" -p "../$line" -t "$line Blog" -s "blog"
n=$((n+1))
done < $filename

cd ..

figlet helpers
cd helpers
git commit -am "Updating all"
git push
cd ..

figlet vim
cp ~/.vimrc ./vim/
cd ./vim
git commit -am "Updating all"
git push
cd ..

figlet journal
cd journal
git commit -am "Updating all"
git push
cd ..

figlet mlseo -w 120
cd mlseo
jupyter nbconvert --to markdown index.ipynb
sed -i -e '1,5d' index.md
mv index.md ./docs
git add ./docs/*
git commit -am "Updating all"
git push
cd ..

figlet Publishing Sites... -w120
filename='./helpers/sites.txt'
n=1
while read line; do
figlet $line -w 120
cd $line
git add _includes/*
git add _posts/*
git commit -am "Updating all"
git push
cd ..
n=$((n+1))
done < $filename

figlet Done!

echo "Press any key to continue"
while [ true ] ; do
read -t 10 -n 1
if [ $? = 0 ] ; then
exit ;
else
echo "waiting for the keypress"
fi
done
exit
```

<div class="post-nav"><div class="post-nav-prev"><span class="arrow">&nbsp;&rarr;</span><a href="/blog/bash-script-loading-external-files/">Bash Script Loading External Files</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/from-jupyter-notebook-to-pip-installable-package-in-one-go/">From Jupyter Notebook to pip Installable Package In One Go</a><span class="arrow">&larr;&nbsp;</span></div></div>
## Categories

<ul>
<li><h4><a href='/script/'>Script</a></h4></li>
<li><h4><a href='/mlseo/'>mlseo</a></h4></li></ul>