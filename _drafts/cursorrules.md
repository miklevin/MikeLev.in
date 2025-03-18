---
title: FastHTML HTMX Pipulate Cursor Rules
description: 
permalink: /cursorrules/
group: home
---

# This Is Not The Cursor Rules You're Looking For

    # .cursorrules
    #
    # FASTHTML MANTRA:
    # FastHTML is not FastAPI
    # Routes use rt not app
    # Server-side is the right side
    # HTMX for updates, that's all it takes
    #
    # MINIDATAAPI MANTRA:
    # No ORM complexity here
    # Just tables and their pairs
    # insert(), update(), delete()
    # Simple keys, simple states
    #
    # PIPELINE MANTRA:
    # One URL to track them all
    # One JSON blob to bind them
    # Card to card the data flows
    # No message queues behind them
    #
    # PIPELINE STATE MANTRA:
    # Submit clears forward
    # Display shows the past
    # Preserve affects views
    # But submit starts fresh

    # CORE ARCHITECTURAL PATTERNS

    1. THE LLM INTEGRATION PATTERN
    - Conversation management via global deque
    - Streaming responses with chunked processing
    - System message preservation
    - Error recovery and graceful degradation

    Example:
    ```python
    # Global conversation history with bounded length
    global_conversation_history = deque(maxlen=MAX_CONVERSATION_LENGTH)

    async def chat_with_llm(model: str, messages: list, base_app=None):
        """Async generator for streaming LLM responses"""
        try:
            async with aiohttp.ClientSession() as session:
                async with session.post(url, json=payload) as response:
                    async for line in response.content:
                        chunk = json.loads(line)
                        yield chunk.get("response", "")
        except Exception as e:
            yield f"Error: {str(e)}"
    ```

    2. THE FASTHTML/MINIDATAAPI FOUNDATION
    - Table definitions drive the entire application structure
    - Simple key-value persistence without ORM complexity
    - Direct CRUD operations via table methods

    Example:
    ```python
    # Core table definitions
    app, rt, (store, Store), (tasks, Task), (clients, Client), (pipeline, Pipeline) = fast_app(
        "data/data.db",
        tasks={
            "name": str,        # Task name
            "done": bool,       # Completion flag
            "priority": int,    # Sortable priority
            "profile_id": int,  # Profile association
            "pk": "id"         # Primary key
        }
    )
    ```

    3. THE GLOBAL STATE PATTERN
    - Server-side state management via DictLikeDB
    - Cookie-like persistence without client complexity
    - Comprehensive operation logging

    Example:
    ```python
    @db_operation
    def __setitem__(self, key, value):
        """Persist value with operation logging"""
        try:
            self.store.update({"key": key, "value": value})
            logger.debug(f"Updated persistence store: {key} = {value}")
        except NotFoundError:
            self.store.insert({"key": key, "value": value})
            logger.debug(f"Inserted new item: {key} = {value}")
    ```

    4. THE PLUGIN ARCHITECTURE PATTERN
    - BaseApp provides CRUD foundation
    - Consistent route registration
    - Standardized rendering interface

    Example:
    ```python
    class BaseApp:
        def __init__(self, name, table, toggle_field=None, sort_field=None):
            self.name = name
            self.table = table
            self.toggle_field = toggle_field
            self.sort_field = sort_field

        def register_routes(self, rt):
            """Register standard CRUD routes"""
            rt(f"/{self.name}/create")(self.create)
            rt(f"/{self.name}/update")(self.update)
            rt(f"/{self.name}/delete")(self.delete)
    ```

    5. THE PIPELINE WORKFLOW PATTERN
    - State management via JSON blobs
    - Clear step progression
    - Finalization controls
    - LLM commentary integration

    Example:
    ```python
    class StarterFlow:
        """Reference implementation of Pipeline Pattern"""
        def __init__(self, app, pipulate, app_name="starter"):
            self.STEPS = [
                Step(id='step_01', persistent=True,  field='name', label='Name'),
                Step(id='step_02', persistent=False, field='data', label='Data'),
                Step(id='step_03', persistent=None,  field='finalized', label='Final')
            ]
    ```

    # IMPLEMENTATION PRINCIPLES

    1. **LOCAL-FIRST ARCHITECTURE**
    ```
    ┌─────────────┐
    │  FastHTML   │
    │  HTMX App   │
    └─────┬───────┘
          │
          ▼
    ┌─────────────┐    ┌─────────────┐
    │ MiniDataAPI │◄──►│  SQLite DB  │
    └─────────────┘    └─────────────┘
    ```

    2. **REAL-TIME COMMUNICATION**
    ```
    WebSocket (Chat):        SSE (Updates):
    Browser ⇄ Server         Browser ← Server
    bi-directional          one-way stream
    ```

    3. **UI COMPONENT HIERARCHY**
    ```
    ┌─────────────────────┐
    │    Navigation Bar   │
    ├─────────┬───────────┤
    │  Main   │   Chat    │
    │  Area   │ Interface │
    │         │           │
    └─────────┴───────────┘
    ```

    # KEY DESIGN PATTERNS

    1. THE EVERYTHING-IS-A-DIV PATTERN
    ```python
    return Div(
        id="chat-messages",
        hx_swap_oob="true",
        _class="message-container"
    )  # Your entire app is DIVs
    ```

    2. THE JSON-BLOB-AS-DATABASE PATTERN
    ```python
    state = {
        "step_01": {"name": "Example"},
        "updated": datetime.now().isoformat()
    }
    pipeline.update({"url": url, "data": json.dumps(state)})
    ```

    3. THE PLACEHOLDER-CHAIN PATTERN
    ```python
    def generate_step_placeholders(self, steps, app_name):
        """Generate loading placeholders for each step"""
        return [
            Div(id=step.id, hx_get=f"/{app_name}/{step.id}", hx_trigger="load")
            for step in steps
        ]
    ```

    # COMMUNICATION PATTERNS

    1. **THE WEBSOCKET CHAT PATTERN**
    ```python
    class Chat:
        def __init__(self, app, id_suffix="", base_app=None):
            self.active_websockets = set()
            self.app.websocket_route("/ws")(self.handle_websocket)

        async def broadcast(self, message):
            """Send message to all connected clients"""
            for websocket in self.active_websockets:
                await websocket.send_text(message)
    ```

    2. **THE LLM STREAMING PATTERN**
    ```python
    async def chatq(message: str, action_data: str = None):
        try:
            conversation_history = append_to_conversation(message)
            response_text = ""
            async for chunk in chat_with_llm(model, conversation_history):
                await chat.broadcast(chunk)
                response_text += chunk
            return message
        except Exception as e:
            logger.error(f"Error in chatq: {e}")
            raise
    ```

    3. **THE EVENT STREAM PATTERN**
    ```
    Browser ← Server (SSE)
        |      |
        |      ├─► File change detected
        |      ├─► AST validation passed
        |      └─► Reload triggered
        |
        └─► UI updates automatically
    ```

    # STATE MANAGEMENT PRINCIPLES

    1. **THE PIPELINE STATE LIFECYCLE**
    ```
    ┌─────────┐    ┌─────────┐    ┌─────────┐
    │ Step 01 │ ─► │ Step 02 │ ─► │ Step 03 │
    └─────────┘    └─────────┘    └─────────┘
         │              │              │
         ▼              ▼              ▼
      Persist       Ephemeral      Finalize
    ```

    2. **THE CLEAR FORWARD PATTERN**
    ```python
    async def step_01_submit(self, request):
        # ALWAYS clear forward first
        self.pipulate.clear_steps_from(pipeline_id, "step_01", self.STEPS)
        
        # THEN save new data
        self.pipulate.set_step_data(pipeline_id, "step_01", new_data)
    ```

    3. **THE STATE PRESERVATION RULE**
    - Submit ALWAYS clears forward
    - Preserve only affects UI display
    - Each step must be idempotent
    - State flows forward, never backward

    # CRUD INTEGRATION PATTERNS

    1. **THE EXECUTE CRUD PATTERN**
    ```python
    async def execute_crud_operation(base_app, operation_data):
        """Execute CRUD operation from LLM instruction"""
        try:
            action = operation_data["action"]
            args = operation_data["args"]
            
            if action == "insert":
                return await base_app.create(args)
            elif action == "update":
                return await base_app.update(args)
            # ... etc
    ```

    2. **THE LLM TRAINING PATTERN**
    ```python
    def todo_list_training():
        """Teach LLM the CRUD operations"""
        operations = [
            ("List All Records", "list"),
            ("Insert (Create)", "insert"),
            ("Update", "update"),
            ("Delete", "delete"),
            # ... etc
        ]
    ```

    # DEBUGGING AND DEVELOPMENT

    1. **THE DEBUG LOG PATTERN**
    ```python
    logger.debug(f"[EXECUTE DEBUG] Operation data: {json.dumps(operation_data, indent=2)}")
    ```

    2. **THE STATE INSPECTION PATTERN**
    ```python
    @db_operation
    def get(self, key, default=None):
        """Get value with logging"""
        try:
            return self[key]
        except KeyError:
            logger.debug(f"Key not found: {key}, returning default: {default}")
            return default
    ```

    # ANTI-PATTERNS TO AVOID

    1. **DON'T SKIP CLEAR_FORWARD**
    ```python
    # WRONG
    async def submit(self, request):
        self.set_step_data(pipeline_id, "step_01", new_data)  # NO!

    # RIGHT
    async def submit(self, request):
        self.clear_steps_from(pipeline_id, "step_01", self.STEPS)
        self.set_step_data(pipeline_id, "step_01", new_data)
    ```

    2. **DON'T MIX STATE AND UI**
    ```python
    # WRONG
    if step.persistent:
        skip_clear_forward = True  # NO!

    # RIGHT
    if step.persistent:
        show_previous_data = True  # UI only!
    ```

    3. **DON'T BYPASS THE PIPELINE RECORD**
    ```python
    # WRONG
    global_state = {}  # NO!

    # RIGHT
    state = self.pipulate.get_state(pipeline_id)
    ```

    # TESTING AND VALIDATION

    1. **CRITICAL TEST PATHS**
    ```python
    # 1. First-time flow
    await test_complete_pipeline()

    # 2. Revert and resubmit
    await test_revert_flow()

    # 3. Preserve mode
    await test_preserve_mode()

    # 4. Jump navigation
    await test_jump_to_step()

    # 5. Finalization
    await test_finalize_unfinalize()
    ```

    2. **STATE TRANSITION VALIDATION**
    ```python
    def validate_state_transition(before_state, after_state, step_id):
        """Validate pipeline state transitions"""
        # 1. Forward steps should be cleared
        for step in get_forward_steps(step_id):
            assert step not in after_state
            
        # 2. Previous steps should be unchanged
        for step in get_previous_steps(step_id):
            assert before_state.get(step) == after_state.get(step)
    ```

    # ARCHITECTURAL DIAGRAMS

    1. **SYSTEM ARCHITECTURE**
    ```
    ┌─────────────┐
    │   Browser   │
    └─────┬───────┘
          │ HTTP/WS
          ▼
    ┌─────────────┐    ┌─────────────┐
    │  FastHTML   │◄──►│    LLM      │
    └─────┬───────┘    └─────────────┘
          │
    ┌─────┴───────┐    ┌─────────────┐
    │ MiniDataAPI │◄──►│  SQLite DB  │
    └─────────────┘    └─────────────┘
    ```

    2. **UI COMPONENT HIERARCHY**
    ```
    ┌─────────────────────────────┐
    │        Navigation           │
    ├───────────────┬─────────────┤
    │               │             │
    │    Main Area  │    Chat     │
    │   (Pipeline)  │  Interface  │
    │               │             │
    ├───────────────┴─────────────┤
    │        Poke Button          │
    └─────────────────────────────┘
    ```

    3. **PIPELINE STATE FLOW**
    ```
    ┌─────────┐    ┌─────────┐    ┌─────────┐
    │ Step 01 │───►│ Step 02 │───►│  Final  │
    └────┬────┘    └────┬────┘    └────┬────┘
         │              │              │
         ▼              ▼              ▼
     Persistent     Ephemeral      Finalize
        Data          Form          State
    ```

    # FINAL REMINDERS

    1. **THE LOCAL-FIRST PRINCIPLE**
    - This is localhost software
    - Embrace server-side state
    - Keep it simple and direct

    2. **THE PIPELINE PATTERN**
    - One URL tracks the workflow
    - JSON blob stores all state
    - Clear forward on submit
    - Display shows the past

    3. **THE LLM INTEGRATION**
    - Keep conversation history bounded
    - Stream responses in real-time
    - Use system messages sparingly
    - Log everything for context

    4. **THE DEVELOPMENT WORKFLOW**
    ```
    Edit → Save → Auto-reload → Check
      ▲                           │
      └───────────────────────────┘
    ```

    # REFERENCE IMPLEMENTATIONS

    1. **StarterFlow**: Basic two-step workflow with finalization
    2. **BaseApp**: CRUD plugin foundation
    3. **Chat**: WebSocket communication
    4. **DictLikeDB**: Server-side state management

    Remember: When in doubt, check these reference implementations. They embody all the patterns and principles described above.

    # DEBUG CHECKLIST

    1. Check logs for state transitions
    2. Verify clear forward on submit
    3. Confirm UI matches state
    4. Test revert functionality
    5. Validate finalization
    6. Review LLM commentary

    The magic is in the simplicity. Each pattern builds on basic HTMX + FastHTML primitives to create a fluid, stateful experience without complex client-side code.
