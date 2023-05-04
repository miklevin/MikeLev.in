---
date: 2023-04-04
title: Getting To Know MOZ Through Mermaid ERDs
headline: Creating SEO Deliverables with MermaidJS and ERDs on April 4, 2023
description: "I'm creating an SEO deliverable on April 4, 2023 by creating Entity Relationship Diagrams (ERDs) of the various MOZ products. To do this, I'm using MermaidJS, a markdown-based language tool. I'm exploring how to use the Mermaid syntax for ERDs, which is compatible with PlantUML, and the statement structure of `first-entity [relationship second-entity : relationship-label]`. Come"
keywords: MOZ, Mermaid, ERDs, SEO, Deliverable, April 4, 2023, Entity Relationship Diagrams, MermaidJS, Markdown-based, Language Tool, PlantUML, Relationship, Relationship-Label
categories: moz, seo
permalink: /blog/getting-to-know-moz-through-mermaid-erds/
layout: post
---


For this next step, I will create an SEO "deliverable" of the type I might do
in an SEO agency, or even a company looking at who is doing well out there in
terms of Web traffic.

Think in terms of ERD (entity relationship diagrams) of the various MOZ
products, without getting too deep into the weeds. And without giving away
anything as a MOZ employee, though I haven't learned enough to know anything
different than you would through the standard product interfaces.

Standard product interfaces, you say?

List 'em...

- Moz Free
- Moz Pro
- Moz Local
- Moz Links API
- Moz Toolbar
- Stat

I needed to have a visual language tool that wasn't Visio and all that
proprietary desktop software. Even FOSS desktop WYSIWYG is too much overhead. I
just want to slam out markdown and have ERD diagrams, so MermaidJS looks like
the way to go. This is the sample ERD diagram from their [interactive web
designer](https://mermaid.live/edit):

<div class="mermaid">
erDiagram
    CUSTOMER }|..|{ DELIVERY-ADDRESS : has
    CUSTOMER ||--o{ ORDER : places
    CUSTOMER ||--o{ INVOICE : "liable for"
    DELIVERY-ADDRESS ||--o{ ORDER : receives
    INVOICE ||--|{ ORDER : covers
    ORDER ||--|{ ORDER-ITEM : includes
    PRODUCT-CATEGORY ||--|{ PRODUCT : contains
    PRODUCT ||--o{ ORDER-ITEM : "ordered in"
</div>

**Mike Levin:** what is the erd symbol system for mermaid js such as one to one, one to many and the like?

**Bing:** Mermaid syntax for ER diagrams is compatible with PlantUML, with an extension to label the relationship. Each statement consists of the following parts: `<first-entity> [<relationship> <second-entity> : <relationship-label>]`¹.

Here are some examples of how to use it:

- One-to-one relationship: `Customer [1] -> [1] Address`¹.
- One-to-many relationship: `Customer [1] -> * Order`¹.
- Many-to-many relationship: `Order *--* Product`¹.

I hope this helps! Let me know if you have any other questions.

Source: Conversation with Bing, 4/4/2023

    (1) Entity Relationship Diagrams | Mermaid. https://mermaid.js.org/syntax/entityRelationshipDiagram.html Accessed 4/4/2023.
    (2) prisma-erd-generator - npm. https://www.npmjs.com/package/prisma-erd-generator Accessed 4/4/2023.
    (3) erd - Is it possible to style an Entity Relation Diagram with Mermaid .... https://stackoverflow.com/questions/66299848/is-it-possible-to-style-an-entity-relation-diagram-with-mermaid-js-like-flowchar Accessed 4/4/2023.
    (4) Generate Mermaid Diagrams for Your Database - DEV Community. https://dev.to/sualeh/how-to-generate-mermaid-diagrams-for-your-database-33bn Accessed 4/4/2023.
    (5) ER diagram attributes · Issue #1361 · mermaid-js/mermaid. https://github.com/mermaid-js/mermaid/issues/1361 Accessed 4/4/2023.

I now need to know the ERD symbols. Found them on https://plantuml.com/ie-diagram

| Type | Symbol |
|------|--------|
| Zero or One | o-- |
| Exactly One | \|\|-- |
| Zero or Many | }o-- |
| One or Many | \}|-- |

And let's talk about the entities that exist in the field of SEO:

<div class="mermaid">
erDiagram
   SERPS
   Keywords
   Links
</div>



## Categories

<ul>
<li><h4><a href='/moz/'>MOZ</a></h4></li>
<li><h4><a href='/seo/'>SEO</a></h4></li></ul>