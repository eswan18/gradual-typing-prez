# Dynamic Typing

- **Dynamically-typed languages** don't worry about types until runtime.

- They usually don't support a way to annotate variables with types.

- They usually don't allow function parameters and return values to be typed.

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

- The compiler/interpreter knows nothing about the types of values in the code until runtime. It just executes the code and if it discovers the value doesn't have a method or attribute that it needs, *then* it complains.
```python
x = 7
# .upper() is a method of strings
x.upper()
```
```text
AttributeError: 'int' object has no attribute 'upper'
```

--

- For example, even obviously-incorrect code, if within an as-yet-unexecuted function, causes no errors:
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

- If the data types involved support the operations you call on them (like addition, or a method, etc.), then assume everything is okay. 
```python
    def add(x, y):
        return x + y
```
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

--

- Why? Allows users to create new types that adhere to an implicit protocol, such as by overriding the `+` operator to "act like" a string.

---

# Dynamic Typing

- All the dynamic languages I'm aware of offer introspection, so you can determine the type of a value if you need to.
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

# Examples of Dynamically-typed Languages

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

- Avoids a whole class of complexity -- things like unions, generics, bounds, protocols

  - Simpler for new developers, especially those coming from other fields

  - Consider the popularity of R and Python in data science, both dynamically-typed

---

# Some Other Points on Typing

- Static and dynamic typing are opposites, but there is something of a spectrum -- some statically-typed languages are stricter than others

---

# Some Other Points on Typing

- **Strong typing** and **weak typing** are often used as synonymous with static and dynamic typing, but my understanding is that they more properly refer to something else: how often and silently values are coerced to other types (and are also a spectrum).

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
x + c
```
```text
TypeError: unsupported operand type(s) for +: 'int' and 'str'
```
