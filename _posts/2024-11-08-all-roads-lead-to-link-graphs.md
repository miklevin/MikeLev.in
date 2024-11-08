---
title: All Roads Lead to Link Graphs
permalink: /all-roads-lead-to-link-graphs/
description: 
layout: post
sort_order: 1
---

Often when I start out with these articles, I pick a topic in the morning that I
think will be the main theme of the article. Yesterday, it was Google Sheets
versus Jupyter Notebooks. But then during the course of the day as the article
grows as I do my daily work journaling, the theme refines and focuses. Some
might say veers off course. I say refines and focuses. And yesterday, it went
from this-vs-that to a whole lot about that. There's just so much to say about
the kind of work I do with Python in Notebooks and my current mission in
particular that... well, that today becomes Part 2!

In Martial Arts and Japanese martial arts in particular, there's a concept
called Kata. Kata is good form. It's fighting an imaginary opponent (or
opponents) with predetermined practiced moves. The idea is that over time these
moves commit to your muscle memory, and you can perform them without thinking in
situations other than the kata. Practice makes perfect, in other words. And
repetition matters. The more you do a thing, the better you know it. Imagining
something repeatedly makes you better at the real thing. Hey Perplexity, What's
that thing about baseball players imagining hitting the ball in their head?

Perplexity: The concept of baseball players imagining hitting the ball in their heads relates to the mental and visual strategies they employ while batting. This involves not just the physical act of hitting but also significant cognitive processes that aid in anticipating and reacting to a pitched ball.

## Visual Tracking in Batting

Research indicates that batters utilize a combination of head and eye movements to effectively track the ball as it approaches. Instead of relying solely on eye movements, batters tend to move their heads to maintain focus on the ball. This head movement helps them cancel out the vestibular ocular reflex (VOR), which would otherwise cause their eyes to move in the opposite direction of their head's rotation. By suppressing this reflex, batters can keep their gaze steady on the ball, which is crucial for making contact within a very short time frame—approximately half a second from pitch release to contact with the bat[1][2].

## Anticipatory Movements

Batters also employ **anticipatory saccades**, which are quick eye movements made toward where they predict the ball will be. These movements often occur before the ball reaches the plate, allowing batters to prepare for a swing based on their predictions about the ball's trajectory. Studies have shown that these predictive eye movements can significantly enhance a batter's ability to hit successfully, as they allow for quicker reactions and better timing[1][2].

## Mental Preparation

The mental aspect of hitting is equally important. Players often visualize themselves successfully hitting the ball, which can enhance their confidence and performance at the plate. This mental rehearsal is akin to how athletes in various sports use visualization techniques to improve their skills and outcomes. The mental preparation involves understanding pitch types, recognizing pitcher tendencies, and developing strategies based on game situations[4][5].

## Conclusion

In summary, successful batting in baseball hinges on a combination of physical tracking techniques and mental strategies. Players not only focus on seeing the ball but also engage in complex cognitive processes that involve predicting its path and visualizing successful hits. This interplay between visual acuity and mental preparation is what makes hitting in baseball one of the most challenging tasks in sports.

Citations:

    [1] https://optometry.osu.edu/news/batters-move-their-heads-keep-their-eyes-ball
    [2] https://www.frontiersin.org/journals/sports-and-active-living/articles/10.3389/fspor.2020.00003/full
    [3] https://www.reddit.com/r/Homeplate/comments/156s1f6/do_professional_players_try_to_guess_the_pitch_or/
    [4] https://qualityatbatsacademy.com/the-mental-side-of-hitting-the-ultimate-guide/
    [5] https://community.hsbaseballweb.com/topic/teaching---see-the-ball-correctly
    [6] https://www.youtube.com/watch?v=d9fEHydJcOQ
    [7] https://www.youtube.com/watch?v=nr1oOcoxVb0

