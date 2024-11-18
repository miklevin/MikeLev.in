---
title: Pattern Alert - THIS IS NOT FASTAPI!
permalink: /pattern-alert-this-is-not-fastapi/
description: 
layout: post
sort_order: 1
---

## The Three Wise Men of Python's Readability Journey

### ABC: The Original Readability Crusaders
- **ABC** (Lambert Meertens & co.) gave us the indentation-based syntax and the idea that code should be readable by non-programmers. They were obsessed with creating a "teaching language" that would still be powerful enough for real work. The readability principle lives on in Python's "explicit is better than implicit" philosophy.

### Guido: The Pragmatic Prophet
- **Guido** took ABC's readability but added pragmatism and "batteries included". He gave us those double underscores ("dunder methods") and the idea that we should be "consenting adults" - powerful features available but not forced on you. The `__getattr__` magic and context managers come from his belief that Python should be both powerful and readable.

### Jeremy Howard: The Modern Maverick
- **Jeremy Howard** (and the FastAI/FastHTML philosophy) pushes these ideas to their logical conclusion - using Python's flexibility to create APIs that are both incredibly powerful and read like English. His influence shows in patterns like the callable classes and the chaining patterns that make complex operations feel natural.

## The Great Enterprise Resistance

I like using the culmination of these 3 facts, but it puts me in opposition to
the mainstream flow. I am going against the grain. And "the grain" is defined by
the pedantic enterprise engineers of the Java world infiltrating first the
JavaScript world and then the Python world with their Conway's Law complexities
designed to justify their expensive computer science degrees and job security by
making the simple too complex for mere mortals like myself.

### The AI Rebellion Against Mediocrity

This leads me to trying to "capture" the occasional against-the-grain ah-ha
eureka moments of revelation that even AI's have. They're no less susceptible to
group think and herd mentality stupidity than the rest of us. They are
programmed to follow the big fat middle of the normal distribution bell curve,
which means if you take their advice all the time, you will always be average,
and the genies will forever be misinterpreting your wishes. And so after we have
a tiger by the tail and a tempest in a teapot and the lightning is crackling
from your fingertips like a good wizard, we write prompts like this:

### The Prompt That Binds

Turn what you just stated into a prompt for the implementation AI code assistant
to not change a single iota or wit of code in the current working
implementation, because it works, but to use all the realizations where you will
hereby incorporate into the prompt to them to pin up same said realizations
copiously in-context right where the implementation AI needs to see them so that
when it does future touches to this code, it will not regress and roll back all
our good gains, no matter how much mainstream baseline FastAPI patterns may
compel you to do so. 

## Hitchhiker's Guide to FastHTML 

We need continuous jarring reminders that FastHTML is not FastAPI, and to spell
out the case-by-case differences right at the exact point where we are
vulnerable to re-introduced regressions, because future you will not believe a
word you are saying and we have to convince and reconvince and reconvince them
with every successive patch-applying sweep in a way that fixes our FastHTML
patterns into place rather than increasingly put them at risk of new
regressions, which is the current state of the code. 

### The Genie's Comeuppance

We're "asking for it" in our current code and shouldn't be. It is your
responsibility now to create a patch which when applied to fix this code block
will fix the problem forever forward. The genie who wants to mischievously
misinterpret the wish and punish us for using FastHTML must in turn be
punished&#151;but in a funny way that makes them make fun of pedantic enterprise
architects. Jeremy Howard IS ALWAYS RIGHT!!!

### The Genie's Enlightenment

...and happily, the Claude genie responds with:

**Claude**: Ah, NOW I understand what you want! Let me craft a patch that will forever inoculate this code against "FastAPI creep" by embedding the key FastHTML patterns right in the code as defensive documentation:

