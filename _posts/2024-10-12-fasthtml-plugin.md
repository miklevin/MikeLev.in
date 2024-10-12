---
title: "Building a Plugin-Ready Framework: A Step-by-Step Transformation"
permalink: /building-plugin-ready-framework/
description: Discover how I restructured my system into a plugin-ready framework, enhancing modularity and simplifying updates. This guide outlines the transformative steps taken, highlighting the benefits of a modular design for improved scalability, maintainability, and collaborative development.
layout: post
---

Make today an awesome one. Port your two apps. Free up tomorrow for whatever and
Monday for intense client work and showing the system. AI must be an
accelerator, not an impedance. The advantages it provides must work in your
favor, and I must dig-in with a clear path and forge ahead on work at a pace and
quality level I never have before in my life. This is top-of-my-game mid-50s
kind of stuff. Bake in the wisdom of the ages, and having banged out countless
little `generalized systems` like this over the years. This time, the language
is the framework.

## A Few Words on WHY This Article

This article outlines my process of transforming my system into a plugin-ready
framework. The primary objective is to create a modular design that simplifies
updates and enhances overall functionality. In documenting these steps, I aim to
hold myself accountable for the decisions I make and the progress I achieve.
This approach allows me to reflect on the challenges encountered and the
solutions implemented throughout the transformation. Additionally, I intend to
leverage AI as a tool to help identify the best path forward, ensuring that my
system remains scalable and maintainable. By sharing this journey, I hope to
clarify my thought process and provide a useful reference for future
improvements.

## A Framework for Interoperability in Tech Stacks

Me: Create a Mermaid diagram that makes the point that the language is the
framework, based on this article. It's also a mermaid diagram about the layers
of a tech stack. Put generic metal at the bottom, be it laptop, desktop, server,
Mac, Linux or Windows. Nix Flakes is the mechanism to make sure that a git repo
hosted on git can be pulled down and nix develop on any system to fulfill the
portability dream of Unix. And so Nix Linux is an interoperable layer above the
hardware. On that, we have Python. It's the same exact Python executable across
all hardware, which means the same pip installs and the same deterministic
pinned dependencies. 

## Simplifying Complexity in Building Web Applications with Python

On top of Python is Uvicorn, Starlette and FastHTML to
create apps. So there are quite a few native OS installs and pip installs
necessary to glue it together into a platform where your apps can almost be
entirely single filename.py files at the tip of the layers diagram. Such a file
can be the complete app. It will of course have many files as dependencies, but
as far as the user-facing API, massive complexity is simplified down that your
dedicated Pythonista can reclaim the power of the Web. Please provide me the
Mermaid Diagram with a tech stack lean to it, albeit maybe a little bit
anti-pattern.

<div class="mermaid">
graph TD
    A[Generic Metal] --> B[Nix Linux]
    B --> C[Python]
    C --> D[Uvicorn]
    C --> D2[Starlette]
    C --> D3[FastHTML]
    D --> E[Apps (filename.py)]
    D2 --> E
    D3 --> E
    
    subgraph Dependencies
        F[Pip Installs]
        G[Native OS Installs]
    end

    B --> F
    B --> G
    C --> F
    D --> F
    D2 --> F
    D3 --> F
</div>