Yeah, so visualize it! Like maybe visualizing the shape of your website,
regardless of how big it is! That's my goal. Actually no, I do that all the
time. Making that easy for anyone to do is my goal. Actually, no. Making it easy
for any Botify user to do is my goal, because getting all that link-graph data
into a database for visualization... well, no thank you. No sireee. No sir I
don't like it, not one bit. I mean like I have written countless web crawlers
over the years, but I'm a shallow click-depth sort of person. Like if the
homepage is depth-0, I'll write a crawler to go to depth-2 maybe, or 3-max. I'm
telling you, that could be millions of pages on a lot of sites, and likely the
beginning of a never-ending spider-trap. Been there, done that. Not interested
in doing it again. And so I work for Botify. They do that real well, and I'm
pretty good at stupid data tricks like exporting the link-graph for
visualization. So let's do that.

We start by continuing yesterday's Botify API kata. Finally, I figured out the
format I'm doing it it. It is of course in a Jupyter Notebook and that notebook
is in the same repository as my ***AI SEO Bot*** project, a local LLM that's
gradually coming to life to do all your next-generation SEO bidding... which is
starting to look like not SEO at all, but rather a nice clean-up, pruning and
curation job to get your site ready for rapid training and re-training of all
those bots that are going to still be using harvested free and open source web
data. Yeah, they're not all cutting the Reddit / Twitter-deals for proprietary
data source. I mean, some will. But a lot's still getting slurped down off the
web, and you've got to get your house in order so you're deemed quality and
important enough (a lot of brand safe harbor stuff here) to be curated in. Did I
mention good form? This is the good form exercise to help clients do good form
exercises.

And when last we left off, I made a new notebook called `kata.ipynb` right in
the root of `aiseobot` where I'll be sure to see it over and over and over. The
actual name of that repo is still in flux as it moves from `pipulate` to
`botifython` to most recently `botifymograph`. I'm not sure what I'm settling
on, but I'm leaning towards `chipotheseus`, for ***Ship of Theseus***, as my
plan is to swap out parts of it over the years in both a hardware and software
perspective (including the AI models it uses), until... until, well the SciFi
that we're living is even more SciFi that we're living. Genies in bottles become
very important. If you don't have your own genie in a bottle, you've got to use
someone else's&#151;at least, if you've got any wishes to fulfill. And so, it's
best to start raising them now.

`kata.ipynb` is a Jupyter Notebook, and as such has meta-data that you don't
want to accidentally commit to the git repo it resides in, and thus also to
GitHub, and thus accidentally leak potentially proprietary information. Also,
all my publishing is now markdown. I had a funny discussion yesterday about when
push comes to shove, I'll still use ***office suite***-style software, like MS
Office or Google Suite with all their GUI formatting stuff. But I'm a wholly
***textfile***-guy. From tables (which make great use of vertical pips (`|`) to
bulleted outlines to free-flowing blocks of text, it's way better to just be
able to manipulate text in a generic vi/vim/NeoVim-like environment. You know,
that includes VSCode, emacs and pretty much any text-editor or integrated
development environment (IDE) worth their salt, because they all offer vim
emulation. There's a reason for that. Develop good form editing text, and you're
future-proofed. Good form leading to muscle memory leading to future-proofing.
Detecting a theme here?

So Jupyter Notebooks are an anomaly in my toolbox. I really hated them at first.
I hated them right up until I loved them. They're no vim, but they have their
use. And to make them useful, we have to keep their metadata out of the git repo
and we have to make them output markdown for such uses as incorporating into
articles here. See, the theme of this article has already veered into a nested
sub-project. But it's still only 6:00 AM, so that's fine. Let's get this
careening done and back on track, and we'll be slamming out the million-edge
link-graphs in no time. For stripping out the meta-data from Notebooks, we `pip
install nb-clean`. I know this because I've used many such tools over the years,
including another tool, `nbdev` from the illustrious Jeremy Howard who recently
brought us `FastHTML`. But that complicates things a little too much for our
purposes here. `nb-clean` is just the right amount of package for this one
purpose, and once done, it's automatic. The magic are (from having cd'd into the
folder):

    nb-clean add-filter

