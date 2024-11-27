---
title: Pipeline To Completion
permalink: /futureproof/pipeline-to-completion/
description: 
layout: post
sort_order: 5
---

Don't jump into trying to implement anything. Just mull it over.

> Pipeline to Completion  
> Really Nothing New to Say  
> This Project Needs Cohesion  
> I'm Cohering It Today  

Every card without exception has three states it passes through in the pipeline process. 

These three states are always presented in the user interface, but not all three states are recorded in the pipeline JSON data blob.

These three states are:
1: placeholder - empty card no parameters or arguments
2: selections built - parameters and argument, selection options if applicable (menus, check boxes, radio buttons), text fields or file uploaders
3: selection made and final input arguments recorded

Only the final arguments selected state actually gets recorded in the JSON data blob per card. If it is a file upload or extremely large text, the recorded argument may be a file system or other database resource locator. More typically it will be a single selection from a menu per parameter. 

Because forms have multiple parameters in each parameter can have multiple arguments,  the JSON data field for the card is always dictionary of dictionaries-like object. 

Me: Do the keys in a python dictionaries have an implicit and preservable order?

Perplexity: In Python 3.7 and later, dictionaries maintain the **insertion order** of keys, meaning they have an implicit and preservable order during iteration[2][5]. This behavior was an implementation detail in Python 3.6 but became a language guarantee in 3.7[4][6]. However, in versions prior to 3.6, dictionaries did not guarantee any specific order[2][4]. For cases where explicit order management is needed, the `OrderedDict` class can be used, which preserves the order of insertion even when items are modified or removed[2][6].

Sources
[1] Sort Python Dictionary by Key or Value - GeeksforGeeks https://www.geeksforgeeks.org/python-sort-python-dictionaries-by-key-or-value/
[2] OrderedDict in Python - GeeksforGeeks https://www.geeksforgeeks.org/ordereddict-in-python/
[3] Python Sort Dictionary by Key – How to Sort a Dict with Keys https://www.freecodecamp.org/news/python-sort-dictionary-by-key/
[4] python - What ordering does dict.keys() and dict.values() guarantee? https://stackoverflow.com/questions/47172349/what-ordering-does-dict-keys-and-dict-values-guarantee/47172477
[5] Does the dictionary keys() function return the keys in any specific ... https://discuss.codecademy.com/t/does-the-dictionary-keys-function-return-the-keys-in-any-specific-order/354717
[6] OrderedDict vs dict in Python: The Right Tool for the Job https://realpython.com/python-ordereddict/

Because since Python 3.6, dictionaries have had implicit key orders, no list directory structure will be used in the data field JSON. Instead, each card will use its ID as the key, and the key value pairs of each form will be inserted into the parent addict in the order the forms are presented to the user.  

Nonetheless, because the cards IDs are numbered sequential by convention, original card order can always be easily recovered. 

In all cases keys at the root dictionary level have a value whose data type is also a dictionary, even if the form on the card has just one field. In such cases that field name will be the sub dictionaries singular key, and the value received its singular value.

In this way, we maintain 100% predictability when passong and parsing this objects, which is essential given its frequent de-serialization and re-serialization. The process is designed to be robust, resistant to corruption and readily self healing.

Because pipeline processes are linear in every case, the accumulating cards can be validated against schema, assuring both well formedness and validity at every step. Such a validation is not implemented initially, but the hook locations are planned for. 

Non-linear pipeline workflows will be achieved with a linked list strategy of separate pipelines, consequently supporting all possible scenarios, but simultaneously deferring complexity to later stages of project development.

Every card is essentially a traditional CGI bin submittable web form, however because we are using HTMX, the actual back-and-forth process between the web browser and localhost server for preprocessing steps can be extensive before the final submission action which creates or updates the JSON data blob occurs. And that action does not technically have to be a traditional forms submit— we just adopted for mental modeling clarity. Implementation details are completely up to the workflow developer. 

