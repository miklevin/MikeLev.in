---
title: Object Oriented Base Class Plugins
permalink: /object-oriented-baseclass-plugins/
description: 
layout: post
---

Okay, after a whole day of working in it, I have the heart of the plugin system
in place, and as it turns out, it's a ***base class*** for using object oriented
programming techniques. I don't do that much but now with the AI coding assist
both through Cursor AI and heavy use of their websites, I have the guidance,
safety net, and thus really confidence as well to tackle stuff I've been
hesitant about tackling in the past. OO syntax under Python is a bit
intimidating to me under Python. 

## Implementing Plugin System Improves Long-Term Adaptability and Viability

Okay, I must resist chasing rabbits down holes today. This adoption of a plugin
system has been a huge rabbit hole, a whole day so far invested into it, but
worth it. These changes now will assure the long-term adaptability and
flexibility, and thus viability of this system. The amount of work required for
adding new features now would make both the complexity and amount of code
explode, and since I'm using a single-file approach, I want to keep that under
control. Plugging in new apps should look beautiful and show off the system.

## Using Object-Oriented Programming in FastHTML Applications

So far, I've got this ***base class*** for apps called `BaseApp` which makes
heavy use of OO. Things I need to notice and say out loud to myself is that yes,
OO is loaded with arbitrary Guido van Rossum decisions, opinions and conventions
you just have to live with. You can't get away from the ***dunder*** internals,
which is a whole discussion in itself. FastHTML avoids exposing you to the `if
__name__ == '__main__'` conventional nonsense, and here we have to deal with a
`__init__` right away. It runs every time something derived from this base class
is instantiated, and in this case it's to make a bundle of variables packaged in
`self` to be made available all throughout the object, parsed from input
arguments on the calling function. Pshwew! Okay, I could document this better
for myself.

```python
class BaseApp:
    def __init__(self, name, table, toggle_field, sort_field):
        self.name = name
        self.table = table
        self.toggle_field = toggle_field  # Field to toggle
        self.sort_field = sort_field  # Field to sort on

    def register_routes(self, rt):
        """Register routes using the provided routing function."""
        rt(f'/{self.name}')(self.get_items)
        rt(f'/{self.name}', methods=['POST'])(self.create_item)
        rt(f'/{self.name}/update/{{item_id}}', methods=['POST'])(self.update_item)
        rt(f'/{self.name}/delete/{{item_id}}', methods=['DELETE'])(self.delete_item)
        rt(f'/{self.name}/toggle/{{item_id}}', methods=['POST'])(self.toggle_item)
        rt(f'/{self.name}/sort', methods=['POST'])(self.sort_items)

    async def get_items(self, request):
        """Retrieve all items."""
        items = self.table()
        return [self.render_item(item) for item in items]

    async def create_item(self, **kwargs):
        """Create a new item."""
        item = self.table.insert(kwargs)
        return self.render_item(item)

    async def update_item(self, item_id: int, **kwargs):
        """Update an existing item."""
        item = self.table[item_id]
        for key, value in kwargs.items():
            setattr(item, key, value)
        updated_item = self.table.update(item)

    async def delete_item(self, item_id: int):
        """
        Delete an item from the table.
        #   ___ ___ _   _ ___ _   ___      _     _       
        #  / __| _ \ | | |   (_) |   \ ___| |___| |_ ___ 
        # | (__|   / |_| | |) |  | |) / -_) / -_)  _/ -_)
        #  \___|_|_\\___/|___(_) |___/\___|_\___|\__\___|
        # crud delete
        Args:
            item_id (int): The ID of the item to delete.

        Returns:
            str: An empty string indicating successful deletion.
        """
        try:
            logger.debug(f"Attempting to delete item ID: {item_id}")
            item = self.table[item_id]
            self.table.delete(item_id)
            prompt = (
                f"Item deleted. "
                "Brief, sassy reaction."
            )
            await chatq(prompt)
            logger.info(f"Deleted item ID: {item_id}")
            return ''
        except Exception as e:
            logger.error(f"Error deleting item: {str(e)}")
            return f"Error deleting item: {str(e)}", 500

    async def toggle_item(self, item_id: int):
        """
        Toggle a boolean field of an item.
        #   ___ ___ _   _ ___ _   _____               _     
        #  / __| _ \ | | |   (_) |_   _|__  __ _ __ _| |___ 
        # | (__|   / |_| | |) |    | |/ _ \/ _` / _` | / -_)
        #  \___|_|_\\___/|___(_)   |_|\___/\__, \__, |_\___|
        # crud toggle                      |___/|___/       

        Args:
            item_id (int): The ID of the item to toggle.

        Returns:
            dict: The rendered updated item.
        """
        try:
            logger.debug(f"Toggling {self.toggle_field} for item ID: {item_id}")
            item = self.table[item_id]
            current_status = getattr(item, self.toggle_field)
            setattr(item, self.toggle_field, not current_status)
            updated_item = self.table.update(item)
            logger.info(f"Toggled {self.toggle_field} for item ID {item_id} to {getattr(item, self.toggle_field)}")

            prompt = (
                f"Item toggled. "
                "Brief, sassy reaction."
            )
            
            await chatq(prompt)

            return self.render_item(updated_item)
        except Exception as e:
            logger.error(f"Error toggling item: {str(e)}")
            return f"Error toggling item: {str(e)}", 500

    async def sort_items(self, items: list):
        """
        Sort items based on the provided order.

        Args:
            items (list): A list of dictionaries containing item IDs and their new order.

        Returns:
            str: A success message or an error message with status code.
        """
        try:
            logger.debug(f"Sorting items: {items}")
            for item_data in items:
                item = self.table[item_data['id']]
                setattr(item, self.sort_field, item_data['priority'])
                self.table.update(item)
            logger.info("Items sorted successfully")
            return "Items sorted successfully"
        except Exception as e:
            logger.error(f"Error sorting items: {str(e)}")
            return f"Error sorting items: {str(e)}", 500

    def render_item(self, item):
        """Render an item as needed. Override in subclasses."""
        return item
```