...and in the voice of Jafar: ***You'll never leak meta again!***

What this does I'm still wrapping my mind around. I'm a big advocate of Linux,
Python, vim & ***git*** (`LPvg`) as a short tech stack for life. Have
well-developed muscle memory and good form with them, and you'll resist
obsolescence like an old-timer whose every trick still works. But the truth is
that `git` is probably my weakest skills. It can do a whole lot I'm not taking
advantage of (yet). I use it mostly as a sort of infinite undo, code-deployment
technique and backup safety mechanism. But it can do so much more in terms of
collaboration, experimental code branching and such. Hey Perplexity:

nb-clean has this line in its docs:

To add a filter to an existing Git repository to automatically clean notebooks when they're staged, run the following from the working tree:

nb-clean add-filter

This will configure a filter to remove cell execution counts, metadata, and outputs. To also remove empty cells, use:

...but I don't even know what staging is in git. I use git commit and git push almost exclusively as far as commands, for a kind of infinite undo. Will nb-clean still help me keep meta data out of committed notebooks?

**Perplexity**: Based on your question, it seems you're using Git in a simplified way primarily for version control, but you're not familiar with some of the intermediate concepts like staging. Let me explain how nb-clean can still be helpful for you, and provide some context on Git staging:

## Git Staging and Your Workflow

Your current workflow of using `git commit` and `git push` is actually implicitly using the staging area without you realizing it. Here's a brief explanation:

1. When you run `git commit`, Git automatically stages all modified files before committing them[3].
2. The staging area (also called the index) is where Git prepares changes to be committed[3].

## How nb-clean Can Help You

Even with your simplified Git workflow, nb-clean can still be very beneficial:

1. **Automatic Cleaning**: Once set up, nb-clean will automatically clean your Jupyter notebooks before they're committed, without you needing to do anything extra[2].

2. **Metadata Removal**: It will remove cell execution counts, metadata, and outputs from your notebooks[2]. This is particularly useful for version control, as it prevents unnecessary changes from being tracked when only the notebook's content has changed.

3. **Smaller Repository**: By removing unnecessary metadata and outputs, your Git repository will be smaller and cleaner.

## Setting Up nb-clean

To use nb-clean with your workflow:

1. Install nb-clean: `python3 -m pip install nb-clean`
2. In your repository, run: `nb-clean add-filter`

This will set up a Git filter that automatically cleans your notebooks when you commit them[2].

## Benefits for Your Workflow

With nb-clean set up:

1. You can continue using `git commit` and `git push` as you have been.
2. Notebooks will be automatically cleaned before each commit.
3. Your repository will only track meaningful changes to notebook content, not execution counts or outputs.

By using nb-clean, you'll maintain cleaner version control for your Jupyter notebooks without needing to change your current Git workflow. It's a simple addition that can significantly improve how your notebooks are tracked in Git.

Citations:

    [1] https://github.com/jupyter/nbdime/issues/548
    [2] https://github.com/srstevenson/nb-clean
    [3] https://graphite.dev/guides/remove-files-from-staging-git
    [4] https://stackoverflow.com/questions/73218304/how-to-clear-jupyter-notebooks-output-and-metadata-when-using-git-commit
    [5] https://www.reddit.com/r/git/comments/16dhysy/how_to_remove_files_from_index_staging_area/
    [6] https://www.reddit.com/r/webdev/comments/udod9z/git_makes_me_want_to_pull_my_hair_out/
    [7] https://awasu.com/weblog/git-guts/staging-index/
    [8] https://git-scm.com/docs/git-commit

