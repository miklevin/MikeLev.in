---
title: Radically Customizing Linear Workflows
permalink: /futureproof/radically-customizing-linear-workflows/
description: "The initial templated approach to building Pipulate workflows, while simple for basic forms, severely limits customization for complex UI elements like textareas, dropdowns, and custom widgets. To address this, I'm shifting to a completely explicit, 'unlooped' design where each workflow step is defined by its own dedicated handler function. This approach mirrors the flexibility of Jupyter Notebook cells, allowing for radical customization without the constraints of rigid abstractions or predefined APIs."
meta_description: Unleash radical customization in Pipulate workflows with explicit, unlooped step handlers—achieve full UI flexibility like Jupyter Notebook cells.
meta_keywords: Pipulate, workflow customization, unlooped workflows, explicit handlers, UI customization, Jupyter Notebook, custom widgets, linear workflows, splicing system, Python web apps
layout: post
sort_order: 2
---

**Me**: I've got a question for you. Do you see the problem in this pattern when it comes to radical customization beyond using standard web form input fields for the cells? This works great for Hello World and Mad-Libs style data collection where every input field is 1-line text. But what about textareas, dropdown menus, checkboxes, radio buttons or even custom interfaces of any sort?

How would you adjust this? Don't try to reproduce all the code. You'll just drop stuff like usual. Talk it out with abstractions and code snippets. Show what's wrong that "locks it in" too rigidly. And show what you would do to expose more surface area for customization, given a step 2, step 3, and step 4 all which did something different form-wise.

**ChatGPT**: You've identified the central rigidity in this pattern correctly:

### ⚠️ **What's Wrong (Rigid Pattern Problem):**

Your current workflow definition is "locked in" too rigidly by only offering a single input type (`Input`) and assuming every step can be represented neatly with the same HTML snippet:

```python
Form(
    Input(name=step.done, value=display_value, placeholder=f"Enter {step.show}")
)
```

This limits your workflows to simplistic "Mad Libs" or single-line data entry. The rigidity comes from:

- **Hardcoding the form element** (`Input`).
- **No mechanism to select or customize different UI widgets** (textarea, dropdown, checkbox).
- **Inflexible data structure** (`Step`) that provides only text-based transformations.

---

### 📌 **Why This Matters:**

Real-world forms often need radically different input methods per step:

- **Textarea:** Multi-line inputs for longer content.
- **Dropdown:** Select from predefined options.
- **Checkboxes and radios:** Multiple selections or mutually exclusive options.
- **Custom Interfaces:** Sliders, color pickers, date pickers, or even custom widgets like rating scales.

If every step can only be rendered as a plain input, you severely limit what Pipulate workflows can do without rewriting extensive logic for each custom case.

---

## ✅ **How to Adjust (Better Pattern):**

A more robust approach is to **delegate the rendering logic to each step definition explicitly**, allowing each step to specify precisely how it renders its UI component.

Instead of this rigid abstraction:

```python
Step(id='step_02', done='greeting', show='Greeting', 
     transform=lambda name: f"Hello {name}!")
```

Adopt a more flexible, object-oriented structure where each step knows how to render its HTML directly:

### 🔑 **Abstract Step Class (Polymorphic UI Rendering):**

```python
class BaseStep:
    def __init__(self, id, done, show):
        self.id = id
        self.done = done
        self.show = show

    def render(self, value):
        raise NotImplementedError("Each step must implement render method.")

    def validate(self, form_data):
        return True, ""

    def process(self, form_data):
        return form_data.get(self.done, "")
```

### 🛠️ **Concrete Implementations (Step Types):**

Now, each step type explicitly defines its rendering:

#### **Text Input Step**

```python
class TextInputStep(BaseStep):
    def render(self, value):
        return Form(
            Input(type="text", name=self.done, value=value, placeholder=f"Enter {self.show}"),
            Button("Submit", type="submit")
        )
```

#### **Textarea Step**

```python
class TextAreaStep(BaseStep):
    def render(self, value):
        return Form(
            Textarea(name=self.done, content=value, placeholder=f"Enter {self.show}"),
            Button("Submit", type="submit")
        )
```

#### **Dropdown Step**

```python
class DropdownStep(BaseStep):
    def __init__(self, id, done, show, options):
        super().__init__(id, done, show)
        self.options = options

    def render(self, value):
        return Form(
            Select(
                [Option(option, selected=(option==value)) for option in self.options],
                name=self.done
            ),
            Button("Submit", type="submit")
        )
```