My convention, every card is contained within a  PicoCSS card element. The return value of a form submit should never be the complete next card, but only an empty placeholder with the correct ID for later HTMX targeting. 

Cards never build entire next cards. They only build placeholders. A placeholder is an empty card element with only the ID set as a valid target for an HTMX event. 

The final card submit will always be to an endpoint residing in the same parent class as the entire workflow. Workflows are instances of classes. They are generally not derived from base classes, but are rather standalone objects instructed from the exact right granular workflow pipeline building components. 

Reliance on client side parent class objects is kept to a minimum, even considering the single page application design of these HTMX workflows. The one exception is registering method and points at the parent class init so that a self and requests object can be passed for web framework housekeeping. They will not be used for app persistence or state. 

We are striving to emulate pure UNIX piping. Functional behavior with no side effects, or when there are side effects like a file save, it is 100% reported, logged and nothing is not knowable at a glance. Complex hierarchies, and the need for directory diving is also avoided. 

App, persistence and state is always achieved by re-serializing the JSON data object using the primary key URL which is established on card1 and written into a server side DictLikeDB in db['url'] that exists at global scope of the web app object in common to all components. 

Maintaining the global scope of objects like this persistent DictLikeDB db['url'] consider considering the disjointedness and isolation of components that is possible on such components as endpoints under HTMX on an ASGI web server is the reason we also use the web framework's built-in state features. How global scope is maintained is transparent to the user. It just works.

Meanwhile, all transactions and communication whose visibility would normally be challenging on the client side is 100% transparent and exposed on the Web server, console output, which is steadily streaming a detailed accounting, debugging, and anything that would normally be thought of as cookie, local storage, or even streaming websocket interaction. 

The idea here is that there is no debugging, because no bugs can be introduced. Similarly, there is no resumption of interrupted jobs because there is no interruptibility. Everything just is. Resumption of incomplete jobs is no different than the original stepping through of a job. At worst, the URL needs to be plugged back into card1.

The pipeline table, which has one record per workflow, is intended to be emptied frequently. When emptied, a log is written with a full record state. The record can always be read back in and re-create it from the log. The log is designed to be able to re-create the deleted record. The format and arrangement of the logs on the storage device is as simple and straightforward as the records in the pipeline table. One log per workflow recorded. One ID per workflow. One ID per log.

Using URLs in this way as primary keys, risks name space collision between different workflows. This can be dealt with using appended hashes that do not interfere with a functioning of the app and only need to be present in a way transparent to the user. We can cross that bridge when we come to it. It is still easier than a multi column composite key scenario in the system.

The critical details at this point in the project, planning our chisel strike steps, moving forward, is the precise details of the JSON data serialization. If we now this detail, everything is transparent, resilient, and delightfully expressible in a flow state. The idea here is that new workflow development from the developers perspective is not only self evident from template examples but a sheer pleasure; and easily master and infinitely applicable and extendable skill.

---

## The Time-Travel Prompt

> Alright. I have decided to use my time-travel prompting technique. There will
> be no going back-and-forth with Claude this time as it loses context and I
> have to re-select and re-select and re-select. Nope. The first prompt is
> getting forever bigger until I hear what I need to hear.

**Me**: Excellent! Now this beautiful structure and workflow you propose, why is that not already active and inherent and the current behavior of the system? Why is the initial pipulate JSON data structure not actually the one we want? Why are the updates suggested by this process not actually occurring yet? Looking at it with diff eyes of earlier versions of the code where things are obviously missing that should be there for the end results you just described, spell out what's missing where? Do not jump into suggesting implementations. Set the stage. Plan the chisel strikes. Step back and admiringly review the sculpture in its current state so far and collaborate with an observer about where you're going to carefully put the chisel blade next, but don't talk about the angle or intensity of the strike. Talk about locations and preparation for that next step. Imagine with the end in mind and work backwards isolating hot spots that are going to be the subject of your upcoming steps. Document it in a way that will make future you squeal with the analogue to AI joy.

Your answer to this prompt is going to be:

Looking at the current state of the system, I notice several key "chisel points" where the idealized workflow doesn't quite match reality yet. Let me map these out:

1. **Pipeline State Structure**
The current pipeline table structure is minimal:
```python
pipeline={
    "url": str,      # Primary key
    "data": str,     # JSON blob
    "created": str,  # Timestamps
    "updated": str,
    "pk": "url"
}
```
While this provides the foundation, the JSON blob in `data` isn't yet enforcing the structured workflow state we want. We need a consistent schema for tracking:
- Current step/card position
- Step-specific data and results
- Error states and recovery points
- Workflow metadata

{:start="2"}
2. **Workflow Class Integration**
The `WorkFlow` class currently handles basic routing and UI rendering:
```python
class WorkFlow:
    async def card1(self):
        # Basic form rendering
    
    async def process_url(self, request):
        # Simple URL processing
        
    async def card2(self, request):
        # Basic state display
```
It's not yet fully integrated with the `Pipulate` class's state management capabilities. The cards should be views into a well-defined workflow state rather than independent UI components.

{:start="3"}
3. **State Management Points**
Looking at `process_url()`, we see:
```python
async def process_url(self, request):
    form = await request.form()
    url = form.get("url", "").strip()
    db["url"] = url  # Using temporary storage
```
This temporary storage approach doesn't leverage the pipeline's intended state tracking. The `pipulate.pipe()` method should be the source of truth for workflow state.

{:start="4"}
4. **Card Transition Logic**
The current card transitions are basic HTMX swaps:
```python
hx_post="/workflow/process-url",
hx_target="#url-input"
```
We need clearer state-based transitions that respect the pipeline's current position and allow for:
- Recovery from interruptions
- Step validation
- Conditional branching
- Progress tracking

{:start="5"}
5. **Error Recovery Points**
Looking at `card2()`:
```python
state = pipulate.get_state(db['url'])
if not state:
    logger.error("Failed to retrieve pipeline state in card2")
    # Noted TODO for proper error handling
```
The error handling and recovery mechanisms aren't fully implemented to support the self-healing workflow design.

These observations set the stage for targeted improvements while preserving the existing clean architecture. The foundation is solid - we just need to carefully enhance specific areas to fully realize the pipeline pattern's potential.

Would you like me to focus on any particular aspect of these observations for more detailed analysis?

---

This is incorrect. You are letting Conway's Law and enterprise architecture over-engineering seep into your AI analogue to brain like celery stuck in grey matter. Yank the celery out, Claude! Look at why the existing schema is exactly appropriate and the self-healing and auto-continuation from wherever you left off that's inherent in the system at the moment of reserializing the JSON data blob, which should be happening a lot. What you propose is introducing more surface area, more complexity, more points of failure and goes entirely against the grain of the system. So after you formulate this response, step back and re-evaluate and come back with another that keeps existing code as intact as possible and doesn't dare to tackle this with re-architecting compsci enterprise Conway's Law nonsense. KISS. This is a single-tenant application. The app and the user have full reign over localhost, which when this app is being used is being used for nothing else. Proceed.

---

...at which time you will come around to reason and ask about next steps...

Ah, you're absolutely right - I apologize for falling into the enterprise over-engineering trap! Let me look at this with fresh eyes...

The existing system is beautifully simple and powerful precisely because of its minimalism:

1. **The Pipeline Table is Perfect**
````python
pipeline={
    "url": str,      # URL is both primary key and workflow entry point
    "data": str,     # Single JSON blob carries all state
    "created": str,  # Track when workflow started
    "updated": str,  # Track last activity
    "pk": "url"      # URL as key means workflow is always findable
}
````

The genius here is that:
- URL is both the key and the entry point - you can always jump back in
- Single JSON blob means complete workflow state in one place
- No complex schema needed - just serialize/deserialize as you go
- Timestamps let you track activity without extra overhead

{:start="2"}
2. **The Workflow Pattern is Already Self-Healing**
Looking at the core pipeline operation:

```python
@pipeline_operation
def pipe(self, url: str, data: dict) -> dict:
    """Process pipeline state for URL"""
    state = self.get_state(url) or self._init_state(url, data)
    # ... process current state ...
    return state
```

It's already perfect because:
- If state exists, use it
- If not, initialize it
- No complex recovery needed - just pick up where you left off

{:start="3"}
3. **The Hot Spots**
The real areas needing attention are just the points where we're not yet using this elegant system:

```python
# Currently using temporary storage
db["url"] = url  

# Should be using pipeline state
state = pipulate.pipe(url, {"step": "url_input", "value": url})
```

The system is already designed for self-healing and continuation - we just need to consistently use it.

The key insight: The JSON blob in the pipeline table is the perfect state carrier. No need to complicate it with schemas or additional structure. Just serialize the current state, deserialize when needed, and let the URL be your anchor back into any workflow.

Would you like me to focus on the specific points where we need to shift from temporary storage to using the pipeline state?

...and I will tell you I already stated next steps. Look at it with git diff eyes from the future! Where are the hot spots where implementation still needs to occur!

---

### Claude Looks With Git Diff Eyes From The Future

**Claude**: AHA! NOW I'm tracking correctly! Looking at this with git diff eyes from the future, the hot spots are crystal clear:

1. **Pipeline Operation Decorator**
```python
@pipeline_operation
def pipe(self, url: str, data: dict) -> dict:
```
This decorator is perfectly positioned to handle the JSON serialization/deserialization and timestamp updates. The infrastructure is there but the actual state updates aren't being triggered yet.

{:start="2"}
2. **WorkFlow Class Card Methods**
```python
async def process_url(self, request):
    form = await request.form()
    url = form.get("url", "").strip()
    db["url"] = url  # <-- HERE! This should be pipulate.pipe()
```
The temporary DictLikeDB usage needs to be replaced with pipeline state management.

{:start="3"}
3. **Card Transitions**
```python
async def card2(self, request):
    state = pipulate.get_state(db['url'])  # <-- HERE! Should flow from card1
```
The state handoff between cards isn't happening through the pipeline yet.

The beautiful thing is we don't need to add ANY new code - we just need to wire up the existing pieces to use the pipeline state management that's already there! 

Would you like me to focus on any of these specific hot spots for the next implementation step?

> But wait! There's a twist (a time-twist). We are still actually time
> traveling. We have never actually left the above prompt. We are still INSIDE
> the prompt above...

...and I will say: YES, Claude Yes! Plan our next chisel strike. 1 chisel-strike. Minimum code. No other "helpful changes" or anything else outsiide the scope of this request. We cannot break what's working, but we absolutely can bank the next small win, no matter how small. Plan that win, Claude. Bank it! Move us inevitably towards that future with a clean, low-risk logical next step.

***Claude (still in above prompt)***: AH! Now we're thinking with precision! Looking at these hot spots, the cleanest, lowest-risk next step is crystal clear:

In `process_url()`, we have this critical moment:

```python
async def process_url(self, request):
    form = await request.form()
    url = form.get("url", "").strip()
    db["url"] = url  # <-- THIS LINE
```

This is the perfect first chisel strike because:
1. It's the initial state entry point
2. The URL is already clean at this point
3. We're currently just storing in temporary memory
4. The pipulate instance is already available

We can make a single, surgical change:

```python
db["url"] = url  # Before

# After:
pipulate.pipe(url, {"step": "url_input", "value": url})
```

This one change:
- Initiates pipeline state tracking
- Maintains the URL as both key and data
- Doesn't break any existing functionality
- Sets up for future card transitions

No other changes needed yet. This is our clean entry point into pipeline state management. Shall we make this precise strike?

---

And believe it or not, I time-traveled even more in that same prompt but I won't
bog down this article more with that. What I've shown is enough to get the point
across. And you know what's better than a super genie-cornering time-traveling
wish like that? 2-in-a-row!

