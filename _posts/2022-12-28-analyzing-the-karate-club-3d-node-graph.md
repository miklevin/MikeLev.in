---
date: 2022-12-28
title: Analyzing the Karate Club 3D Node Graph
headline: Creating a 3D Rotating Network Node Graph with Plotly and NetworkX
description: I'm creating a 3D rotating shape from a website using Linux Jupyter on Windows. I'm analyzing the Karate Club 3D Node Graph and have written code to plot it. I'm exploring NetworkX, a Python library for creating and manipulating graphs, to create a networkx.classes.graph.Graph object and plotting nodes and edges in 3D space. I'm using Plotly to generate a 3D rotating network node graph with different colored nodes.
keywords: Karate Club, 3D Node Graph, Linux, Jupyter, Windows, NetworkX, Python, Plotly, Graph, Nodes, Edges, Colors, Labels, Spring Layout, URLs, Links, Figure
categories: node, python, microsoft, linux, jupyter
permalink: /blog/analyzing-the-karate-club-3d-node-graph/
layout: post
---


I'm pursuing a dream that I've had for awhile now to graph the data from a
crawled website so that you can interact with it like a 3D rotating shape. This
tech has been around for awhile now in various forms, but I've failed to
connect the dots (quite literally) in making it a generic tool for SEO. The
iron is hot now with Linux Jupyter on Windows. That makes all the difference. I
can solve it, then I can "can it" in Pipulate. So do so. First, let's look at
the code to plot the famous Karate Class:

```python
import networkx as nx
import plotly.graph_objects as go

ZKC_graph = nx.karate_club_graph()
spring_3D = nx.spring_layout(ZKC_graph, dim=3, seed=18)
spring_3D[4]
Num_nodes = len(spring_3D)

x_nodes = [spring_3D[i][0] for i in range(Num_nodes)]
y_nodes = [spring_3D[i][1] for i in range(Num_nodes)]
z_nodes = [spring_3D[i][2] for i in range(Num_nodes)]

edge_list = ZKC_graph.edges()

x_edges = []
y_edges = []
z_edges = []

for edge in edge_list:
    # format: [beginning,ending,None]
    x_coords = [spring_3D[edge[0]][0], spring_3D[edge[1]][0], None]
    x_edges += x_coords

    y_coords = [spring_3D[edge[0]][1], spring_3D[edge[1]][1], None]
    y_edges += y_coords

    z_coords = [spring_3D[edge[0]][2], spring_3D[edge[1]][2], None]
    z_edges += z_coords

trace_edges = go.Scatter3d(
    x=x_edges,
    y=y_edges,
    z=z_edges,
    mode="lines",
    line=dict(color="black", width=2),
    hoverinfo="none",
)

trace_nodes = go.Scatter3d(
    x=x_nodes,
    y=y_nodes,
    z=z_nodes,
    mode="markers",
    marker=dict(
        symbol="circle",
        size=10,
        colorscale=["lightgreen", "magenta"],  # either green or mageneta
        line=dict(color="black", width=0.5),
    ),
    hoverinfo="text",
)

axis = dict(
    showbackground=False,
    showline=False,
    zeroline=False,
    showgrid=False,
    showticklabels=False,
    title="",
)

layout = go.Layout(
    title="Minimum 3D Rotating Network Node Graph",
    width=1000,
    height=625,
    showlegend=False,
    scene=dict(
        xaxis=dict(axis),
        yaxis=dict(axis),
        zaxis=dict(axis),
    ),
    margin=dict(t=100),
    hovermode="closest",
)

data = [trace_edges, trace_nodes]
fig = go.Figure(data=data, layout=layout)

fig.show()
```

