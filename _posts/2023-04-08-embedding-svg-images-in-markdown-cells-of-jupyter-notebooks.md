---
date: 2023-04-08
title: Embedding SVG Images in Markdown Cells of Jupyter Notebooks
headline: Embedding SVG Images in Jupyter Notebooks - How I Did It!
description: This blog post explains how I wrote a Python program that uses the base64 module to encode an SVG image file, generates an HTML img tag with the encoded data as the src attribute, and outputs the HTML img tag as a string. This allows the image to be displayed properly in a markdown cell of a Jupyter Notebook, making it easy to reference the original file. Read on to find out how I did it!
keywords: Python, Program, base64, Module, Encode, SVG, Image, File, HTML, img, Tag, src, Attribute, Output, String, Display, Properly, Markdown, Cell, Jupyter, Notebook, Reference, Original
categories: python, html, string, jupyter
permalink: /blog/embedding-svg-images-in-markdown-cells-of-jupyter-notebooks/
layout: post
---


**Mike Levin:** Write a Python program that will load a .svg image and output an html img
tag wit the src attribute set to the encoded svg data that will allow the
output of the program to be copy/pasted into markdown cell of a Jupyter
Notebook and display properly as if a reference to the original .svg file, but
actually now embedded.

**ChatGPT:** To achieve this, we can use the base64 module in Python to encode the
SVG image data and then generate the HTML img tag with the encoded data as the
src attribute. Here is a Python program that accomplishes this:

```python
import base64

# Load the SVG image file
with open('image.svg', 'rb') as f:
    svg_data = f.read()

# Encode the SVG image data using base64
encoded_svg_data = base64.b64encode(svg_data).decode('utf-8')

# Generate the HTML img tag with the encoded SVG data
html_img_tag = '<img src="data:image/svg+xml;base64,{}">'.format(encoded_svg_data)

# Output the HTML img tag
print(html_img_tag)
```

This program assumes that the SVG image file is named image.svg and is located
in the same directory as the Python script. You can modify the filename and
path as necessary.

The base64.b64encode() function encodes the SVG image data as a base64 string,
which is then decoded as a UTF-8 string using the decode() method. The
resulting string is then formatted into the src attribute of the HTML img tag.
Finally, the program outputs the complete HTML img tag as a string.

You can copy and paste the output of this program into a markdown cell of a
Jupyter Notebook and it should display the SVG image properly as if it were a
reference to the original file.


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/better-living-through-text-editors/">Better Living Through Text Editors</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/recruiting-chatgpt-s-help-advocating-lpvg-toolset/">Recruiting ChatGPT's Help Advocating LPvg Toolset</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/html/'>HTML</a></h4></li>
<li><h4><a href='/string/'>Strings</a></h4></li>
<li><h4><a href='/jupyter/'>Jupyter</a></h4></li></ul>