## Adding Docstrings and Comments to Help Grok OO

Okay, here it is again, but now documented and with the unimplemented stuff
stripped down to bare minimum and moved to the bottom:

```python
class BaseApp:
    """
    A base class for creating application components with common CRUD operations.

    This class provides a template for building application components that interact
    with database tables and handle basic Create, Read, Update, Delete (CRUD) operations.
    It includes methods for registering routes, rendering items, and performing various
    database operations.

    The class is designed to be flexible and extensible, allowing subclasses to override
    or extend its functionality as needed for specific application components.
    """

    def __init__(self, name, table, toggle_field, sort_field):
        # Initialize a new BaseApp instance with the given parameters.
        # 'name' is the name of the app.
        # 'table' is the database table associated with this app.
        # 'toggle_field' is the field name used for toggling.
        # 'sort_field' is the field name used for sorting.
        self.name = name
        self.table = table
        self.toggle_field = toggle_field
        self.sort_field = sort_field

    def register_routes(self, rt):
        # Register only the implemented routes: update and toggle
        rt(f'/{self.name}/delete/{{item_id}}', methods=['DELETE'])(self.delete_item)
        rt(f'/{self.name}/toggle/{{item_id}}', methods=['POST'])(self.toggle_item)

    def render_item(self, item):
        # A wrapper function currently serving as a passthrough for item rendering.
        # This method is part of the system's "styling" mechanism, transforming
        # dataclasses into HTML or other instructions for display or HTMX operations.
        # Subclasses are expected to override this method with context-aware implementations.
        return item

    async def delete_item(self, item_id: int):
        """
        Delete an item from the table.
        #   ___ ___ _   _ ___ _   ___      _     _       
        #  / __| _ \ | | |   (_) |   \ ___| |___| |_ ___ 
        # | (__|   / |_| | |) |  | |) / -_) / -_)  _/ -_)
        #  \___|_|_\\___/|___(_) |___/\___|_\___|\__\___|
        # crud delete
        Args:
            item_id (int): The ID of the item to delete.

        Returns:
            str: An empty string indicating successful deletion.
        """
        try:
            logger.debug(f"Attempting to delete item ID: {item_id}")
            item = self.table[item_id]
            self.table.delete(item_id)
            prompt = (
                f"Item deleted. "
                "Brief, sassy reaction."
            )
            await chatq(prompt)
            logger.info(f"Deleted item ID: {item_id}")
            return ''
        except Exception as e:
            logger.error(f"Error deleting item: {str(e)}")
            return f"Error deleting item: {str(e)}", 500

    async def toggle_item(self, item_id: int):
        """
        Toggle a boolean field of an item.
        #   ___ ___ _   _ ___ _   _____               _     
        #  / __| _ \ | | |   (_) |_   _|__  __ _ __ _| |___ 
        # | (__|   / |_| | |) |    | |/ _ \/ _` / _` | / -_)
        #  \___|_|_\\___/|___(_)   |_|\___/\__, \__, |_\___|
        # crud toggle                      |___/|___/       

        Args:
            item_id (int): The ID of the item to toggle.

        Returns:
            dict: The rendered updated item.
        """
        try:
            logger.debug(f"Toggling {self.toggle_field} for item ID: {item_id}")
            item = self.table[item_id]
            current_status = getattr(item, self.toggle_field)
            setattr(item, self.toggle_field, not current_status)
            updated_item = self.table.update(item)
            logger.info(f"Toggled {self.toggle_field} for item ID {item_id} to {getattr(item, self.toggle_field)}")

            prompt = (
                f"Item toggled. "
                "Brief, sassy reaction."
            )
            
            await chatq(prompt)

            return self.render_item(updated_item)
        except Exception as e:
            logger.error(f"Error toggling item: {str(e)}")
            return f"Error toggling item: {str(e)}", 500

    async def sort_items(self, items: list):
        # Sort items.
        # TODO: Implement sorting logic
        pass

    async def create_item(self, **kwargs):
        # Create a new item.
        item = self.table.insert(kwargs)

    async def update_item(self, item_id: int, **kwargs):
        # Update an existing item.
        item = self.table[item_id]
```

