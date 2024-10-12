---
title: Test SPA Endpoints (Single Page Applications in FastHTML) 
permalink: /test-spa-endpoints/
description: This article details the development of a comprehensive testing suite for a FastHTML single-page application using Python's `unittest`. It covers endpoint testing, logging enhancements, and future plans for UI automation, ensuring the application’s reliability and robustness while showcasing code snippets for clarity.
layout: post
---

What I want now is a FastHTML ***app plugin*** framework. Or would that just be
"plugin framework"? Either way, it's a framework that I plug things into. I've
really got to change my focus to performing the actual client work itself. But
now I've got a framework, ho ho ho.

And even though I haven't made it mutli-tenant yet and ready to host, I know
that work is ahead of me as soon as people start seeing this thing and asking
where they can use it online. I'm going to bide some time talking about how with
the proprietary nature of the data going onto these apps, it's not a good idea
to expose it on the public Web until we're ready. Until then, we just run it
ourselves, just like a program on our desktop. We're used to that still, at
least a little bit, through ScreamingFrog. All I have to do is add those crawler
features and tell people to use whatever proxy they like on their machine
(desktop or laptop), and... well, the concepts are:

- Private "Point of Entry" App
- Self Hosted on Demand (just like any local Node/Electron software these days)
- No Login, Cause It's Yours (until I add login)

Jeremy uses login as one of the early examples when he gets one of his employees
up to speed with that "Advanced" todo list tutorial. There's simpler versions,
but because so much of the web experience these days begins with a login, he
begins with a login. I will too, eventually.

But even simpler is the todo list. The FastHTML tutorials start with a todo list
for a reason. There's a lot that a todo-list gets you when you name it something
else. And so, I have to slam out some copies of the todo app as those first
round of plug-in apps. 

My tutorial on `Pipulate` is going to be to start an SEO client consulting
engagement, but while using it to do it for myself for a that proprietary
`Botifython` fork.

- Slam out Todo List clones
- Acquire Botify Token app

- [ ] Token App
- [ ] Task List
- [ ] Client List
- [ ] Website List
- [ ] Competitor List
- [ ] Top Keywords
- [ ] Top Questions
- [ ] Micro Tools
- [ ] Bookmarks

Prepare the app for distribution

- Make Botifython GitHub account
- Make an SSH Key Pair for the distro

Okay, but let's power through the clones.

Uhhh. There's a point of no return there. The complexity of the code could
explode beyond the first beautiful instance. So beautify the latest and
incorporate some testing. The beautified and testing-included version becomes
the new `Pipulate` main instance. Than I immediately fork that for the
`Botifython` proprietary instance.

So for that round of cleanup, this looks like a job for o1!

Without changing one iota of code, nor leaving out a single function in the
response, please reorganize this for beauty. It is important to leave in all the
comments, and you can even enhance them and point out important but overlooked
parts. Please respond including the entire program so it's copy/paste ready, and
it's essential to not leave anything out with "the rest of your code goes here"
comments. This is to get the overarching structure and beauty of the program
visible with a top to bottom perusal. Please give me this program back in its
entirety arranged for beauty.

### Enhancements and Important Notes:

1. **Consistent Section Headers**: The program is organized into clear sections using comment headers (`# *******************************`) to delineate different parts of the application. This enhances readability and allows for quick navigation through the code.

2. **Detailed Function Docstrings**: Each function includes comprehensive docstrings that explain its purpose, arguments, and return values. This is crucial for maintainability and for other developers to understand the codebase.

3. **Logging Enhancements**: The logging statements are strategically placed to provide insights into the application's behavior, especially during error handling and critical operations like database updates and WebSocket interactions.

4. **Error Handling**: Robust error handling ensures that the application can gracefully handle unexpected scenarios, such as missing profiles or failed database operations, without crashing.

5. **WebSocket Management**: The WebSocket functions manage user connections effectively, maintaining a dictionary of connected users and ensuring that messages are correctly streamed to all active clients.

