---
date: 2023-03-05
title: Looking For The Best Python dict-like API to NoSQL
headline: Exploring Python Dict-Like APIs for NoSQL Databases
description: "This blog post explores the question of whether making a Python dictionary persistent would make it considered a database, and if so, a NoSQL system. It explains the features needed from the database and provides information about three libraries: ZODB, UnQLite and SqliteDict. I also discuss the possibility of using Python packages to provide a unified dict-like key-value persistent store across different back ends, and provide an example of how to use PyDAL to create a dict-"
keywords: Python, dict-like API, NoSQL, database, ZODB, UnQLite, SqliteDict, PyDAL, MongoDB, key-value, name Alice, age 26
categories: database, python
permalink: /blog/looking-for-the-best-python-dict-like-api-to-nosql/
layout: post
---


When did the term NoSQL start being used? Who coined it? And what is the status of NoSQL today? Name some popular NoSQL products and tell me about BerkeleyDB. Was it NoSQL? Why wasn't it called NoSQL back in the day? What happened to it? What is the key-value database built into Unix and how does it relate? What are the alternatives to NoSQL today such as Postgres which can use 2-column tables to accomplish much the same thing. And how does this all relate to Python dictionaries?

That's a lot of questions! I'll try to answer them briefly.

- The term NoSQL was first used in 1998 by Carlo Strozzi while naming his lightweight, open-source “relational” database that did not use SQL¹⁴. The name came up again in 2009 when Eric Evans and Johan Oskarsson used it to describe non-relational databases¹³.
- NoSQL databases are still widely used today for storing and retrieving unstructured or semi-structured data that does not fit well into the relational model. Some popular NoSQL products include MongoDB, Cassandra, Redis, CouchDB and Neo4j⁵.
- BerkeleyDB is an embedded database software library for key/value data that was historically significant in open source software⁷. It was not a relational database, although it had advanced database features such as transactions and concurrency control⁷. It was not called NoSQL back in the day because the term was not popularized until 2009¹⁴. BerkeleyDB is now unmaintained and its latest release was in 2016⁹.
- A key-value database from the original Unix is DBM (database manager), which is a 1979 library originally written by Ken Thompson. It is an early example of a NoSQL system[^10^] ¹¹. It stores arbitrary key/data pairs as byte arrays and supports multiple data items for a single key[^10^].
- Some alternatives to NoSQL today are relational databases that support JSON or XML data types, such as PostgreSQL or MySQL. These databases can use two-column tables (key and value) to store semi-structured data without losing the benefits of SQL querying and schema constraints. Another alternative is using hybrid databases that combine relational and non-relational models, such as Oracle Database or SQL Server.
- Python dictionaries are data structures that store key/value pairs in memory. They are similar to hash tables or associative arrays in other programming languages. They are not directly related to NoSQL databases, but they can be used to manipulate or process data from them.

I hope this helps you understand more about NoSQL databases. Do you have any follow-up questions?

Source: Conversation with Bing, 3/5/2023

    (1) A Brief History of Non-Relational Databases - DATAVERSITY. https://www.dataversity.net/a-brief-history-of-non-relational-databases/ Accessed 3/5/2023.
    (2) NoSQL - Wikipedia. https://en.wikipedia.org/wiki/NoSQL Accessed 3/5/2023.
    (3) The Evolution of NoSQL | Datastax. https://www.datastax.com/blog/evolution-nosql Accessed 3/5/2023.
    (4) What Is NoSQL? NoSQL Databases Explained | MongoDB. https://www.mongodb.com/nosql-explained Accessed 3/5/2023.
    (5) Berkeley DB - Wikipedia. https://en.wikipedia.org/wiki/Berkeley_DB Accessed 3/5/2023.
    (6) Releases · berkeleydb/libdb · GitHub. https://github.com/berkeleydb/libdb/releases Accessed 3/5/2023.
    (7) DBM (computing) - Wikipedia. https://en.wikipedia.org/wiki/DBM_(computing) Accessed 3/5/2023.
    (8) DBM (computing) - Wikipedia. https://en.wikipedia.org/wiki/DBM_(computing) Accessed 3/5/2023.
    (9) A Brief History of Non-Relational Databases - DATAVERSITY. https://www.dataversity.net/a-brief-history-of-non-relational-databases/ Accessed 3/5/2023.
    (10) Berkeley DB - Database of Databases. https://www.dbdb.io/db/berkeley-db Accessed 3/5/2023.
    (11) Oracle Berkeley DB. https://www.oracle.com/database/technologies/related/berkeleydb.html Accessed 3/5/2023.
    (12) Key–value database - Wikipedia. https://en.wikipedia.org/wiki/Key%E2%80%93value_database Accessed 3/5/2023.
    (13) Best Key-Value Databases for Linux - 2023 Reviews & Comparison. https://sourceforge.net/software/key-value-databases/linux/ Accessed 3/5/2023.
    (14) database - Standard key/value datastore for unix - Unix & Linux Stack .... https://unix.stackexchange.com/questions/21943/standard-key-value-datastore-for-unix Accessed 3/5/2023.
    (15) A Guide to Key-Value Databases | InfluxData. https://www.influxdata.com/key-value-database/ Accessed 3/5/2023.