## Understanding Wrapper Classes Requires Out-of-Order Thinking

And here is the current wrapper classes that instantiate instances of this base
class, both the wrapper definitions and their instantiating. This is the stuff
that's normally hard for me to wrap my mind around, because I'm a "sequential
story telling" sort of person, and this requires you imagining all sorts of
phantom things around it with out-of-order execution to make sense. I'm more of
a ***Jupyter Notebooks without functions*** if I can help it sort of person. I
like top-to-bottom story-telling without jumping around or multiple files to
look in. OO is antithetical to my way of operating. You've got to get the
internals into your head and keep them there. It's funny how something meant to
simplify and offer flexibility actually hardwired your mind to particular
implementations. Not my bally wick, but necessary in this case.

```python
class TodoApp(BaseApp):
    def __init__(self, table):
        super().__init__(
            name='todo',
            table=table,
            toggle_field='done',
            sort_field='priority'
        )

    def register_routes(self, rt):
        super().register_routes(rt)

    def render_item(self, todo):
        return render_todo(todo)


class ProfileApp(BaseApp):
    def __init__(self, table):
        super().__init__(
            name='profile',
            table=table,
            toggle_field='active',
            sort_field='priority'
        )

    def register_routes(self, rt):
        super().register_routes(rt)

    def render_item(self, profile):
        return render_profile(profile)


# Instantiate and register routes
todo_app = TodoApp(table=todos)
todo_app.register_routes(rt)

profile_app = ProfileApp(table=profiles)
profile_app.register_routes(rt)
```

## Superdunderself Included

