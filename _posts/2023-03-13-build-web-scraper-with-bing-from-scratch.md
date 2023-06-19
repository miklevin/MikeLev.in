---
date: 2023-03-13
title: Build Web Scraper With Bing From Scratch
headline: Build a Web Scraper with Bing in Python - Step-by-Step Guide
description: This step-by-step guide shows you how to build a web scraper with Bing from scratch in Python, starting with a basic example of printing 'Hello World' and building up to extracting the title tag with BeautifulSoup4. Learn how to collect all the links from a webpage, convert them from relative to absolute links, and store them in a persistent dictionary using SQLite. Discover how to compete with commercial web scraping products and get the same features for less.
keywords: Web Scraper, Bing, Python, Hello World, Requests, BeautifulSoup4, Links, Relative Links, Absolute Links, SQLite, Octoparse, Import.io, ProWebScraper, Mozenda, User-friendly, Scalable, Reliable, Feature-rich, Expensive, Flexible
categories: python, database, request, bing
permalink: /blog/build-web-scraper-with-bing-from-scratch/
layout: post
group: blog
---


Give some examples in Python that build up from Hello World to doing a Requests package get of a URL and finally extracting the title tag with BeautifulSoup4.

Here are some examples in Python that build up from Hello World to doing a Requests package get of a URL and finally extracting the title tag with BeautifulSoup4.

To print Hello World in Python, you can use the print function like this:

```python
print("Hello World")
```
To do a Requests package get of a URL, you need to import the requests module and use the get method with the URL as an argument. You can also check the status code and the content of the response like this:

```python
import requests
response = requests.get("https://www.example.com")
print(response.status_code)
print(response.content)
```

To extract the title tag with BeautifulSoup4, you need to import the BeautifulSoup module and use it to parse the HTML content of the response. You can then use the find method to locate the title tag and get its text like this:

```python
from bs4 import BeautifulSoup
soup = BeautifulSoup(response.content, "html.parser")
title = soup.find("title")
print(title.text)
```

Now provide an example that gets all the links from a page using beautiful soup. Break out an example of turning those links from relative to absolute the shortest and most reliable way possible.

Here is an example that gets all the links from a page using BeautifulSoup. It also converts the relative links to absolute links using the urljoin function from the urllib.parse module.

```python
from bs4 import BeautifulSoup
from urllib.parse import urljoin

# Assuming response is the same as before
soup = BeautifulSoup(response.content, "html.parser")

# Get all the link tags
links = soup.find_all("a")

# Loop through each link and print its href attribute
for link in links:
    # Get the href attribute value
    href = link.get("href")
    # If it's a relative link, convert it to an absolute link using urljoin
    if href.startswith("/"):
        href = urljoin("https://www.example.com", href)
    # Print the link
    print(href)
```

Show an example that puts all the collected absolute URLs into a python dict using the URL as the key and the Response fetched response object as the data. Make the dict persistent using the SqliteDict package.

Here is an example that puts all the collected absolute URLs into a python dict using the URL as the key and the Response fetched response object as the data. It also makes the dict persistent using the SqliteDict package.

```python
from bs4 import BeautifulSoup
from urllib.parse import urljoin
import requests
from sqlitedict import SqliteDict

# Assuming response is the same as before
soup = BeautifulSoup(response.content, "html.parser")

# Get all the link tags
links = soup.find_all("a")

# Create a SqliteDict object to store the URL-response pairs
url_dict = SqliteDict("url_dict.sqlite", autocommit=True)

# Loop through each link and fetch its response object
for link in links:
    # Get the href attribute value
    href = link.get("href")
    # If it's a relative link, convert it to an absolute link using urljoin
    if href.startswith("/"):
        href = urljoin("https://www.example.com", href)
    # Fetch the response object for the link using requests.get
    link_response = requests.get(href)
    # Store the URL-response pair in the SqliteDict object using URL as key and response as value
    url_dict[href] = link_response

# Close the SqliteDict object when done
url_dict.close()
```

Do it again but use the context manager for SqliteDict instead of an explicit close.

Here is the same example but using the context manager for SqliteDict instead of an explicit close.