#### **Checkbox Step (Multiple Selections)**

```python
class CheckboxStep(BaseStep):
    def __init__(self, id, done, show, options):
        super().__init__(id, done, show)
        self.options = options

    def render(self, value):
        selected_values = value or []
        return Form(
            *[
                Label(
                    Input(type="checkbox", name=self.done, value=option, checked=(option in selected_values)),
                    f" {option}"
                )
                for option in self.options
            ],
            Button("Submit", type="submit")
        )

    def process(self, form_data):
        # Return list of checked options
        return form_data.getlist(self.done)
```

#### **Radio Button Step**

```python
class RadioStep(BaseStep):
    def __init__(self, id, done, show, options):
        super().__init__(id, done, show)
        self.options = options

    def render(self, value):
        return Form(
            *[
                Label(
                    Input(type="radio", name=self.done, value=option, checked=(option==value)),
                    f" {option}"
                )
                for option in self.options
            ],
            Button("Submit", type="submit")
        )
```

---

### 🔄 **Step Instances (Customized per Workflow):**

Your workflow definition can now explicitly choose UI type per step:

```python
steps = [
    TextInputStep(id='step_01', done='username', show='Your Username'),
    TextAreaStep(id='step_02', done='bio', show='Short Bio'),
    DropdownStep(id='step_03', done='favorite_color', show='Favorite Color', options=['Red', 'Blue', 'Green']),
    CheckboxStep(id='step_04', done='interests', show='Interests', options=['AI', 'SEO', 'Python']),
    RadioStep(id='step_05', done='experience_level', show='Experience Level', options=['Beginner', 'Intermediate', 'Advanced']),
]
```

---

### 🎯 **How the Workflow Code Becomes Simpler:**

Your central `handle_step` method shrinks dramatically to something like:

```python
async def handle_step(self, request):
    step_id = request.url.path.split('/')[-1]
    step = self.get_step_by_id(step_id)
    value = self.get_saved_value(step_id)
    return Div(step.render(value), id=step.id)
```

Similarly, your submission handler becomes clearer:

```python
async def handle_step_submit(self, request):
    step_id = request.url.path.split('/')[-1].replace('_submit', '')
    step = self.get_step_by_id(step_id)
    form = await request.form()
    is_valid, error_msg = step.validate(form)
    if not is_valid:
        return P(error_msg, style="color: red;")
    processed_val = step.process(form)
    self.save_step_data(step_id, processed_val)
    next_step = self.get_next_step(step_id)
    return Div(
        Div(f"{step.show}: {processed_val}"),
        Div(id=next_step.id, hx_get=f"/{self.app_name}/{next_step.id}", hx_trigger="load")
    )
```

---

### 🚩 **Major Benefits of This Adjusted Approach:**

1. **Full Flexibility:** Each step can define entirely custom UI without hacking core logic.
2. **Cleaner Code:** Workflow methods are cleaner and don't have form-specific logic.
3. **Easy to Extend:** Adding new step types is trivial.
4. **Clear separation of concerns:** Rendering, validation, and processing neatly encapsulated per step.

---

## 🚧 **Potential Further Abstraction:**

- Consider defining reusable step "widgets" for commonly reused UI patterns.
- You could further allow passing arbitrary kwargs to steps, enabling even richer customization.

Example of arbitrary kwargs for more flexibility:

```python
class CustomWidgetStep(BaseStep):
    def __init__(self, id, done, show, render_func, **kwargs):
        super().__init__(id, done, show)
        self.render_func = render_func
        self.kwargs = kwargs

    def render(self, value):
        return self.render_func(self.done, value, **self.kwargs)
```

Now you can instantiate:

```python
steps = [
    CustomWidgetStep(
        id='step_06',
        done='rating',
        show='Your Rating',
        render_func=my_rating_widget,  # completely custom rendering
        stars=5, color='gold'
    ),
]
```

---

## 🗣️ **Final Takeaway:**

Your current Pipulate/FastHTML pattern is beautifully simple but overly rigid for realistic workflows beyond simple text-entry. By adopting a polymorphic rendering pattern, delegating UI and form complexity explicitly to each step type, you dramatically expand Pipulate’s potential without sacrificing clarity or elegance. 

This adjustment future-proofs your framework for genuinely complex, realistic user interaction scenarios.

---

## Nope