Pshwew! Okay, and here's a better documented version of a single app definition.
I have a bit of difficulty knowing what to call these. I want to say
***wrapper*** because they wrap and extend the capabilities of the ***base
class***, but wrap has a special decorator meaning in Python. The two definitely
are related, and I think there's a lot in Python to *trick* you into intuitively
using good object oriented techniques without thinking about it or knowing
you're doing it (like filenames as their own namespaces). This is the opposite.
Everything is explicit with lots of *superdunderself*.

Here is just one of those wrapper thingies. When I say wrapper, the thing with
OO is that there are factory classes and stamped-out instances of those classes,
something like:

```python
cookie = CookieCutter(shape="star")
```

But if the shape of the cookie is really hard to understand, you can eliminate
the use of parameter arguments and create a special star-cutting cookie cutter
making your usage look like:

```python
cookie = StarCutter()
```

In the case of this agile framework, our `StarCutter` details are much longer
and convoluted than the example above implies. Maybe not for `delete` and
`toggle` which is why I started with those. But when it gets to `insert` and
`update` where the database fields change ***per app***, we're going to be
really glad we can reuse `BaseApp` code, albeit overwritten here and there as it
will have to be.

```python
class TodoApp(BaseApp):
    """
    A specialized application for managing todo items.

    This class extends BaseApp to provide specific functionality for todo items,
    including initialization with todo-specific fields and custom rendering.
    """

    def __init__(self, table):
        # 'super()' is used here to call the __init__ method of the parent class (BaseApp).
        # This ensures that the parent class is properly initialized with the specific
        # parameters for the TodoApp: name, table, toggle_field, and sort_field.
        super().__init__(
            name='todo',
            table=table,
            toggle_field='done',
            sort_field='priority'
        )

    def register_routes(self, rt):
        # 'super()' is used here to call the register_routes method of the parent class.
        # This allows TodoApp to inherit and use the route registration logic from BaseApp,
        # while still having the option to add additional routes specific to TodoApp if needed.
        super().register_routes(rt)

    def render_item(self, todo):
        # This method doesn't use 'super()' because it's likely overriding or implementing
        # a method specific to TodoApp, rather than extending behavior from the parent class.
        return render_todo(todo)
```

Okay, this shift in coding style is important for me. What we are doing is
moving to a sort of scalpel like precision with OO (object oriented) that I have
been remiss to do in the past, because with an AI-tutor it was extremely
difficult to work through on my own. AI is not coding ***for*** me. AI is coding
***with*** me, allowing me to hit above my weight class.

Okay, so sorting on a drag-and-drop operation is next up. It's most similar to
the delete and toggle functions implemented so far because it doesn't need to
know anything except the table to operate on and the name of the field to use
for priority sorting. That's almost exactly like a toggle.

Okay, with all that above gobbledygook in mind, it's time to implement sorting.
We can do this precision-like now. We make the endpoint exist before we do
anything in the UI to connect it. First, let's look at the ***old*** endpoint
we're replacing:

```python
@rt(f'/{TODO}_sort', methods=['POST'])
async def update_todo_order(values: dict):
    """
    Update the order of todo items based on the received values.

    Args:
        values (dict): A dictionary containing the new order of todo items.

    Returns:
        str: An empty string indicating successful update, or an error message with status code.
    """
    logger.debug(f"Received values: {values}")
    try:
        items = json.loads(values.get('items', '[]'))
        logger.debug(f"Parsed items: {items}")
        for item in items:
            logger.debug(f"Updating item: {item}")
            todos.update(id=int(item['id']), priority=int(item['priority']))
        logger.info("Todo order updated successfully")

        # After successful update, queue a message for the chat
        prompt = "The todo list was reordered. Make a brief, witty remark about sorting or prioritizing tasks. Keep it under 20 words."
        await chatq(prompt)

        return ''
    except Exception as e:
        logger.error(f"Error updating todo order: {str(e)}")
        return str(e), 500  # Return the error message and a 500 status code
```

