# Static Typing

- **Statically-typed languages** enforce rules about what values can be assigned to a given variable.

- More importantly, they are able to catch potential errors in source code by knowing the properties of the values involved.

  - If that sounds vague, that's okay -- more on this later

???

- This is a simple definition.
- Usually, the easiest way to think about what makes a language dynamic is that there are compile-time errors related to types.

---

# Static Typing
.flex[

.half-flex-container[
Typically, there is a mechanism for a programmer to specify the type of a variable when assigning to it.
```go
var x int = 7
```
]

.half-flex-container[
In most cases, assigning an object of a different type to that variable will fail.
```go
var x int = 7
x = "hello world"
```
.allow-wrap[
```text
./prog.go:9:6: cannot use "hello world" (untyped string constant) as int value in assignment
```
]
]

]

???

Typically but not always

Basically, the compiler is keeping you honest.


---

# Static Typing

- In statically-typed languages, function parameters and return values are generally typed as well.
    ```go
    func add(x float32, y float32) float32 {
          return x + y
    }
    ```

--

- This allows the compiler or interpreter to reason through the entire data flow, verifying that functions receive the expected inputs, and that their outputs are assigned to variables of the proper type.

    ```go
    var a float32 = 3.4
    var b float32 = 3.8

    var result string
    result = add(a, b)
    ```
    ```text
    ./prog.go:10:11: cannot use add(a, b) (value of type float32) as type string in assignment
    ```

???

Ultimately, this is the main point of static typing.

If the compiler knows all the types all (well, most) of the time, it can know at compile time whether your code will break because you passed an `int` to a function where a string was expected.

---

# Static Typing

- Some modern statically-typed languages don't require the programmer to explicitly describe the type of a variable if it can be determined from context; this process is called **type inference**

- However, this doesn't make them any less statically typed. Below, `x` is never marked as an `int` in the code but we still get the same error -- because the compiler knows it's an `int` based on its initial value
```go
var x = 7
x = "hello world"
```
```text
./prog.go:9:6: cannot use "hello world" (untyped string constant) as int value in assignment
```

???

My impression is that this is a feature of "modern" statically-typed languages.

Programmers don't want to be writing obvious types on variable declarations over and over.
If the compiler knows the type of the thing on the right, it can just assume that's the type of the variable.

---

# Types

- The idea of a "type" is somewhat abstract, but in practice it can usually be thought of as the *interface* of an object
  - That is: the set of accessible fields (and methods, in OO languages) guaranteed to be present on a given object
  - All classes are types under this definition, but there are types that aren't classes

- Many statically-typed languages support the idea of a **protocol** or **interface**, a set of functionality defined by the user that isn't linked to a particular instantiable class/struct.
  - e.g. Any object that supports a `read` method.


---

# Types

- The class/type distinction gets blurred when you ask for the "type" of an object -- usually you're asking for its parent class, or what kind of primitive it is

  - As opposed to what interfaces it implements

- Through introspection, some languages let you get this info at runtime (but some don't!)
```go
var x = 7
fmt.Printf("%T", x)
```
```
int
```

???

Good time to shout out untyped languages, like some shell languages. In bash everything is a string and it is very frustrating sometimes.

---

# Examples of Statically-typed Languages

- C, C++
- Java
- C#
- Go
- Haskell
- Swift

???

You will not be surprised to learn that this list isn't exhaustive.

Also, it's no coincidence that all but Haskell are mostly targeted at large, performance-sensitive application development.

---

# Perks of Static Typing

- Because the compiler knows the type of every variable throughout the code, it can raise **compile-time errors** when it detects the use a variable in an unsupported way.

  - e.g. a method/attribute is accessed that doesn't actually exist on the object

- This helps to catch bugs that might be hard to find with traditional testing approaches.

  - Conventional wisdom is that as applications grow larger, the presence of type metadata in the source code (along with the compiler's enforcemnt of it) is more and more valuable.

- The knowledge of types can also be used for other purposes too:
  - Tools that autogenerate documentation
  - Populating autocomplete in IDEs
  - Enabling compiler optimizations

???

There's probably more too.

Ultimately, my experience is that most static typing partisans value the compile-time errors the most.

Even among dynamic language users, the view that "large applications become very difficult without static type checking" is common.
