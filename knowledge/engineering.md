# Engineering Practices: The Philosophy of Clean Code

Code is written once, but read hundreds of times. Code that is "clever" is often bad. Code that is "boring" and immediately understandable is excellent.

## Fundamental Concepts

### 1. YAGNI (You Aren't Gonna Need It)
Engineers often suffer from the temptation to over-engineer solutions for problems that might occur five years from now. YAGNI mandates that you only build what is strictly required for the current requirements. Do not build abstract factory generators if a simple function suffices today.

### 2. Fail-Fast & Guard Clauses
Deeply nested `if-else` blocks are incredibly difficult to read. The **Fail-Fast** principle dictates that a function should immediately check for invalid conditions at the very top, and immediately exit or throw an error. This leaves the rest of the function flat, un-nested, and focused purely on the "happy path."

### 3. DRY vs WET
**DRY (Don't Repeat Yourself)**: If an intricate core business rule is duplicated in three places, and the rule changes, you have three places to update (and likely forget one). This must be abstracted.
**WET (Write Everything Twice)**: However, over-applying DRY to purely structural code leads to unreadable, highly-coupled spaghetti. A minor duplication of a structure is vastly preferable to a highly-abstracted, impossible-to-navigate shared utility.

### 4. Boy Scout Rule
"Always leave the campground cleaner than you found it." When you touch a file to add a feature, take responsibility for the immediate vicinity. Fix a poorly named variable, extract a massive function, or add a missing test. Incremental improvements prevent massive refactoring sprints.