Okay, this next huge code block is a great example (for me) of why OO is
mind-bending. I'm letting the AI code assistant strip out the `figlet` banners,
the chatter inserted by the local LLM while this thing runs, and a bunch of
documentation. I can always put that stuff back in. Right now I want to focus on
core functionality, and I'll let the AI code assistant do the same thing.

Now the often overlooked nuance (by me) is that the endpoint is really simple,
like `/action/id`, with toggle being `/toggle/id`. See what's missing? What
field to toggle? It seems like there's a parameter missing. But you want it this
way because the API URL is short and snappy, and it even has security advantages
because hackers can't so easily go probing for other fields to toggle. It can
only mean one thing. But then where is that extra parameter argued? The argument
is made in the ***wrapping*** function that's actually calling the base class.

But the funny thing is that the base class that advertises the endpoints
operates later on data that came in from something other than the endpoints it
knows about. It effectively knows the internals of its cookie-cutter
customizers. So when the `__init__` is called, it builds function-scoped
variables using stuff that shouldn't be there, if you look at `BaseApp` alone.
The wrapper functions are passing them in.

Another thing I found annoying is the mystery appearance of the `item_id`'s
which FastHTML is invisibly making available to the calling functions. I made it
explicit in the updated code below so you can track where the IDs are coming
from.

And lastly, I added `=None` default values for `sort` and `toggle` because not
every table used in this system will have such fields.

Oh, and lastly lastly, notice the sort endpoint doesn't slash `/` off of the
base path, but instead underscores `_`. This is because of subtleties of how
endpoints that expect variable values like `id` are using that slash. If you
have something that follows the pattern without an passable value, you might end
up getting an error from the wrong endpoint being used. It's okay to share the
pattern between `toggle` and `delete` because they pass IDs the same way, but
not for sort because of weird internal difference when you pass *a bundle of
attributes* with a form `POST` which is what invisibly happens when you
drag-and-drop sort. I think I got that right. Ugh!