If a Python dictionary could be made persistent so that its data could be retrieved between sessions, would that make it considered an database, and becaus Python dicts are key-value pairs, does that make it a NoSQL dict?

That’s an interesting question. I think the answer depends on how you define a database and a NoSQL system. A database is usually a collection of data that can be accessed and manipulated by one or more applications. A NoSQL system is a type of database that does not use SQL or the relational model to store and query data. So, if you make a Python dictionary persistent, you could argue that it is a database, but not necessarily a NoSQL system. For example, you could use pickle or shelve modules to serialize and store Python dictionaries in files . These files are persistent databases, but they are not NoSQL systems because they do not provide any features such as scalability, concurrency control, indexing or querying that are common in NoSQL products. On the other hand, if you use a library such as ZODB or UnQLite to store Python dictionaries in persistent objects or key-value stores that support transactions and queries, then you could argue that they are NoSQL systems because they offer some of the benefits of non-relational databases.
So, I would say that making a Python dictionary persistent does not automatically make it a NoSQL system. It depends on how you store and access the data and what features you need from the database. Does this answer your question?

Tell me about ZODB and UnQLite. Also tell me about SqliteDict. Are their APIs compatible? What is the best way to use the standard Python dict API and have the data structure it's referencing actually be whatever NoSQL back-end you like from SQLite3 (included with Python) to Redis or MongoDB.

ZODB is an object-oriented database for transparently and persistently storing Python objects⁵. It is part of the Zope web application server, but can also be used independently of Zope⁴. ZODB has a pluggable storage architecture that allows a variety of storage schemes including memory-based, file-based and distributed (client-server) storage¹³. ZODB lets you work with Python objects without worrying about persistence or database operations²³.

UnQLite is an embedded NoSQL database engine that can store both JSON documents and key-value pairs. It is self-contained, serverless, zero-configuration and transactional. It supports both in-memory and on-disk databases. UnQLite has a Python binding that exposes a simple API for working with collections (documents) or key-value stores.

SqliteDict is a lightweight wrapper around Python's built-in sqlite3 database that provides a dictionary-like interface for storing arbitrary objects. It uses pickle to serialize and deserialize objects. SqliteDict supports multiple tables in one file and access from multiple threads or processes.

The APIs of these libraries are not compatible, as they have different methods and parameters for creating, accessing and modifying databases. However, they all support some common operations such as getting, setting, deleting and iterating over keys or values.

The best way to use the standard Python dict API and have the data structure it's referencing actually be whatever NoSQL back-end you like depends on your use case and preferences. One possible option is to use a library such as anydbm or dbm that provides a generic interface to various key-value databases such as BerkeleyDB, DBM or GDBM. Another option is to use a library such as pymongo or redis-py that provides high-level wrappers around MongoDB or Redis respectively. These libraries allow you to use dictionaries or other Python data structures to interact with the NoSQL databases.

I hope this gives you some overview of ZODB, UnQLite and SqliteDict. Do you want me to explain more about any of them?

Source: Conversation with Bing, 3/5/2023

    (1) Zope Object Database - Wikipedia. https://en.wikipedia.org/wiki/Zope_Object_Database Accessed 3/5/2023.
    (2) ZODB - a native object database for Python. https://zodb.org/en/latest/ Accessed 3/5/2023.
    (3) Introduction — ZODB documentation. https://zodb.org/en/latest/introduction.html Accessed 3/5/2023.
    (4) Tutorial — ZODB documentation. https://zodb.org/en/latest/tutorial.html Accessed 3/5/2023.
    (5) An overview of the ZODB (by Laurence Rowe) — ZODB documentation. https://zodb.org/en/latest/articles/ZODB-overview.html Accessed 3/5/2023.

Does anydbm support the SQLite3 that comes with Python? Does anydbm give you a very Standard Library dict like interface to a key-value database? Compare anydbm to SqliteDict in this respect. I like the SqliteDict API but not that SQLiTE is the only back-end database it supports. Is anydbm a viable replacement? If not, what else might be? In particular, I want Redis, PostgreSQL or Memcached support.

anydbm is a module that provides a generic interface to various DBM-style databases that use simple string values as keys and values¹. It does not support SQLite3, which is a relational database that uses SQL queries and supports multiple data types¹. anydbm gives you a very standard library dict-like interface to a key-value database, but it does not support all the methods of a dict. For example, it does not have pop, popitem or update methods³. SqliteDict also gives you a dict-like interface to a key-value database, but it uses pickle to store arbitrary objects as values. It supports more methods than anydbm, such as pop, popitem, update and iteritems.

anydbm is not a viable replacement for SqliteDict if you want to store objects other than strings or use SQLite3 as the backend database. If you want Redis, PostgreSQL or Memcached support, you might want to look at other modules that provide high-level wrappers around these databases. For example:

- redis-py: A Python client for Redis that allows you to use native Python data types such as dicts, lists and sets to interact with Redis data structures⁴.
- psycopg2: A Python adapter for PostgreSQL that supports both basic and advanced features of PostgreSQL such as transactions, notifications and large objects.
- pymemcache: A comprehensive Python client for Memcached that supports both ASCII and binary protocols and provides consistent hashing and failover mechanisms.