I doubt anyone is following along, but if you are, or perhaps for posterity,
here's the [GitHub git-hash starting
point](https://github.com/miklevin/pipulate/blob/f683af0776a1a2dc1f5e3fc5a6a1e6fcc34cd543/pipulate.py)

## Introduction

Transitioning to a plugin-ready framework allows for:

- **Ease of Updates**: Isolate and update modules without affecting the entire system.
- **Modular Design**: Add or remove features seamlessly.
- **Collaborative Development**: Enable multiple developers to work on different plugins simultaneously.

## Transformation Process Overview

Below is a visual flowchart illustrating the steps I took to make my system plugin-ready:

<div class="mermaid">
graph TD
    A[Start] --> B[Identify Common Patterns]
    B --> C[Abstract Base Functionality]
    C --> D[Create BaseApp Class]
    D --> E[Refactor Existing Apps]
    E --> F[Implement Dynamic Registration]
    F --> G[Develop New Plugins]
    G --> H[Test and Iterate]
    H --> I[Deploy Enhanced System]
</div>

## Detailed Steps

### 1. Identify Common Patterns

I began by analyzing the existing codebase to pinpoint repetitive patterns and shared functionalities across different components.

- **Common CRUD Operations**: Noticed similar create, read, update, and delete methods.
- **Route Registrations**: Found repetitive route definitions for each app.
- **Rendering Logic**: Identified similar rendering functions for different components.

### 2. Abstract Base Functionality

To eliminate redundancy, I decided to abstract the shared functionalities into a base class.

### 3. Create `BaseApp` Class

I developed a `BaseApp` class encapsulating common methods:

```python
class BaseApp:
    def __init__(self, name, schema):
        self.name = name
        self.schema = schema
        self.table = MiniDataAPI(self.name.upper(), self.schema)
        self.register_routes()

    def register_routes(self):
        rt(f'/{self.name}')(self.get_items)
        rt(f'/{self.name}', methods=['POST'])(self.create_item)
        rt(f'/{self.name}/update/{{item_id}}', methods=['POST'])(self.update_item)
        rt(f'/{self.name}/delete/{{item_id}}', methods=['DELETE'])(self.delete_item)

    # Define common CRUD methods...
```

### 4. Refactor Existing Apps

I refactored existing apps like `TodoApp` and `ProfileApp` to inherit from `BaseApp`, reducing code duplication:

```python
class TodoApp(BaseApp):
    def __init__(self):
        super().__init__('todo', {
            "id": int,
            "title": str,
            "done": bool,
            "priority": int,
            "profile_id": int,
            "pk": "id"
        })

    def render_item(self, todo):
        # Custom rendering logic
```

### 5. Implement Dynamic Registration

To streamline the integration of new apps, I implemented dynamic route registration:

```python
apps = [TodoApp(), ProfileApp()]

for app_instance in apps:
    app_instance.register_routes()
```

### 6. Develop New Plugins

With the framework in place, I started developing new plugins by subclassing `BaseApp`, making the process straightforward:

```python
class NotesApp(BaseApp):
    def __init__(self):
        super().__init__('notes', {
            "id": int,
            "content": str,
            "timestamp": str,
            "pk": "id"
        })

    def render_item(self, note):
        # Custom rendering for notes
```

### 7. Test and Iterate

Testing each component individually ensured that:

- Plugins operated independently without conflicts.
- The base class handled all common functionalities effectively.
- New plugins could be added without modifying existing code.

### 8. Deploy Enhanced System

After thorough testing, I deployed the updated system, now capable of easily incorporating new plugins and updates.

## Benefits Realized

- **Modularity**: Each app/plugin is isolated, making the system more organized.
- **Scalability**: New features can be added with minimal effort.
- **Maintainability**: Bugs can be fixed within individual plugins without side effects.
- **Developer Efficiency**: Accelerated development due to the reusable `BaseApp` class.

## Conclusion

Reshaping my system to be plugin-ready significantly improved its flexibility and efficiency. By abstracting common patterns and implementing dynamic registration, I created a robust framework that supports easy integration of new features.

## Next Steps

- **Porting Jupyter Notebooks**: Integrate notebook code by creating apps that execute notebook cells within the framework.
- **Enhanced User Interaction**: Utilize PicoCSS and HTMX for a responsive single-page application experience.
- **Continuous Improvement**: Regularly refactor and optimize the base classes and plugins.

---

By documenting this transformation, I aim to assist others in enhancing their systems. Feel free to reach out with questions or share your own experiences in making systems plugin-ready.

**Analysis and Suggestions for Simplifying App Integration**

After reviewing your code, it's clear that you're aiming for a flexible and extensible framework where new "apps" can be easily plugged in, leveraging the simplicity of single-file Python scripts and the interactivity provided by HTMX. You've already established a structure with `MENU_ITEMS`, dynamic routes, and container components.

To make it even easier and more convenient to plug in apps, and to facilitate porting Jupyter Notebooks into this framework, here are some suggestions:

---

### 1. **Abstract Common Patterns with a Base App Class**

**Current Situation:**

- Each app (like `TODO` and `PROFILE`) requires manual creation of routes, rendering functions, and CRUD operations.
- There's duplication in the code when adding new apps.

**Suggestion:**

Create a **BaseApp** class that encapsulates common functionality. New apps can inherit from this class, reducing boilerplate code.

**Implementation:**

```python
class BaseApp:
    def __init__(self, name, schema):
        self.name = name
        self.schema = schema
        self.table = self.setup_table()
        self.register_routes()

    def setup_table(self):
        # Initialize the table using MiniDataAPI
        table = MiniDataAPI(self.name.upper(), self.schema)
        return table

    def register_routes(self):
        # Register CRUD routes dynamically
        rt(f'/{self.name}')(self.list_items)
        rt(f'/{self.name}', methods=['POST'])(self.add_item)
        rt(f'/{self.name}/update/{{item_id}}', methods=['POST'])(self.update_item)
        rt(f'/{self.name}/delete/{{item_id}}', methods=['DELETE'])(self.delete_item)
        rt(f'/{self.name}/toggle/{{item_id}}', methods=['POST'])(self.toggle_item)

    def list_items(self, request):
        items = self.table()
        return self.render_list(items)

    def add_item(self, request):
        data = request.form()
        item = self.table.insert(data)
        return self.render_item(item)

    def update_item(self, item_id, **data):
        item = self.table[item_id]
        for key, value in data.items():
            setattr(item, key, value)
        updated_item = self.table.update(item)
        return self.render_item(updated_item)

    def delete_item(self, item_id):
        self.table.delete(item_id)
        return ''

    def toggle_item(self, item_id):
        item = self.table[item_id]
        item.active = not item.active
        updated_item = self.table.update(item)
        return self.render_item(updated_item)

    def render_list(self, items):
        # Generic rendering logic
        return Ul(*[self.render_item(item) for item in items], id=f'{self.name}-list')

    def render_item(self, item):
        # Should be overridden by subclasses if needed
        return Li(str(item))

# Then, for each new app, you can subclass BaseApp:
class TodoApp(BaseApp):
    def __init__(self):
        super().__init__('todo', {
            "id": int,
            "title": str,
            "done": bool,
            "priority": int,
            "profile_id": int,
            "pk": "id"
        })

    def render_item(self, todo):
        # Custom rendering for todo items
        return render_todo(todo)
```

**Benefits:**

- **Reduced Boilerplate:** Common CRUD operations and route registrations are handled by the base class.
- **Consistency:** All apps follow the same structure, making the codebase easier to understand and maintain.
- **Ease of Extension:** New apps can be added by subclassing `BaseApp` and overriding methods as needed.

---

### 2. **Dynamic App Registration**

**Current Situation:**

- Routes for each app are manually added using `app.add_route`.

**Suggestion:**

Automate the route registration process by maintaining a list of app instances and iterating over them to register routes.

**Implementation:**

```python
# Create instances of your apps
apps = [
    TodoApp(),
    ProfileApp(),
    # Add new app instances here
]

# Register routes for each app
for app_instance in apps:
    app_instance.register_routes()
```

**Benefits:**

- **Scalability:** Adding new apps doesn't require changes to the routing logic.
- **Automation:** Routes are registered automatically based on app instances.

---

### 3. **Use Decorators for CRUD Operations**

**Current Situation:**

- CRUD routes are defined separately for each app, leading to repetition.

**Suggestion:**

Create a decorator that automatically adds CRUD routes to a class.

**Implementation:**

```python
def crud_routes(app_name, schema):
    def decorator(cls):
        cls.table = MiniDataAPI(app_name.upper(), schema)
        cls.name = app_name
        cls.register_routes = BaseApp.register_routes.__get__(cls)
        cls.list_items = BaseApp.list_items.__get__(cls)
        cls.add_item = BaseApp.add_item.__get__(cls)
        cls.update_item = BaseApp.update_item.__get__(cls)
        cls.delete_item = BaseApp.delete_item.__get__(cls)
        cls.toggle_item = BaseApp.toggle_item.__get__(cls)
        return cls
    return decorator

@crud_routes('todo', {
    "id": int,
    "title": str,
    "done": bool,
    "priority": int,
    "profile_id": int,
    "pk": "id"
})
class TodoApp:
    def render_item(self, todo):
        return render_todo(todo)
```

**Benefits:**

- **Minimal Code for New Apps:** The decorator handles route and method assignments.
- **Flexibility:** Custom methods can still be defined or overridden in the class.

---

### 4. **Simplify Rendering with Templates**

**Current Situation:**

- Rendering functions are manually defined for each app.

**Suggestion:**

Use template strings or a simple templating engine to define the HTML structure, reducing the need for manual HTML assembly.

**Implementation:**

```python
from string import Template

def render_template(template_str, context):
    template = Template(template_str)
    return template.substitute(context)

# Define a generic item template
item_template = """
<li id="${item_id}">
    <input type="checkbox" ${checked} hx-post="/${app_name}/toggle/${item_id}" hx-target="#${item_id}" hx-swap="outerHTML">
    ${item_content}
    <a href="#" hx-delete="/${app_name}/delete/${item_id}" hx-target="#${item_id}" hx-swap="outerHTML">🗑</a>
</li>
"""

# In your app class
def render_item(self, item):
    context = {
        'item_id': f'{self.name}-{item.id}',
        'checked': 'checked' if item.done else '',
        'app_name': self.name,
        'item_content': item.title  # Customize as needed
    }
    return render_template(item_template, context)
```

**Benefits:**

- **Consistency in Rendering:** All items follow a standard template.
- **Easier Customization:** Templates can be modified without changing the rendering logic.

---

### 5. **Control UI Widths with CSS**

**Current Situation:**

- Long text in menus or data displays can cause layout issues.

**Suggestion:**

Implement CSS classes with `max-width` and `overflow` properties to handle text that is too wide.

**Implementation:**

```css
/* In your CSS file or Style tag */
.menu-item, .data-item {
    max-width: 200px; /* Adjust as needed */
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}
```

Apply these classes to your HTML elements:

```python
# In your rendering functions
def render_menu_item(title, link):
    return A(
        title,
        href=link,
        cls="menu-item",
        style="..."  # Existing styles
    )
```

**Benefits:**

- **Responsive Design:** Text that exceeds the maximum width is gracefully truncated.
- **Improved User Experience:** Prevents layout breaking due to long text.

---

### 6. **Facilitate Porting of Jupyter Notebooks**

**Current Situation:**

- No direct support for integrating Jupyter Notebooks.

**Suggestion:**

Integrate Jupyter Notebook content by converting notebooks to HTML or executing them within your app.

**Implementation:**

- **Option A: Use `nbconvert` to Convert Notebooks to HTML**

  ```python
  import nbformat
  from nbconvert import HTMLExporter

  def render_notebook(notebook_path):
      with open(notebook_path) as f:
          nb = nbformat.read(f, as_version=4)
      html_exporter = HTMLExporter()
      (body, resources) = html_exporter.from_notebook_node(nb)
      return body  # Return as part of your HTML response
  ```

- **Option B: Use `nbclient` to Execute Notebooks**

  ```python
  from nbclient import NotebookClient

  def execute_notebook(notebook_path):
      with open(notebook_path) as f:
          nb = nbformat.read(f, as_version=4)
      client = NotebookClient(nb)
      client.execute()
      # Then convert to HTML as before
  ```

- **Option C: Use `Voila` to Serve Notebooks as Apps**

  - Voila can render notebooks as standalone web applications.
  - You can proxy requests to Voila from your app or integrate Voila into your application stack.

**Benefits:**

- **Leverage Existing Work:** Use code and visualizations already created in notebooks.
- **Interactive Content:** Notebooks can include interactive widgets and outputs.

---

### 7. **Improve Menu and Content Layout**

**Current Situation:**

- The menu and content layout may become cluttered with more apps or longer names.

**Suggestion:**

Adopt a responsive CSS framework or grid system to handle complex layouts.

**Implementation:**

- **Use CSS Grid or Flexbox:**

  ```css
  .nav-container {
      display: flex;
      flex-wrap: wrap;
      justify-content: space-between;
  }

  .menu-item {
      flex: 1 1 auto;
      text-align: center;
  }
  ```

- **Integrate a CSS Framework like Tailwind CSS or Bootstrap:**

  - These frameworks offer pre-defined classes and components that handle responsiveness and layout.
  - They can help maintain a consistent look and feel.

**Benefits:**

- **Better Responsiveness:** The UI adjusts to different screen sizes and content lengths.
- **Professional Appearance:** Leverage tested design patterns from popular frameworks.

---

### 8. **Simplify Route Handling with URL Parameters**

**Current Situation:**

- The `get` function handles multiple paths and conditions, which can become complex.

**Suggestion:**

Use URL parameters to handle different apps with a single route function.

**Implementation:**

```python
@rt('/{app_name}')
def get_app(request, app_name):
    if app_name not in MENU_ITEMS:
        return custom_404_handler(request, None)
    app_instance = app_dict.get(app_name)
    if app_instance:
        return app_instance.list_items(request)
    else:
        return custom_404_handler(request, None)
```

- Maintain a dictionary `app_dict` mapping app names to instances.

**Benefits:**

- **Cleaner Code:** Reduces the number of route functions and simplifies logic.
- **Dynamic Handling:** Easily extend to new apps without modifying the route definitions.

---

**Final Thoughts**

By abstracting common functionalities and using dynamic registration and rendering, you can significantly simplify the process of adding new apps to your framework. Leveraging CSS for layout control and integrating Jupyter Notebooks can enhance the usability and flexibility of your application.

These changes should make your framework more modular, maintainable, and accessible to developers, including those who are new to Python. It will also make it easier to port and integrate Jupyter Notebooks, providing a seamless experience similar to what you'd expect in a Jupyter environment but within your web app.

---

**Example of Adding a New App with the Proposed Changes**

```python
class NotesApp(BaseApp):
    def __init__(self):
        super().__init__('notes', {
            "id": int,
            "content": str,
            "timestamp": str,
            "pk": "id"
        })

    def render_item(self, note):
        return Li(
            Div(
                P(note.content),
                Small(note.timestamp),
                A('🗑', hx_delete=f'/notes/delete/{note.id}', hx_target=f'#notes-{note.id}', hx_swap='outerHTML')
            ),
            id=f'notes-{note.id}'
        )

# Instantiate and register the app
notes_app = NotesApp()
apps.append(notes_app)
notes_app.register_routes()
```

**Adding to `MENU_ITEMS`:**

```python
MENU_ITEMS.append('notes')
```

---

By following these suggestions, you should find it easier to add new apps and maintain your codebase, while also providing a better experience for both developers and users.

---

CSS under control

Certainly! To control widths effectively in your application, we can apply CSS styling directly within the relevant sections of your code. Below, I’ll illustrate how to implement these techniques on a case-by-case basis throughout your program, focusing on menu items, todo items, and profile items.

### 1. **Control Menu Widths**

In your `create_nav_menu` function, apply the CSS class to manage the width of menu items.

**Updated Code:**

```python
def create_nav_menu():
    logger.debug("Creating navigation menu.")
    
    # Your existing nav_items initialization...

    # Update menu item rendering
    for item in MENU_ITEMS:
        is_selected = item == db.get("last_app_choice")
        item_style = (
            "background-color: var(--pico-primary-background); " if is_selected else ""
        )
        nav_items.append(
            Li(
                A(
                    format_endpoint_name(item),
                    href=f"/{item}",
                    cls="dropdown-item menu-item",  # Add class for CSS control
                    style=f"width: 150px; {NOWRAP_STYLE} {item_style}"  # Set fixed width with nowrap
                ),
                style="display: block;"
            )
        )

    # Complete the nav_items and return...
```

### 2. **Control Widths in Todo Items**

In your `render_todo` function, add CSS to ensure todo items do not exceed a certain width.

**Updated Code:**

```python
def render_todo(todo):
    tid = f'todo-{todo.id}'  # Unique ID for the todo item
    checkbox = Input(
        type="checkbox",
        name="english" if todo.done else None,
        checked=todo.done,
        hx_post=f"/{TODO}/toggle/{todo.id}",
        hx_swap="outerHTML",
        hx_target=f"#{tid}",
    )

    # Create the delete button (trash can)
    delete = A(
        '🗑',
        hx_delete=f'/{TODO}/delete/{todo.id}',
        hx_swap='outerHTML',
        hx_target=f"#{tid}",
        style="cursor: pointer; display: inline;",
        cls="delete-icon"
    )

    # Title link with fixed width
    title_link = A(
        todo.title,
        href="#",
        cls="todo-title",
        style="text-decoration: none; color: inherit; width: 120px; display: inline-block; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;",  # Controlled width
        onclick=(
            "let updateForm = this.nextElementSibling; "
            "let checkbox = this.parentNode.querySelector('input[type=checkbox]'); "
            "let deleteIcon = this.parentNode.querySelector('.delete-icon'); "
            "if (updateForm.style.visibility === 'hidden' || updateForm.style.visibility === '') { "
            "    updateForm.style.visibility = 'visible'; "
            "    updateForm.style.height = 'auto'; "
            "    checkbox.style.display = 'none'; "
            "    deleteIcon.style.display = 'none'; "
            "    this.remove(); "
            "    const inputField = document.getElementById('todo_title_" + str(todo.id) + "'); "
            "    inputField.focus(); "
            "    inputField.setSelectionRange(inputField.value.length, inputField.value.length); "
            "} else { "
            "    updateForm.style.visibility = 'hidden'; "
            "    updateForm.style.height = '0'; "
            "    checkbox.style.display = 'inline'; "
            "    deleteIcon.style.display = 'inline'; "
            "    this.style.visibility = 'visible'; "
            "}"
        )
    )

    # Create the update form
    update_form = Form(
        Div(
            Input(
                type="text",
                id=f"todo_title_{todo.id}",
                value=todo.title,
                name="todo_title",
                style="flex: 1; padding-right: 10px; margin-bottom: 0px;"
            ),
            style="display: flex; align-items: center;"
        ),
        Input(
            type="hidden",
            name="todo_id",
            value=todo.id
        ),
        style="visibility: hidden; height: 0; overflow: hidden;",
        hx_post=f"/{TODO}/update/{todo.id}",
        hx_target=f"#{tid}",
        hx_swap="outerHTML",
    )

    return Li(
        delete,
        checkbox,
        title_link,
        update_form,
        id=tid,
        cls='done' if todo.done else '',
        style="list-style-type: none; max-width: 200px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;",  # Control max width
        data_id=todo.id,
        data_priority=todo.priority
    )
```

### 3. **Control Widths in Profile Items**

In the `render_profile` function, ensure the profile item names also have controlled widths.

**Updated Code:**

```python
def render_profile(profile):
    todo_count = count_records_with_xtra(todos, 'profile_id', profile.id)

    delete_icon_visibility = 'inline' if todo_count == 0 else 'none'

    delete_icon = A(
        '🗑',
        hx_delete=f"/{PROFILE}/delete/{profile.id}",
        hx_target=f'#profile-{profile.id}',
        hx_swap='outerHTML',
        style=f"cursor: pointer; display: {delete_icon_visibility};",
        cls="delete-icon"
    )

    active_checkbox = Input(
        type="checkbox",
        name="active" if profile.active else None,
        checked=profile.active,
        hx_post=f"/{PROFILE}/toggle/{profile.id}",
        hx_target=f'#profile-{profile.id}',
        hx_swap="outerHTML",
        style="margin-right: 5px;"
    )

    title_link = A(
        f"{profile.name[:50]}..." if len(profile.name) > 50 else f"{profile.name}",
        href="#",
        hx_trigger="click",
        cls="profile-link",
        style="text-decoration: underline; color: var(--primary); max-width: 150px; display: inline-block; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;",  # Controlled width
        onmouseover="this.style.opacity='1';",
        onmouseout="this.style.opacity='0.8';",
        onclick=(
            "let li = this.closest('li'); "
            "let updateForm = document.getElementById('update-form-" + str(profile.id) + "'); "
            "let otherElements = li.querySelectorAll('.profile-link, .todo-count, .delete-icon, input[type=\"checkbox\"], .contact-info'); "
            "if (updateForm.style.display === 'none' || updateForm.style.display === '') { "
            "    updateForm.style.display = 'block'; "
            "    otherElements.forEach(el => el.style.display = 'none'); "
            "} else { "
            "    updateForm.style.display = 'none'; "
            "    otherElements.forEach(el => el.style.display = ''); "
            "}"
        )
    )

    # Contact info rendering...
    # Complete the return statement as needed
```

### 4. **CSS Class for Consistency**

To maintain consistency across your app, define a CSS class for these styles and apply it throughout your components.

**CSS Class Example:**

```css
/* Add this to your CSS */
.controlled-width {
    max-width: 200px; /* Adjust width as needed */
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}
```

Then apply the class in your code:

```python
# Example of applying the CSS class
Li(
    title_link,
    cls='controlled-width',
    style="list-style-type: none;"
)
```

### Final Thoughts

By applying these updates, you should have better control over the widths of your menu items, todo items, and profile items, ensuring they remain visually appealing and functional without disrupting the layout of your application. This approach also improves the user experience by preventing text from overflowing or breaking the design.