6. **Asynchronous Operations**: The use of `asyncio` and asynchronous functions ensures that the application remains responsive, especially during I/O-bound operations like network requests and database interactions.

7. **UI Feedback**: Functions like `stream_chat` simulate a typing effect, enhancing the user experience by making interactions feel more natural and engaging.

8. **Configuration Constants**: All configurable settings, such as `APP_NAME`, `MAX_LLM_RESPONSE_WORDS`, and menu widths, are defined at the top of the program. This centralization makes it easier to adjust settings without digging through the code.

9. **Utility Functions**: Helper functions like `pluralize` and `generate_menu_style` promote code reuse and reduce redundancy, making the codebase cleaner and more efficient.

10. **Database Wrapper**: The `DictLikeDB` class provides a convenient interface for interacting with the database, abstracting away the underlying implementation and simplifying data access patterns.

By adhering to these organizational and coding best practices, the program achieves a high level of clarity, maintainability, and aesthetic appeal, making it easier for developers to understand and work with the codebase.

...okay, I knit together that long reply and it looks like it's still working,
but keep an eye on it! It took both o1-preview and o1-mini to churn through
that. Next up:

Excellent, thank you! Put together a set of pytest tests to make sure all the
endpoints remain intact and instructions on how to put them in location.

Certainly! Ensuring that all your application's endpoints remain intact is crucial for maintaining functionality and reliability. Below, you'll find a comprehensive set of `pytest` tests tailored to your application's endpoints, along with detailed instructions on how to set them up and execute them effectively.

---

## **1. Setting Up Your Testing Environment**

### **a. Install Required Dependencies**

Before writing and running tests, ensure that you have the necessary testing libraries installed. You can install them using `pip`:

```bash
pip install pytest pytest-asyncio httpx
```

- **`pytest`**: The core testing framework.
- **`pytest-asyncio`**: Allows testing of asynchronous code.
- **`httpx`**: An HTTP client for Python that supports asynchronous requests, ideal for testing ASGI applications.

### **b. Organize Your Project Structure**

Organize your project to include a dedicated `tests` directory. Here's a recommended structure:

```
your_project/
├── app.py               # Your main application file
├── requirements.txt
├── tests/
│   ├── __init__.py
│   └── test_endpoints.py
└── ...
```

> **Note:** Replace `app.py` with the actual name of your main application file if it's different.

---

## **2. Writing `pytest` Tests for Your Endpoints**

Create a file named `test_endpoints.py` inside the `tests` directory with the following content:

```python
# tests/test_endpoints.py

import pytest
import json
from httpx import AsyncClient
from unittest.mock import patch, MagicMock

# Import your ASGI app. Replace 'app_module' with the actual module name where your app is defined.
from app import app

# *******************************
# Fixtures
# *******************************

@pytest.fixture
def anyio_backend():
    return 'asyncio'

@pytest.fixture
async def client():
    async with AsyncClient(app=app, base_url="http://test") as ac:
        yield ac

# *******************************
# Utility Mocks
# *******************************

# Mocking the chat_with_ollama function to prevent actual API calls during testing
@pytest.fixture
def mock_chat_with_ollama():
    with patch('app.chat_with_ollama') as mock:
        mock.return_value = "This is a mocked response."
        yield mock

# Mocking database interactions
@pytest.fixture
def mock_db():
    with patch('app.db') as mock_db:
        mock_db.get.return_value = None
        mock_db.__getitem__.return_value = None
        mock_db.__setitem__.return_value = None
        mock_db.__delitem__.return_value = None
        mock_db.items.return_value = []
        mock_db.keys.return_value = []
        mock_db.values.return_value = []
        yield mock_db

# *******************************
# Test Cases
# *******************************

# -------------------------------
# Main Page and Specific Pages GET Requests
# -------------------------------

@pytest.mark.anyio
async def test_main_pages(client, mock_chat_with_ollama, mock_db):
    routes = ['/', '/todo', '/profiles', '/link_graph', '/gap_analysis']
    for route in routes:
        response = await client.get(route)
        assert response.status_code == 200
        assert "application/json" in response.headers.get("content-type", "")

# -------------------------------
# Profile Menu Handler
# -------------------------------

@pytest.mark.anyio
async def test_profile_menu_handler(client, mock_chat_with_ollama, mock_db):
    profile_id = 1
    mock_profile = MagicMock()
    mock_profile.id = profile_id
    mock_profile.name = "Test Profile"
    mock_db.get.return_value = mock_profile
    
    response = await client.get(f'/profiles/{profile_id}')
    assert response.status_code == 200
    # Further assertions can be added based on response content

# -------------------------------
# Todo Endpoints
# -------------------------------

@pytest.mark.anyio
async def test_create_todo(client, mock_chat_with_ollama, mock_db):
    todo_title = "Test Todo"
    response = await client.post("/todo", data={"title": todo_title})
    assert response.status_code == 200
    # Check if the response contains the rendered todo item
    assert todo_title in response.text

@pytest.mark.anyio
async def test_delete_todo(client, mock_chat_with_ollama, mock_db):
    tid = 1
    response = await client.delete(f"/todo/delete/{tid}")
    assert response.status_code == 200
    # Further assertions can be added based on response content

@pytest.mark.anyio
async def test_toggle_todo(client, mock_chat_with_ollama, mock_db):
    tid = 1
    response = await client.post(f"/todo/toggle/{tid}")
    assert response.status_code == 200
    # Further assertions can be added based on response content

@pytest.mark.anyio
async def test_update_todo(client, mock_chat_with_ollama, mock_db):
    todo_id = 1
    new_title = "Updated Test Todo"
    response = await client.post(f"/todo/update/{todo_id}", data={"todo_title": new_title})
    assert response.status_code == 200
    assert new_title in response.text

@pytest.mark.anyio
async def test_update_todo_order(client, mock_chat_with_ollama, mock_db):
    items = [{"id": 1, "priority": 2}, {"id": 2, "priority": 1}]
    response = await client.post("/update_todo_order", data={"items": json.dumps(items)})
    assert response.status_code == 200
    # Further assertions can be added based on response content

# -------------------------------
# Profiles Endpoints
# -------------------------------

@pytest.mark.anyio
async def test_get_profiles(client, mock_chat_with_ollama, mock_db):
    response = await client.get("/profiles")
    assert response.status_code == 200
    assert "Client" in response.text  # Assuming USER_NAME is "Client"

@pytest.mark.anyio
async def test_add_profile(client, mock_chat_with_ollama, mock_db):
    profile_data = {
        "profile_name": "New Profile",
        "profile_email": "new@example.com",
        "profile_phone": "123-456-7890"
    }
    response = await client.post("/add_profile", data=profile_data)
    assert response.status_code == 200
    assert profile_data["profile_name"] in response.text

@pytest.mark.anyio
async def test_toggle_active_profile(client, mock_chat_with_ollama, mock_db):
    profile_id = 1
    response = await client.post(f"/toggle_active/{profile_id}")
    assert response.status_code == 200
    # Further assertions can be added based on response content

@pytest.mark.anyio
async def test_delete_profile(client, mock_chat_with_ollama, mock_db):
    profile_id = 1
    response = await client.post(f"/profile/delete/{profile_id}")
    assert response.status_code == 200
    # Further assertions can be added based on response content

@pytest.mark.anyio
async def test_update_profile(client, mock_chat_with_ollama, mock_db):
    profile_id = 1
    updated_data = {
        "name": "Updated Profile",
        "email": "updated@example.com",
        "phone": "098-765-4321"
    }
    response = await client.post(f"/profile/update/{profile_id}", data=updated_data)
    assert response.status_code == 200
    assert updated_data["name"] in response.text

@pytest.mark.anyio
async def test_update_profile_order(client, mock_chat_with_ollama, mock_db):
    items = [{"id": 1, "priority": 2}, {"id": 2, "priority": 1}]
    response = await client.post("/update_profile_order", data={"items": json.dumps(items)})
    assert response.status_code == 200
    # Further assertions can be added based on response content

@pytest.mark.anyio
async def test_profile_app(client, mock_chat_with_ollama, mock_db):
    response = await client.get("/profile")
    assert response.status_code == 200
    assert "Client" in response.text  # Assuming USER_NAME is "Client"

# -------------------------------
# Search Endpoint
# -------------------------------

@pytest.mark.anyio
async def test_search(client, mock_chat_with_ollama, mock_db):
    search_term = "test search"
    response = await client.post("/search", data={"nav_input": search_term})
    assert response.status_code == 200
    assert "Sorry, that feature is still in beta" in response.text

# -------------------------------
# Poke Endpoint
# -------------------------------

@pytest.mark.anyio
async def test_poke_chatbot(client, mock_chat_with_ollama, mock_db):
    response = await client.post("/poke")
    assert response.status_code == 200
    assert "Poke received" in response.text

# -------------------------------
# WebSocket Endpoint
# -------------------------------

@pytest.mark.anyio
async def test_websocket(client, mock_chat_with_ollama, mock_db):
    async with client.websocket_connect("/ws") as websocket:
        # Send a message through WebSocket
        await websocket.send_text("Hello, chatbot!")
        
        # Receive messages (assuming the chatbot sends multiple messages due to streaming)
        messages = []
        for _ in range(2):  # Adjust the range based on expected number of messages
            message = await websocket.receive_text()
            messages.append(message)
        
        # Assert that the mocked response is received
        assert "This is a mocked response." in messages[-1]

```

