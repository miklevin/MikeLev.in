---
date: 2022-09-14
title: Writing Automated Install Script for LXD & Jupyter on WSL
headline: Unlocking the Potential of JupyterLab with LXD and WSL
description: This article describes my attempt to use JupyterLab under LXC and my progress on an automated install script for LXD and Jupyter on WSL. I'm also trying to simulate the tftp tricks I've done in Levinux and make my own bit optional graphics build. Read on to find out more about my journey and how it can help you!
keywords: Writing, Automated Install Script, LXD, Jupyter, WSL, JupyterLab, LXC, Windows Settings, Apps, Overhead Lag, Bit Optional Graphics Build, Tftp, Tricks, Levinux
categories: lxc, trick, container, jupyter, levinux, wsl
permalink: /blog/writing-automated-install-script-for-lxd-jupyter-on-wsl/
layout: post
group: blog
---


Wow, wow, wow! In an attempt to force myself to use JupyterLab under LXC, I
uninstalled Jupyter-Desktop through Windows Settings / Apps per their upgrade
instructions. It's like disabling the arrow keys in vim to force yourself to
use hjkl. Find the love in things. I initially had concerns over performance
and there is a wee bit of overhead lag on LXD vs. just WSL, but I'm willing to
live with it for the Noah's Ark benefit. Speaking of which, look at this great
ASCII art I found. Right? Right! I'm so working that in.
http://www.ascii-art.de/ascii/ab/ark_of_noah.txt

        (\
     _\_(`\_ `/`                     _
       `/,-'=/`                   _,'|`._
       /'  `/`                 ,-' |||._ `-._        i_i
                           _,-' ,-' ||  `__  `-._ "=(. .)="
                       _,-' _,-'  --||- (..=`/._ `-/#\ (    i_i
                     ,\ _,-'     |  )|_|-==` \_)`-/  /v  "=(. .)="
                   ,' ,|/      \ |__||\ //|\\ /  / #/    ,/ \ (
                 ,' ,' ((_.--._))   || )(/|\)'  /#  ;  ,/ #,/v
               ,' ,'   |`-    -'    ||/  (/\\  /  #; ,/# ,/
             ,'  ' /   |  \  */"-._ |/ _____,-''"/_)/__ /
           ,',---|((_.--._(__/    _.--""_____)-//_______"-.
            (,-.)| `-     -(  _,"_.--""    |||((   __ "-.:
          ___,/ ;|   \  */ _\'_,"  (\__/)  |||\\\ |__`,()() . \
         (,_.) (_|   (__/,'_,' /_/)=\.\. = |||||| | `( ` ``\|\)\
           ( ;.__|  _,-'_,'  =//. ==> _7)< |||||| |`` , ` *  "")
         ___\  _,--'_,-'  //_(7__/) ////\  |||||| |``` \___.--'
          \_"""_,--' <*)_//'""    )/_/-"""":|||||,""""(("-._/
          | """" ) ( _(-' _.---"\___,----. |||||| |  ,' "`._ ,((
          |  ) ( \_/'   ,'    _""   "_    `.||||| |,"\\'--._)   "._
           \ \_/<. .>""(      ( .   .)      )|||| |\\ \/,"\\ /`--._)
            <. .>|_/\|  \/     ) \,-(     \(||||| | \\)"\\ \)
            ||_/( (  |   |\/   /, \  \ )\\(:|||||,()""""-.:|
            |  \ `-\ |   |__\/,  :`/-`._____,-""_,'    ctr:|
            |"""\___,""""""""""""""\(_,( (__,-"||---"""""";
             \---""""---------""""""""````/////))----""""/
           ~~~\                         ~///////~      ~/~~~~~
               \ ~~~~~      ~~~~~~~      /~~~~/      ~~/    ~~~
           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Wow, every last thing becomes love-worthy.

Be sure to make it that re-running ~/repos/jupyme/install.sh has little to no
downsides. You'll loose your pip installs and Jupyter configuration, but I can
address all that. Also, apt installs.

I want to make the bit optional graphics build.

First, make the conduit between the host machine and the LXD instance. The
important thing is to simulate the tftp (trivial file transfer protocol) tricks
that I've done in Levinux. Moving my Levinux tricks over to LXD is potentially
profoundly big win... wow, releasing such potential. As simple as possible!

Hmmm, maybe even make your WSL default instance


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/switching-from-wsl-to-lxd-containers-permanently/">Switching From WSL to LXD Containers Permanently</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/already-renamed-jupyme-to-wsl2lxd/">Already Renamed Jupyme to WSL2LXD</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/lxc/'>LXC</a></h4></li>
<li><h4><a href='/trick/'>Tricks</a></h4></li>
<li><h4><a href='/container/'>Container</a></h4></li>
<li><h4><a href='/jupyter/'>Jupyter</a></h4></li>
<li><h4><a href='/levinux/'>Levinux</a></h4></li>
<li><h4><a href='/wsl/'>WSL</a></h4></li></ul>