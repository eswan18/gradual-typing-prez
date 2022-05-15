# Static Typing

- **Statically-typed languages** enforce rules about what values can be assigned to a given variable.
- Typically, there is a mechanism for a programmer to specify the type of a variable when assigning to it.
```go
var x int = 7
```

--

- In most cases, assigning an object of a different type to that variable will fail.
```go
var x int = 7
x = "hello world"
```
```text
./prog.go:9:6: cannot use "hello world" (untyped string constant) as int value in assignment
```

- *(Subtypes are an exception to this rule.)*

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

---

# Types

- The idea of a "type" is somewhat abstract and an entire subject unto itself (see **Type Theory**), but in practice it can usually be thought of as the set of fields (and methods, in OO languages) that define a certain class of objects
  - In fact, the distinction between *class* and *type* can be pretty fuzzy in languages with classes.

- So... a struct definition is a type, a class is a type, built-in primitives are types.

- Many statically-typed languages support the idea of a **protocol** or **interface**, a set of functionality defined by the user that isn't linked to a particular instantiable class/struct.
  - e.g. Any object that supports a `read` method.

---

# Types

- Every value has a type (in most languages), and if the language supports introspection it may be possible to determine at runtime.
```go
var x = 7
fmt.Printf("%T", x)
```
```
int
```

---

# Perks of Static Typing

- Because the compiler knows the type of every variable throughout the code, it can raise **compile-time errors** when it detects the use a variable in an unsupported way.

  - e.g. a method/attribute is accessed that doesn't actually exist on the object

- This helps to catch bugs that might be hard to find with traditional testing approaches.

  - Conventional wisdom is that as applications grow larger, the presence of type metadata in the source code (along with the compiler's enforcemnt of it) is more and more valuable.

- The knowledge of types can also be used for things like autogenerating documentation and populating autocomplete in IDEs.
