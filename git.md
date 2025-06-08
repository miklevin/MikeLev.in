---
title: git
description: This article advocates for using Git locally as a version control system, even without GitHub. It emphasizes the benefits of local repositories for personal projects, providing step-by-step instructions on setting up and managing these repositories. The article also details how to move existing GitHub repositories to a local environment, highlighting the importance of data autonomy and reducing reliance on cloud services.
permalink: /git/
group: home
---

# Git Without GitHub

## Cloud Optional

Everything should be in git, but not everything needs to be in GitHub, or any
other cloud repo, for that matter. This page covers the basics of using git on
your personal machine in its capacity as an infinite undo. When we talk about
git as a distributed version control system (DVCS), we're going to turn the D
into distributed across several personal devices so you can have some of the
confidence of using a remote or offside backup location, but not.

### Context & Purpose

There's so much I'd like to cover directly in-context here, but this is just one
little piece of what I'm currently layering up in my book about future-proofing
yourself and your skills in the world of high technology. Things move so fast it
seems like no sooner you learned something important that it's obsolete.
Effectively challenging that kind of tech churn is my mission, and this is just
the page I extracted because I want it really easy to find in the short-term
(not buried in the blog/book) due to its immediacy and forever-relevance.

### Why Local Git Can Be Better

If you're not using it for collaboration, then you don't need GitHub. This is
particularly true on a per-repository basis. Maybe you should be on GitHub for
collaborating here and there, making edits and pull requests on public projects
and engage in the free and open source software community (FOSS), but if you
just need to make some file safe and available to you all the time, it might be
better to employ a 1, 2, 3 backup procedure which are the same basic best
practices as protecting any of your data.

## Setting Up Local Git Repositories

Let's start with making a git repository that you can pull from, push to and
clone from right on your local machine, without even running any server
software. If you are pulling from and pushing to your same local machine as
you're working on, you can get the files into at least two places, either on the
same physical device (more risky but fewer moving parts), or onto 2 physically
different devices (safer but can be flaky if one is removable media). I
personally recommend two places on the same drive so that your pushes and pulls
always work, and then we'll use rsync or plain old file copying to
intermittently synchronize everything across separate (often removable) devices.

### The Linux Advantage

So let's say you're on a Linux system. Yeah, I'm going to talk Linux because
that's now the Universal Operating System! If you're on Mac, it's close enough.
And if you're on Windows, there's Windows Subsystem for Linux (WSL). Sooner or
later, if not this year then next or the year after that, you'll have to face
it. Linux won. It won in the professional server space. And it just doesn't make
sense for the proprietary stuff to stay-won in the personal space, except as a
consumer device capable of hosting your plug-in Linux environment for
development work. And I'm not talking virtual machines or even containers. I'm
talking nix and guix. More on that later.

### Initial Setup Steps

For now, make sure you have a directory in you `~/` home folder. I use
`git-repos`, but it could be anything. Just go ahead and make a directory (or
folder, if you prefer) there:

```bash
cd ~/
mkdir git-repos
```

And now you have where you push and pull your git repos from, exactly as if you
were using GitHub. You just need to sprinkle in the magic fairy dust that makes
it all work. Yeah, so there's a few steps. But there is on GitHub too. So 6 of
one and a half-dozen of the other. Make your `[repo].git` folder...

```bash
mkdir ~/git-repos/your-repo.git
cd ~/git-repos/your-repo.git
git init --bare
```

### Creating Your Working Repository

There! Now you have a "target" or the remote origin location that all your git
pushes and pulls work from. You're essentially replacing everything git does
over the network using SSH or HTTPS protocols with your local filesystem. It's
remarkably easy and was a big awakening when I discovered it. Be your own
GitHub! This at least gets your git rep, which already has its inherent
infinite undo version control properties, into at least a second location,
albeit on the same physical storage device. It's not the end of the story. We're
going to work it up in layers. This is the first layer.

### Initializing Your Working Directory

At this point if you haven't already turned your working directory into a git
repo folder, do that:

```bash
cd ~/repos/your-repo
git init
touch foo.txt
git add foo.txt
git commit -am "Git Kung Fu"
```

### Connecting to Your Local Remote

And now you're caught up with how much you can do without a remote origin. You
have a local origin and you want to make that other location on the same drive
your remote origin. So you simply:

```bash
git remote add origin ~/git-repos/your-repo.git
git remote set-url origin ~/git-repos/your-repo.git
```

You can now check that your remote location is set correctly:

```bash
git remote -v
```

### First Push and Regular Usage

Now you can do your first push, but you have to set the location:

```bash
git push --set-upstream origin master
```

And now you can commit and push as usual:

```bash
git touch foo.txt
git commit -am "More git Kung Fu"
git push
```

## Moving Repos Off Of GitHub

Okay, so that covers how to create a git repo locally from scratch and then back
it up to another location on the same storage device. But let's say you've got a
repo already on GitHub and you want to change it's upstream location from GitHub
to local, and then delete it from GitHub. This is part of the declouding
process, which I think will rise in popularity as home equipment becomes easier
to maintain and people want to get the most out of the equipment they already
own before subscribing to or becoming dependent upon yet another cloud service,
even if it is GitHub. There's a reason Microsoft bought them. The want... no,
they ***need*** you dependent on them. 

### First, check current remote

cd ~/repos/exiting-repo
git remote -v

### Remove the GitHub remote

```bash
git remote remove origin
```

### Add your new local remote

```bash
git remote add origin ~/git-repos/existing-repo.git
```

### Check branch name

```bash
git branch
```

### Push your existing repository to the new remote

```bash
git push --set-upstream origin master  # or 'main' depending on your branch name
```
