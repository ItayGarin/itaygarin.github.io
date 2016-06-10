---
layout: post
title: "Rust vs C/C++ Pitfalls"
categories: Rust
featured: false
comments: true
---

It's much harder to shot yourself in the foot with Rust :)

<!--more-->

-------------------------------------------------------------------------------

<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-generate-toc again -->
**Table of Contents**

- [Intro](#intro)
- [100% Safe](#100-safe)
- [The Pitfalls](#the-pitfalls)
    - [NULL Dereference](#null-dereference)
    - [Use After Free](#use-after-free)
    - [Returning Dangling Pointers](#returning-dangling-pointers)
    - [Integer Overflows (and Underflows)](#integer-overflows-and-underflows)
    - [Out Of Bounds Access](#out-of-bounds-access)
- [Conclusion](#conclusion)

<!-- markdown-toc end -->

# Intro

Rust is really growing on me.
The more I use it, the more I want to use it!

So I've decided to demonstrate its awesomeness to my co-workers.

Doing that has several benefits -

1. It'll improve the quality and robustness of our future products. 
2. Teaching Rust will be a great learning opportunity for me.
3. I enjoy discussing and presenting new technologies :)

For us, Rust's biggest selling point is its safety guarantees.
It's a significant advantage over C/C++ (which we're writing daily).
It's also the core idea that makes Rust such a unique language.
So that's what I'll be focusing on in my talk.

I figured that the best strategy to present this merit would be to show my colleagues how
Rust will make their daily work easier and more enjoyable.

Specifically, demonstrating how Rust completely eliminates many pitfalls
that are inherent to C and C++.
That promise, combined with its modern features, yields an ergonomic experience
with much fewer bugs to tackle.

(*Also, I suspect that these safety guarantees contribute to a much better night's sleep*).

I believe that the material I've prepared for the talk will be useful to others.
Hopefully, it'll motivate more developers to make the transition.

# 100% Safe

Before diving into the examples, it's important to explain how [Rust approaches safety](https://doc.rust-lang.org/nomicon/meet-safe-and-unsafe.html).

In Rust, most of the code that's written is called ["safe" code](https://doc.rust-lang.org/nomicon/meet-safe-and-unsafe.html).
"Safe" code is **guaranteed** to be **100% safe**. Not statistically safe. Not safe when the compiler feels like it.
As long as your code compiles, it will be safe in terms of memory safety and data-race freedom.

If you somehow manage to break these guarantees, please [file a bug report](https://github.com/rust-lang/rust/blob/master/CONTRIBUTING.md)!

Of course, these measures won't prevent you from introducing logic errors. 
You are still fully responsible for those.

With that said, there are rare occasions when it's appropriate to break these rules.
For those occasions, Rust allows you to write ["unsafe" code](https://doc.rust-lang.org/nomicon/meet-safe-and-unsafe.html).
With "unsafe" code you gain much more low-level control. You can do pretty much whatever you want.
However, this comes with a price. It means that the compiler will no longer protect you, and hell can break loose.

![with-great-power-comes-a-great-responsibility](https://cdn.meme.am/instances/500x/64050332.jpg)

# The Pitfalls

## NULL Dereference

The infamous [Segmentation Fault](https://en.wikipedia.org/wiki/Segmentation_fault) error is a common sight in the realm of C and C++.
If I had to guess, I'd say that [NULL dereferences](https://www.owasp.org/index.php/Null_Dereference) are the number one cause of these faults.

Dereferencing NULL usually happens when you forget to check the validity of a returned pointer - 

### C/C++

```c
uint8_t* pointer = (uint8_t*) malloc(SIZE); // Might return NULL
for(int i = 0 ; i < SIZE ; ++i) {
    pointer[i] = i; // Might cause a Segmentation Fault
}
``` 

Rust's method of dealing with these pointer errors is extreme.
It simply **forbids** the use of raw pointers in "safe" code.
Additionally, it eliminates the null value from "safe" code.

But, you shouldn't worry. There's an elegant alternative.
Instead of pointers, Rust allows you to [borrow references](https://doc.rust-lang.org/book/references-and-borrowing.html) to variables.
Under the hood, these references are essentially the same good old pointers. 
But, they are made safe with the [Lifetimes](https://doc.rust-lang.org/book/lifetimes.html) and [Borrowing](https://doc.rust-lang.org/book/references-and-borrowing.html) rules.

### Rust

```rust
let my_var: u32 = 42;
let my_ref: &u32 = &my_var; // <-- This is a reference. References ALWAYS point to valid data!
let my_var2 = *my_ref; // <-- An example for a Dereference. 
```

## Use After Free

One often hears about the "[User After Free](https://www.owasp.org/index.php/Using_freed_memory)" pitfall through news about exploits in the wild.
That's because it can be a serious vulnerability that might allow attackers to execute arbitrary code 
through your executable.

Here's a simple example of user after free in C -

### C/C++

```c
uint8_t* pointer = (uint8_t*) malloc(SIZE);

...

if (err) {
  abort = 1;
  free(pointer);
}

...

if (abort) {
  logError("operation aborted before commit", pointer);
}

// 
//
``` 

The Rust solution here will be intuitive to C++ developers.
It uses the [RAII](https://en.wikipedia.org/wiki/Resource_Acquisition_Is_Initialization) approach everywhere (Resources Acquisition Is Initialization).

This means that the [lifetime](https://doc.rust-lang.org/book/lifetimes.html) of a variable is defined in terms of its **scope**.
i.e Every variable is deterministically freed when it goes out of scope (= a pair of curly braces).
So with "safe" Rust, you NEVER need to worry about freeing memory.

### Rust

```rust 
fn foo() {
    let staying_alive = 42;
    ^
    |
    | a lifetime
    |
    |
    V
} // `staying_alive` will be freed once we get here
``` 

```rust 
fn bar() {
    let foobar = 0;
    {
      let staying_alive = 42;
      ^
      |
      | another lifetime
      |
      |
      V
    } // `staying_alive` will be freed once we get here
    
    println!("foobar = {}", foobar);
} 
``` 

But Rust doesn't stop there. It goes a crucial step further.
In Rust, the compiler is fully aware of these lifetimes.
It won't let you access memory that was freed!

```rust 
fn bar() {
    let foobar = 0;
    {
        let staying_alive = 42;
    }
    println!("staying_alive = {}", staying_alive);
}

// main.rs:16:36: 16:49 error: unresolved name `staying_alive` [E0425]
// main.rs:16     println!("staying_alive = {}", staying_alive);
//                                               ^~~~~~~~~~~~~
``` 

## Returning Dangling Pointers

Seasoned C/C++ programs know that returning a pointer to a stack-bound variable is bad.
By the time it gets to the caller, the stack frame will be long gone.
Thus, the returned pointer will point to undefined memory.

To be fair, this mistake is more prevalent in the code of junior developers.
Once you internalize the concept of stack mechanics and calling convention, 
making this error will become very unlikely.

Here's an example in C -

### C/C++

```c
uint8_t* get_dangling_pointer(void) {
    uint8_t array[4] = {0};
    return &array[0];
}

// Returns a dangling pointer to a previously stack allocated memory
``` 

### Rust

As it turns out, Rust's [lifetime](https://doc.rust-lang.org/book/lifetimes.html) checks apply to more than just locally defined variables.
They also apply to returned values. 

In contrast to C and C++, when returning a reference, the Rust compiler makes sure that it will remain valid when it finally reaches the caller.
i.e., the compiler verifies that the returned reference will **live** long enough.
Thus, it can be said that Rust references ALWAYS point to valid memory.

```rust
fn get_dangling_pointer() -> &u8 {
    let array = [0; 4];
    &array[0]
}

// main.rs:1:30: 1:33 error: missing lifetime specifier [E0106]
// main.rs:1 fn get_dangling_pointer() -> &u8 {
//                                        ^~~
```

To keep this post somewhat short. I won't dive into the intricacies that make this work.
But, it's worth mentioning that managing lifetimes mostly happens in the background.
Though, sometimes, the compiler won't be able to automatically infer the lifetime of a returned reference.
In those cases, you'll have to specify the lifetime explicitly.

```rust
fn get_static_string() -> &'static str {
    "I'm a static string!"
}

// This works because we are returning a string with a `static` lifetime.
// A static lifetime simply means that it'll live for the entire duration of the program
```

## Integer Overflows (and Underflows)

It is safe to assume that most C/C++ developers had to deal with an integer overflow caused bug at least once.
It's very easy to introduce, and can smoothly slip under the code-review "radar".

For those who've never heard of this phenomenon, here's a short explanation.
An [Integer Overflow](https://en.wikipedia.org/wiki/Integer_overflow) occurs when an arithmetic operation attempts to create a numeric value that is too large to be represented within the available storage space.

For example, in C/C++,  
if we'd attempt to return 256 via an 8-bit register, we'd actually end up returning 0.

### C/C++

```c
uint8_t overflows(void) {
    return 255 + 1;
} 

// returns 0
``` 

Rust, being the safe language that it is, flags this behavior as erroneous.
i.e it treats integer overflows and underflows as bugs.

Thus, to ward off this incidental behavior, the Rust team employed run-time checks on integer types.
If the check fails, a "[panic](https://doc.rust-lang.org/std/macro.panic!.html)" is triggered, and the program will be aborted.

### Rust

```rust
fn overflow_panics() -> u8 {
    255 + 1
}

// thread '<main>' panicked at 'arithmetic operation overflowed', main.rs:2
``` 

## Out Of Bounds Access

### C/C++

Another very common pitfall is accessing memory that isn't owned by you.
More often than not, that simply means accessing an array with an index that's out of range.
This applies to read and write operations alike.

Like the "Use After Free" pitfall, accessing out-of-bounds memory can introduce nasty vulnerabilities into your executable.
Again, these vulnerabilities might allow an attacker to execute arbitrary code on your client's computer (see Buffer Overflows).

Probably the most well-known out-of-bounds access vulnerability in recent times is [Heartbleed](https://en.wikipedia.org/wiki/Heartbleed).
Check out this article - [Would Rust have prevented Heartbleed? Another look](https://tonyarcieri.com/would-rust-have-prevented-heartbleed-another-look)

Here's a simple<sup>*</sup> example that illustrates this bug.

```c
void print_out_of_bounds(void) {
    uint8_t array[4] = {0};
    printf("%u\r\n", array[4]);
}

// prints memory that's outside `array` (on the stack)
``` 

\* *it's worth mentioning that in most cases, this bug will manifest in much less obvious ways*

### Rust

Again, Rust makes use of run-time checks to mitigate this unwanted behavior.
I must admit, this non-glamorous feature put a smile on my face the first time I stumbled upon it.

Here's the same example in Rust -
  
```rust
fn print_panics() {
    let array = [0; 4];
    println!("{}", array[4]);
}

// thread '<main>' panicked at 'index out of bounds: the len is 4 but the index is 4', main.rs:3
```

# Conclusion

At the moment, Rust looks like a very promising language. 

In this article, I've only provided a small glimpse into the many measures Rust takes to protect you from yourself.
These measures were meticulously refined so that you'll be able to enjoy an ergonomic developing experience while not giving into the obvious garbage collection solution.

In fact, these safety guarantees go a step above the conventional GC, along with memory safety they also provide a data-race freedom.
I'll leave the data race aspect to a later blog post.

I strongly encourage you to try out [Rust](https://www.rust-lang.org/).
The [official book](https://doc.rust-lang.org/book/) is completely free so there are no excuses.