# From Dynamic to Static

- Static typing may be better for large projects, but dynamic typing makes it faster to get something working

- One pattern:
  1. Build a prototype in a dynamically-typed language
  2. Eventually rebuild the "production" version in a statically-typed one

---

# From Dynamic to Static

- Many languages have ways for developers to rewrite some bits but not others

- Several languages support interop with compiled C extensions

    - Some languages have specific toolchains for writing statically-typed code similar to "normal" language code that gets compiled into a C extension behind-the-scenes (e.g. Cython)

---

# From Dynamic to Static

- Even with partial rewrites, developers usually have to convert entire modules at a time, so the "lift" can be big

- They also have to change the code itself, which carries some risk; runtime behavior may change

---

# Gradual Typing

.flex[
.half-flex-container[
- The notion of combining untyped code with *some* type annotations is **gradual typing**.

- The idea is that types can be "gradually" added to a codebase, as needed

- Personally, I think of the "truly" gradually-typed languages as the ones that don't require any annotations at all if you don't want them
]
.half-flex-container[
```python
def add(x: int, y: int) -> int:
    return x + y

def subtract(x, y):
    return x - y

result = add(subtract(4, 3), 41)
print(result)
```

```text
42
```
]
]

???

Technically though, any language with a magical "dynamic" type that plays nice in all situations is gradually typed.

Silly, though -- you can't "gradually" do much unless you've already added that dynamic annotation to every variable.

---

# Gradual Typing with Precompilers

- There are some languages with dynamic typing built-in, but (to me) it seems like these are pretty uncommon

- A more common case is "precompilers" that convert and typecheck code before transpiling it down to a common dynamic language
    - TypeScript -> JavaScript
        - depending on compiler options, unannotated JS is valid TypeScript
    - Hack -> PHP

???

I also learned some things from the Wikipedia page.
- C# was originally static but now has a `dynamic` type.
- Raku (Perl 6) was designed for dynamic typing
- Dart is dynamically typed

---

# Gradual Typing with Typecheckers

- Another gradual typing implementation is a standalone **typechecker**, a separate program that validates the type annotations and does nothing else

- This is (necessarily) an entirely optional part of the workflow; it doesn't run code or produce a new source/executable file

- Some examples:

    - **mypy** (Python) -- reads inline annotations in Python source code

    - **Sorbet** (Ruby) -- reads separate RBI files that provide types for corresponding `.rb` files.

???

Since typecheckers don't *do* anything to the code, if types are embedded directly in it, the language needs to support the presence of type annotations even if it ignores them.

Note that Ruby 3 has introduced a new standard type file format, RBS. I haven't used it.

---

# The `Any` Type

- One key aspect of gradual typing is the presence of a special type, which I will call `Any`

- Objects of type `Any` are considered always-consistent, regardless of situation.

- Typecheckers allow:

    - Calls to any method or accesses of any attribute on `Any` objects

    - Objects of type `Any` to be passed to any function and assigned to any variable

---

# The `Any` Type

To a gradual typechecker, this code raises no errors.


```python
def dostuff(x: Any, y: Any) -> int:
    x = x.lower()
    x = x + y
    return x ** 2

dostuff(True, False)
```
- addition, `.lower()`, and powers are all valid on `Any` objects

- `x ** 2` can be returned where an `int` is expected because it's of type `Any`

- Passing `True` into a function expecting `Any` is allowed

---

# The `Any` Type

- The presence of `Any` is vital for gradual typing because it can be applied to all unannotated code, and that code will necessarily be valid.

- This means that code without annotations is fine; only annotated code can result in typing errors.

    - In this way, a codebase can be *gradually* typed as annotations are added to more and more files.

- Luciano Ramalho's *Fluent Python* provides an excellent explanation of this topic.

---

# Gradual Typing in Python

- Since version 3.0 (2008), Python has supported inline annotations for variables and functions

    - Not specifically for the purpose of typing, but now that's how they're usually used

- The Python interpreter itself basically ignores these annotations

    - The idea is that static analysis tools, or third party libraries, can use the annotations to reason about code

---

# Gradual Typing in Python

- Today, annotations are almost exclusively used to denote types

```python
def multiply(n1: int | float, n2: int | float) -> int | float:
    result = n1 * n2
    return result

x: int = 5
y: float = 3.4
product: int | float = multiply(x, y)
```

---

# Mypy

- Mypy is the most popular typechecker in Python

    - There are others, which come with different tradeoffs

- It's run as an independent executable -- not as part of running the program

.flex[
.half-flex-container[
```python
# concat.py
def concat(s1: str, s2: str) -> str:
    return s1 + ' ' + s2

concat('abc', 'def')
```
```text
$ mypy concat.py

Success: no issues found in 1 source file
```
]
.half-flex-container[
```python
# concat.py
def concat(s1: str, s2: str) -> str:
    return s1 + ' ' + s2

concat('abc', 7)
```
.allow-wrap[
```text
$ mypy concat.py

concat.py:4: error: Argument 2 to "concat" has incompatible type "int"; expected "str"
Found 1 error in 1 file (checked 1 source file)
```
]
]
]

---

# Mypy

.flex[
.half-flex-container[
- Python itself runs the code as if there were no annotations at all
- So ... this is valid Python and will run without warning or error
- In this case, the methods and operators are all valid **at runtime** despite their clash with the annotations
]
.half-flex-container[
```python
# mystify.py

def mystify(x: float, y: float) -> bool:
    return x.upper()

result: int = mystify('abc', 'def')
print(result)
```
```text
$ python mystify.py

ABC
```
]
]

---

# Mypy

.flex[
.half-flex-container[
- Mypy, however, isn't happy
]
.half-flex-container[
```python
# mystify.py

def mystify(x: float, y: float) -> bool:
    return x.upper()

result: int = mystify('abc', 'def')
print(result)
```
]
]

```text
$ mypy mystify.py

test.py:2: error: "float" has no attribute "upper"
test.py:3: error: Argument 1 to "mystify" has incompatible type "str"; expected "float"
test.py:3: error: Argument 2 to "mystify" has incompatible type "str"; expected "float"
Found 3 errors in 1 file (checked 1 source file)
```

---

# Gradual Typing in Ruby

- I don't have personal experience with typing in Ruby, but did a bit of research on it

- The most popular typechecker is Sorbet

    - Created by Stripe

- Sorbet can use both:

    - Inline annotations (e.g. `sig {params(x: Integer).returns(String)}`)

    - Separate `.rbi` files that complement the source code