---

## **3. Instructions to Place and Run the Tests**

### **a. Create the `tests` Directory**

Ensure that your project has a `tests` directory at the root level. If not, create one:

```bash
mkdir tests
touch tests/__init__.py
```

The `__init__.py` file makes Python treat the `tests` directory as a package.

### **b. Add the Test File**

Place the `test_endpoints.py` file (as provided above) inside the `tests` directory:

```
your_project/
├── app.py
├── requirements.txt
├── tests/
│   ├── __init__.py
│   └── test_endpoints.py
└── ...
```

### **c. Update Your Application for Testing**

To allow the test suite to import your ASGI app correctly, ensure that your main application file (e.g., `app.py`) exposes the `app` object. For instance:

```python
# app.py

from fastapi import FastAPI

app = FastAPI()

# ... rest of your application code ...

# To allow running with Uvicorn
if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
```

> **Note:** Adjust the import paths in `test_endpoints.py` if your application structure differs.

### **d. Running the Tests**

Navigate to your project's root directory and execute the tests using `pytest`:

```bash
pytest
```

This command will automatically discover and run all tests within the `tests` directory that follow the `test_*.py` naming convention.

---

## **4. Understanding the Test Cases**

Here's a breakdown of the test cases provided:

1. **Main Pages GET Requests (`test_main_pages`)**:
    - Tests the accessibility of main routes: `'/'`, `'/todo'`, `'/profiles'`, `'/link_graph'`, and `'/gap_analysis'`.
    - Asserts that each route returns a `200 OK` status and that the response is in JSON format.

2. **Profile Menu Handler (`test_profile_menu_handler`)**:
    - Tests the `/profiles/{profile_id}` endpoint.
    - Mocks a profile and checks if the endpoint responds correctly.

3. **Todo Endpoints**:
    - **Create Todo (`test_create_todo`)**: Tests the creation of a new todo item.
    - **Delete Todo (`test_delete_todo`)**: Tests the deletion of an existing todo item.
    - **Toggle Todo (`test_toggle_todo`)**: Tests toggling the completion status of a todo.
    - **Update Todo (`test_update_todo`)**: Tests updating the title of a todo item.
    - **Update Todo Order (`test_update_todo_order`)**: Tests reordering of todo items.