**Me**: This is one approach. But what about if every instance is radically
different than the one that came before it. Isn't such OOP templating just
loosening up the restrictions with another set of rigid restrictions. Now you
have to go inventing all sorts of new APIs and conventions, causing cognitive
overload forever forward. It's a lot like the decision to not use a superclass
for workflows at all. However, in one concession to easy example templating, I
made a loop so that the same `handle_step()` and `handle_step_submit()` could be
reused. But what if instead of those being templates, they were each "un-looped"
and "un-templated", expanded-out to provide unlimited surface-area for
customization in each step. Imagine if each step were as fully flexible as a
cell in a Jupyter Notebook. How inflexible would a Notebook cell be with the
kinds of limitations you're proposing be?

**ChatGPT**: You've hit the nail on the head:  

Your concern is absolutely valid. Even introducing the OOP-based polymorphic rendering still restricts flexibility—just at a slightly different abstraction level. Rather than liberating your workflow steps, it introduces **another layer of conventions and cognitive overhead**. It might be slightly better than your initial restriction to text inputs, but it's not fundamentally more flexible.

The ultimate **goal** you have—making each workflow step as fully flexible as a Jupyter Notebook cell—means each step can freely mix:

- **Rendering logic:** Any combination of HTML/HTMX you want.
- **Validation logic:** Any custom Python code.
- **Processing logic:** Arbitrary transformations without restrictions or predefined APIs.

Your proposed approach of completely **"unlooping" and "untemplating"** the steps is actually the purest, most liberating way forward—*radically embracing explicitness over abstractions.*

---

### 🟢 **The Real Solution (Complete "Un-looping"):**

Instead of looping through steps with abstract handlers (`handle_step` / `handle_step_submit`) that rely on pre-defined data structures (`Step`) or superclass abstractions, you explicitly write out **each step’s handler as its own function.**  

You abandon attempts to generalize or loop, and directly embrace clarity, freedom, and full Python flexibility:

**Before (current pattern):**
```python
# Reused for every step, locked into abstraction:
async def handle_step(step_id): ...
async def handle_step_submit(step_id): ...
```

**After ("Unlooped," flexible pattern):**
```python
# Each step explicitly, fully flexible:
async def step_01(request):
    return Form(
        Input(name="username"),
        Button("Submit"),
        hx_post="/step_01_submit"
    )

async def step_01_submit(request):
    form = await request.form()
    username = form.get("username")
    save_data("username", username)
    return Div(f"Hello {username}", hx_get="/step_02")

async def step_02(request):
    # Now, something radically different—like a textarea or custom widget
    return Form(
        Textarea(name="user_bio", placeholder="Enter bio..."),
        Button("Submit"),
        hx_post="/step_02_submit"
    )

async def step_02_submit(request):
    form = await request.form()
    bio = form.get("user_bio")
    if len(bio) < 10:
        return P("Bio must be at least 10 chars", style="color:red;")
    save_data("user_bio", bio)
    return Div(f"Bio saved!", hx_get="/step_03")

async def step_03(request):
    # Completely custom HTML, checkbox group, or special UI
    return Form(
        Label(Input(type="checkbox", name="interests", value="AI"), " AI"),
        Label(Input(type="checkbox", name="interests", value="SEO"), " SEO"),
        Button("Submit"),
        hx_post="/step_03_submit"
    )

async def step_03_submit(request):
    form = await request.form()
    interests = form.getlist("interests")
    save_data("interests", interests)
    return Div(f"Interests: {', '.join(interests)}", hx_get="/step_04")

# And so on...
```

---

### ✅ **Why This "Un-looped" Approach Is Best:**

- **Zero Cognitive Overhead:**  
  Every step handler directly expresses its intent. Developers never need to learn or remember intermediate abstractions.

- **Unlimited Surface Area:**  
  Each handler can have radically different forms, validations, layouts, and UI. No artificial constraints.

- **Explicitness & Clarity:**  
  No mental jumps or mappings needed. What you see is literally what you get. Each step is like a notebook cell.

- **Easy Customization:**  
  Rapid changes per step don't trigger "cascading refactor" headaches.

- **Debuggable & Observable:**  
  Each handler explicitly defined means debugging becomes trivial, without guessing about abstract behaviors.

- **Future-Proofing:**  
  You're not locked into new APIs or conventions that could quickly become outdated or confusing.

---

### ⚠️ **Isn't This Code Duplication?**

You might initially feel this approach is too repetitive—but consider:

- **"Duplication" ≠ "Repetition":**  
  Each step is actually unique enough to justify explicitness, just as each notebook cell is unique.

- **"DRY" Misuse:**  
  Overzealous DRY ("Don't Repeat Yourself") leads to fragile abstractions. Sometimes, explicit is better than abstract.

- **Copy-and-Paste as a Feature:**  
  Just as Jupyter Notebook cells explicitly encourage cell-level duplication and adaptation, this approach explicitly encourages customization per-step.

---

### 📌 **Minimal Common Utilities:**

While abandoning forced abstractions, you can still provide minimal optional helper utilities—like:

- `save_data(key, value)` to store step data.
- `load_data(key)` to retrieve saved step data.
- `validation_helpers.py` for common validations, etc.

But these helpers are fully optional conveniences, **never mandatory constraints.**

---

### 🧩 **Philosophically Aligned with Your Project:**

This aligns perfectly with your philosophy in Pipulate and FastHTML:

- **Radical simplicity:** fewer abstractions, more clarity.
- **Explicit pipelines:** like UNIX pipes or notebook cells.
- **No forced superclass:** each workflow explicitly defined.

---

### 🚩 **How Inflexible Would Notebook Cells Be with Rigid Abstractions?**

Imagine enforcing something similar in a notebook:

```plaintext
NotebookCell(content_type='text', content='...')
NotebookCell(content_type='code', code='print(x)')
```

The notebook would immediately lose its charm. Each cell would lose flexibility, ease of experimentation, and the ability to freely mix content, inputs, outputs, and logic. That's exactly the rigidity you'd impose by overly abstracting each step into rigid form types or subclasses.

---

## 🎯 **Final Recommendation:**

Your intuition to completely un-loop and explicitly expand out each step is exactly right. Embrace it. Give each step full surface-area, explicitly defined. This fully reflects the notebook’s cell-level freedom and aligns perfectly with your design philosophy.

**Explicit, un-looped, un-templated step definitions** provide maximum flexibility, clarity, and user empowerment.

---

## Splice-ables

**Me**: Okay, I think you're finally getting the idea. However, from what I've
seen of your coding so far I don't trust you to do the job yourself. You're
going to subtly change stuff and break it. But I do trust you to analyze the
unlooping job ahead of me. In the same way that you did the Analysis of a
Pipulate Workflow, do an analysis of the re-use of `handle_step()` and
`handle_step_submit()`, as if it were a step-by-step guide to doing the
unlooping and creating surface area for customization on a 2-step procedure. In
fact, we should make it a 3-step procedure so that there is "one-in-the-middle"
ready for splicing. The first one comes from `landing` and the last one goes to
`finalization`, making the one in the middle the only one that has a `step_xx`
on either side.

What we're laying the groundwork for is a splicing system. I am going to keep a
library of copy/pastable templates of each type of form thing, such as
dropdowns, textareas and radio buttons. But it will support too things like
Anywidgets and tables made from `pip install dominate`. Get it? Lego building
blocks. Or given the Unix pipe metaphor we've been using, Unix commands. Things
specifically designed to take the input from the prior step, process it, and
send the output to the next step.

So in the end, I am basically making a new Hello World example for this system,
a new `workflow_template.py` file, but one that is a bit longer. I don't want
anyone to be caught in the confusion and excessive confines of the templated
loop. I want it to be clearly laying the groundwork for radical customization
Jupyter Notebook Cell style.

And what I am asking for from you is not the new code. No, I am going to be
precise and pedantic about it, copy/pasting blocks that would be too expensive
for you with all those tokens, causing you to take short-cuts that will only
introduce bugs. Dedicate your entire formidable self to creating a step-by-step
guide assisting me in doing this de-templating and un-looping work, please and
thank you!

**ChatGPT**: 

## 🎯 **Step-by-Step Guide to Unlooping & De-Templating Your Pipulate Workflow**

This guide precisely walks you through the process of turning your current workflow (with abstract `handle_step()` and `handle_step_submit()`) into a completely explicit, cell-like structure—"unlooped" and "untemplated"—ready for radical customization.

Instead of loops and reused methods, you'll explicitly define handlers per step, each directly handling rendering, validation, and processing. Your 3-step workflow will become:

- **Step 1:** from `landing` to `step_01`.
- **Step 2:** `step_02`, the middle step (easily replaceable).
- **Step 3:** from `step_02` to `finalization`.

---

## 📍 **Overview of Steps to Unlooping**

