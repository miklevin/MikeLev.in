---
title: This Also Becomes Your H1
permalink: /slug/
description: Becomes your meta description.
layout: post
---

Okay, after a whole day of working in it, I have the heart of the plugin system
in place, and as it turns out, it's a ***base class*** for using object oriented
programming techniques. I don't do that much but now with the AI coding assist
both through Cursor AI and heavy use of their websites, I have the guidance,
safety net, and thus really confidence as well to tackle stuff I've been
hesitant about tackling in the past. OO syntax under Python is a bit
intimidating to me under Python. 

Okay, I must resist chasing rabbits down holes today. This adoption of a plugin
system has been a huge rabbit hole, a whole day so far invested into it, but
worth it. These changes now will assure the long-term adaptability and
flexibility, and thus viability of this system. The amount of work required for
adding new features now would make both the complexity and amount of code
explode, and since I'm using a single-file approach, I want to keep that under
control. Plugging in new apps should look beautiful and show off the system.

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
        # Register routes for CRUD operations using the provided routing function.
        # 'rt' is the routing function provided by the web framework.
        # This method sets up a single route for the CRUD operation specified
        # when creating an object from this base class.
        crud_operation = self.name  # The CRUD operation is determined by the 'name' attribute
        if crud_operation == 'create':
            rt(f'/{self.name}', methods=['POST'])(self.create_item)
        elif crud_operation == 'read':
            rt(f'/{self.name}')(self.get_items)
        elif crud_operation == 'update':
            rt(f'/{self.name}/update/{{item_id}}', methods=['POST'])(self.update_item)
        elif crud_operation == 'delete':
            rt(f'/{self.name}/delete/{{item_id}}', methods=['DELETE'])(self.delete_item)
        elif crud_operation == 'toggle':
            rt(f'/{self.name}/toggle/{{item_id}}', methods=['POST'])(self.toggle_item)
        elif crud_operation == 'sort':
            rt(f'/{self.name}/sort', methods=['POST'])(self.sort_items)

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

And here is the current wrapper classes that instantiate instances of this base
class, both the wrapper definitions and their instantiating. This is the stuff
that's normally hard for me to wrap my mind around, because I'm a "sequential
story telling" sort of person, and this requires you imagining all sorts of
phantom things around it with out-of-order execution to make sense.

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

Pshwew! Okay, and here's a better documented version of a single app definition.
I have a bit of difficulty knowing what to call these. I want to say
***wrapper*** because they wrap and extend the capabilities of the ***base
class***, but wrap has a special decorator meaning in Python. The two definitely
are related, and I think there's a lot in Python to *trick* you into intuitively
using good object oriented techniques without thinking about it or knowing
you're doing it (like filenames as their own namespaces). This is the opposite.
Everything is explicit with lots of *superdunderself*.