Nice! Thanks, Perplexity. You know, there's a lot of concern that as AI Models
get trained and re-trained and fine-tuned off of all the data from the free and
open source web, more and more of it is going to be AI-generated derivative data
already, thus having a quality-reducing, bias-amplifying feedback loop. Am I
doing that here? I am following my free-form train of thought. There's nothing
AI-generated about the text between my little bouncing ideas off Perplexity, so
is it derivative and synthetic? Or is it organic and hybrid? Who's running this
show anyhow? Well, I am clearly, but having a dream-come-true in the form of
something that can answer my questions with the research and citations to back
it up, pre-formatted as ready-to-publish markdown with the footnotes to boot!
OMG, that's the world we live in. Had Perplexity been from OpenAI a year ago, it
would have already kicked Google's ass. As it is, it's the in-the-know search
insider's meta-ai-search-engine. Remember ***Dogpile**, ***Metasearch***,
***Hotbot***... oh my, it's a long list. The days of metasearch before Google
solidified its single-source dominance? Yeah, well those days are back. In the
voice of Dennis Miller: ***Stop me before I subreference again!***

Did I mention pre-formatted and ready-to-publish markdown? Yes I did! And so the
next step is to give our not-vim Jupyter Notebooks some additional redeeming
qualities by infusing into them the ability to output markdown I can copy/paste
directly into articles like this and for that we... Perplexity?

Perplexity: There are a few PyPI packages that can convert Jupyter notebooks to markdown format:

1. notedown

notedown is a simple tool that can convert between Jupyter notebooks and markdown files. Some key features:

- Converts notebooks to markdown and back
- Preserves code cells and markdown cells
- Can strip output cells when converting to markdown
- Supports R markdown as well

Usage:

```
notedown input.ipynb --to markdown > output.md
```

2. jupytext 

Jupytext is a more full-featured tool for converting between notebooks and various text formats. It supports:

- Converting notebooks to/from markdown, R markdown, Julia/Python/R scripts
- Pairing notebooks with text representations for version control
- Round-trip conversion preserving metadata
- Integration with Jupyter to automatically sync paired files

Usage:

```
jupytext --to markdown notebook.ipynb
```

3. nbrmd

nbrmd is an earlier version of jupytext with similar functionality:

- Converts between notebooks and markdown/scripts
- Preserves cell metadata 
- Command line tool for conversion

Usage:

```
nbrmd --to markdown notebook.ipynb
```

Of these options, jupytext seems to be the most actively maintained and feature-rich package for notebook-markdown conversion. It has good integration with Jupyter and supports a variety of text formats beyond just markdown[1][2][5].

Let me know if you need any clarification or have additional questions about using these packages!

Citations:

    [1] https://pypi.org/project/notedown/
    [2] https://pypi.org/project/jupytext/0.6.5/
    [3] https://towardsdatascience.com/how-to-convert-a-python-jupyter-notebook-into-an-rmarkdown-file-abf826bd36de?gi=28e9ba8e88a4
    [4] https://stackoverflow.com/questions/36288670/how-to-programmatically-generate-markdown-output-in-jupyter-notebooks
    [5] https://pypi.org/project/nbrmd/
    [6] https://pypi.org/project/jupytext/1.1.1/
    [7] https://pypi.org/project/jupytext/0.8.4rc0/
    [8] https://pypi.org/project/jupytext/