This actually renders the 3D graph in JupyterLab the way I currently have
Pipulate configured, but is a bit rough in form. Namely, it's the Karate Club
data and not my own, all the circles look alike and there are no labels. I
stripped the labels and the coloring out to get a bare minimum example, but the
original tutorial is
[here](https://deepnote.com/@deepnote/3D-network-visualisations-using-plotly-a18c5e37-a517-4b27-bfde-1fee94a5760f)

Okay, so before I manipulate the labels and aesthetics, I want to get my own
data from an actual crawl into here. An investigation of the ZKC_graph object
shows that it's a networkx.classes.graph.Graph object. Asking ChatGPT how to
make one, it tells me this:

## How can I create a networkx.classes.graph.Graph object?

To create a Graph object in the networkx library, you can use the Graph
constructor. Here's an example:

```python
import networkx as nx

# Create an empty graph
G = nx.Graph()

# You can also create a graph with a set of nodes and edges
# For example, this will create a graph with 3 nodes (1, 2, and 3)
# and two edges connecting them: (1, 2) and (2, 3)
G = nx.Graph([(1, 2), (2, 3)])
```

You can also create a graph by adding nodes and edges to an empty graph using
the add_node and add_edge methods. Here's an example:

```python
import networkx as nx

# Create an empty graph
G = nx.Graph()

# Add some nodes
G.add_node(1)
G.add_node(2)
G.add_node(3)

# Add some edges
G.add_edge(1, 2)
G.add_edge(2, 3)
```

You can find more information about creating and working with Graph objects in
the NetworkX documentation:
https://networkx.github.io/documentation/stable/tutorial.html#graphs

---

Okay, my work is on the verge of getting visually interesting. Could I make it
interesting enough to intrigue my kid? Let's delve into that node object. There
are nodes and there are edges. This system can plot them in 3D space with
springy weighting of line weights to avoid visual clutter of nodes. Then you
can grab the mouse, touchpad, arrow keys or touchscreen and spin it around.
Zoom in and out. Examine the shape of the network.

1, 2, 3... 1? Clarity! We are talking about NetworkX here, really. Get your
documentation and first principle concepts in order here.

NetworkX

From https://networkx.org/documentation/stable/tutorial.html

Nodes can be added from a list of tuples, each tuple containing a node ID and a
dictionary of what appear to be attributes such as colors and labels, which can
be used in the visualization. And similarly, you can create the edges. You can
load a list of tuples, each tuple containing 2 node IDs.


```python
import networkx as nx

G = nx.Graph()
G.add_nodes_from([
    (1, {"color": "blue"}),
    (2, {"color": "brown"}),
    (3, {"color": "brown"}),
    (4, {"color": "brown"}),
])

G.add_edges_from([(1, 2), (1, 3), (1, 4)])
```

The graph G now contains H as a node. This flexibility is very powerful as it
allows graphs of graphs, graphs of files, graphs of functions and much more. It
is worth thinking about how to structure your application so that the nodes are
useful entities. Of course you can always use a unique identifier in G and have
a separate dictionary keyed by identifier to the node information if you
prefer.

Okay, so I can replace the Karate Class graph object with this bare bones basic
example, which is deliberately constructed with some color attributes. I don't
use the attributes yet, but in the next step, I'll be using attributes for
stuff like node size, color and label. This is starting to take shape. There's
such a lack of building-it-up from the basics examples like this on the net.

```python
import networkx as nx
import plotly.graph_objects as go

G = nx.Graph()
G.add_nodes_from([
    (0, {"color": "blue"}),
    (1, {"color": "brown"}),
    (2, {"color": "brown"}),
    (3, {"color": "brown"}),
    (4, {"color": "green"}),
])

G.add_edges_from([(0, 1), (0, 2), (0, 3), (0, 4)])

spring_3D = nx.spring_layout(G, dim=3, seed=18)
Num_nodes = len(spring_3D)

x_nodes = [spring_3D[i][0] for i in range(Num_nodes)]
y_nodes = [spring_3D[i][1] for i in range(Num_nodes)]
z_nodes = [spring_3D[i][2] for i in range(Num_nodes)]

edge_list = G.edges()

x_edges = []
y_edges = []
z_edges = []

for edge in edge_list:
    # format: [beginning,ending,None]
    x_coords = [spring_3D[edge[0]][0], spring_3D[edge[1]][0], None]
    x_edges += x_coords

    y_coords = [spring_3D[edge[0]][1], spring_3D[edge[1]][1], None]
    y_edges += y_coords

    z_coords = [spring_3D[edge[0]][2], spring_3D[edge[1]][2], None]
    z_edges += z_coords

trace_edges = go.Scatter3d(
    x=x_edges,
    y=y_edges,
    z=z_edges,
    mode="lines",
    line=dict(color="black", width=2),
    hoverinfo="none",
)

trace_nodes = go.Scatter3d(
    x=x_nodes,
    y=y_nodes,
    z=z_nodes,
    mode="markers",
    marker=dict(
        symbol="circle",
        size=10,
        colorscale=["lightgreen", "magenta"],  # either green or mageneta
        line=dict(color="black", width=0.5),
    ),
    hoverinfo="text",
)

axis = dict(
    showbackground=False,
    showline=False,
    zeroline=False,
    showgrid=False,
    showticklabels=False,
    title="",
)

layout = go.Layout(
    title="Minimum 3D Rotating Network Node Graph",
    width=1000,
    height=625,
    showlegend=False,
    scene=dict(
        xaxis=dict(axis),
        yaxis=dict(axis),
        zaxis=dict(axis),
    ),
    margin=dict(t=100),
    hovermode="closest",
)

# Include the traces we want to plot and create a figure
data = [trace_edges, trace_nodes]
fig = go.Figure(data=data, layout=layout)

fig.show()
```

Alright, and now after a bit more work putting the crawl data in.

```python
# Import the required packages
import pandas as pd
import networkx as nx
import plotly.graph_objects as go
from sqlitedict import SqliteDict as sqldict

table = []
with sqldict("ncrawl.db") as db:
    for i, url in enumerate(db):
        links = db[url]
        if links:
            for link in links:
                table.append((url, link))
df = pd.DataFrame(table).iloc[:, :]

dedupe_me = list(df[0].unique()) + list(df[1].unique())

seen = set()
new_list = []
for url in dedupe_me:
    if url not in seen:
        new_list.append(url)
        seen.add(url)

url_dict = dict([(x[1], x[0]) for x in enumerate(new_list)])

G = nx.Graph()
for url in df[0].unique():
    G.add_node(url_dict[url])

edges = list(map(tuple, (df.to_records(index=False))))
for edge in edges:
    l, r = edge
    G.add_edge(url_dict[l], url_dict[r])

spring_3D = nx.spring_layout(G, dim=3, seed=18)
Num_nodes = len(spring_3D)
x_nodes = [spring_3D[i][0] for i in range(Num_nodes)]
y_nodes = [spring_3D[i][1] for i in range(Num_nodes)]
z_nodes = [spring_3D[i][2] for i in range(Num_nodes)]

edge_list = G.edges()
x_edges = []
y_edges = []
z_edges = []

for edge in edge_list:
    # format: [beginning,ending,None]
    x_coords = [spring_3D[edge[0]][0], spring_3D[edge[1]][0], None]
    x_edges += x_coords

    y_coords = [spring_3D[edge[0]][1], spring_3D[edge[1]][1], None]
    y_edges += y_coords

    z_coords = [spring_3D[edge[0]][2], spring_3D[edge[1]][2], None]
    z_edges += z_coords

trace_edges = go.Scatter3d(
    x=x_edges,
    y=y_edges,
    z=z_edges,
    mode="lines",
    line=dict(color="black", width=2),
    hoverinfo="none",
)

trace_nodes = go.Scatter3d(
    x=x_nodes,
    y=y_nodes,
    z=z_nodes,
    mode="markers",
    marker=dict(
        symbol="circle",
        size=10,
        colorscale=["lightgreen", "magenta"],  # either green or mageneta
        line=dict(color="black", width=0.5),
    ),
    hoverinfo="text",
)

axis = dict(
    showbackground=False,
    showline=False,
    zeroline=False,
    showgrid=False,
    showticklabels=False,
    title="",
)

layout = go.Layout(
    title="3D Graph of Website",
    width=1000,
    height=1000,
    showlegend=True,
    scene=dict(
        xaxis=dict(axis),
        yaxis=dict(axis),
        zaxis=dict(axis),
    ),
    margin=dict(t=100),
    hovermode="closest",
)

# Include the traces we want to plot and create a figure
data = [trace_edges, trace_nodes]
fig = go.Figure(data=data, layout=layout)

fig.show()
```


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/let-s-visualize-websites-as-network-node-graphs/">Let's Visualize Websites as Network Node Graphs</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/planning-a-large-browser-automation-job/">Planning A Large Browser Automation Job</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/node/'>Node</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/microsoft/'>Microsoft</a></h4></li>
<li><h4><a href='/linux/'>Linux</a></h4></li>
<li><h4><a href='/jupyter/'>Jupyter</a></h4></li></ul>