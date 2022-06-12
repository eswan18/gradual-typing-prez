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

    - **Pyre** -- Facebook

    - **Pytype** -- Google

    - **Pyright** -- Microsoft

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