I just wish markdown numbered lists didn't restart at 1 when there's too much
stuff going on between line items. I'd fix it, but life's too short to do
follow-up markdown editing (except for indenting Perplexity's
footnotes&#151;I'll do that). And so we accumulate and assimilate knowledge and
forge on, now equipped with the amazing `jupytext` which is billed as a bit more
heavyweight than I want with all the formats it supports, but what isn't? I use
Pandas for converting things to CSVs. Same thing. And so my still lean and mean
`requirements.txt` has grown to:

```python
# For long-running task communication
asyncio
aiohttp

# For Pipulate / Botifython
beautifulsoup4
loguru
pyfiglet
python_fasthtml
Requests
rich
sqlite_minutils
starlette
watchdog

# For JupyterLab / Data Science
jupyterlab
numpy
pandas
nb-clean
itables
```

And some stuff is on there not because it has to be, but only because they're
such useful requirements of other packages on their own right that its useful to
remind myself I have them and htey are worth investigating further. `numpy` is
the big example, because it's really a requirement of `pandas` so I don't really
have to list it in my requirements. But I do because I need to polish up on my
maths and that's a good reminder. Similarly... hmmm... Perplexity?

Perplexity: This is an excellent observation about dependency management. Let's analyze your requirements list to create a more concise requirements.txt file:

## Simplified Requirements

1. **Pandas includes NumPy**: You're correct that pandas automatically installs numpy as a dependency[1]. Therefore, you don't need to explicitly list numpy.

2. **Starlette is a dependency of python_fasthtml**: As you pointed out, starlette is required by python_fasthtml, so it doesn't need to be listed separately.

3. **JupyterLab includes several dependencies**: JupyterLab often includes or requires numpy and pandas, so you might not need to list these separately if you're installing JupyterLab.

Given these considerations, here's a potentially shorter requirements.txt:

```
aiohttp
beautifulsoup4
loguru
pyfiglet
python_fasthtml
Requests
rich
watchdog

jupyterlab
nb-clean
itables
```

## Additional Considerations

1. **Indirect Dependencies**: Some packages might be dependencies of others in your list. For example, aiohttp might be required by another package you're using.

2. **Version Specificity**: While not directly related to shortening the list, it's important to specify versions for each package to ensure reproducibility.

3. **Development vs. Production**: Consider separating requirements for different environments. For instance, JupyterLab and related tools might only be needed in a development environment.

4. **Minimal Installation**: If you're aiming for the absolute minimum, you could start with just the core packages you directly use in your code and let pip resolve the dependencies automatically.

Remember, while shortening your requirements.txt can make it more manageable, it's crucial to ensure all necessary dependencies are still installed correctly when setting up a new environment. Always test your application after making changes to the requirements file to ensure everything works as expected.

Citations:

    [1] https://stackoverflow.com/questions/74344430/what-does-it-mean-by-the-statement-numpy-is-a-dependency-of-pandas
    [2] https://github.com/python-poetry/poetry/issues/8489
    [3] https://github.com/pandas-dev/pandas/issues/25316
    [4] https://pandas.pydata.org/docs/getting_started/install.html
    [5] https://pandas.pydata.org/pandas-docs/version/0.25.1/install.html
    [6] https://pypi.org/project/pandas/0.23.2/
    [7] https://pandas.pydata.org/pandas-docs/version/0.24/install.html
    [8] https://help.sonatype.com/en/python-application-analysis.html

Oh, that's sweet! So much so, I'm changing my mind! I want to flex my muscle
with how short my `requirements.txt` file is for Chip O' Thesesus, and I'm
updating it to what Perplexity just reported. I no longer need to remind myself
`fasthtml` uses `starlette` and that I need to brush up on numeric array stuff.
I know! Slick. 

Okay, so I now add `jupytext` to the list for turning my Jupyter Notebooks into
content here. And so the article really just begins. And it's 6:45 AM. Nice. The
time has come to really lean into your work and achieve something big. You're in
a race. Machines are only going to be achieving human-level intelligence once
and it's good to have an ambitious and related project going on while they do.
And little is as important now as the API syntax of more-machine-friendly
intermediary languages. This is mostly about `JSON` and sometimes `XML`.
However, it is also about `markdown`. And `jupytext` converts `.ipynb` files to
it with this command:

    jupytext --to markdown kata.ipynb

And that's where today's story begins. First, let's clean the mess I've made in
the `botifymograph` repo folder. I like running ***JupyterLab*** now out of the
same repo folder I run the Chip O'Theseus `server.py` file (its name doesn't
matter). But basically I'm running a Python webserver using the classic form
`python server.py` which makes the folder it runs from `root` to the server. It
can find all its resources really easily from there without paths or fancy
additional package imports and code. You can refer to a configuration file
directly by name and it will find it. This is usually bad practice for web
development as it makes things hackable as people probe for things they're not
supposed to have access to on root, but it makes everything easier and the code
more beautiful and I'm developing this as a single-tenant desktop app even
though it's a web app. But a lot of things accumulate there as a result, and you
can identify them easily with a `git status` because they don't belong and will
be called out as ***Untracked files***. I zap much of them with:

    rm *.csv
    rm *.gz