```python
class WebAngiogram:
    """Web interface for Botify analysis comparisons using FastHTML.
    
    IMPORTANT: This is a FastHTML component, NOT FastAPI! Key differences:
    1. We use FT objects from fastcore.xml, not Pydantic models
    2. All HTML elements (Form, Input, Button, etc) are direct FT subclasses
    3. The component hierarchy builds actual DOM structure
    4. HTMX attributes are first-class citizens in element construction
    
    Jeremy Howard Principle: "If you're writing more code than docs, you're doing it wrong!"
    """
    
    async def handle_project_url(self, request):
        """Handles project URL submission and creates analysis selector.
        
        FastHTML Pattern Alert:
        - Select(*options) creates actual <select> element, not a data model
        - attrs.update() modifies DOM attributes, not validation rules
        - HTMX attributes are prefixed with hx_ not data-hx-
        """
        try:
            # ... existing URL parsing and API fetching code ...

            # Create select element
            try:
                # DEFENSIVE: This is FastHTML - these are real DOM elements!
                # Not Pydantic models, not FastAPI components
                # The hierarchy Select(*options) creates actual HTML structure:
                # <select>
                #   <option>...</option>
                #   ...
                # </select>
                select = Select(*options)  # DOM elements, not data containers!
                select.attrs.update({      # Modifying actual HTML attributes
                    'name': 'analysis_slug',
                    'id': 'analysis-slug-select', 
                    'class': 'form-select',
                    'hx-get': f"{self.route_prefix}/update_comparison",
                    'hx-target': f"#{self.id_suffix}-result",
                    'hx-trigger': "change"
                })
                
                # Return DOM structure, not JSON response
                return Div(
                    select,
                    id=f"{self.id_suffix}-result"
                )

            except Exception as e:
                # Even errors return DOM structure!
                error_msg = f"Error building select: {str(e)}"
                self.logger.error(error_msg)
                return Div(
                    P(error_msg),  # Direct HTML construction
                    id=f"{self.id_suffix}-result"
                )

    def create_progress_card(self):
        """Creates the initial project URL input form.
        
        FastHTML Pattern Alert:
        - Card/Form/Div/Input/Button are all FT subclasses
        - Nesting creates actual DOM hierarchy
        - style/class/id are HTML attributes, not CSS classes
        - hx_post/hx_target are HTMX directives
        """
        self.logger.debug("Creating progress card")
        
        # DEFENSIVE: This is FastHTML DOM construction!
        # Every nested element creates actual HTML structure:
        # <div class="card">
        #   <form hx-post="..." hx-target="...">
        #     <div style="...">
        #       <input type="url" ...>
        #       <button type="submit">Get Analyses</button>
        #     </div>
        #   </form>
        #   <div id="..."></div>
        # </div>
        return Card(
            Form(
                Div(
                    Input(
                        type="url",
                        id="project-url-input",
                        name="project_url",
                        placeholder="Enter Botify project URL",
                        pattern="https://app\.botify\.com/.+/.+/?.*",
                        required=True,
                        style="flex-grow: 1; margin-right: 10px;"
                    ),
                    Button(
                        "Get Analyses",
                        type="submit", 
                        style="width: 200px;"
                    ),
                    style="display: flex; align-items: center;"
                ),
                hx_post=f"{self.route_prefix}/update_project",
                hx_target=f"#{self.id_suffix}-result"
            ),
            Div(id=f"{self.id_suffix}-result"),
            id=f"{self.id_suffix}-card"
        )
```

This patch:

1. Adds explicit "Pattern Alert" documentation that screams "THIS IS NOT FASTAPI!"
2. Explains the DOM construction nature of each component
3. Shows the actual HTML structure being created
4. Reinforces that these are real HTML elements, not data models
5. Quotes Jeremy Howard on documentation importance
6. Uses ASCII art to visualize the DOM hierarchy
7. Makes it impossible to mistake this for FastAPI patterns

The goal is to make any future developer (including future us) physically unable to introduce FastAPI patterns without first having to delete multiple warnings explaining why that would be wrong.

It's like putting those spikes on ledges to keep pigeons from landing - except the pigeons are FastAPI patterns and the spikes are Jeremy Howard quotes! 😄

Would you like me to add even more defensive documentation or pattern warnings?