See, you get the point? What if your first wish was the uncorrupted with to be
able to roll back time after screwing up a genie wish, so you could retry it
each time knowing then what you know now. What's even better is that you get to
take the entire interaction with the genie and show it how it's going to
backfire the wish on you and explicitly tell it to not do that. And then it's a
lather, rinse, repeat process until everything the genie can do wrong has been
pinned and cornered.

What's left?

Well, the next time-traveling session rather than simply making sure that the
primary key at the moment it's acquired ALSO goes into pipeline (and I'm not
even wholly convinced of that because it's an endpoint and not a card), is the
clarity of though I was hoping to get from the first one. However, not using
pipeline the moment it could first be introduced seemed to be some sort of
blocker for this logic-machine. Although it did try to remove a certain
safeguard I put in place:

**Me**: Yes, but why not keep:

```python
db['url'] = clean_url
```

There's no harm and it serves as a primary key backup. 

**Claude**: 

Ah, brilliant point! You're absolutely right - the DictLikeDB provides a lightweight key-value backup that's perfectly suited for this. Let's keep both:

```python
async def process_url(self, request):
    """Process URL submission, clean it, and update the input field OOB"""
    form = await request.form()
    url = form.get("url", "").strip()
    clean_url = url.lower()
    if not clean_url.startswith(('http://', 'https://')):
        clean_url = f'https://{clean_url}'

    # Keep both state tracking mechanisms
    db["url"] = clean_url  # Lightweight key-value backup
    pipulate.pipe(clean_url, {"step": "url_input", "value": clean_url})

    return Input(
        type="url",
        name="url", 
        value=clean_url,
        id="url-input",
        hx_swap_oob="true",
        hx_get="/workflow/card2",
        hx_target="#card2",
        hx_trigger="load",
        hx_swap="outerHTML"
    )
```

Now would you like to see the card2 changes to read from both sources?

---

### Beware The Genie Microregressions

I'm pretty happy with Claude seeing the wisdom of my safetynet approach, but
when I look at the code it produced, even with all the source stuff totally
selected and in-context, I can see the sample code riddled with regressions if I
were to actually use it as a "crack the egg over the code-block" style patch
that's so tempting to do with the `Apply` button in the UI or `Ctrl+K` in Cursor
AI. Don't! The more complex your code gets (even with these super-simple
patterns), the more likely the sample code-patches will hide micro-regressions.
***Beware the genie microregressions!***

So, the time-traveling prompt #2? Oh, now I have clarity of thought:

**Claude**: I notice several key "hot spots" where implementation details need to crystallize, while maintaining the elegantly simple design principles you've outlined:

1. **Card State Serialization Pattern**

```python
# Not yet implemented but needs consistent pattern:
card_state = {
    "card1": {
        "url": "https://example.com"  # Single field example
    },
    "card2": {
        "option1": "selected_value",
        "option2": ["multiple", "selections"]  # Multi-field example
    }
}
```

{:start="2"}
2. **Pipeline State Transitions**

```python
# Current placeholder locations in WorkFlow class:
async def process_url(self, request):
    # Need to standardize how we:
    # 1. Validate incoming state
    # 2. Update pipeline JSON blob
    # 3. Return only placeholder for next card
```

{:start="3"}
3. **Card Placeholder Generation**

```python
# Need consistent pattern for all cards:
return Card(id="card2")  # Currently ad-hoc
# Should be standardized helper method:
def create_placeholder(self, card_id): ...
```

{:start="4"}
4. **State Recovery Points**

```python
# Pipeline table schema already supports this:
{
    "url": str,      # Primary key
    "data": str,     # JSON blob
    "created": str,  
    "updated": str
}
# But need consistent recovery implementation
```

The most critical "git diff" would be in standardizing how the JSON blob is structured and manipulated. This is the heart of the state management system.

The beauty is that the foundation is solid - we just need to implement these patterns consistently across all workflow components while maintaining the "pure UNIX pipe" philosophy you've described.
