---
title: "Python Programming Language Advantages & Disadvantages in 2017"
description: "Python Programming Language Advantages & Disadvantages in 2017"
permalink: /2011/01/python-programming-language-advantages/
---

# {{ page.description }}

## by Mike Levin SEO & Datamaster, 01/05/2011

Check out my **[YouTube Channel](https://www.youtube.com/mikelevin)**, [**Podcast**](https://itunes.apple.com/us/podcast/the-python-experience/id1165128787), follow me on **[Twitter](https://twitter.com/miklevin)**, connect on **[LinkedIn](https://www.linkedin.com/in/miklevin)** and see my **[Portable Linux](https://github.com/miklevin/Levinux)** and **[Python SEO](https://github.com/miklevin/Pipulate)** projects in Github.

## Newsflash: Python Overtakes Java as The Most Popular Language in 2017!

## ![Python vs Java 2017](/images/python-vs-java-2017-1024x275.png)

## Hear Why I Love Python More Than Ever, Going Into 2017...

<iframe src="https://www.youtube.com/embed/bdFhXRMFYGw" width="560" height="315" frameborder="0" allowfullscreen="allowfullscreen"></iframe>

# Welcome to Mike Levin's "Love Letter to Python" Article

![Daddy's Amiga](/images/daddys-amiga-225x300.jpeg)Is Python worth learning? **Yes!** This article is about Python vs. other languages, and why it became so endearing to me. I am not a professional programmer, yet I program professionally. In other words, I code almost every day _**at**_ my job, but not _**as**_ my job. If that sounds like you, then my experience finding Python and the difference it has made in my life and career may be of interest to you, oh seeker of the right language. Python's my favorite tech since the Amiga computer.

## Python vs. JavaScript? (one language or two)

Why not _**just**_ JavaScript? It's a tough one to answer. If you want one language to rule them all, then JavaScript is definitely your choice these days. If you're doing any Web stuff (and increasingly Mobile App work), then you _**must**_ learn JavaScript anyway. So why not stick with JavaScript on the server as well via Node.js and master one broadly applicable general-purpose language, particularly well suited for the Web? Well, it's a strong argument, and I would buy it, except for the fact that every instinct in my body tells me that with Python, I have finally reached a computer programming language I can actually love the way I did the Amiga computer, and in which I can "_**natively**_" think. Case in point:

#### Stepping through a collection in JavaScript:

for (var item in collection) {
  if( collection.hasOwnProperty( item ) ) {
    console.log(item);
  } 
}

#### Stepping through a collection in Python:

for item in collection:
    print(item)

I cannot emphasize enough that what you're (I'm) trying to achieve here is the same sort of spontaneous comfort-level and ability to express myself in a flowing, continuous and natural fashion which I enjoy in my native spoken language, English. I've always expected that after awhile with a language, I would be able to stop thinking about the language itself, and just type my thoughts expressively, just like I'm doing right now. This has been a quest of mine for quite some time, and I'm nearly 50 years old and have tried quite a few languages in my day. I have to say that Python is the first one that's really "sticking" for reasons that the above collection iteration example makes quite clear. Only the semi-colon needs to be explained.

[![Python Programming Language Advantages](/images/Python-Programming-Language-Advantages.jpg "Python Programming Language Advantages")](http://mikelev.in/wp-content/uploads/2011/01/Python-Programming-Language-Advantages.jpg)

Yeah, I get why JavaScript those extra required steps (filtering out the ever-present "prototype objects"). But this just shows how Brendan Eich made JavaScript with one set of notions in mind, and Guido van Rossum made Python with another. Few things exemplify Guido's simple common-cases-made-simple mentality better than iterating through members of a collection. If you're choosing your first programming language or found programming tedious so far, or are about to be sucked into the "full web development stack" JavaScript trap, then I urge you to open your mind.

## ![Jump On The Python Bandwagon](/images/python-bandwagon-300x241.png)Why Hop On The Python Bandwagon?

From the chart at the top of this article, which is derived from Google search frequencies (admittedly, skewed based on language difficulty or general user profiles) on words related to each language maintained by the [PYPL site](http://pypl.github.io/PYPL.html), only one language has a constant unabated upward trend. That's consistent over 25 years. Think about that. _**Python pulls ahead of Java for worldwide popularity in 2017**_ unless something causes an uptick in Java adoption again.

The Java honeymoon is probably over, right while more and more folks who don't have the time to become professional Java or C programmers but need the power of coding are picking up Python, such as the Data Science community. More and more people are getting over the terrible misconceptions that I think arise from its snake name, and having that "Ah-Ha!" moment, where you realize it's an omage to Monty Python, and start to get into that wonderful head of Guido van Rossum and fall in love.

## Python vs. Java (static or dynamic)

Since I first wrote this article in 2010, the question "why not just Java" has come up a lot too—on the complete opposite of JavaScript question. Whereas you can't get away from JavaScript on the front-end (developing browser-based user interfaces), it's hard to avoid Java software on the back-end, with various "killer server apps" with which you must interact (Lucene, Hadoop, etc.).

![Java vs Python](/images/java.jpg)Java is only popular today because CompSci departments around the world switched over to it from Pascal & C++ years ago because it spared students the tedious chores of pointer tracking and garbage collection during those critical learning years, and for the same simplification reasons, Python is now taking over that role in schools, being both an easy language to learn on and a powerful enough for industry. Whereas Java was only incrementally easier and powerful enough, Python is _**much easier**_ and _**powerful enough**_. And while Java disciples will insist otherwise, it's generally much better for your "primary spoken language" of programming to be the much easier one. I hereby predict that after 25 years already, we have only just begun to see the rise of Python's popularity. Just like English, it will become the lingua franca of tech.

### Which Hello World do you prefer?

![Hello World](/images/hello-world-300x300.png)Just like the "iterating through members of a collection" example above, highlighting the differences between JavaScript and Python, so too is there a core example illustrating the difference between Java and Python, called "Hello World". The Hello World test is simply showing how much code is involved in just showing the words "Hello World" on the standard output device (usually, a screen). The lesson here is that if you're going to rip off the syntax of another language to foster adoption (what JavaScript did to Java), don't choose one with head-bashing verbosity, which itself had ripped off its syntax from C++. Multiply these lines of code below by a million (for all the simple things), and you will have a pretty clear idea of your life in that language. Welcome to the concept of cognitive syntax fatigue. It's lowest in Python.

### Java Hello World

public class HelloWorld {
    public static void main(String\[\] args) {
        System.out.println("Hello, World");
    }
}

### Python Hello World

print("Hello World")

## ![Java Dogma](/images/dogma.jpg)But I Didn't Learn It That Way In School!

Of course, Java programmers may disagree that Python has a long future with you as your primary language for large projects, insisting that static typed variables are superior to Python's more dynamic nature, which would relegate Python's role to just "small" projects. But Python is a dynamic language on more than one front — it evolves. Support for static variable types now exists.

Google was originally implemented in Python, and Facebook in PHP. So, you can't judge a language by it's snooty detractors. Instead, look around you at the real evidence. Think for yourself. There's a derogatory put-down tendency deeply engrained in the programming culture. People love their tools and rapidly degrade into religiously polarizing notions. This is a love letter, so I'm guilty of that too. However, I feel this way at the end of a quarter-century quest to find the religion best suited to me. I haven't stuck with my first, second or third choices. After many false starts, and now over 5-years experience with Python, I accept that the non-conventional way of doing a thing may actually sometimes be the best. Often, the best way to do a thing in Python is called the "pythonic" way.

### ![Jupyter Notebook](/images/jupyter-sq-text.png)Scientists Agree: Python Just Might Have Something There

I've attempted to take-up many languages over the years that ended up just feeling like a necessary-evil. A couple years ago I _**thought**_ I found my one true programming love, Ruby! But in hindsight, I see it was just an infatuation from not really having seen a really beautiful language before. Python and Ruby are comparable in this way, but Ruby just didn't stick. I attribute that to its forced objected oriented-ness that being a subtle dissuasion. When I started using Python, I just kept finding more reasons to use it. It became a sort of general calculator to me. Speaking of which, I encourage you to find and install **[Jupyter Notebook](http://jupyter.org/),** which was developed to bring the power and ease of Python to the scientific community that doesn't have time for all that being a professional coder nonsense, but need to be effective manipulating their data nonetheless.

### ![Top 3 Benefits of Python](/images/nutshell-271x300.png)The 3 Biggest Advantages of Learning Python In a Nutshell:

1. Time-wasting matters of style, especially regarding enclosing curly-bracket positioning blocks, simply go away.
2. Whenever you're faced with a problem and are figuring out how to do it, there will be multiple well-documented ways.
3. You can become productive in Python fairly quickly even as a beginner, yet it will serve you in industry like a champ too!

### The 3 Biggest Disadvantages of Learning Python In a Nutshell:

1. Concurrency and parallelism, although completely possible in Python, are not designed-in for super-elegant use, as with JavaScript and Go Lang.
2. If you choose JavaScript on the server (and by default on the client), then you only ever need to know one language, and Python feels unnecessary.
3. If you like meta programming of the sort popular in LISP, then Python's one-liner anonymous functions called Lambda's are going to be limiting.

## Cutting back the overhead - Python indentation advantages

![Advantages and Disadvantages of Python](/images/advantages-and-disadvantages-of-python-150x150.png)Now what do I mean by this? The clearest example is the non-use of curly braces—or brackets of any sort, for that matter—as code block delimiters. One of the most debated matters of programming style in [BCPL](http://en.wikipedia.org/wiki/BCPL "BCPL")\-derivative languages such as C and Java is "indent styles", or how to arrange those curly-brackets for maximum readability—which happens to make absolutely no difference in how your program actually runs. Curly braces were a BCPL invention (a precursor to C) to help compilers—_**not**_ developers. Programmer time lost on these matters of style can now be measured in centuries. That curly braces have propagated to like every other "serious" language is one of the biggest and saddest facts in the world of information technology.

Ruby, Visual Basic and most non-C derivative languages instead of curly brackets use "keywords" such as Ruby's “def” and “end” for code blocks, instead of using curly-brackets. Python takes it one step further and only uses a keyword only at the beginning. The rest of the code block is contained merely by virtue of line indenting. That white space matters is perhaps the most controversial (contrary to most other languages) and pragmatic thing about Python—and drives plenty of people crazy who want to dis' Python on that basis—a position that fills with glee those of us who've traded in the pain of curly brackets for the clarity of whitespace long ago. However, the price of Python's innovation is the required use of a colon at the end of a function or class—the leaving-off-of-which is probably among the largest of Python newbie mistakes.

### For Example, Here Are Curly Bracket Examples in Other Languages...

**C++** (Placement of curly brackets arbitrary and a matter of style):

void function functionname()
{
    some code
}

...which can also be stated in this and other ways...

void function functionname() {
    some code
}

You can't imagine the time wasted on the discussion of the merits of each, and how ugly code gets when followers from each camp try to combine their code. Keyword languages are a little different...

**Ruby** (Uses keyewords instead of curly braces)

def functionname()
    some code
end

This is still allows matching end confusion to occur, especially with nested functions...

def functionname()
    def nestme
        more code
end
    some code
end

**Go Lang** (Like C, but must use [one particular curly bracket style variant](https://en.wikipedia.org/wiki/Indent_style#K.26R_style))

func functionname() {
    some code
}

### But Now Look At The Simplicity of This (Your Lizard-brain's Gonna Love Python):

**Python** (Only one keyword, but indents matter)

def functionname():
    some code

Now, isn't it a sigh of relief to be looking at Python? The system-1 lizard-brain inside your head likes Python. It puts you at cognitive ease, and doesn't demand work to look at the _**syntax**_ of code, freeing your higher-form consciousness to zero-in on pure meaning. Python is not a flowery language. To understand the psychological principles driving Python's steady up-take, go read Thinking Fast And Slow by Daniel Kahneman. He talks about a "system 1" brain, but he's talking about that fast-thinking lower-level animal part of the brain that frees up your higher-level cognitive capacity for the tough work of being human. That animal part of your brain _**loves**_ Python!

![Lizard Brain](/images/lizard-brain-300x285.gif)This Python whitespace stuff profound. Take a moment to let that seep in. It's contrary to most people's (conditioned) thinking—yet it appeals perfectly to your inner-lazy animal. How Python uses whitespace for code-block enclosures is both its greatest strength and weakness. It is either the reason you will embrace it and love Python for the rest of your life, or will run away, trying not to pollute your mind with anything that doesn't follow the ridiculous compiler-centric BCPL / C / C++ / Java / JavaScript / Go Lang / PHP curly-brace model. If you have any doubt that curly brackets are for compilers and not for people, check out why Google's new Go Lang [enforces](http://golang.org/doc/faq#semicolons) one particular sub-style of curly braces. Of course, there's LISP that uses parenthesis, but that's another story. LISP is always another story. But one thing you should _**never**_ let people convince you is that curly braces are the intuitive or correct way to define blocks of code. Nope! Just look at how they're all trying to arrange their code like Python anyway. If you're going to use the whitespace, you might as well make it _**mean something**_. Give Python a few months and then try going back to a curly-brace language.

\[caption id="attachment\_1060" align="alignright" width="350"\][![Python Indents Dresscode](/images/python-indents-dresscode.jpg "python-indents-dresscode")](http://mikelev.in/wp-content/uploads/2011/01/python-indents-dresscode.jpg) Python's Forced Indenting Results In Cleaner Code\[/caption\]

### But isn't the indent-amount in Python a matter of style?

Yes! You can indent the first line as much or as little as you want, but then all subsequent code in the block must remain consistent with the first line. By convention (the infamous PEP8), most people use 4 spaces for an indent (not tabs). I used to use 2 spaces, but went to 4 as I got more into Python. That's about as rebellious as you can get with Python programming style. Now this flies in the face of modern programming conventions where white-space generally doesn't matter, and code formatting is largely a matter of personal style. But Python uses the equivalent of a school dress-code, ensuring a certain amount of conformity between members, and... drumroll please... the elimination of overhead!

With enforced formatting, not only do you not need to decide how to dress in the morning with Python, but you also purge hundreds of lost man-hours resulting from indenting ambiguity. If it's indented in Python, then it belongs to that code-block. Readability skyrockets and misunderstandings plummet. Not only is this a personal advantage in efficiency, but it makes Python well suited for open source or other projects where programmers must collaborate on the same code. About the only matter-of-style they can waste time fighting over is whether to use 2 or 4 spaces for an indent. Code gets terse.

### Zero, Empty and None are False. The reverse is True.

Want shorter code? Every variable and object in Python also has a True-state or a False-state, IN ADDITION to whatever else they contain, so you can directly check whether they've been used yet. False returns on any number-variable set to Zero (0) or any string-variable set to Empty ('') or any instantiated object variable like a list, but which has no entries (\[\]). So you can instantiate variables or objects setting them to zero or empty, and check them later. Therefore, one of the most common if-checks that we do becomes ridiculously terse and readable:

if checkme:
  print("I have been used")

Go take a moment to check how to do the equivalent in JavaScript. I'll wait. Back? There is about a zillion conflicting opinions, and one way is probably just as good as above, but it's probably going to at least have parenthesis and curly brackets... which do you use where? And why? Oh, that feels arbitrary. It is? Oh... okay.

On the flip-side of this pro-Python terseness argument that very few other popular popular programming languages work this way, in which indenting matters, and everything is capable of returning True or False. If you are making Python your "native language" (i.e. your first programming language—the language that you will end up "thinking in"), you are NOT getting used to the standard conventions of the world's most prevalent languages, that all litter themselves up with curly braces: Java, JavaScript and all variations of C, such as C#, C++ and Objective C.

Whether this is a good thing or not is a matter for philosophical debate. I made my choice, preferring to strip out the overhead in 99% of what I do day-to-day, and deal with it in those rare instances when I really have to use C to optimize my Python code (more on that later). After stints with Java, C++ and JavaScript, you can't imagine the relief of getting curly braces out of my life.

Let me remind you at this point, I am not a career programmer. I am not trying to get a job based on my programming skills. I am trying to get things done that require automation and process-streamlining that exceed my competition in a non-programming—but still, knowledge-based—field (SEO).

## No ambiguous ducks allowed!

[![Python Duck Typing](/images/ambiguity-not-allowed.png)](http://mikelev.in/wp-content/uploads/2011/01/ambiguity-not-allowed.png)

Okay, so indenting matters, and that's the single biggest personality-shaping characteristic of Python. Code gets more terse. Speaking of terse, Python doesn't require declaring and typing variables before using. The first time they're used, they're declared, and they hang around until you go out of scope, and they get destroyed. This is called [duck-typing](http://en.wikipedia.org/wiki/Duck_typing "Duck typing") with garbage collection—if it quacks like a duck, then it’s a duck. Advantage? Disadvantage? Let's take a look.

This is the second most personality-defining part of the Python programming language from my perspective, but not just for duck typing, but for how _**it's implemented to reduce misuse**_. It's hotly debated whether duck typing is good for writing stable, bug-free code, but it's awesome for making your program even shorter and even more readable. But how can a language be worthy of loving if ambiguous duck typing lets bugs in?

As a concession to keeping bugs out, Python creates a forced-stop error if you try to do anything ambiguous with a variable, like adding a string and an integer. For example:

'Ni'+3 # would fail

...because Ni is a string and 3 is an integer, so you might want concatenation or type conversion. But

'Ni'\*3 # will succeed

...because there is no such ambiguity and this can only mean Ni 3 times:

NiNiNi

[![Compiler Safety Net](/images/300px-Mosquito%2Cnet%2Cinside%2CTamilNadu404.jpeg "Compiler Safety Net")](http://commons.wikipedia.org/wiki/File:Mosquito%2Cnet%2Cinside%2CTamilNadu404.jpeg)

### Compilers Aren't Your Only Type-Safe Safety Net

So, Python is indeed duck-typed, but _**it won't do any of that auto-conversion magic for you if there's more than one possible meaning**_. That gives you all the advantages of duck typing without the one whopping huge drawback (of letting bugs in). If it's ambiguous, it raises a fatal error—that's a pretty big tenant of Python. The net result is that all those bugs that variable-typing Nazis get furious about just don't happen in practice because the code immediately stops running until you fix it. Once again, witness the pragmatic flair of Python. Pragmatism wins out over purity, and as a result, Python code only gets shorter, more readable, and reliable code. I thought those were static-typed language

But to really appreciate this, you have to consider the time you burn typing and sizing variables in strictly static languages, like C or... gulp... Scala. In those languages, you must do it on every new variable at the time it is created. This is basically everywhere in your program—hundreds, thousands, tens-of-thousands of times throughout your program. With explicit variable typing comes tons more code to manage, whereas with Python, you must be explicit only at the moment where something might be misinterpreted when you try to use it, otherwise the program won't run.

### Stop Burning Time Typing Variables You're Just Going To Convert, Anyway

[![Burning Time](/images/burning-time.jpg "Burning Time")](http://mikelev.in/wp-content/uploads/2011/01/burning-time.jpg)These instances of ambiguity are less-common, and identified for you the moment you try to run the program, so Python is actually still favoring explicitness. It just favors it at the less-common moments when it's necessary versus burning time with explicitness all over the place (for no good reason, given Python uses an interpreter versus a compiler). Of course static languages that force you to declare and size variables, and then use compilers to make the most efficient executable code possible to run faster, and there is advantage in that. But so long as you're using an interpreted language (yes, I know... Python and its ilk are actually pseduo-compiled bytecode), you might as well get the full advantage of immaculately terse and readable duck typed code. This is one of those cases where the arguments for well-designed high-level interpreted languages will get stronger as CPU processors get faster, and you're no longer paying to save YOUR time as a developer at the expense of your users. I think we're already there.

## By Ref unless otherwise Stated.copy()

What else do I love about Python? Well, it made me finally understand the by-reference versus by-value that I found so ambiguous in other languages. This deals with the eternal headache in programming of having enough power to write things that explode in your face—figuratively. By explode, I mean needlessly using up all your system's memory fast. It's a variation of the Sorcerer's Apprentice problem, but instead of intentionally making new brooms, you make them accidentally whenever you use it, and pretty soon you're drowning in brooms.

In Python, everything is automatically a reference, and you have to ask explicitly to get a copy of a truly new copy of an object in memory using methods such as .copy(). I find that I get just a better understanding of what's going on, and that it becomes harder to create accidental memory-bloat. This applies to objects, and not to numbers, which takes awhile to keep clear in your head, but the pragmatic benefit is worth it. So, for example:

#This will make a copy of the integer
>>> a = 1
>>> b = a
>>> b = 2
>>> print(a)
1

#But this will reference the original object
>>> a = \[1\]
>>> b = a
>>> b\[0\] = 2
>>> print(a)
\[2\]

This is because the first case is an integer, and there's little opportunity for memory-bloat or object-mangling, so the behavior that you've come to expect in every other language applies. You can instantiate new instances of numbers all over the place without limit, and they are essentially copies of each other. But try to do the same thing with any complex data object—a list in this case—and you will see everything suddenly start to become references to the original object in memory. Why is this the pragmatic choice for Python behavior? Advantage or disadvantage? Advantage, once you grok it! Let me explain why...

[![Star Trek Transporters Can't Copy](/images/star-trek-transporters-cant-copy.jpg "star-trek-transporters-cant-copy")](http://mikelev.in/wp-content/uploads/2011/01/star-trek-transporters-cant-copy.jpg)

### Star Trek's Ridiculous Transporters Illustrate ByRef vs. ByVal

It is more likely that you will mangle your original objects in-place, resulting in instantly noticeable bug, rather than ones that slip quietly by, growing in size in the background until your system performance slows down. In-short, Python has made you much less vulnerable to one of the the easiest to commit and hardest to track-down bad coding faux pas: memory abuse! So, feel free to write recursive functions that pass objects to themselves. It's kinda like the Star Trek transporters that can't copy, except for the rare instances like when you're Tom Riker in the Memory Alpha episode of Next Gen.

So you see, your already terse, readable code is simply less likely to cause memory-leaks by design. A principle similar to duck typing, where you are explicit, but only when you really need to be, is at work here. That clever rascal, Guido van Rossum, has made a system by which the aspiring newb who knows enough to be dangerous has to work pretty hard to shoot him or herself in the foot. You get the "conventional way" things should mostly work with hardly any code, and you have to begin ADDING code to override that default behavior to take the training wheels off the bike.

Knowing that as a rule all variable-passing between functions never copies, but rather references the original object in memory is very liberating. It makes you understand a lot more about memory usage in your own code without all that explicit heap, stack, byref and byval nonsense that bogs down the code in other languages and burdens the programmer with precisely the type of housekeeping computers should be good at anyway. You get to intuitively understand the stack, realizing how all un-returned local variables get destroyed when exiting functions. Balloons inflate. Balloons pop. If you don't carry that balloon around on a string, it's going to pop. If you want a copy of an object in memory, you explicitly ask for it, and that turns out to be a more efficient place to be explicit than everywhere else in your code. Again, the upshot is that you get more terse, readable code.

## Python IS a Framework

[![Framework](/images/scaffolding-framework-239x300.jpg)](http://mikelev.in/wp-content/uploads/2011/01/scaffolding-framework.jpg)Python's approach of making the most common desired behavior the default, then overriding it for special cases is much like what "joyful frameworks" (pretty much everything since Ruby on Rails) are supposed to do. Such frameworks are larger systems built on top of a programming language designed to make your most common tasks easy—so long the things you are trying to do are approximately what the framework designers imagined.

Well, Python did this too—right down to building a low-level webserver right into native Python! Creating a fully functional webserver is the following line:

python -m SimpleHTTPServer

And so what Guido has done is made Python get 80% of the way to a polished finished framework—say for example, a web-programming one of which there are tons. That's why there's only PHP in PHP, but there's Pylons, Zope, Flask, Django, web.py, webapp2, CherryPy, bottle.py and a ton of others. It seems that everyone's favorite sport is to slam out a new web framework on top of Python just to kick its tires.

### Apache, nginx, gunicorn external webservers are OPTIONAL!

Just to clarify here, NONE of the aforementioned solutions has a webserver like Apache or nginx in the picture. The "frameworks" are only provided to turn an otherwise non-web-like language into a web-like one where you can insert code into HTML files PHP-style or make Python programs "emit" web pages more easily. All these frameworks are just a bunch of files SITTING DIRECTLY ON PYTHON providing template or quick-app-bulding rules while Python provides the webserver itself. Yet, if you WANT nginx you can still use it with Python with minimal modification to your code, thanks to the API standards (called WSGI), so its the best of all worlds. Grok that.

Advantage or disadvantage? Advantage!

### Focus on the correct Framework: Python itself! Oh, And Avoid Code Generators!

Having so much pre-built in an already framework-like way in Python is _**not only an advantage for beginners**_, but also lets seasoned pros save a bunch of time building up directly on top of Python as their framework-like starting-point, cutting ACTUAL framework dependencies out of the picture. Their work can therefore appear less cookie-cutter template-like, while still delivering very sophisticated features without having to build it up from scratch. This is the case with my favorite Web framework on Python: Flask. I never feel like I'm using Flask in particular. I feel like I'm just using Python. The components of Flask (Werkzeug and the Jinja2 templates) only sprinkle a light set of rules regarding http request routing and a PHP-like page templating system on top of very familiar Python.

As a result, your expertise accumulates where it counts: the core language and not the frameworks—oh, except for Django. In the case of Django, it's more about the framework, but there are always exceptions. Don't choose Django on Python unless it's a REALLY CLOSE fit to your needs. Otherwise, do yourself a favor and choose something lightweight like Flask and get creative.

One things frameworks can sometimes do is actually generate some code for you. This feature is appropriately enough called code generators (not to be confused with a Python generator function). But I feel, why let something else write your code? The price of spewing out some magical scaffolding for you to step in and start customizing is that you have to learn the language pretty deeply anyway customize, but now having a basically competent (and usually [CRUD](https://en.wikipedia.org/wiki/Create,_read,_update_and_delete)y) app thrown into place predisposes your way of thinking, cuts off creative solutions that could have only come from you, and generally gives your application an easily recognizable and undifferentiated "software signature"—making you look just like everyone else. Code generators are very popular on Ruby for example, which is no surprise as Ruby's main claim to fame is the Rails framework, which is basically a massively predisposing scaffolding-vomiter. If you really want code generators in the Python world, you can look at Pylons which is a lot like Flask, but it'll spit out the scaffolding for you with a code generator.

## Lists are just really well done in Python

\[caption id="attachment\_1082" align="alignright" width="446"\][![Morbo LISP Lists](/images/morbo-lisp-lists.gif "morbo-lisp-lists")](http://mikelev.in/wp-content/uploads/2011/01/morbo-lisp-lists.gif) Both Morbo and Paul Graham are big advocates of the LISP programming laugage.\[/caption\]

Okay, now for the sexy bit. Many languages bill themselves as list manipulators, and have array or vector structures to represent and allow the programmer to interact with them. LISP, PERL and TCL are all known for this, with the L in LISP actually standing for this (and arguably, in PERL as well—pathologically eclectic rubbish lister). Lists in LISP are among the most basic building-blocks, from which almost everything is built-up making powerful meta-tricks possible that programmers like Paul Graham would argue are just not possible in other languages. Unfortunately, you have to be a pulsing-brain alien to use them.

But there is another kind of list—easy-to-use containers for a series of values, often thought of as arrays. But the "list" container can be more versatile than a mere array, ready for countless general-purpose tasks, such as mini-databases of name/value pairs, FIFO/LIFO stacks and more. Such list-like array structures spare you from building them up from scratch in every program you need them (which is always) and inventing possibly inconsistent interfaces to them. Python employs the list concept as well, making it and its close relatives the dictionary (key/value hashes) and tuples (immutable list) into front-and-center features that heavily shape Python's personality. Here's making a list then iterating through it:

alist = \[\]
alist.append("spam")
alist.append("eggs")
for item in alist:
  print(item)

This can also be stated as:

alist = \["spam", "eggs"\]
for item in alist:
  print(item)

And dare I even tell you about list comprehension by which you can do the already terse above loop as:

alist = \["spam", "eggs"\]
\[print(item for item in alist)\]

...which can make complex statements calling for the iterating-over and acting-upon a lot of sub-lists into some very efficient and elegantly stated code—all the more elegantly. Ruby people love their Regular Expression one-liners (which ARE very nice), but Python people can do some amazing one-liners with list comprehension.

I also feel the need to point out that:

\['Hello World', 'This is list 1'\] + \['Hello World 2', 'This is list 2'\]

...becomes:

\['Hello World', 'This is list 1', 'Hello World 2', 'This is list 2'\]

...and likewise:

a = \['Hello World', 'This is list 1'\]
b = \['Hello World 2', 'This is list 2'\]
c = a + b
print(c)

...will also output:

\['Hello World', 'This is list 1', 'Hello World 2', 'This is list 2'\]

Yes, adding 2 lists together is that easy.

Python documentation sometimes call lists, dicts and tuples first-class data type objects, like a string or integer, just with plenty of built-in methods like iteration, popping, appending and sorting. All these structures can be arbitrarily nested for complex objects (jagged-arrays in other languages), and represented as ASCII strings (even when containing Unicode) making Python data ridiculously easy to transport—very similar to JavaScript's JSON notation in which the string representation of an object is so readily swapped with the object itself in memory. Built-in libraries can flipflop your object in memory between JSON and native Python, so JSON-based web service API-work is a snap.

So, we have a dictionary object in our program (which are hashes, or collections of name/value pairs), and we need it to be JSON:

\>>> adict = {'spam' : 'delicious', 'eggs' : 'delightful'}
>>> import json
>>> ajson = json.dumps(adict)
>>> print(ajson)
'{"eggs": "delightful", "spam": "delicious"}'

It's worth pointing out that single-quotes and double-quotes are interchangeable in both JavaScript and Python, and which you select is by convention, and to encourage clarity. For all intents and purpose, the visual representation of the object in memory is almost identical with Python and JavaScript. If we wanted to convert the JSON back into native Python...

\>>> bdict = json.loads(ajson)
>>> print(bdict)
{u'eggs': u'delightful', u'spam': u'delicious'}

The "u" token is inserted as Python's way of representing Unicode. Essentially the only difference that happened to our object as it got passed around is that it got "converted up" to Unicode—not the worst thing in the world. While not as awesome as having JSON, the emerging lingua franca of simplified data interchange as your native object language, Python is an extremely good neighbor, making translation a mere formality.

And even though it potentially deserves its own section in this article, I would be remis if I did not mention Python slices, which is basically just a string and object manipulation syntax whereby you eliminate the need for functions like instring, indexOf, left, right, mid, and all those other string-manipulation functions that make grabbing sub-strings so hard. In other words, if you want only the middle of "middle", you would say "middle"\[1:-1\], which would chop off the first and last character to produce "iddl". Slices are yet another one of the strengths of Python, and there is so much more to say here, such as pointing out negative indexes, but the astute reader should be able to infer all that. Slices work on strings and lists, and just makes everything about manipulating text and lists so much cleaner and terse.

\>>> astr = 'homeslice'
>>> print(astr)
homeslice
>>> print astr\[:\]
homeslice
>>> print(astr\[:-1\])
homeslic
>>> print(astr\[-1:\])
omeslice
>>> print(astr\[-1:-1\])
omeslic
>>> print(astr\[1:3\])
om
>>> print(astr\[:4\])
home
>>>  print(astr\[astr.find('s'):\])
slice

The upshot of all this list stuff, is that the data-container mechanisms called for throughout nearly every programming pattern is built into Python, making some of the most common and tedious tasks in programming actually a pleasure to perform. Populate a list. Append and pop values. Grab sub-lists. Pass the whole thing as an argument to a function—no problem. Learn the interface to a list, and you pretty much know the interface to dict's and tuples. Python quickly turns you into a list loving mad hasher. It's soooo easy, that many folks make their first project with Python building yet another framework—when in reality you may not even need it because Python is so far along to being a framework already itself.

The advantages are so numerous, I can hardly list them!

Again, we encounter the concept here of Python having a lot in common with a "framework"—something usually added on top of a language. The parts of Python are built up just enough towards being a framework to spare you the desire to add yet another level of framework, and by being part of the core distribution, you can rely on these perfectly-sized building blocks being there in every Python program you write. Getting familiar with them, and how to best use them, leads to the "Pythonic" way of thinking. When you achieve it, you will stop having to look for code examples, except of course for learning the interfaces to libraries you haven't used before.

Yes, larger third-party Python frameworks like django are still there in the wings waiting to be a sort-of Ruby on Rails for Python, but I think I would recommend resisting django for awhile when taking up Python, just to appreciate for awhile how framework-like Python on its own already is. Python strikes this nice framework-balance without going overboard, with a gargantuan Class Library where you have to use obscure dot.this.dot.that notation in an insane sort of scavenger hunt just to do simple things, such as with Java or .NET. Python is just chunky enough, with lists being the tastiest bits. Some people find that where Python falls just shy of being super-easy for Web development, you can add a very lightweight framework like Flask to take you that last mile without having to jump on the Django tank.

## Files just become namespaces

[![Python Namespaces](/images/python-namespaces.jpg "Python Namespaces")](http://mikelev.in/wp-content/uploads/2011/01/python-namespaces.jpg)

Okay, time to talk code manageability. Many computer systems have the concept of modules and namespaces. In Python, these concepts are tied together, and latched firmly onto "files". So, each file on the hard drive (or whatever) in a Python directory is a module that can be imported into any other file in that directory, automatically getting it's own namespace that is the same as... drumroll, please... the name of the file! If you see something-dot-something, and the first something isn't built into Python or a class in your current file, you're going to find a file by that name on the drive—probably in the folder you're working in. So in Python, you barely need to understand namespaces to get their benefit—you're just sort of using them automatically—another big boon for collaboration.

Did I mention importing modules? Okay, here's the part that blows my mind: you can keep re-importing the same modules all over the place with no loss of efficiency. Unless explicitly stated otherwise, the library is imported only the first time it's needed, and subsequent imports merely reference the original import to make namespaces available. In other words, file A can import file B and file B can import file A, and there's no problem with that. This will not create an infinite loop of imports, and in fact, it will have the desirable consequence of file A's namespace being available in file B and visa versa.

This mutual importing as an encouraged technique to manage namespaces took me awhile to grok, but it was awesome when I did. Resultingly, some code nests module imports deep in a function, assuming the module will only be loaded into memory the first time it's needed. Conversely, you can write one common file that does all your module imports, and import that in each of your other modules for a global resources approach.

## The good, the bad, and the good again

\[caption id="attachment\_15642154436" align="alignright" width="435"\][![The Python Language is Named For Monty Python](/images/python-language-named-for-monty-python.jpg "The Python Language is Named For Monty Python")](http://mikelev.in/wp-content/uploads/2011/01/python-language-named-for-monty-python.jpg) The Python Language is Named For Monty Python—NOT the snake.\[/caption\]

Okay, if you're thinking Python sounds fun, keep in mind that it was in fact named after Monty Python—and NOT the snake, as is commonly believed. So, instead of foo and bar, you will frequently encounter spam and eggs in example code, along with Knights who say 'Ni'\*3. And although Python was created by a single individual, Guido van Rossum, who managed to get himself hired by Google (which was developed partly in Python), the language is now maintained and advanced as open source by a committee, using Python Enhancement Proposals (PEPs)—with Guido named the benevolent dictator for life. The community is willing to break compatibility with older versions when something really objectively needs to be improved.

One thing that really needs to be improved is the Urllib2 library. Just by its very name, you know that you need to be "in the know" that you shouldn't be using the original Urllib—which is particularly a shame, because this is the first thing you want to do in Web Service programming. And even so, just to change the useragent of an http request, you have to go making functions that inherit from a superclass and override methods. That really sucks if you don't know object oriented programming, which can be avoided in all other regards. Making simple http requests is much easier in Ruby, but this can be alleviated by adding the Request module, which I hope will be wrapped into the Python core libraries.

So, Python is not trying to be everything for everyone, and has its occasional annoyance. I think it's just trying to be many things to most people while minimizing annoyances. Computer science types might be more satisfied with LISP or C that let you get "closer to the metal" to yield higher performance, or meta-languages with more robust support for anonymous functions, like LISP or Ruby, enabling certain things that are nearly impossible in other languages. Also, an optimized high-speed runtime environment isn't on of Python's strengths, nor is it undergoing the evolutionary pressure imposed by the browser JavaScript runtime speed arms-race, such as occurring with the Google V8 engine that made node.js possible, and whatever Microsoft and Firefox are doing.

### JavaScript: One Language To Rule Them All

[![One Language To Rule Them All](/images/one-language-to-rule-them-all.jpg "One Language To Rule Them All")](http://mikelev.in/wp-content/uploads/2011/01/one-language-to-rule-them-all.jpg)

In fact, about the only reason I can think for a newbie to NOT take up Python is that you MUST learn JavaScript at some point, as the defacto standard way to do client-side programming for the Web browser. A year ago, this would not have been compelling enough, because you would still have to pick a different language for the server, but with the new node.js project, JavaScript is once again (since the now obsolete Netscape Server & Active Server Pages) a valid option for server-side programming—and possibly, the one language to rule them all. If your goal is to only ever have to learn one language, JavaScript might be your choice these days, with the advantage that you will be getting somewhat familiar with C and Java syntax—if you see that as an advantage.

And finally, Python's fun, high accessibility to newbies, open source-ness and willingness to break compatibility would generally make most old-school programmers look on it with suspicion, and consider it not to be a "real" language—you know, one with a super-optimized compiler for creating binary executable. Well uh, while it's not the norm, you can create binary executable with Python, and even so, it's not trying or pretending to be C or C++.

But when the time comes to super-optimize your Python code, it does work quite nicely with either C or C++. Both can communicate with Python, allowing Python modules (files) to be swapped off with compiled C/C++ for hotspot optimization. This means that learning Python lets you flesh out applications quickly, speeding up development speed at the sacrifice of application speed. But when application speed becomes the priority, you can start swapping out bits with C, arguably making Python a productive step on the way to C.

Python is a language for which a newbie and pro alike can love. It can be a stepping-stone to C or C++, or an end in-itself. As an end in-itself, Python is different from most any other language, but in ways that yields great advantage, making it actually worth diverging from the mainstream. Yet, Python still manages to hang on as a mainstream language.

I'm not a professional programmer, but nearly everything I do directly demands programming, so I need a language I can take up again between long stretches of inactivity, without feeling like I have to chase the rabbit down into Wonderland to be productive again (as you do with languages with lots of overhead). Plus, following what I can only imagine to be a similar line of reasoning, Python is the first language to break LISP's 20-year stronghold on MIT's legendary introduction to computer science course.

It seems that in almost every discussion LISP is the exception to the rule—which is both its greatest strength and weakness. If you're ready to chase that rabbit down the hole into Wonderland, and become a professional programmer with super-powers, then LISP may be your best choice. If you're just getting started and you want to only ever have to learn one language, then JavaScript is your best option. However, if you are a casual non-professional programmer like me, and want to simply love the opportunity to take on the occasional programming project and want super-powers when you do, then Python may be for you.

Thanks for sticking it out through such a long love-affair article about Python. For those of you who are here mostly to learn the benefits, you can stop reading now. For the more sadistic among you, I have prepared a few more words on the disadvantages of Python.

## Disadvantage: Less-than Elegant Parallelism

Python is much maligned for something called the Global Interpreter Lock, or the GIL. It doesn't stop Python from doing parallel processing, but it does create some gotcha's in edge cases, like when you're using components that have parts optimize and compiled in C-code, which is done for execution-speed anyway, like NumPy and SciPy. However, for many years now, multiprocessing has been included in the Python core libraries, and if you're into it, there's nothing stopping you from using Python that way. It's just that it wasn't designed-into Python from conception, the way it was with JavaScript, Google's Go, Ericsson's Erlang, or the LISP dialect called Clojure.

### Not Parallel By Design

All these languages assumed high level of parallelism, multithreaded, concurrency, non-blocking I/O, Asynchronous IO or one of the other terms used for doing lots of stuff at the same time. Each language had different reasons for designing easy concurrency in as a core tenant of the language, like JavaScript didn't want the user to have to wait after the browser made some sort of request of a server thousands of miles away. At Ericsson, the system folks wanted code that would run continuously in their telecommunications systems even right as they swapped hardware in and out, so actual running programs are able to flow around while still running and not caring what actual physical instance of hardware they were running on. And so on.

This was just not so with Python. Python actually does have various approaches to parallelism, both in core and external libraries. You actually can take advantage of multi-core CPUs going back to Python 2.6 using the multiprocessing library that essentially side-steps the GIL. It can either use multiple cores in the same computer or remote machines. It did this by using subprocesses instead of threads, letting you do some pretty cool stuff like process pools. In my mind, this is much like how Regular Expressions is very natural in Ruby and therefore "better" because it is designed in as a core-assumption of the language (you WILL be doing RegEx matching), but Python's implementation is more powerful… but obtuse. Not designed-in doesn't mean worse. It just means not straightforward and usually more choices.

### Nothing Blocking Python Since 3.4

Did I mention more choices? Well, just like the multiprocessing module hit the Python core libraries since version 2.6, technically invalidating everyone's GIL-bellyaching, JavaSript-ish asynchronous IO hit Python 3.4 in a new core module called Tulip (oh, those Dutch and their tulips). While asynchronous IO is related to multiprocessing and multithreading, they are not really the same thing. A thread that does something that's going to require a returned value usually freezes everything until that value is returned. That's synchronous IO. Things happen in order. The big thing JavaScript popularized is not having to wait. A request is made, and then whenever the (often remote) service answers the call and does it's thing, a callback function is executed, interrupting the original calling thread and the data gets wrapped back in. It might have done other things in the meanwhile. So even with one core, asynchronous IO can help if the thing answering the call is another computer, or maybe an IO devices like a hard drive or display device with its own processor.

### More Farting In the General Direction of GIL-kill

Okay, after all this, people are going to say… yeah, but there's still the GIL. Well, the much-maligned Global Interpreter Lock only comes into play if you're using Python modules that were compiled in C for optimization and performance, like NumPy and SciPy. And be reminded that the class of number-crunching operations that things like NumPy and SciPy are for are not necessarily even the type of Web apps that require asynchronicity. Further, if they actually do need it, you could just fork a process and not get hung up on doing inside a thread in a threadsafe-way that makes you run up against the GIL. You just have to understand the issues and deal with them in a way that Go and Erlang people don't need to. Python makes you pay in the edge cases—NOT in the things most people have to do most of the time.

If you're just simply coding Python apps using Python code and not relying on components with C-optimized parts, you actually will get the benefits of multi-core CPUs when you use the multiprocessing modules. No GIL issues at all. You just have to import the multiprocessing module and adjust your coding style.

### Delightful Everywhere Else

So there you have it—the one big disadvantage of Python comes down to adjusting your coding style to use parallelism if you want parallelism. The direct procedural style of programming that Python encourages by virtue of its terseness and obviousness clarity is not going to take advantage of multi-cores automatically. This is in contrast to other languages like JavaScript, Go and Erlang for whom parallelism was a top priority, and by design encourages you into that programming style.

Yup.

### What are the benefits of learning Python?

### So, Should You GO to Python?

Google made that decision. NOTHING out there was good enough for them, so they put one of the fathers of modern computing, Ken Thompson who invented Unix, in charge of the new Go programming language, designed to compile WAY faster than C++, provide the asynchronous IO of JavaScript and the beauty and pragmatism of Python. So why not use Go? Maybe you should! Go take a look and make the decision for yourself.

But in the end, I myself am not a professional programmer, and I may go for months or even years without a serious programming project. And so, I need to re-instantiate my initial state. I need to get back into the zone. I need to climb on the bicycle again after years. And THAT is where all that aforementioned love for Python comes into play. It just working the way you would want and expect most of the time, and only having to worry about extreme explicit declarations or less-commonly desired behavior (copy vs. reference) at edge cases… well, it lets you re-instantiate your ready-to-program state faster.

To NOT consider Python because you want to fully embrace the "full web stack" JavaScript/node.js would be a mistake. JavaScript in my mind has become forever more like Regular Expressions. They are their own entire unavoidable sub-language required for their own special domain (web-UI). But as Alan Turing once pointed out, any Turing Complete language could be used to do anything any other language could do. But that's not to say, one language can't make a particular (and in the case of Python, VERY LARGE) set of tasks easier to accomplish than other. It can.

## Python versus JavaScript and node.js

JavaScript was probably my first choice of language when I started a major personal re-platforming off of Microsoft Active Server Pages and VBScript back in 2009 in order to get that "one language to rule them all" advantage. This intuitively made sense to me, because even then you HAD to learn JavaScript in addition to whatever else you took up, because it is the defacto standard language of the web browser client. And the symmetry of JavaScript on both the browser and server just appeals and makes sense. JavaScript is no stranger to the server, even long before node.js. For example, ASP supported a M$ variant of JavaScript on the server, and ages prior, the Netscape Commerce Server also used JavaScript on the server.

But around 2009 before the node.js project appropriated the Google V8 JS engine, there really were no mainstream viable choices for JavaScript on the server. I played around with Helma, which used the Mozilla-based Rino JavaScript engine (a precursor to the Google V8 engine), but it was extremely fringe, and my experiments did not work out that well. Had I conducted my investigation only a year or two later, node.js would have been on the scene, and the only thing keeping me from using it would probably have been the lack of mature client libraries for things like the Google Data API (gdata), which was always made available in what were deemed the two "enterprise languages" of Java and .NET (C#). This notion that Java and .NET are the enterprise languages that you must use for projects deemed worthy of banks and other failsafe, security-minded organizations continues today. I am not in a position to say whether this perception is true, but they do seem to be for organizations that need the might of Oracle or Microsoft adding credibility and support to such high-risk installations. Having previously ruled out both Java and .NET as my languages of choice, that left only Python, and in all honesty, that's probably the main reason I didn't choose JavaScript on the server.

So, would I choose JavaScript today on the server, with node.js and the wonderful NPM remote package management system (better than Python's) and it's web-friendly non-blocking concurrent design and awesome full free and open source tool stacks, like MEAN (MongoDB, Express, Anglular and Node)? Having taken a long hard look at JavaScript as a "primary spoken language" as this article addresses, and having now the benefit of having fully embraced HTML5 and "must-know-JavaScript" and having carried out a project-or-twenty involving fairly sophisticated JavaScript-on-the-browser, I can now firmly and definitively answer: NO! I would NOT choose JavaScript as my primary natural first programming language. I feel I dodged a major bullet that would have set back my love-of-programming (and hence, the projects themselves) had node been on the scene when I had to make my choice?

Why do I feel like I dodged a bullet by not adopting JavaScript on the server? That would be a whole other article, suffice to say: try iterating through a container object in Python (one of the most common tasks in all programming), and then try to do the same thing in JavaScript. In addition to having to deal with all the stupid curly brackets inherited from JavaScript trying to be like Java trying to be like C trying to be like BCPL, you ALSO have to specifically filter out things that may be "floating around" in that container object that comes from the object's prototype class, that you don't know is there tying to be counted along with, say, a set of numbers you threw into an array. Here's how you iterate through an object in Python:

for item in container:
  print(item)

And in JavaScript, the (unavoidable) equivalent has a whole other step just to filter out prototype members:

for (var item in container) {
  if (container.hasOwnProperty(item)) {
    alert(item);
  }
}

Now multiply this by several million times having to deal with this over the course of your life, and you'll start to get a feel why I'm glad that I didn't choose to use a language designed primarily for managing web user interfaces (JavaScript) as my every day common chores language. Non-blocking I/O and that "one language to rule them all" siren's song of JavaScript is just not reason enough to add... drumroll please... Yes, tons and tons of extra, un-necessary, and far from pragmatic process to your common daily chores.

Now I won't say that it's the need for hasOwnProperty() alone that fuels my aversion to JavaScript. It's that smoothing out such rough edges in the main daily chores of programming does not seem to be a priority in JavaScript... like even at all... like not even one little bit. For example, the keyword for function is function, rather than the much easier to type and look-at def or func in Python, Ruby and Go (respectively). Plus, you HAVE to use the curly brackets and battle style issues—style issues that you have to deal with again with the use of semicolons. Oh, did I mention parenthesis must in the most arbitrary-feeling way possible MUST be used around comparison operators in evaluations whether or not you need them to wrangle order-of-operations.

And everything just takes so much space horizontally with long document object model names and methods like the always-needed Document.getElementById(). Yeah, sure there's JQuery to collapse it down to $("#\[id\]") but still...

Once again, I advocate going for the most benefits in the most use-cases (Python) and not the best benefits in edge cases. Some would argue JavaScript's approach to concurrency isn't really the best thing going out there, when you've got stuff like Erlang and Google's relatively new GoLang handling concurrency much better, with less of the timing-ambiguity of anonymous callback functions that JavaScript relies on so much. I choose not to take up a primarily edge-case language that has lots of strange hoops for you to jump through for the MOST COMMON everyday tasks (yes, even more everyday than concurrency) that should flow off your tongue (or fingers onto keyboard) in a process very close to natural spoken language, as Python does.

## Python versus Ruby (on Rails)

Python versus Ruby is an interesting one, because both languages are so similar in conceptual design. Ruby is significant because it was most mainstream programmer's first exposure to both a philosophically pure and uncompromising language designed to take the best of a popular program other-than-C (PERL, in this case) in addition to most people's exposure to a truly joyful framework—meaning that conventional behavior could be so relied upon that you didn't need configuration files to get your apps working initially. It was like magic!

Tons of systems existed like this before, even one that was called MAGIC (today it is UniPaaS: Uni Platform as a Service), but Ruby on Rails was the first to be built exclusively for the web and get all the little details right that web frameworks before it (like Python's own Django) got wrong. Things like MAGIC and SmallTalk and other things that really nailed their problem domains before the web came along were victims of bad timing. Ruby was not. Ruby and Rails are the benefactors of very, very good timing... indeed, a perfect storm of folks wanting to flock of of M$ ASP, PHP, and every other sub-standard web dev platform the world was plagued with at the time.

That doesn't make Ruby on Rails best. Like JavaScript on the browser, it only makes it first and most familiar to folks who were quick to jump on the bandwagon. Now, after a few years of people groking joyful frameworks, there are both a plethora of other ones on different languages AND the honeymoon of that joyful-magic is wearing off as people realize the trade-offs.

Of course before we even talk frameworks, the biggest split between Python and Ruby comes in that Python uses whitespace to delineate code-blocks and allows you to use the very comfortable and immediately intuitive imperative programming style without having to go through the object oriented learning curve. Ruby on the other hand does everything in the object oriented style. You can see this most clearly with how in Python, you can use the len() function wrapped around almost any object and get back it's length. In Ruby, you must always invoke the .length method of the object. And as a Ruby-freak once told me, you are not required to program everything using object oriented design. It's just that everything you interact with requires you to have naturally understood and internalized it's teachings—not always a bad thing, but not automatically a good thing, either. OO is just not the best fit for the most common daily programming tasks.

Which style is better or worse (object oriented versus procedural/imperative) is a matter of debate (as is many things in this article), suffice to say that when I tried taking up Ruby very early on in the Ruby on Rails bandwagon hype days, I stumbled and abandoned Ruby for the following reasons:

- I couldn't see myself using object oriented programming style for every little chore (tremendous overhead)
- The client libraries and third party modules were abysmal compared to Python (that's changed a bit now)
- Having created "joyful frameworks" of my own in the past, I disagreed with a lot of the philosophy of the one-and-only (at the time) framework on Ruby... the very Rails that made it popular.

That last one may need a little explaining. Frameworks should not be "code generators" like how ROR spits out scaffolding that you start overriding left-and-right to customize it to your liking. I find shortcuts like that to be more of a hinderance and crutch to creative thinking than a shortcut to productivity. Why take a huge long-term hit on how creative you are being encouraged to be based on a code-shitter du jour called a generator?

So, what's the alternative? What's a framework if not a code-generating shortcut? Well, in short, frameworks should not really even be necessary, as they are just revealing shortcomings in the programming and code execution environments that they're built on top of. If you need a framework too badly on the platform you chose, then maybe you chose the wrong platform. Frameworks should fix abstraction-level mistakes that the underlying language decided not to include... and the lack-of-inclusion should be by design, because that abstraction-layer up of the framework does not belong in core... precisely because it's too based on preference and philosophically laden conventions.

Huh? Well, look at the Flask web framework on Python. First, it's one of dozens that have a lot in common. It seems that everyone's favorite sport in Python is to slam out yet another web framework... because it's so darn easy, because Python brings you 80% of the way there with perfectly chunky (but not too chunky) abstraction layers underneath, like whole webservers with one line of code. Flask lightly sits on top of a web request routing system called Werkzeug that handles the philosophical-bits of web frameworks and a PHP-like HTML code mix-in template system called Jinja2 to create a barely-web-framework. You'll find no code generators here and no pre-built apps springing into existence making everything equally... well, CRUDy (create, record, update, delete), which is a SQL-centric view of the world that Rails professionally and mentally binds you to.

One of the best things I've ever done for my programming efficiency and flexibility was to give up the SQL dependence that I had in my VBScript/HitTail days. And I'm not talking about just a switch to NoSQL either. I'm talking about using all those wonderful chunky bits of list abstraction in Python to avoid database dependencies in almost all common use cases where code typically gets bloated x1000 by immediately reaching for SQL... yes, even SQLlite3.

Life's just better when your naked platform is framework enough for most cases without putting excessively restrictive "rails" on creative thinking. If you like cookie-cutter copy-and-paste and lots of invisible inhibitors keeping you from deviating from that center line (and magical code-generators to delude you into thinking you are deviating), then Ruby and Rails may be for you.

## Python versus Java

Java was one of the computer industry's (Sun's, actually) first ambitious and successful attempts to clean up the most unproductive aspects of the C-languages while still remaining familiar to professional C (aka, "serious") programmers familiar with C. Primarily, C added garbage collection and eliminated the need to so meticulously manage memory pointers to keep things stable. In other words, C gave you plenty of ability to shoot yourself in the foot, and Java fixed that. Java also added a much larger set of core components in a "class library" that amounts to shortcuts, so you didn't have to build up your own personally written libraries for common tasks.

All this sounds great, and I myself was lured in by these promises. Plus, Java was one of the first popular languages to tout the "virtual machine" for software portability between different hardware--a very appealing thing, until you realize virtual machines have been built into almost everything for the same portability benefits, and has been since the rise of Unix (via the BCPL vm) in 1970.

And so, what you're left with in Java is C with garbage collection and a huge class library that you can go scavenging in for pre-built bits. Again, not a bad thing. But if you hate C for it's unfriendly syntax, annoying compile step, and necessity to define everything about your variables when they're created (as I do), then you'll hate Java (as I do).

But plenty of people love Java, and a whole generation of compsci students were raised on it, and it's one of the few megacorp-backed languages that's not Microsoft. And it's timing was similar to JavaScript and PHP's as a sort of defacto standard during (and immediately prior to) the rise of the Web--but mostly only on the server back-end after a humorously failed flirting with browser support, through something called Applets.

But this was at a time where there was a lot of interest in and willingness to try out non-C-derivative languages, especially in web development that attracted a lot of non-traditional developers with no background in compsci--languages like PERL that were more accessible, due to their lack of a compile-step or the necessity to type all your variables, and accordingly offered a much more rapid and iterative test/deploy cycle. PERL is the first of the "P" languages to of the LAMP stack of Linux, Apache, MySQL, and PERL, PHP or Python--the platform that opened the floodgates of the Web by making development easy, cheap, and indeed, fun.

In other words, scripting languages were faster and easier to use than Java, so Java got relegated to the purely professional and "serious" programming crowd who wanted off of C, but were not sufficiently drawn to the new flock of tools that were kooky in comparison, and violated a lot of tenants of presumably good compsci, like rigidly typed static variables.

In the end, I probably COULD HAVE stuck with Java and transitioned myself and my career into a more serious career programming direction, but then I would have been miserable. The tennants of Python are so radically different from Java, it's like they were written by different species of humans. They can both be characterized by their relationship to the original C language of Unix.

Whereas Java endeavors to replace C, Python endeavors to be compatible with C and indeed, interchangeably optimized by C many cases. In fact, two of Python's most popular third-party libraries, NumPy and SciPy, are greatly compiled C modules nested into a Python wrapper, providing the speed and optimization of compiled native C-binaries, and Python ease-of-use.

I never had the need to replace C. My need has been to love programming and have solving my most frequent use-cases come naturally to me like a spoken language--which Python does. So, why not choose Python as my ease-of-use secret weapon and C as my occasional performance optimization scret weapon? Java just no longer fits into my programming worldview.

## Python versus Google's Go Language

Okay, now things become interesting. New projects such as programming languages are created because someone has an itch to scratch that isn't satisfied by any of the other known solutions out there. Take 20,000+ programmers working for a company that was born on Python (google PageRank) but had to switch to C++ for the benefit of completely tweaked-out performance optimization, and make them all wait a half-hour a fay 2 or 3 times-a-day for a compile step, requiring systems to be stopped and started every time you test your code. Say it's an hour a day times 20K programmers, 5 times a week.

Okay, here's the math behind why the Go language age exists: take 1 hour x 5 days x 20K people. Thats 100K hours/week or ~4,000 days of down-time by your developers every week while they wait for code to compile. THAT'S an itch worth scratching. That's a Google-scale itch that they're throwing the inventor of Unix, Plan 9 and Google's own file locking system at. These guys amount to Bill Gates, Sergey and Larry, Steve Jobs and a few other superstar brainiac rolled into one. Google got their fast compile times as you might imagine.

They also got one of the best implementations of a language to take advantage of today's multicore processor architectures (of the sort "the Cloud" is made of) better than any other language. Some might point out Erlang or VAX OS, but those systems are more geared towards hot-swapping whole running servers for fail-safe redundancy than increasing the throughput on single jobs that can be sped up with parallel processing. Being able to do more at once is such a related goal to faster compile times that it's worth taking a look at.

Web applications scale to Google-size by throwing more processor and storage capacity at them. Of course, the app needs to be written to be able to scale when such resources are thrown at them, and not all languages are made that way. And not all languages can scale horizontally and vertically with equal ease. Horizontal scaling means throwing more servers at the problem--each of which come with their own processors and storage. This sort of scaling is particularly easy and is what burst-mode on the Amazon computing cloud is all about. Requisition more servers on demand... BAM! But vertical scaling is a bit trickier, because it means adding more processors (and memory) to the same server and having the app just inherently perform better... not something languages are all to good at making happen...

...unless of course, that language is Google's Go. Go scales vertically better than other languages, specifically because it is designed to take advantage of more processors on the same server. Of course these days whether servers on the cloud have one or more processors is greatly a matter of resource allocation. Almost all datacenters are comprised of row after row of multicore processors that get sliced and diced into smaller or larger virtual units to be divvied out to cloud customers according to what they're paying for. If you write your apps in Go and then make your server instance larger in terms of more cores, your app just inherently and automatically runs better (due to the designed-in principles of Go). That's not necessarily true of Python or other languages.

Add to this easier software deployment in Go (also important for cloud apps), because it's always easier to plop a compiled binary with most of it's library dependencies statically compiled-into the binary (a program that carries around all the external dependencies that it needs inside itself) than it is to deploy a whole tangled mess of inter-dependent software, as with Python. That's not to say Go is a panacea, either. Not all dependencies can really be baked into distributable binaries (those libraries must allow static linking). But still, statically compiled binaries are nice for deployment.

So, Go is better, right? It is stealing a bunch of Python programmers according to Github statistics. But rates are a funny statistic. 1000% growth in the use of a language is created when the first 10 people take it up. Such it is with Go. The actual number of people actually using Go as a percentage of the whole comes in after VimScript, the macro-programming language built into the vim text editor, in terms of new repositories being started on it in Q4 of 2014. That's not to say the popularity contest tells how good a language is... just how popular. To understand that point, look at the stellar growth of JavaScript recently.

All this just supports the age-old truism that there's always a better tool for some special situation. And choice of tools amounts to choosing the ones that match your most frequent situations and allow you to address them well. Go is going to be (and is probably already today) a better tool for building web services that have the performance of C without the compile times, and need to scale vertically in the cloud, making your single-instance more and more powerful within the natural native context of the language.

I'm the first to admit that faster execution-time (native code) and more natural concurrency is damn appealing. You feel like the future-kid when taking up GoLang, and it may be the right direction... someday... maybe. However, given that Google was born on Python, I rather suspect Google would stay on it if they could. But having grown as large as they have, they were actually forced for performance reasons onto C for systems needing the absolute best code-execution times—and now for economic reasons (eliminating waiting for compiles) are being forced once again onto another language.

The itch that Google is scratching with Go simply isn't one of my itches. The one Guido scratched with Python is precisely, exactly my same itch.
