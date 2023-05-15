---
date: 2022-12-27
title: Let's Visualize Websites as Network Node Graphs
headline: Visualizing Websites with 3D Interactive Graphs in Jupyter Notebooks
description: I've been researching the best way to visualize large link and node graphs in Jupyter notebooks, comparing the advantages and disadvantages of using NetworkX and Bokeh, and have decided to try out Plotly. Over the holiday I made progress and outlined a plan to create 3D interactive visualizations in JupyterLab. I'm also teaching stakeholders how to access data on their own by setting up an instance of Linux WSL, installing nodejs and jupyter.
keywords: Visualize, Websites, Network, Node, Graphs, Jupyter, Notebooks, NetworkX, Bokeh, Plotly, 3D, Interactive, Visualizations, JupyterLab, Linux, WSL, Nodejs, Labextension, Automating, Delivery, Portable, Low-Dependency, Apt_Install, Pip_Install, Git_Install
categories: network, jupyter, linux, node, wsl, javascript
permalink: /blog/let-s-visualize-websites-as-network-node-graphs/
layout: post
---


The time has come to visualize link-graphs in Jupyter, so I ask ChatGPT what it
thinks is best:

## What is the best way to visualize a large link graph or node graph in Jupyter?

There are several ways to visualize a large link graph or node graph in Jupyter notebooks. Some of the most popular options are:

1. NetworkX: This is a Python library that allows you to create, manipulate, and analyze graphs and networks. You can use NetworkX to draw your graph using various layout algorithms and customize the appearance of the nodes and edges.
1. Bokeh: This is a Python library for creating interactive plots and visualizations. You can use Bokeh to create a dynamic and interactive graph visualization in your Jupyter notebook.
1. Matplotlib: This is a widely used Python library for creating static plots and visualizations. You can use Matplotlib to create a static graph visualization in your Jupyter notebook.
1. plotly: This is a Python library for creating interactive, publication-quality graphs. You can use plotly to create a dynamic and interactive graph visualization in your Jupyter notebook.

Ultimately, the best way to visualize a large link graph or node graph in Jupyter will depend on your specific needs and preferences. You may want to try out a few different options to see which one works best for your purposes.

> What are the relative advantages and disadvantages between NetworkX and Bokeh?

Both NetworkX and Bokeh are popular tools for creating and visualizing graphs and networks in Python. Here are some of the main advantages and disadvantages of each:

## NetworkX:

- Advantages:
  - Supports a wide range of graph and network algorithms, including connectivity, centrality, and shortest path.
  - Can handle large graphs and networks efficiently.
  - Provides a range of layout algorithms for arranging the nodes and edges in a visually appealing way.
- Disadvantages:
  - The output is static, meaning that the graph cannot be interacted with or modified by the user.
  - Limited options for customizing the appearance of the nodes and edges.

## Bokeh:

- Advantages:
  - Can create dynamic and interactive visualizations that allow the user to zoom, pan, and hover over elements to see more information.
  - Provides a wide range of customization options for the appearance of the nodes and edges.
  - Can be easily integrated with web applications.
- Disadvantages:
  - May not be as efficient as NetworkX for handling large graphs and networks.
  - Limited support for graph and network algorithms compared to NetworkX.
  - Ultimately, the choice between NetworkX and Bokeh will depend on your specific needs and preferences. If you need to perform advanced graph and network analysis, or if you want a static visualization, then NetworkX may be a better choice. If you want to create an interactive and dynamic visualization, or if you need to customize the appearance of the nodes and edges in more detail, then Bokeh may be a better option.

Haha after all that, I think I'll end up starting out with Plotly. I may change
my mind, but you don't ***have*** to log in with Plotly to use the FOSS part of
its packages. Logging in is only for sharing visualizations that they are able
to host. But with Pipulate is alleviated a lot of necessity of hosting, 'cause
a local fully configured for this sort of thing Linux server could be your
host.

Wanna share? Not everything needs to be a Web app. Have them install Pipulate.
Or share the .HTML file. I'll investigate how to email 3D interactive network
node graph visualizations, 'cause that's what we're talking about. And maybe
animated, to see your 3 click-depth crawl over time.

Okay, I've made remarkable progress over the holiday. Wow! Let's get a basic
thing laid out here for in-JupyterLab 3D interactive visualization success. The
first and most important thing is... uh, I think it's Operation Everyone is a
Data Scientist. It's important to teach the stakeholders who need the data how
to fish for themselves. Or to automate delivery of such-and-such to them in
such a way as you can modify, refine and iterate quick. And it's all gotta be
portable and low-dependency. Did I mention that? Run it locally on your Windows
laptop under Linux or on some Raspberry Pi or NAS server in your house. We
don't need no stinkin' cloud.

Okay... a test. We need iPyWidgets!

I got it working in my current Linux WSL instance. Let's bottle it. It required
a nodejs >12 install...

    curl -sL https://deb.nodesource.com/setup_16.x -o /tmp/nodesource_setup.sh
    sudo bash /tmp/nodesource_setup.sh
    sudo apt install nodejs
    jupyter labextension install jupyterlab-plotly

Yes, I have to wrap in the visualization stuff. It turns out that the
apt_install phase come before the pip install which comes before the
git_install. That's good. You can simply treat apt as the before-pip phase for
things like lxml and such, and git_install for both git cloning and post-pip
stuff like playwright and jupyter install commands.


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/an-essay-on-modern-seo-a-call-to-pipulate/">An Essay on Modern SEO. A Call to Pipulate.</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/analyzing-the-karate-club-3d-node-graph/">Analyzing the Karate Club 3D Node Graph</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/network/'>Network</a></h4></li>
<li><h4><a href='/jupyter/'>Jupyter</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li>
<li><h4><a href='/node/'>Node</a></h4></li>
<li><h4><a href='/wsl/'>WSL</a></h4></li>
<li><h4><a href='/javascript/'>JavaScript</a></h4></li></ul>