4. **Profiles Endpoints**:
    - **Get Profiles (`test_get_profiles`)**: Tests retrieval of all profiles.
    - **Add Profile (`test_add_profile`)**: Tests the creation of a new profile.
    - **Toggle Active Profile (`test_toggle_active_profile`)**: Tests toggling the active status of a profile.
    - **Delete Profile (`test_delete_profile`)**: Tests the deletion of a profile.
    - **Update Profile (`test_update_profile`)**: Tests updating profile details.
    - **Update Profile Order (`test_update_profile_order`)**: Tests reordering of profiles.
    - **Profile App (`test_profile_app`)**: Tests the `/profile` endpoint.

5. **Search Endpoint (`test_search`)**:
    - Tests the `/search` endpoint, ensuring it responds correctly when a search is attempted.

6. **Poke Endpoint (`test_poke_chatbot`)**:
    - Tests the `/poke` endpoint, ensuring the chatbot responds to a poke.

7. **WebSocket Endpoint (`test_websocket`)**:
    - Tests the `/ws` WebSocket endpoint by sending a message and verifying the chatbot's response.

### **a. Mocking External Dependencies**

- **`chat_with_ollama` Function**:
    - The `chat_with_ollama` function interacts with an external API (Ollama). To prevent actual API calls during testing, it's mocked to return a predefined response.

- **Database Interactions (`mock_db`)**:
    - Database interactions are mocked to isolate tests from the actual database. This ensures tests run consistently without relying on external data sources.

### **b. Asynchronous Testing with `pytest-asyncio`**

- The tests utilize `pytest-asyncio` to handle asynchronous code, allowing you to test `async` endpoints seamlessly.

---

## **5. Enhancing Test Coverage**

While the provided tests cover the primary endpoints, consider the following to enhance your test coverage:

1. **Edge Cases**:
    - Test how endpoints handle invalid input data.
    - Ensure proper error messages and status codes are returned for unexpected scenarios.

2. **Authentication and Authorization**:
    - If your application has authentication mechanisms, include tests to verify access controls.

3. **Performance Testing**:
    - Assess how your application behaves under load, ensuring endpoints remain responsive.

4. **WebSocket Specific Tests**:
    - Test scenarios like multiple simultaneous WebSocket connections.
    - Verify the handling of disconnections and reconnections.

5. **Integration Tests**:
    - Test the interaction between different components of your application to ensure they work together seamlessly.

---

## **6. Running the Test Suite**

Execute the following command in your project's root directory to run all tests:

```bash
pytest
```

For more detailed output, you can use:

```bash
pytest -v
```

This command runs all test cases in the `tests` directory and provides verbose output, showing each test's name and status.

---

## **7. Continuous Integration (Optional)**

Integrate your tests into a Continuous Integration (CI) pipeline (e.g., GitHub Actions, Travis CI) to ensure that all tests pass automatically with each commit. This practice helps maintain code quality and catch issues early.

---

## **Final Notes**

- **Maintainability**: Regularly update your tests to reflect changes in your application's logic and endpoints.
- **Isolation**: Ensure tests are independent of each other to prevent cascading failures.
- **Documentation**: Document your test cases to provide clarity on what each test verifies.

By implementing these `pytest` tests and following the setup instructions, you'll establish a robust testing framework that ensures your application's endpoints remain functional and reliable as your codebase evolves.

i---

Ugh! Implementing `pytests` is like banging my head against the wall. Let's look
at `unittest`.

Absolutely! Since you have a single-file program and don't want to deal with the complexity of configuring `pytest`, there are simpler alternatives for testing in Python. I'll outline a few straightforward approaches you can use:

### 1. **Use Python's Built-in `unittest` Module**

The `unittest` module is a great alternative if you want something lighter and more intuitive. You can create a test file and write your test cases using `unittest` without needing to deal with async fixtures and complex setup.

Here's how you can set it up:

1. Create a file named `test_botifython.py` in the same directory as your main program (`botifython.py`).