Okay, I've got it down to a manageable level. There's a few `.md` (markdown)
files left, and some of them have real value and are there precisely because of
this project, and I want to leave them there for now. In fact, I want to roll
them all into a single ~~master~~ main notebook that consolidates all that yummy
training stuff into one location. And now it's time for some good form...

- Things need training (including myself) 
- Some of those things are human, and some are machines
- If done well, the same materials can train both
- This is Jupyter Notebook is an attempt to do just that
- It will be turned into markdown documentation

I need structure! I need to rig my Notebook format for successful training. Hey
Perplexity, what's that format Llama uses to train models?

**Perplexity**: The Llama format for training models typically involves preparing data in a specific structure to fine-tune the model effectively. Here are the key aspects of the Llama training format:

## Data Format

The most common format for Llama fine-tuning data is JSON or JSONL (JSON Lines), with each entry containing the following fields:

- "instruction": The task or question posed to the model
- "input": Additional context or information (optional)
- "response": The expected output or answer

A typical example would look like this:

```json
{
  "instruction": "Summarize the following text:",
  "input": "Lorem ipsum dolor sit amet...",
  "response": "This is a summary of the given text."
}
```

## Training Approaches

Llama models can be fine-tuned using different approaches:

**Raw Text Continuation**
For simple text generation tasks, you can use raw text without specific formatting[1].

**Instruction Tuning**
To create a more versatile model that can follow instructions, you should format your data to match instruction-following models like Alpaca or Vicuna[1].

**Question-Answer Pairs**
Many training scripts expect JSON files with question-answer pairs to facilitate easy formatting and disk space optimization[1].

## Data Preparation

When preparing your dataset for Llama fine-tuning, consider the following:

1. **Quality and Quantity**: Llama models benefit from high-quality, diverse datasets. Meta's approach for Llama 3 involved using over 15 trillion tokens from public sources, with rigorous preprocessing to ensure data quality[2].

2. **Preprocessing**: Apply filters for NSFW content, perform semantic deduplication, and use text classifiers to predict quality[2].

3. **Data Mix**: Experiment with different combinations of data types and sources to find the optimal mix for your specific use case[2].

4. **Iterative Refinement**: Implement multiple quality assurance iterations to improve data quality and model performance[2].

## Training Process

When training a Llama model:

1. Use the appropriate model weights and tokenizer for your chosen Llama version[4].

2. Set up the training configuration, including learning rate, batch size, and number of training steps[4].

3. Prepare the model for training, potentially using techniques like LoRA (Low-Rank Adaptation) for more efficient fine-tuning[4].

4. Utilize a training framework like the Hugging Face Transformers library to manage the training process[4].

Remember that the specific format and approach may vary depending on the version of Llama you're using (e.g., Llama 1, 2, or 3) and your particular use case. Always refer to the most up-to-date documentation for the specific Llama version you're working with.

Citations:

    [1] https://www.reddit.com/r/LocalLLaMA/comments/16sjyvc/llama_2_data_format/
    [2] https://kili-technology.com/large-language-models-llms/llama-3-guide-everything-you-need-to-know-about-meta-s-new-model-and-its-data
    [3] https://en.wikipedia.org/wiki/LLaMA
    [4] https://www.mlexpert.io/blog/alpaca-fine-tuning
    [5] https://ai.meta.com/blog/large-language-model-llama-meta-ai/
    [6] https://huggingface.co/blog/nroggendorff/train-with-llama-architecture
    [7] https://www.datacamp.com/tutorial/fine-tuning-llama-2
    [8] https://github.com/ggerganov/llama.cpp/discussions/3805