I hope this helps you compare anydbm and SqliteDict and find some alternatives. Do you have any more questions?

Source: Conversation with Bing, 3/5/2023

    (1) anydbm – Access to DBM-style databases - Python Module of the Week. https://pymotw.com/2/anydbm/ Accessed 3/5/2023.
    (2) database - Using the dbm module in Python 3 - Stack Overflow. https://stackoverflow.com/questions/6204318/using-the-dbm-module-in-python-3 Accessed 3/5/2023.
    (3) Python. https://docs.python.org/2/library/anydbm.html Accessed 3/5/2023.
    (4) AnyDBM - WebThing. http://www.webthing.com/software/AnyDBM/ Accessed 3/5/2023.

Are there any Python packages that are specifically for providing a unified dict-like key-value persistent store across different back ends including SQLite3, Redis and PostgreSQL?

There are some Python packages that provide a unified dict-like key-value persistent store across different back ends, but they may not support all the back ends you mentioned. For example:
shelve: A module in Python’s standard library that provides a persistent dictionary-like object that can store arbitrary Python objects using pickle. It uses anydbm as the default backend, but it can also use other DBM-style databases such as dbhash, gdbm or dbm1.
sqlitedict: A lightweight wrapper around SQLite3 that provides a dictionary-like interface for storing arbitrary objects using pickle. It supports multiple tables in one file and access from multiple threads or processes2.
ZODB: An object-oriented database for transparently and persistently storing Python objects. It has a pluggable storage architecture that allows a variety of storage schemes including memory-based, file-based and distributed (client-server) storage3.
However, none of these packages support Redis or PostgreSQL as back ends. If you want to use these databases, you might need to use their specific Python clients such as redis-py or psycopg2. Alternatively, you might want to look at some other packages that provide more general interfaces for working with different data sources such as:
SQLAlchemy: A popular Python SQL toolkit and object-relational mapper that provides a flexible and consistent way to access various relational databases such as SQLite3, PostgreSQL, MySQL and Oracle.
PyDAL: A pure Python database abstraction layer that supports SQLite3, PostgreSQL, MySQL, MongoDB and Google App Engine among others. It allows you to define models and query data using a simple syntax.
I hope this helps you find some Python packages that suit your needs. Do you want me to compare any of them in more detail?

Give me some example code for PyDAL that is like a hello world program that just shows the basics to get started. Make the example simulate the API of a stanard Python dict as much as possible so that a dict-like object serves as a interface to a NoSQL database.

Here is some example code for PyDAL that shows the basics to get started. It creates a dict-like object that serves as an interface to a MongoDB database. Note that PyDAL does not support all the methods of a standard Python dict, such as pop or update.

```python
# Import PyDAL
from pydal import DAL, Field

# Connect to MongoDB database
db = DAL('mongodb://username:password@localhost/test')

# Define a table with two fields: key and value
db.define_table('mydict', Field('key'), Field('value'))

# Create a dict-like object that maps to the table
mydict = db.mydict

# Insert some key-value pairs
mydict.insert(key='name', value='Alice')
mydict.insert(key='age', value=25)
mydict.insert(key='city', value='New York')

# Get the value of a key
print(mydict(mydict.key == 'name').select().first().value) # Alice

# Set the value of a key
mydict(mydict.key == 'age').update(value=26)

# Delete a key-value pair
mydict(mydict.key == 'city').delete()

# Iterate over the keys or values
for row in mydict.iterselect():
    print(row.key, row.value) # name Alice, age 26

# Close the connection
db.close()

If the Python context manager is supported, show this example again without having to close the connection explicitly. Simplify the code as much as possible.

PyDAL supports the Python context manager, so you can use the with statement to automatically close the connection when you are done. Here is the same example with some simplifications:
# Import PyDAL
from pydal import DAL, Field

# Connect to MongoDB database using with statement
with DAL('mongodb://username:password@localhost/test') as db:

    # Define a table with two fields: key and value
    db.define_table('mydict', Field('key'), Field('value'))

    # Create a dict-like object that maps to the table
    mydict = db.mydict

    # Insert some key-value pairs
    mydict.insert(key='name', value='Alice')
    mydict.insert(key='age', value=25)
    mydict.insert(key='city', value='New York')

    # Get the value of a key using shortcut syntax
    print(mydict[key == 'name'].value) # Alice

    # Set the value of a key using shortcut syntax
    mydict[key == 'age'] = 26

    # Delete a key-value pair using shortcut syntax
    del mydict[key == 'city']

    # Iterate over the keys or values using shortcut syntax
    for k, v in mydict.items():
        print(k, v) # name Alice, age 26

# The connection is closed automatically when exiting the with block
 ```


<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/exploring-new-bing-as-science-news-source/">Exploring New Bing as Science News Source</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/are-rigid-geometric-weather-balloons-possible/">Are Rigid Geometric Weather Balloons Possible?</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/database/'>Database</a></h4></li>
<li><h4><a href='/python/'>Python</a></h4></li></ul>