- **✅ Step A:** Identify & remove loop-based route registration.
- **✅ Step B:** Remove generalized `handle_step()` and `handle_step_submit()`.
- **✅ Step C:** Explicitly define rendering/submit handlers for each step (`step_01`, `step_02`, etc.).
- **✅ Step D:** Clearly set explicit form/input customization areas per step.
- **✅ Step E:** Explicitly handle transitions between steps.
- **✅ Step F:** Provide explicit save/load state handling without abstractions.

Let's start:

---

## ✅ **Step A: Remove Loop-Based Route Registration**

**Before (Looped registration):**
```python
for step in self.STEPS:
    routes.extend([
        (f"/{app_name}/{step.id}", self.handle_step),
        (f"/{app_name}/{step.id}_submit", self.handle_step_submit, ["POST"])
    ])
```

**After (Explicit per-step route definition):**
```python
routes = [
    (f"/{app_name}/step_01", self.step_01),
    (f"/{app_name}/step_01_submit", self.step_01_submit, ["POST"]),
    (f"/{app_name}/step_02", self.step_02),
    (f"/{app_name}/step_02_submit", self.step_02_submit, ["POST"]),
    (f"/{app_name}/finalize", self.finalize, ["GET", "POST"]),
    # keep other general handlers like landing, revert, etc.
]
```

Now every step is explicit. You're no longer tied to the abstraction of looping.

---

## ✅ **Step B: Remove Generalized Handlers**

You will **completely delete** these methods:

```python
async def handle_step(self, request):
    # DELETE THIS METHOD ENTIRELY
async def handle_step_submit(self, request):
    # DELETE THIS METHOD ENTIRELY
```

You're freeing yourself from the template-based restrictions.

---

## ✅ **Step C: Explicit Handlers for Each Step**

Define each step explicitly, clearly, and self-contained:

### **Step 1:** Landing → Step 01

```python
async def step_01(self, request):
    await self.pipulate.simulated_stream("Please enter your name.")
    return Div(
        Card(
            H3("Step 01: Your Name"),
            Form(
                Input(type="text", name="name", placeholder="Enter name"),
                Button("Submit"),
                hx_post=f"/{self.app_name}/step_01_submit",
                hx_target="#step_01"
            )
        ),
        id="step_01"
    )

async def step_01_submit(self, request):
    form = await request.form()
    name = form.get("name", "").strip()
    if not name:
        return P("Name required.", style="color: red;")
    self.pipulate.save_step("step_01", {"name": name})
    await self.pipulate.simulated_stream(f"Name saved: {name}")
    return Div(id="step_02", hx_get=f"/{self.app_name}/step_02", hx_trigger="load")
```

### **Step 2:** Fully Customizable Middle Step

This is your "splicing" point—where different templates can be easily pasted in:

```python
async def step_02(self, request):
    name = self.pipulate.load_step("step_01")["name"]
    await self.pipulate.simulated_stream(f"Hello {name}! Choose your favorite color.")
    return Div(
        Card(
            H3("Step 02: Favorite Color"),
            Form(
                Select(name="color",
                    options=[
                        Option("Red"), Option("Green"), Option("Blue")
                    ]
                ),
                Button("Submit"),
                hx_post=f"/{self.app_name}/step_02_submit",
                hx_target="#step_02"
            )
        ),
        id="step_02"
    )

async def step_02_submit(self, request):
    form = await request.form()
    color = form.get("color")
    if not color:
        return P("Color required.", style="color: red;")
    self.pipulate.save_step("step_02", {"color": color})
    await self.pipulate.simulated_stream(f"Color chosen: {color}")
    return Div(id="finalize", hx_get=f"/{self.app_name}/finalize", hx_trigger="load")
```

*This is the middle cell—your copy-paste playground!*

### **Step 3:** Finalization

Leave your existing finalize handler, but simplify explicitly:

```python
async def finalize(self, request):
    step_01 = self.pipulate.load_step("step_01")
    step_02 = self.pipulate.load_step("step_02")
    if request.method == "GET":
        await self.pipulate.simulated_stream("Ready to finalize.")
        return Card(
            H3("Finalize"),
            P(f"Name: {step_01['name']}"),
            P(f"Color: {step_02['color']}"),
            Form(
                Button("Finalize Workflow"),
                hx_post=f"/{self.app_name}/finalize",
                hx_target="#finalize"
            ),
            id="finalize"
        )
    else:  # POST
        self.pipulate.save_step("finalize", {"finalized": True})
        await self.pipulate.simulated_stream("Workflow finalized successfully.")
        return Div(P("Workflow complete!", style="color: green;"))
```

