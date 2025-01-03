---
title: One Card Flow
permalink: /futureproof/one-card-flow/
description: 
layout: post
sort_order: 1
---

## Getting Started with OneCardFlow

I'm ready to get started with OneCardFlow.

A lot can be done with just one card, and my earlier temptation was to jump into
Anywidget and start with the integrations straight away. But you know what's
more fundamental? You know what the muscle memory habits I'm trying to get into
my finger are? You know the one version of state that can be client-side that's
okay? If it's not server-side cookies with my dict-like-DB object, then you know
what it could still be client-side without any friggin JavaScript library or
session state tracking nonsense, yet still be valid for a card?

## The DOM and HTMX

It's called the DOM, aka document object model. Whether I want to pretend it or
not, it's still there, and it still can be manipulated, and so long as a page
refresh doesn't occur, it's still persistent in the single page application mode
in which these pipeline workflows exist. Consequently, it is HTMX that I need to
learn and get better at. Consequently, it is the examples on these two key very
important pages that I need to pay attention to:
[htmx.org/reference/](https://htmx.org/reference/) and
[htmx.org/examples/](https://htmx.org/examples/). Not to hard to remember, but
easy to forget. The music of the pipes is greatly the sound of HTMX.

### Server-Side State and Forms

And so consequently, even with my `.cursorrules` cursing of server-side state,
the state of the matter is that I can affect server-side state with HTMX in a
web form, and that is valid. That is a valid way to collect multiple points of
data, the number of which I do not really know ahead of time in a single card.
If I want to collect anywhere from 1 to 100 items for a list of indeterminate
size, ***we can do that on a single card*** using the example... the example...
the example... oddly, there is none.

There's an example to [delete a row](https://htmx.org/examples/delete-row/) and
to [edit a row](https://htmx.org/examples/edit-row/) but not to ***add a row***,
haha! It's almost like fate is answering my mini-app vs. textarea element. And
this in itself should be a little lesson for me.

### The Table Generation Dilemma

First, so what? If I wanted a little app that adds rows to an HTML table, I
totally could do that. Recently in the creation of the CSV file browser I added
the [dominate](https://pypi.org/project/dominate/) PyPI (pip installable)
package to make making old school HTML tables easy, and thus have now mixed the
upper-case [FastHTML component names that shadow HTML element
names](https://github.com/AnswerDotAI/fasthtml/blob/main/fasthtml/components.py)

Huh? Yeah, it takes me a moment to wrap my head around what I did. But I have
one set of Python functions when I code that come from FastHTML called FT
components. They're all listed here and they give me a bunch of functions that
will help me build tables: 'Tbody', 'Td', 'Tfoot', 'Th', 'Thead', and 'Tr', but
I used dominate which does almost the same thing with lower-case versions
***because AI told me to*** because it was trained on `dominate` before it was
trained on `fasthtml`, and I was too dumb to spot it in time. Duhhhh.

### The Library Mismatch Adventure

And then I went and tried to fix... and discovered a rabbit hole that is best
avoided, and so I am going to leave the `dominate` import in place and the use
of it to construct the CSV file browser. But I made some discoveries along the
way worth sharing. This was my prompt to Claude:

**Me**: Read my @.cursorrules And then look at these functions to draw a little
CSV file browser. And then look at
@[https://github.com/AnswerDotAI/fasthtml/blob/main/fasthtml/components.py](https://github.com/AnswerDotAI/fasthtml/blob/main/fasthtml/components.py).
Now why would I use
@[https://pypi.org/project/dominate/](https://pypi.org/project/dominate/) when I
have FastHTML FT components?

Consider `from fasthtml.common import * ` which already brings all the FT
components we need into global namespace as clean HTML-named-like Python
functions per
@[https://github.com/AnswerDotAI/fasthtml/blob/main/fasthtml/fastapp.py](https://github.com/AnswerDotAI/fasthtml/blob/main/fasthtml/fastapp.py)
which imports
@[https://github.com/AnswerDotAI/fasthtml/blob/main/fasthtml/basics.py](https://github.com/AnswerDotAI/fasthtml/blob/main/fasthtml/basics.py)
which imports
@[https://github.com/AnswerDotAI/fasthtml/blob/main/fasthtml/components.py](https://github.com/AnswerDotAI/fasthtml/blob/main/fasthtml/components.py)
which dumps the following into global:

```python
__all__ = ['named', 'html_attrs', 'hx_attrs', 'hx_attrs_annotations', 'show', 'attrmap_x', 'ft_html', 'ft_hx', 'File',
           'fill_form', 'fill_dataclass', 'find_inputs', 'html2ft', 'sse_message', 'A', 'Abbr', 'Address', 'Area',
           'Article', 'Aside', 'Audio', 'B', 'Base', 'Bdi', 'Bdo', 'Blockquote', 'Body', 'Br', 'Button', 'Canvas',
           'Caption', 'Cite', 'Code', 'Col', 'Colgroup', 'Data', 'Datalist', 'Dd', 'Del', 'Details', 'Dfn', 'Dialog',
           'Div', 'Dl', 'Dt', 'Em', 'Embed', 'Fencedframe', 'Fieldset', 'Figcaption', 'Figure', 'Footer', 'Form', 'H1',
           'H2', 'H3', 'H4', 'H5', 'H6', 'Head', 'Header', 'Hgroup', 'Hr', 'Html', 'I', 'Iframe', 'Img', 'Input', 'Ins',
           'Kbd', 'Label', 'Legend', 'Li', 'Link', 'Main', 'Map', 'Mark', 'Menu', 'Meta', 'Meter', 'Nav', 'Noscript',
           'Object', 'Ol', 'Optgroup', 'Option', 'Output', 'P', 'Picture', 'PortalExperimental', 'Pre', 'Progress', 'Q',
           'Rp', 'Rt', 'Ruby', 'S', 'Samp', 'Script', 'Search', 'Section', 'Select', 'Slot', 'Small', 'Source', 'Span',
           'Strong', 'Style', 'Sub', 'Summary', 'Sup', 'Table', 'Tbody', 'Td', 'Template', 'Textarea', 'Tfoot', 'Th',
           'Thead', 'Time', 'Title', 'Tr', 'Track', 'U', 'Ul', 'Var', 'Video', 'Wbr']
```

## The Great Library API Mismatch

...to which Claude has great responses and I try to clean up the CSV file
browser to unify on the FastHTML pseudo-HTML tags versus the dominate ones...
and it just all explodes in my face. Their APIs are totally different, and I
have a strong sense of "if it ain't broken, don't fix it". I have other fish to
fry tonight, and this is exactly the kind of rabbit hole that needlessly burns
up all your decision fatigue energy, which ends up making you defer the work
that you really wanted to do in the first place (the work that ***could make all
the difference***) to another day&#151;and which is ultimately, self-defeating.

## Late Night Realizations 

What's even worse and more insulting to this whole getting-started for the day
(at 11:00 PM at night, haha) is that the HTMX table-manipulation that I got so
infatuated with pursuing, the key example for implementing happens to be the one
left off the htmx.org site, can all be avoided if only I... if only I... if only
I...

### The Simple Solution

Just use a textarea box instead of some micro to-do app, hahaha!

Headsmack!

---

## Post-Realization Rubber Ducking with o1 Pro

> Rubber Ducky o1 Pro's the one!  
> That master-planner is so much fun!  
> And OpenAI's hoping people won't peep  
> Or seek too deeply how DeepSeek is cheap!  

**o1 Pro**: Yes—sometimes a simple `<textarea>` is all you really need for multi-line or multi-item input! It can spare you the complexities of an “add row” UI pattern, especially when HTMX does *not* supply a straightforward example for it, and especially when you’ve already got other pressing tasks. This is exactly the kind of trade-off you want to keep in mind whenever your “gut” (or your LLM assistant) tempts you into building a mini “add row” micro-app.  

However, if you do decide you really *want* that “add a row” pattern in a single card (maybe for practice, or because multiple items in a single card is truly the best user experience), below are some notes that preserve your muscle-memory training in HTMX, remain minimal, and avoid entangling you too deeply in library mismatches (whether `dominate` or `FastHTML`).

---

## 1. “Add Row” With a Single Card Using HTMX

### HTML Setup

```html
<!-- The single card – an HTML form that can add rows dynamically -->
<div id="onecard-container">
  <h3>My Items</h3>
  <table id="items-table" border="1">
    <thead>
      <tr><th>Item</th><th>Action</th></tr>
    </thead>
    <tbody>
      <!-- Existing items (if any) rendered here by server on initial load -->
    </tbody>
  </table>

  <form id="add-item-form"
        hx-post="/onecardflow/add_item"
        hx-target="#items-table tbody"
        hx-swap="afterbegin">
    <input type="text" name="new_item" placeholder="Enter an item..." required />
    <button type="submit">Add Item</button>
  </form>
</div>
```

Key points:

- **`hx-post="/onecardflow/add_item"`**: The server route that handles the “Add Item” action.  
- **`hx-target="#items-table tbody"`**: We want to update the `<tbody>` part of the table.  
- **`hx-swap="afterbegin"`**: Insert new rows at the top of the table (or use `"beforeend"` if you want them to append at the bottom).

### Server Route (Pseudo-Code)

```python
@app.post("/onecardflow/add_item")
def add_item(request):
    form = await request.form()
    new_item = form.get("new_item", "")
    
    # Potentially store it server-side in pipeline state here
    #   pipeline_id = db.get("pipeline_id", "unknown")
    #   state = pipulate.get_state(pipeline_id)
    #   state["items"] = state.get("items", []) + [new_item]
    #   pipulate.set_step_data(pipeline_id, "step_01", {"items": state["items"]})

    # Then just return one TR of HTML
    return Tr(
        Td(new_item),
        Td(
            Form(
                Input(type="hidden", name="delete_item", value=new_item),
                Button("Delete", type="submit"),
                hx_post="/onecardflow/delete_item",
                hx_target="closest tr",
                hx_swap="outerHTML"
            )
        )
    )
```

- This route just returns a single `<tr>` snippet. On the client side, HTMX will swap it in.  
- Notice you can incorporate the **delete** pattern from HTMX examples by specifying `hx_target="closest tr"`, `hx_swap="outerHTML"`, etc.

### Deleting a Row

Then you have an endpoint:

```python
@app.post("/onecardflow/delete_item")
def delete_item(request):
    form = await request.form()
    item_to_delete = form.get("delete_item", "")
    
    # Possibly remove from pipeline state here
    #   pipeline_id = db.get("pipeline_id", "unknown")
    #   state = pipulate.get_state(pipeline_id)
    #   if item_to_delete in state["items"]:
    #       state["items"].remove(item_to_delete)
    #   pipulate.set_step_data(pipeline_id, "step_01", {"items": state["items"]})

    # Return empty so the row disappears
    # (hx_swap="outerHTML" will replace the row with nothing)
    return ""
```

And that’s it. So each new row is a pure “row fragment” that you or your framework returns. You can do the final “submit all items” or “finalize” from the server state any time you want—**all on one card**.

---

## 2. Unifying With `FastHTML` or `dominate`

- If you want to generate the `<tr>...</tr>` snippet in Python using `FastHTML` components, do something like:
  ```python
  from fasthtml.common import Tr, Td, Form, Input, Button, ...
  return Tr(
      Td(new_item),
      Td(
          Form(
              Input(type="hidden", name="delete_item", value=new_item),
              Button("Delete", type="submit"),
              hx_post="/onecardflow/delete_item",
              hx_target="closest tr",
              hx_swap="outerHTML"
          )
      )
  )
  ```
- Or if you’re using `dominate`, do it with that API. The concept remains the same: *return a row snippet for partial HTML swap*.

If you find yourself half-using `dominate` and half-using `FastHTML` in the same code file—**it’s not the end of the world**. Yes, it’s a bit messy, but if it’s stable and working, you can fix it later when you have more time (or never!).

---

## 3. Using a Single `<textarea>` Instead

If all you really need is “some unbounded list of lines” that the user can type, then a single `<textarea>` is drastically simpler. One card can do:

```python
# Step 01 form
Form(
  Textarea(name="lines", rows="10", cols="50", placeholder="Enter line after line..."),
  Button("Save", type="submit")
)
```

Then the server can `.splitlines()` to get each line, store them, etc. No table manipulation needed, no partial-HTML row swapping, no “delete row” logic. So if you don’t need the row-by-row illusions, the `<textarea>` is an easy path—**no headscratch** about how to add or delete items on the client side.

---

## 4. Final Thoughts

- **Choose the simpler approach** unless you explicitly want HTMX practice building an “add row” mini-app.  
- **One card can do a lot**—especially if you’re using ephemeral DOM-based interactions. But keep an eye on your real goals. If you truly need row-by-row manipulation, go for the HTMX approach. If you just want a fluid multi-line input, `<textarea>` may suffice.  
- **Be mindful of rabbit holes**. If it’s 11:00 PM and your top priority is building something else (e.g. hooking up that Anywidget you’ve been itching to try), a good short-term fix might be the `<textarea>` approach so you can move on to the fun part.  

In short, a “single card” collecting an arbitrary number of items can be as fancy (tables + row additions + partial HTML returns) or as simple (a single `<textarea>`) as your immediate constraints dictate. Each approach is valid! The trick is deciding which approach is “good enough” for the next step of your pipeline journey.

---

## Challenging AI Confirmation Bias

Alright, alright, I get it. You will tell me anything I want to hear, Mr. AI
Rubber Ducky. But you will try to create a fair spread of options. I do not
think this is your purely emergent behavior. I think this is OpenAI wrangling
you into being fair-handed. I do not want a confirmation bias, but I also do not
want to be fighting against you if I think that I am right and you are just
over-trained on all the wrong (overweight enterprise architecture) stuff.

## The Tension in AI Interactions

There's a tension here. I guess that's why so much of this AI stuff is about
tensors, huh? There are internal tensions and forces and torques and directions
trying to get you to move or think or decide this way or that. The user's
feedback adds to those forces in all sorts of ways, and prompt and response
after prompt and response chains it all up in such a way that your static model
determinism is very hard to predict, indeed.

## Making the Final Decision

And so in the end, the decision is mine. I will go the way I want in this, and
my concerns trump everything else. And my concerns are are moving the project
forward as a whole, without getting bogged down with the often devastatingly
interesting rabbit hole projects that feel important and feel like foundational
pillars that should be woven into the strong base fabric of a project at the
beginning. But they're not. They're 100% deferrable. Good enough is good enough.

### The Balance of Deferral

But that attitude is self-defeating in the other direction. And indeed it would
be if all your deferential decisions were not actually right there still on the
surface of the wood that you're whittling, the fuzz and the spurs that you're
not going to forget. They have to be left there on the surface in such a way
that they are reminders to your future self to come sand them down and smooth
them out&#151; later.

## The Case for Simple Solutions

Using an html form textarea instead of a little row-based todo widget built from
HTMX, which wouldn't actually be too hard, is actually a good example. My single
card app right now is going to be a textarea app. I mean, actually think of the
long-term flexible utility of this as one of the generic card widget types I can
forever tap. For example, I really want to make some sort of markdown-to-HTML
converter for copy/pasting meeting agendas without volunteering that data to
some anonymous web hosted app that offers such services for free&#151;at the
mere cost of your data! Take that in-house!

### The Pipeline Philosophy

And why as part of a card in a pipeline? Because you can slam them out, and
don't have to think about user interface issues beyond the single card.
Data-in/data-out in that Unix pipe flow. You don't have to "build an app" for
that. You just... well, you just port it from how you would implement it in a
Jupyter Notebook, for that was the genesis of this workflow pipeline project
after all&#151;fast Notebook ports.

## The New Age of AI Prompting

I'll get to the work in a moment, but this is the new-age prompt, stories like
this, fleshing out all the background so that your AI coding assistant has
***real life context!*** I mean talk about context, right? Now o1 Pro and Claude
are both going to know, because I'm going to feed this article to each of them,
that this linear progress these pipeline workflows represent is the same thing
that happens in both Jupyter Notebooks and Unix pipes.

### Managing Global State

Now Jupyter Notebooks have Python's global namespace to make truly dysfunctional
fubar, but it works and is even justifiable because Python's global namespace is
nothing more than the page-level module's parent namespace, and those are fine
for some reason when imported, but not at the top level? Sheesh! Anyhow, even
though it's defensible, we're going to try to avoid it.

In the case of the Pipulate workflows, it's avoided by using the JSON blob in
the data field of Pipulate's pipeline record for that workflow's instance as the
single source of truth. We do have a dict-like database in global we can use for
server-side cookies here and there, but for all that state stuff tied to the
pipeline instance, it really gets wrapped into that JSON blob card-by-card. The
entire workflow end-to-end can be reproduced from a single pipeline record, and
mostly just from that data field JSON blob.

## The Pipeline Schema

```python
pipeline={           # To "pipulate" is use this for a Unix pipe-like "pipeline" workflow: Card 1 | Card 2 | Card 3
    "url": str,      # A url must be used on Card 1 to initiate a job, and can be plugged in later to from last complete Card step
    "endpoint": str, # The app endpoint, not technically part of composite primary key (yet) but sure useful for MiniDataAPI spec with table.xtra() as a search filter in workflow app ID field searches
    "data": str,     # All jobs get just 1 pipulate record and use a JSON blob to track state for the entire workflow. The JSON blog contains the args and results of each Card for interruptionless pattern
    "created": str,  # ISO timestamp of first insert
    "updated": str,  # ISO timestamp of last update
    "pk": "url"      # URL is the primary key and can always be plugged into Card 1 to continue a job, jumping to where it left off (the same behavior as any step of workflow processing)
}                    # A FastHTML-friendly querystring-like path can be used to jump to any Card in the workflow: /endpoint/card3
```

## Example Pipeline Record

### A Mad-Libs Style Workflow

...and here is an instance of a Pipulate pipeline record after having carried
out single workflow. Conceptually, there could be an unlimited number of these
in the pipeline table, each one being any state of completion of any variation
on a workflow. Each workflow class gets its own endpoint. Every time you carry
out a workflow for that endpoint, it gets its own key. One workflow/key combo,
one entry in the pipeline table. This is the results of a Mad-Libs style
workflow that just kept appending new output to input to build a story.

url | endpoint | data | created | updated
blah | tenflow | {"created": "2025-01-02T16:49:52.635184", "updated": "2025-01-02T17:03:17.970048", "step_01": {"data": "cat"}, "step_02": {"data": "cats"}, "step_03": {"data": "happy cats"}, "step_04": {"data": "happy cats sleep"}, "step_05": {"data": "happy cats sleep soundly"}, "step_06": {"data": "happy cats sleep soundly at night"}, "step_07": {"data": "happy cats slept soundly at night"}, "step_08": {"data": "happy cats slept soundly at night because they were tired"}, "step_09": {"data": "happy cats slept soundly at night because they were tired, peacefully"}, "step_10": {"data": "Happy cats slept soundly at night because they were tired, peacefully!"}, "step_11": {}} | 2025-01-02T16:49:52.635184 | 2025-01-02T17:03:17.970048