2. Use `unittest` like this:

    ```python
    # test_botifython.py
    import unittest
    from botifython import app  # Import your app directly if it's exposed correctly in the file

    class TestAppEndpoints(unittest.TestCase):
        """Test cases for the main application endpoints."""

        def setUp(self):
            """Setup code to run before each test."""
            self.client = app.test_client()  # Assuming you're using a compatible app interface
            self.client.__enter__()

        def tearDown(self):
            """Teardown code to run after each test."""
            self.client.__exit__(None, None, None)

        def test_homepage(self):
            """Test the homepage endpoint."""
            response = self.client.get('/')
            self.assertEqual(response.status_code, 200)

        def test_profiles_page(self):
            """Test the profiles page."""
            response = self.client.get('/profiles')
            self.assertEqual(response.status_code, 200)

    if __name__ == "__main__":
        unittest.main()
    ```

3. Run the tests using:
    ```bash
    python test_botifython.py
    ```

### 2. **Manual Testing Using Simple Function Calls**

If you want to avoid any testing frameworks, you can manually test your endpoints and functions by adding a `main()` function to your single file. This approach lets you run small test cases as function calls.

Example:

```python
# botifython.py

def test_endpoints():
    """Simple function to test various endpoints."""
    client = app.test_client()  # Assuming `app` is correctly defined and compatible
    try:
        # Test the home route
        response = client.get("/")
        print("Homepage response status:", response.status_code)
        assert response.status_code == 200, "Homepage did not return status 200"

        # Test the profiles route
        response = client.get("/profiles")
        print("Profiles response status:", response.status_code)
        assert response.status_code == 200, "Profiles did not return status 200"

        # Add more tests as needed...
        print("All tests passed!")

    except Exception as e:
        print(f"Test failed: {e}")
    finally:
        client.__exit__(None, None, None)

# Main function to run tests
if __name__ == "__main__":
    test_endpoints()
```

This approach provides you with basic testing capabilities without adding any complexity or additional dependencies.

### 3. **Basic Print-Based Testing**

You can use simple print statements to validate your functions and outputs. For example:

```python
# botifython.py

def run_basic_tests():
    """Run basic tests using print statements."""
    print("Running basic tests...")

    # Call a function or an endpoint and print the result
    try:
        response = app.test_client().get('/')
        print("GET / response status code:", response.status_code)
        assert response.status_code == 200, "Homepage failed to load."

        response = app.test_client().get('/profiles')
        print("GET /profiles response status code:", response.status_code)
        assert response.status_code == 200, "Profiles failed to load."

        print("All basic tests passed!")

    except Exception as e:
        print(f"Basic test encountered an error: {e}")

if __name__ == "__main__":
    run_basic_tests()
```

This is the simplest form of testing, and it can help you quickly validate key parts of your application.

### 4. **Use a Simple HTTP Client Like `requests`**

If your application is serving endpoints, you can use the `requests` library to manually check responses:

```python
# test_botifython_manual.py
import requests

def manual_test():
    """Run basic HTTP tests using requests."""
    try:
        # Replace 'http://localhost:8000' with your server's URL
        base_url = "http://localhost:8000"

        response = requests.get(f"{base_url}/")
        print(f"GET / response: {response.status_code}")
        assert response.status_code == 200, "Homepage failed to load."

        response = requests.get(f"{base_url}/profiles")
        print(f"GET /profiles response: {response.status_code}")
        assert response.status_code == 200, "Profiles failed to load."

        print("Manual tests passed!")

    except Exception as e:
        print(f"Manual test encountered an error: {e}")

if __name__ == "__main__":
    manual_test()
```

### Final Recommendation

Given your preference for simplicity, I'd recommend starting with `unittest` or manual function calls (`run_basic_tests`), as these approaches are easy to implement and do not require any additional dependencies or configuration.

Let me know if this fits your needs, or if you need further assistance!

---

# Fast-forward to the End of SPA Testing Project