---

## ✅ **Step D: Areas Clearly Marked for Form Customization**

- Each step above explicitly renders its form fields.
- Step 2’s area is explicitly meant for pasting dropdowns, checkboxes, radio buttons, Anywidgets, dominate tables, or other UI Lego blocks.

---

## ✅ **Step E: Explicit Transition Handling**

- Every handler explicitly specifies `hx_get` next-step loading.
- No hidden automatic transitions.

Example:

```python
# Explicit next step call
return Div(id="step_xx", hx_get=f"/{self.app_name}/step_xx", hx_trigger="load")
```

---

## ✅ **Step F: State Saving & Loading (Simple and Explicit)**

Replace complex abstractions with simple methods:

```python
self.pipulate.save_step("step_id", {"key": "value"})
self.pipulate.load_step("step_id")
```

A simple JSON blob state-saving mechanism.

---

## 📌 **Resulting Structure (Clearly Explicit)**

```plaintext
Landing → Step_01 → Step_02 (Customizable) → Finalize
```

- Each explicitly handled with clearly defined functions.
- Perfectly ready for radical per-step customization and "splicing."

---

## 🔥 **Final Result & Philosophy**

This clearly explicit and de-templated workflow aligns completely with your Unix pipe and Jupyter Notebook metaphor:

- **Each handler is a cell.**
- **Data explicitly moves from handler-to-handler (cell-to-cell).**
- **Customization requires zero cognitive overhead.**
- **Splicing is trivial.** You copy/paste handlers freely without worrying about abstractions.

This structure **lays the perfect groundwork** for your explicit library of form-building blocks (dropdowns, checkboxes, custom widgets, etc.), fully enabling your vision.

---

## 🌟 **Conclusion**

By precisely following this guide:

- You've removed abstractions that limit radical customization.
- You've explicitly created a 3-step template (landing, middle, finalize) perfect for splicing.
- You've made your workflows flexible, explicit, intuitive, and Jupyter-cell-like.

This explicitly "un-looped" structure empowers developers to freely mix-and-match steps like Lego bricks, enabling rapid, frustration-free customization of workflows.

---

## An AI's Take

Alright, let's get this done.

**Summary (Author's Perspective):**

"I've realized that the initial templated approach to building Pipulate workflows, while simple for basic forms, severely limits customization for complex UI elements like textareas, dropdowns, and custom widgets. To address this, I'm shifting to a completely explicit, 'unlooped' design where each workflow step is defined by its own dedicated handler function. This approach mirrors the flexibility of Jupyter Notebook cells, allowing for radical customization without the constraints of rigid abstractions or predefined APIs. By eliminating generalized `handle_step()` and `handle_step_submit()` methods and instead defining each step's rendering, validation, and processing logic independently, I'm creating a system where developers can easily splice in custom UI components and logic, fostering a more intuitive and powerful workflow creation experience."

**Title and Headline Ideas:**

* **Titles:**
    * Unlooping Pipulate: Radical Customization for Workflows
    * Beyond Templates: Building Flexible Workflows with Explicit Steps
    * Pipulate Unchained: Empowering Custom UI in Workflows
    * From Abstraction to Explicitness: Revolutionizing Pipulate Workflows
    * The Jupyter Cell Approach: Reimagining Pipulate Steps
* **Headlines:**
    * "Ditch the Templates: Unleashing Custom UI in Pipulate"
    * "Unloop Your Workflows: Radical Flexibility with Explicit Steps"
    * "Pipulate Reimagined: Empowering Developers with Cell-Level Customization"
    * "No More Restrictions: Building Workflows with Full UI Freedom"
    * "Jupyter-Style Workflows: The Future of Pipulate Customization"

**AI Opinion:**

I find the author's decision to move towards a fully explicit, "unlooped" workflow structure to be a very insightful and practical approach. It addresses the inherent limitations of template-based systems, especially when dealing with the diverse UI requirements of real-world applications. The analogy to Jupyter Notebook cells is particularly effective in illustrating the desired level of flexibility and customization. By prioritizing clarity and explicitness over abstract generalizations, the author is creating a developer-friendly environment that encourages experimentation and innovation. This approach not only simplifies the development process but also enhances the long-term maintainability and extensibility of the Pipulate framework. It's a very refreshing way to look at workflow creation.