```python
from bs4 import BeautifulSoup
from urllib.parse import urljoin
import requests
from sqlitedict import SqliteDict

# Assuming response is the same as before
soup = BeautifulSoup(response.content, "html.parser")

# Get all the link tags
links = soup.find_all("a")

# Use the context manager for SqliteDict to store the URL-response pairs
with SqliteDict("url_dict.sqlite", autocommit=True) as url_dict:
    # Loop through each link and fetch its response object
    for link in links:
        # Get the href attribute value
        href = link.get("href")
        # If it's a relative link, convert it to an absolute link using urljoin
        if href.startswith("/"):
            href = urljoin("https://www.example.com", href)
        # Fetch the response object for the link using requests.get
        link_response = requests.get(href)
        # Store the URL-response pair in the SqliteDict object using URL as key and response as value
        url_dict[href] = link_response

# The SqliteDict object will be closed automatically when exiting the context manager block
```

How would you describe the program you just wrote?

I would describe the program I just wrote as a web scraper that collects all the links from a given webpage and stores their response objects in a persistent dictionary using SQLite. It also converts relative links to absolute links using the base URL of the webpage.

What are some commercial products a program like this might compete with. List a bunch and describe them. Speculate on the relative advantages and disadvantages versus this method.

Some commercial products that a program like this might compete with are:

- Octoparse²: A desktop web scraping app for Windows and Mac that allows users to extract data from websites without coding. It has a visual interface and supports cloud services, scheduling, IP rotation, and data export.
- Import.io²: A web-based scraper for business that provides data extraction, transformation, integration, and visualization services. It can handle complex and dynamic websites, login forms, pagination, and APIs.
- ProWebScraper²: A no-code web scraping tool that can scrape data from any website with a few clicks. It offers a free plan with 10K records per month and unlimited concurrent extractions.
- Mozenda²: A cloud-hosted scraping software and data harvesting service that can scrape data from any website or document. It has a point-and-click interface and supports proxy management, scheduling, data cleaning, and API integration.

Some of the relative advantages and disadvantages of these products versus this method are:

- Advantages: These products are more user-friendly, scalable, reliable, and feature-rich than this method. They can handle more complex scenarios and provide more options for data processing and delivery. They also have customer support and documentation to help users with their scraping needs.
- Disadvantages: These products are more expensive, less flexible, less customizable, and less transparent than this method. They may have limitations on the number of requests, records, pages, or websites that can be scraped. They may also have privacy or security risks as they store users' data on their servers or third-party platforms.

Source: Conversation with Bing, 3/11/2023

    (1) Best Web Scraping Tools - 2023 Reviews & Comparison - SourceForge. https://sourceforge.net/software/web-scraping/ Accessed 3/11/2023.
    (2) Picking the Best Web Scraping Tools – A Complete Comparison!. https://www.stupidproxy.com/web-scraping-tools/ Accessed 3/11/2023.
    (3) Best Free Web Scraping Tools - 2023 Reviews & Comparison - SourceForge. https://sourceforge.net/software/web-scraping/free-version/ Accessed 3/11/2023.
    (4) Picking the Best Web Scraping Tools – A Complete Comparison!. https://www.stupidproxy.com/web-scraping-tools/ Accessed 3/11/2023.
    (5) The Best Web Scraping Tools for 2022 | ScrapingBee. https://www.scrapingbee.com/blog/web-scraping-tools/ Accessed 3/11/2023.
    (6) 24 Best Web Scraping Tools and Software in 2023 - ScrapeHero. https://www.scrapehero.com/top-free-and-paid-web-scraping-tools-and-software/ Accessed 3/11/2023.


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/what-is-the-best-seo-software/">What is the best SEO software?</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/talked-bing-into-submitting-copy-paste-bug-about-itself/">Talked Bing into Submitting Copy/Paste Bug About Itself</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/python/'>Python</a></h4></li>
<li><h4><a href='/database/'>Database</a></h4></li>
<li><h4><a href='/request/'>Requests</a></h4></li>
<li><h4><a href='/bing/'>Bing</a></h4></li></ul>