## **Creating a Complete Testing Suite for FastHTML Single Page Application (SPA)**

As I embarked on the journey to develop a robust FastHTML single-page application, I quickly recognized the necessity of a thorough testing suite. This suite would focus on validating the application’s endpoints effectively, ensuring all functionalities remain intact as my code evolves. Below, I'll share the detailed steps I took to build this testing framework, complete with code snippets and points of interest that contributed to the amazing finished product.

### **1. Utilizing `unittest` for Endpoint Testing**

To start, I chose Python’s built-in `unittest` module for its simplicity and effectiveness in structuring tests. This choice allows for a clean and manageable testing setup, perfect for focusing on backend logic.

Here’s a basic structure for the test class:

```python
import unittest
import requests

class TestBotifythonApp(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        cls.base_url = "http://localhost:5001"  # Adjust the base URL for your application
        cls.test_results = []

    def setUp(self):
        """Prepare any necessary test data before each test."""
        self.test_todo_id = None
        self.test_profile_id = None

    @classmethod
    def tearDownClass(cls):
        """Clean up resources after all tests have run."""
        # Additional cleanup can be done here if needed
        cls.print_summary()

    def add_result(self, endpoint, status, message=""):
        """Log the result of each test."""
        self.test_results.append({
            "endpoint": endpoint,
            "status": status,
            "message": message
        })
```

### **2. Configurable Constants**

At the start of the testing class, I defined configurable constants for the endpoints I would test. This approach enhances readability and makes it easier to modify the code later.

```python
TODO = "competitor"
PROFILE = "client"

class TestBotifythonApp(unittest.TestCase):
    # Define other attributes and methods...
```

### **3. Comprehensive Test Cases**

Each endpoint gets its dedicated test method. For example, here’s how I structured the test for creating a new todo item:

```python
def test_create_todo(self):
    new_todo = {"title": "Test Todo Item"}
    response = requests.post(f"{self.base_url}/{TODO}", data=new_todo)
    status = "Success" if response.status_code == 200 else "Failure"
    self.add_result(f"POST /{TODO}", status, "Created new todo")
    self.assertEqual(response.status_code, 200)
```

### **4. Testing Dynamic Configurations**

To facilitate a dynamic testing environment, I created a list of configurations representing each test case. Each configuration contains details about the endpoint and the corresponding test method.

```python
test_config = [
    {"endpoint": "/", "method": "GET", "test_func": "test_server_running"},
    {"endpoint": f"/{TODO}", "method": "POST", "test_func": "test_create_todo"},
    # Add more configurations for other tests...
]

def test_dynamic_execution(self):
    for config in self.test_config:
        test_func = getattr(self, config["test_func"], None)
        if test_func:
            test_func()
```

### **5. Summary Reporting with Rich Console**

To improve the test output, I integrated the `rich` library to display a visually appealing summary of the test results. This summary includes each test's status and any messages associated with it.

```python
from rich.console import Console
from rich.table import Table

def print_summary(self):
    console = Console()
    table = Table(title="Test Summary")
    
    table.add_column("Endpoint", style="cyan")
    table.add_column("Status", style="green")
    table.add_column("Message", style="yellow")

    for result in self.test_results:
        table.add_row(result["endpoint"], result["status"], result["message"])
    
    console.print(table)
```

### **6. Future Plans for UI Testing**

While my current testing suite focuses exclusively on backend endpoints, I plan to implement browser automation for UI testing using libraries like `Selenium` or `Playwright`. This will enable me to simulate user interactions within the web application and ensure that both the frontend and backend work harmoniously.

```python
# Example for a future UI test using Selenium
from selenium import webdriver

def test_homepage_ui(self):
    driver = webdriver.Chrome()  # Ensure you have the appropriate driver installed
    driver.get("http://localhost:5001/")
    assert "Welcome" in driver.title  # Replace with an actual condition
    driver.quit()
```

### **7. Running the Tests**

