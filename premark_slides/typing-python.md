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

# `Union` and `Optional`

- **Unions** describe the idea that an object can be either of two or more types

    - This parameter will be an integer, float, or complex number

    - Expressed with the pipe operator: `int | float | complex`

        - Prior to Python 3.10 (2022): `Union[int, float, complex]`

- **Optional** types allow for the object to be None

    - Either an integer or `None`

    - Written: `Optional[int]` (synonymous with `int | None`)

- Both `Optional` and `Union` must be imported from the built-in `typing` library 

---

# `Union` and `Optional`

```python
from typing import Optional

def at_position(word: str | bytes, position: int) -> Optional[str | bytes]:
    if position >= len(word):
        return None
    else:
        return word[position]
```

---

# Common Containers

- Most container objects native to Python are **generic**

- This means that they can be annotated based on the types they contain

---

# Common Containers

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

# Protocols and Abstract Base Classes

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

# Protocols and Abstract Base Classes

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
    - Expect no errors here, except configuration issues
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

Prioritize typing in modules that are common sources of bugs. This is where they'll have the biggest impact.

---

# Libraries That Use Type Hints at Runtime

- While Python and its standard library typically ignore type annotations at runtime, some third party tools make use of them

- Notable examples are **Pydantic** and **FastAPI**

    - These are both handy enough to justify knowing a bit about type hints *even* if you don't intend to typecheck your code

---

# Pydantic

**Pydantic** is a library for modeling json-like schemas with type validation

```python
from pydantic import BaseModel

class User(BaseModel):
    id: int
    email: str
    password: str
    linked_accts: list[str]
```

--

```python
u = User(id=123, email='abc@example.com', password='abc', linked_accts='def@example.com')
```
```text
pydantic.error_wrappers.ValidationError: 1 validation error for User
linked_accts
  value is not a valid list (type=type_error.list)
```

---

# FastAPI

- FastAPI is a relatively new API library in Python

    - Quickly gaining adoption; generally considered the best option for new APIs

- Does type validation on its input parameters; automatically returns errors if inputs are invalid
    
    - No user-written validation code needed

---

# FastAPI

```python
@app.get('/item/')
def get_items(min_price: float, max_price: float, category: str | None = None) -> list[Item]:
    result = []
    for item in get_all_items():
        if item.category == category or category is None:
            if min_price <= item.price <= max_price:
                result.append(item)
    return result
```
```python
requests.get('https://example.com/item', json={'min_price': 34.00, 'max_price': 42.42})
```
```text
<Response[200]>
```

---

# FastAPI

- FastAPI also integrates Pydantic, so parameters can be Pydantic models

.flex[
.half-flex-container[
```python
class User(BaseModel):
    id: int
    email: str
    linked_accts: list[str]

class UserIn(User):
    password: str

class UserOut(User):
    ...

@app.post('/user/', response_model=UserOut)
def create_user(user: UserIn) -> UserOut:
    db.add_user(user)
    # Return val will be coerced to UserOut
    # (so no password returned)
    return user
```
]
.half-flex-container[
```python
requests.post(
    'https://example.com/user',
    json={
        'id': '123',
        'email': 'me@me.com',
        'password': 'abc',
        'linked_accts': ['person@me.com'],
    }
)
```
]
]
