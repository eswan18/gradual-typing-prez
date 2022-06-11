# Dynamic Typing

- **Dynamically-typed languages** don't worry about types until runtime.

- They *usually* don't support any type annotations

---

# Dynamic Typing

- With dynamic typing, reassigning a value of a different type to a variable is totally fine.
```python
x = 7
# No error
x = "hello world"
```

---

# Dynamic Typing

- The compiler/interpreter knows nothing about the types until runtime.

- It just executes the code and if works, it works!

    - If it discovers the value doesn't support a requested method or attribute that it needs, *then* it complains.

<br>

```python
x = 7
# .upper() is a method of strings
x.upper()
```
```text
AttributeError: 'int' object has no attribute 'upper'
```

---

# Dynamic Typing

- Even obviously-incorrect code, if within an as-yet-unexecuted function, causes no errors:
```python
    def capitalize_seven():
        x = 7
        return x.upper()
```

---

# Duck Typing

- A popular but somewhat contentious approach among dynamic typing users is **duck typing**.

- If it looks like a duck and quacks like a duck, (pretend that) it's a duck.

---

# Duck Typing

.flex[
.half-flex-container[
- If the data types involved support the operations you call on them (like addition, or a method, etc.), then assume everything is okay. 
- Why? Allows users to create new types that adhere to an implicit protocol, such as by overriding the `+` operator to "act like" a string.
]
.half-flex-container[
```python
def add(x, y):
    return x + y
```
<br>
```python
add(1, 4)
```
```text
5
```
```python
add("hello", " world")
```
```text
"hello world"
```
]
]

---

# Duck Typing

- The primary recommendation of duck typing is not to explicity check the types of things

- Sometimes abbreviated **EAFP** -- easier to ask *forgiveness* than *permission*

```python
def raise_to_power(base, power):
    if not isinstance(base, (float, int)):
        raise Exception
    if not isinstance(base, (float, int)):
        raise Exception
    return base ** power
```

--

- Explicit type checks make for lots of additional verbosity

- Also, this function will error on complex numbers, user-defined numeric types, and more

    - Duck typing enthusiasts would say you should just try to do the operations and see what happens

---

# Dynamic Typing

- Dynamic languages usually offer **introspection**, so you can determine the type of a value if you need to.
```python
x = 7
type(x)
```
```text
int
```

- And you likely *do* need to, often. Even diehard followers of duck typing still sometimes program defensively, particularly if their code is used by others.
  - Without the enforcement of types by the compiler, users could pass in absolutely anything to your functions.

---

# Some Dynamically-typed Languages

- JavaScript
- Python
- Ruby
- PHP
- Perl

---

# Perks of Dynamic Typing

- Less verbose; no types listed in code

- Faster development in early stages of project

  - Debatable if it's still faster as codebases get larger

- Avoids a whole class of complexity for users -- things like unions, generics, bounds, protocols

  - Simpler for new developers, especially those coming from other fields

  - Consider the popularity of R and Python in data science, both dynamically-typed

---

# Related: Strong vs Weak Typing

- **Strong typing** and **weak typing** are sometimes used synonymously with static and dynamic typing, but more commonly (arguably *properly*) refer to something else: how often and silently values are coerced to other types (and are also a spectrum).

- From Wikipedia:
> A weakly typed language has looser typing rules and may produce unpredictable or even erroneous results or may perform implicit type conversion at runtime.


---

# Related: Strong vs Weak Typing

- C is statically-typed but pretty weak:
```c
char c = 'a';
int x = 7;
# No complaints from the C compiler, but uh....
int result = x + c;
```

- Python is dynamically-typed but fairly strong:
```python
c = "a"
x = 7
result = x + c
```
```text
TypeError: unsupported operand type(s) for +: 'int' and 'str'
```
