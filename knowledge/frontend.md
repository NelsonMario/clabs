# Frontend Architecture: State and View

Modern UI frameworks (React, Vue, Svelte) are incredible tools for binding data to the DOM. However, they are terrible places to store complex business logic. The Hexagonal philosophy applies to the frontend just as rigorously as the backend.

## The Core Concept

### 1. The Separation of State and View
Imagine building a shopping cart. The logic for calculating totals, applying discount codes, and preventing out-of-stock purchases is pure **Domain Logic**. It has absolutely nothing to do with whether the user is on a web browser, a mobile app, or a terminal. 
This logic should be written in pure, framework-agnostic classes or functions. 

The React or Vue component should be exceedingly "dumb." It acts as a **View Adapter**. Its sole responsibility is to say: "Give me the state of the cart, and I will draw the boxes and buttons on the screen." 

### 2. Side-Effects and Infrastructure
When the user clicks "Checkout", the UI component shouldn't make the HTTP `fetch` request directly. It should call an `executeCheckout()` use-case inside your State layer. The State layer then reaches out to an **Infrastructure Adapter** (an API clent) to actually perform the network request. This keeps your UI components blazing fast, infinitely testable, and strictly focused on visuals.

### 3. Global vs Local State
Not all state belongs in the global "Domain." If a user clicks a dropdown menu to open it, that `isOpen` boolean is purely **Local UI State**. It belongs entirely inside the component. Do not clutter the business domain with irrelevant pixel-pushing state parameters.
