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

- The notion of combining untyped code with *some* type annotations is **gradual typing**.

```python
def add(x: int, y: int) -> int:
    return x + y

def subtract(x, y):
    return x - y

result = add(subtract(4, 3), 41)
print(result)
```
- The idea is that types can be "gradually" added to a codebase, as needed

- I think of the "truly" gradually-typed languages as the ones that don't require any annotations at all if you don't want them -- though that's not the precise definition

???

Technically though, any language with a magical "dynamic" type that plays nice in all situations is gradually typed.

Silly, though -- you can't "gradually" do much unless you've already added that dynamic annotation to every variable.

---

# Gradual Typing with Precompilers

- There are some languages with dynamic typing built-in, but (to me) it seems like these are pretty uncommon

- A more common case is "precompilers" that convert and typecheck code before transpiling it down to a common dynamic language
    - TypeScript (with certain compiler options, plain JS is valid), compiles to JavaScript
    - Hack, compiles to PHP

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

# Mypy

- Mypy is fairly mature and a good example of a typechecker

- Takes advantage of Python's "annotation" syntax, which the Python interpreter ignores entirely

```python
def concat(s1: str, s2: str) -> str:
    return s1 + ' ' + s2
```

--

- Because Python itself ignores these annotations, they don't help at runtime. This is valid Python and will run without warning or error

```python
def mystify(x: float, y: float) -> bool:
    return x.upper()

result: int = mystify('abc', 'def')
```

- Python runs the code as if there were no annotations at all