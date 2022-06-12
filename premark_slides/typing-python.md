# Overview

- If you've written untyped Python already, adding types is pretty straightforward

- Mypy's type inference for variables is generally reliable, so the place to start is annotating functions

- Parameter types go after the parameter name, separated by a colon

- Return value types are added after an arrow (`->`)

```python
def read_data(filename: str) -> str:
    with open(filename) as f:
        contents = f.read()
    return contents.strip()
```

---

# Overview: `Union` and `Optional`

- **Unions** describe the idea that an object can be either of two or more types

    - This parameter will be an integer, float, or complex number

    - Expressed with the pipe operator: `int | float | complex`

        - Prior to Python 3.10 (2022): `Union[int, float, complex]`

- **Optional** types allow for the object to be None

    - Either an integer or `None`

    - Written: `Optional[int]`

    - This is synonymous with `int | None`

- Both `Optional` and `Union` must be imported from the built-in `typing` library to be used

    - This is common with special type annotations; they're not in the global namespace by default

---

# Overview: `Union` and `Optional`

```python
from typing import Optional

def at_position(word: str | bytes, position: int) -> Optional[str | bytes]:
    if position >= len(word):
        return None
    else:
        return word[position]
```

---

# Overview: Common Containers

- Most container objects native to Python are **generic**

- This means that they can be annotated based on the types they contain

---

# Overview: Common Containers

A list of integers: `list[int]`
```python
def avg(numbers: list[int]) -> int:
    ...
```
<br>
A dictionary of strings that map to booleans: `dict[str, bool]`
```python
def sort_by_state(zips: list[str], zip_to_state_lkp: dict[str, str]) -> list[str]:
    ...
```
<br>
A set of strings: `set[str]`
```python
def uniq_values(list[str | bytes]) -> set[str | bytes]:
    ...
```

---

# Overview: Protocols and ABCs

- Sometimes you want to accept any object that implements certain methods and/or attributes

- Perhaps your function expects any object that can be iterated over:

```python
from typing import Iterable

def index_of_max(numbers: Iterable[float]) -> int:
    max = None
    max_index = None
    for idx, n in enumberate(numbers):
        if n > max or max is None:
            max = n
            max_index = idx
    return max_idx
```

---

# Overview: Protocols and ABCs

- There are lots of existing protocols and abstract base classes in the standard library, but you can also build your own.

- Say you want to accept any object with a `.lower()` method

```python
from typing import Any, Protocol


class SupportsLower:

    def lower(self): ...


def lowercase_all(inputs: list[SupportLower]) -> list[Any]:
    return [i.lower() for i in inputs]
```

---

# Getting Started with Existing Codebase

A good approach:

1. Run mypy on the code: `mypy <foldername>`
    - Expect no errors here, except things like imports that weren't found
2. Pick a function and add annotations to its parameters and return value.
3. Run mypy. Fix any errors.
4. Return to step 2 and repeat, until all functions in the code are typed.

---

# Some Tips

While you'll discover potential bugs, you will occasionally find false positives -- cases where mypy sees an error in a place you know it's impossible
- In these cases, it's okay to use `cast` or the `# type: ignore` comment to silence mypy

In situations where annotations are very complicated (e.g. generics), don't feel like you need to type everything perfectly. Evaluate whether the juice is worth the squeeze.
- Python is a dynamically typed language and you can't make it a statically typed one. Don't fight the language if it's not worth the effort.
- Feel free to use `Any` in situations like this to placate the type checker and trust the runtime behavior.

Prioritize typing in modules that are common sources of bugs. This is where they'll hve the biggest impact.