```python
class BaseApp:
    """
    A base class for creating application components with common CRUD operations.

    This class provides a template for building application components that interact
    with database tables and handle basic Create, Read, Update, Delete (CRUD) operations.
    It includes methods for registering routes, rendering items, and performing various
    database operations.

    The class is designed to be flexible and extensible, allowing subclasses to override
    or extend its functionality as needed for specific application components.
    """
    def __init__(self, name, table, toggle_field=None, sort_field=None, sort_dict=None):
        self.name = name
        self.table = table
        self.toggle_field = toggle_field
        self.sort_field = sort_field
        self.sort_dict = sort_dict or {'id': 'id', sort_field: sort_field}

    def register_routes(self, rt):
        # Register routes: delete, toggle, and sort
        rt(f'/{self.name}/delete/{{item_id}}', methods=['DELETE'])(self.delete_item)
        rt(f'/{self.name}/toggle/{{item_id}}', methods=['POST'])(self.toggle_item)
        rt(f'/{self.name}_sort', methods=['POST'])(self.sort_items)

    def render_item(self, item):
        # A wrapper function currently serving as a passthrough for item rendering.
        # This method is part of the system's "styling" mechanism, transforming
        # dataclasses into HTML or other instructions for display or HTMX operations.
        # Subclasses are expected to override this method with context-aware implementations.
        return item

    async def delete_item(self, request, item_id: int):
        """
        Delete an item from the table.

        Args:
            request: The incoming request object.
            item_id (int): The ID of the item to delete.

        Returns:
            str: An empty string indicating successful deletion.
        """
        try:
            logger.debug(f"Attempting to delete item ID: {item_id}")
            self.table.delete(item_id)
            prompt = f"Item {item_id} deleted. Brief, sassy reaction."
            await chatq(prompt)
            logger.info(f"Deleted item ID: {item_id}")
            return ''
        except Exception as e:
            logger.error(f"Error deleting item: {str(e)}")
            return f"Error deleting item: {str(e)}", 500

    async def toggle_item(self, request, item_id: int):
        """
        Toggle a boolean field of an item.

        Args:
            request: The incoming request object.
            item_id (int): The ID of the item to toggle.

        Returns:
            dict: The rendered updated item.
        """
        try:
            logger.debug(f"Toggling {self.toggle_field} for item ID: {item_id}")
            item = self.table[item_id]
            current_status = getattr(item, self.toggle_field)
            setattr(item, self.toggle_field, not current_status)
            updated_item = self.table.update(item)
            logger.info(f"Toggled {self.toggle_field} for item ID {item_id} to {getattr(updated_item, self.toggle_field)}")

            prompt = f"Item {item_id} toggled. Brief, sassy reaction."
            await chatq(prompt)

            return self.render_item(updated_item)
        except Exception as e:
            logger.error(f"Error toggling item: {str(e)}")
            return f"Error toggling item: {str(e)}", 500

    async def sort_items(self, values: dict):
        """
        Update the order of items based on the received values.
        """
        logger.debug(f"Received values for {self.name} sort: {values}")
        try:
            items = json.loads(values.get('items', '[]'))
            logger.debug(f"Parsed items: {items}")
            for item in items:
                logger.debug(f"Updating item: {item}")
                update_dict = {self.sort_field: int(item[self.sort_dict[self.sort_field]])}
                self.table.update(id=int(item[self.sort_dict['id']]), **update_dict)
            logger.info(f"{self.name.capitalize()} order updated successfully")

            prompt = f"The {self.name} list was reordered. Make a brief, witty remark about sorting or prioritizing. Keep it under 20 words."
            await chatq(prompt)

            return ''
        except Exception as e:
            logger.error(f"Error updating {self.name} order: {str(e)}")
            return str(e), 500

    async def create_item(self, **kwargs):
        # Create a new item.
        item = self.table.insert(kwargs)

    async def update_item(self, item_id: int, **kwargs):
        # Update an existing item.
        item = self.table[item_id]


class TodoApp(BaseApp):
    """
    A specialized application for managing todo items.

    This class extends BaseApp to provide specific functionality for todo items,
    including initialization with todo-specific fields and custom rendering.
    """

    def __init__(self, table):
        super().__init__(
            name='todo',
            table=table,
            toggle_field='done',
            sort_field='priority'
        )

    def register_routes(self, rt):
        super().register_routes(rt)

    def render_item(self, todo):
        return render_todo(todo)

class ProfileApp(BaseApp):
    def __init__(self, table):
        super().__init__(
            name='profile',
            table=table,
            toggle_field='active',
            sort_field='priority'
        )

# Instantiate and register routes
todo_app = TodoApp(table=todos)
todo_app.register_routes(rt)

profile_app = ProfileApp(table=profiles)
profile_app.register_routes(rt)
```

You can now see that the sorting endpoint is published:

## Endpoints

- `/` (GET, HEAD)
- `/app_1` (GET, HEAD)
- `/app_2` (GET, HEAD)
- `/app_3` (GET, HEAD)
- `/client` (GET, HEAD)
- `/client` (POST)
- `/client/update/{profile_id}` (POST)
- `/client/{profile_id}` (GET, HEAD, POST)
- `/competitor` (GET, HEAD)
- `/competitor` (GET, HEAD)
- `/competitor` (POST)
- `/competitor/update/{todo_id}` (POST)
- `/live-reload` (WebSocket)
- `/poke` (POST)
- `/profile/delete/{item_id}` (DELETE)
- `/profile/toggle/{item_id}` (POST)
- `/profile_sort` (POST)
- `/search` (POST)
- `/todo/delete/{item_id}` (DELETE)
- `/todo/toggle/{item_id}` (POST)
- `/todo_sort` (POST)
- `/ws` (WebSocket)
- `/{fname:path}.{ext:static}` (GET, HEAD)

The idea here is that I'm removing the `/client/` and `/competitor/` endpoints
that are created the old way before the plugin system, and I'm replacing them
with `\profile\` and `\todo\` as the default values inserted by the plugin
system by default. The list of router endpoints published by FastHTML/Starlette
is my to-do list for getting this done, haha!
