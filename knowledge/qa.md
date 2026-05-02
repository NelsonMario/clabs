# Quality Assurance: The Testing Philosophy

A suite of tests is not just a tool to catch bugs; it is the ultimate, living documentation of what the system is supposed to do. Our QA philosophy is governed by confidence, speed, and strict boundaries.

## The Testing Pyramid

### 1. Unit Testing (The Foundation)
Unit tests should comprise the vast majority (70%+) of your testing suite. They must execute in milliseconds. To achieve this, a unit test must test the pure **Domain Logic** in total isolation. 
If a function calculates a mortgage rate, the unit test passes various numbers in and checks the result. If the function needs to fetch a user profile from a database to do this, you **Mock** the database port. The unit test assumes the database works perfectly and focuses solely on whether the *math* is correct.

### 2. Integration Testing (The Adapters)
You mocked the database in your unit tests, but eventually, you need to prove your SQL queries actually work. This is the Integration Layer (20%).
These tests target your **Infrastructure Adapters** (Repositories, HTTP Clients). They spin up a real, temporary database, write data to it, and read it back. You do not test the complex mortgage math here; you strictly test whether the "Save Mortgage" SQL statement actually saves exactly what it was told to.

### 3. End-to-End Testing (The Peak)
E2E tests (10%) are slow, brittle, and expensive. They boot up the entire application—UI, Backend, Databases, Caches—and click through it exactly like a human user. 
Because they are expensive, you do not test edge-cases here. You test the "Critical Golden Paths." Can a user log in? Can a user perform the primary action of the application? 

## The Fallacy of 100% Coverage
Code coverage is a metric, not a goal. Chasing 100% coverage often leads to brittle tests that break every time you rename a variable, or tests that assert nothing of value just to execute lines of code. Test behaviors, not implementation details.
