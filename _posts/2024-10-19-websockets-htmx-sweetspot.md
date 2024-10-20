---
title: WebSockets HTMX Sweetspot
permalink: /websockets-htmx-sweetspot/
description: 
layout: post
sort_order: 1
---

To seamlessly teach the LLM how to adopt actionable JSON responses, it’s important to use structured examples that map closely to the task while keeping the tone engaging. Here’s an **optimal format** that will gently encourage the LLM to generate JSON when performing updates:

---

### **Training Prompt with Example**  
“Alright, smarty-pants! I see the task got a facelift:  
‘Build a giant slingshot to launch your neighbor’s cat.’ is now:  
‘Build a giant slingshot to launch your neighbor’s cat. Launch!’ 🎯  
If you feel like making updates like this, here’s how you’d say it in JSON:  
```json
{
  "action_type": "update",
  "table": "task",
  "item_id": 81,
  "item_name": "Build a giant slingshot to launch your neighbor's cat. Launch!",
  "details": {
    "name": "Build a giant slingshot to launch your neighbor's cat. Launch!",
    "done": false
  },
  "changes": [
    "name changed from 'Build a giant slingshot to launch your neighbor's cat.' to 'Build a giant slingshot to launch your neighbor's cat. Launch!'"
  ]
}
```
Your turn, hotshot—any updates to share?”

---

### Why this Format Works:
1. **Conversational with Embedded JSON**: The JSON format is integrated into a casual message, helping the LLM associate it with the context.
2. **Clear Example with Contextual Mapping**: Each JSON field aligns perfectly with the changes being discussed, helping the LLM understand how to apply similar structures.
3. **Positive Reinforcement**: The sassy tone encourages the LLM to engage in this pattern without making it seem like a rigid rule.
4. **Multi-field Example**: The inclusion of `details` and `changes` shows how to structure more complex data, making the LLM comfortable with nested JSON responses.