Okay, I can't let the process get convoluted. It has to lean into the strengths
of the Notebook conversion that's going to happen.

Me: I'm going to be converting a Jupyter Notebook into model training markdown. So the whole JSON format isn't going to work for me. But the markdown cells in Notebooks provide some freedom in prefixing every code block that will output. So I can say something about each code block that will follow. Review other formats that are commonly used to train models and devise an approach I can use.

Perplexity: When converting a Jupyter Notebook into markdown for model training, you can adopt a structured approach that combines explanatory text with code blocks. Here's a suggested format based on common practices:

## Section Headers

Use markdown headers to organize your document into logical sections. For example:

```markdown
# Model Training: [Model Name]

## 1. Data Preparation
## 2. Model Architecture
## 3. Training Configuration
## 4. Training Process
## 5. Evaluation
```

## Code Block Prefixes

Before each code block, provide a brief description of what the code does. You can use a consistent prefix format:

```markdown
### [Action]: [Brief Description]

```python
# Your code here
```
```

For example:

```markdown
### Load Data: Import and preprocess the dataset

```python
import pandas as pd

data = pd.read_csv('dataset.csv')
X = data.drop('target', axis=1)
y = data['target']
```
```

## Explanatory Text

Between code blocks, include explanatory text to provide context, reasoning, or additional information:

```markdown
The dataset is split into training and validation sets to ensure proper model evaluation. We use a 80/20 split ratio.

### Split Data: Create training and validation sets

```python
from sklearn.model_selection import train_test_split

X_train, X_val, y_train, y_val = train_test_split(X, y, test_size=0.2, random_state=42)
```
```

## Parameter Tables

For important configurations or hyperparameters, consider using markdown tables:

```markdown
### Model Configuration: Set up hyperparameters

| Parameter | Value |
|-----------|-------|
| Learning Rate | 0.001 |
| Batch Size | 32 |
| Epochs | 100 |

```python
model = MyModel(
    learning_rate=0.001,
    batch_size=32
)
```
```

## Results and Visualizations

For outputs, results, or visualizations, you can use a similar prefix format:

```markdown
### Result: Training accuracy over epochs

![Training Accuracy](./images/training_accuracy.png)

The graph shows a steady increase in accuracy over the first 50 epochs, followed by a plateau.
```

This structured approach provides a clear, readable format that combines explanatory text with code blocks, making it easy for others to follow your model training process. It's flexible enough to accommodate different types of models and training procedures while maintaining a consistent structure.

Citations:

    [1] https://www.mlexpert.io/blog/alpaca-fine-tuning
    [2] https://developers.redhat.com/articles/2021/05/21/introduction-machine-learning-jupyter-notebooks
    [3] https://www.datacamp.com/tutorial/fine-tuning-llama-2
    [4] https://kili-technology.com/large-language-models-llms/llama-3-guide-everything-you-need-to-know-about-meta-s-new-model-and-its-data
    [5] https://huggingface.co/blog/nroggendorff/train-with-llama-architecture
    [6] https://docs.polypheny.com/en/latest/user_interfaces/notebooks/cells/markdown-cells
    [7] https://www.earthdatascience.org/courses/intro-to-earth-data-science/open-reproducible-science/jupyter-python/code-markdown-cells-in-jupyter-notebook/
    [8] https://runestone.academy/ns/books/published/httlads/PythonReview/markdown.html

Pshwew! What a journey! Well, it's pretty clear that I've got my first piece of
content on my website that's going to resist blog format. Already I have a bit
more repetition of content than I'm comfortable with, but life's to short to
retro-edit (much), so I'm going to use my newfound powers to launch my first
sub-section of my site. 