To execute the tests, I simply run the test script. The built-in capabilities of `unittest` handle test discovery, and the results are printed directly to the console.

```bash
python test_botifython.py
```

### **8. Detailed Test Implementations**

Let’s expand the tests to cover all aspects of my application. Below are additional examples that demonstrate how I validate different functionalities, including retrieving, updating, and deleting todo items and profiles.

#### **Get All Todos**

```python
def test_get_todos(self):
    response = requests.get(f"{self.base_url}/{TODO}")
    status = "Success" if response.status_code == 200 else "Failure"
    self.add_result(f"GET /{TODO}", status, "Fetched all todo items")
    self.assertEqual(response.status_code, 200)
```

#### **Update Todo Item**

```python
def test_update_todo(self):
    # First, create a todo item to update
    self.test_create_todo()
    update_data = {"todo_title": "Updated Todo Item"}
    response = requests.post(f"{self.base_url}/{TODO}/update/{self.test_todo_id}", data=update_data)
    status = "Success" if response.status_code == 200 else "Failure"
    self.add_result(f"POST /{TODO}/update/{self.test_todo_id}", status, "Updated todo item")
    self.assertEqual(response.status_code, 200)
```

#### **Toggle Todo Status**

```python
def test_toggle_todo(self):
    # Ensure a todo item exists before toggling
    self.test_create_todo()
    response = requests.post(f"{self.base_url}/{TODO}/toggle/{self.test_todo_id}")
    status = "Success" if response.status_code == 200 else "Failure"
    self.add_result(f"POST /{TODO}/toggle/{self.test_todo_id}", status, "Toggled todo status")
    self.assertEqual(response.status_code, 200)
```

#### **Delete Todo Item**

```python
def test_delete_todo(self):
    # Create a todo item to delete
    self.test_create_todo()
    response = requests.delete(f"{self.base_url}/{TODO}/delete/{self.test_todo_id}")
    status = "Success" if response.status_code == 200 else "Failure"
    self.add_result(f"DELETE /{TODO}/delete/{self.test_todo_id}", status, "Deleted todo item")
    self.assertEqual(response.status_code, 200)
```

#### **Get All Profiles**

```python
def test_get_profiles(self):
    response = requests.get(f"{self.base_url}/{PROFILE}")
    status = "Success" if response.status_code == 200 else "Failure"
    self.add_result(f"GET /{PROFILE}", status, "Fetched all profiles")
    self.assertEqual(response.status_code, 200)
```

#### **Create New Profile**

```python
def test_create_profile(self):
    new_profile = {
        "profile_name": "Test Profile",
        "profile_address": "123 Test St",
        "profile_code": "TEST001"
    }
    response = requests.post(f"{self.base_url}/{PROFILE}", data=new_profile)
    status = "Success" if response.status_code == 200 else "Failure"
    self.add_result(f"POST /{PROFILE}", status, "Created new profile")
    self.assertEqual(response.status_code, 200)
```

### **9. Enhanced Logging with Loguru**

To further enhance the testing process, I integrated the `loguru` library for better logging capabilities. This allows me to track detailed logs of each test case, which can be incredibly useful for debugging.

```python
from loguru import logger

logger.add("test_log.log", rotation="1 MB")

def add_result(self, endpoint, status, message=""):
    logger.info(f"Testing {endpoint}: {status} - {message}")
    self.test_results.append({
        "endpoint": endpoint,
        "status": status,
        "message": message
    })
```

### **10. Conclusion and Next Steps**

By establishing this comprehensive testing suite for my FastHTML single-page application, I’ve made significant strides toward ensuring the reliability and robustness of the application. The structured approach using `unittest`, combined with rich output through the `rich` library, allows for easy maintenance and scalability of the tests.

As I move forward, I plan to integrate UI testing to cover the complete user experience, ultimately leading to a more resilient application that meets user expectations. With the groundwork laid, I look forward to future enhancements and the inevitable challenges of maintaining and expanding this project.
