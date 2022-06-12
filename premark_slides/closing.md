# Gradual Typing in Ruby

- I don't have personal experience with typing in Ruby, but did a bit of research on it.

- The most popular typechecker is Sorbet

    - Created by Stripe

- Sorbet can use both:

    - Inline annotations (e.g. `sig {params(x: Integer).returns(String)}`)

    - Separate `.rbi` files that complement the source code

---

# Other Python Typecheckers

- All differ from mypy in one important way: they try to make some inferences about untyped code

    - Thus, untyped modules may still raise errors

- Otherwise, they differ in leniency and interpretation of certain situations but are basically quite similar

- Big ones:

    - **Pyre** (Facebook)

    - **Pytype** (Google)

    - **Pyright** (Microsoft)

---

# Type Hints for Security

- Type hints can be used for static analysis of potential vulnerabilities

- Example: Starting in 3.11 (2022), Python will have a `LiteralString` type (PEP 675)

    - Helps disambiguate string literals from user inputs, values from a file, etc

    - Analysis tools can flag non-literal strings as "unsafe" in situations like SQL interpolation

- Good talk from Meta on using this in production with Pyre: https://youtu.be/nRt_xk2MGYU

---

# Python is Changing Fast

- In the last few Python versions, a lot of the new features are related to typing

    - This means that newer versions of Python can have more concise and descriptive annotations

- 3.10 introduced `int | float` syntax; improved old syntax:
    ```python
    Union[int, float]
    ```

- 3.9 made standard classes into generics, allowing `list[str]`; improved old syntax:
    ```python
    from typing import List
    List[str]
    ```

---

# Where Python is Going

- Large-scale Python projects are increasingly adding type hints, at least where feasible

    - Worth being familiar *at least* to read others' Python code

- The Python ecosystem is adding more support and convenience every year

- Libraries like FastAPI, Pydantic, and more are integrating typing in ways that make code simpler and more concise (and sometimes faster!)

---
class: center, middle

# Thanks!
## Questions?
