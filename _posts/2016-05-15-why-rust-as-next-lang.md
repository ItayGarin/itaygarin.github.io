---
layout: post
title:  "Why I Picked Rust as my next Programming Language"
categories: Rust
featured: false
comments: true
---

and why you should give it a try as well!

<!--more-->

## Prologue

It's no secret that I like to try out new technologies.

I find it to be very entertaining and exciting.
Moreover, it feeds my everlasting hunger to learn and explore new things.

The spectrum of things I like to try is quite large. It includes anything from Emacs plugins to Linux Distros.

It explains why I naturally tend to keep up with the latest trends in the field.

But, If had to name the one I like to explore the most, it would have to be programming languages.

Aside from sheer entertainment, I love the way it lets me broaden my perspective. 
That comes very handy when tackling demanding and complex programming challenges.

To maximize that aspect, I strive to uncover and extract the underlying opinionated view of the language author(s). 

I believe this methodology propels me forward as a software developer.
As the famous quote goes - *"Growth begins at the end of your comfort zone"*.

Thus, when looking for a new language, I always start by searching for a paradigm shift.
That can literally manifest as a different programming paradigm, but it might also be a unique way of approaching things.

Clojure, which I've previously delved into, is a good example of the former. 
It was my first attempt at a proper functional language.
I learned so much from it, and it was a real joy.

Rust is a solid example of the latter.
It has a unique way of hermetically dealing with memory safety, 
while letting you maintain full control of the bits and bytes.

## What I was looking for

Currently, I'm mostly making use of C and Python for my daily work.
These complement my "low-level" specialty beautifully.

I'm very comfortable with both of these languages, and I appreciate them for what they are.

C has an incredible what-you-see-is-what-you-get kind of style.
This, coupled with the simple and intuitive syntax creates a delightful package.

This combo leaves tiny room for guessing.
But, it goes even deeper than this.

Once you familiarize yourself with the inner-workings of the target platform (assembly, calling conventions, ABI, etc...), it gets even sweeter. 

Your brain turns into a "virtual compiler" that allows you to envision in real-time what your code will eventually turn into.
This is very powerful indeed.

Alas, C has significant downsides as well.

The wonderful simplicity comes at a high cost of expressiveness and power.
Modern features such as lambdas, generics, iterators, lazy evaluations and powerful macros are nowhere to be found.

Additionally, when compared to the newer rivals, C's age becomes very apparent.
This is especially true when observing the package management support.

Out-of-the-box package managers are a norm with almost all new languages.
In my opinion, that's a crucial standard that should be ubiquitous.

Honestly, there are times when the lack of such a manager in C makes me a bit jealous.

In my experience, what usually ends up happening is one of two unfortunate scenarios.

Either the individual takes it upon himself to implement the functionality,
or he grabs an open source implementation in an ad-hoc manner.

Coming from Clojure, this disadvantage was quite hard to ignore. 
So of course, I started looking for a new modern systems programming language.

## The Hottest Systems Programming Languages 

Aside from the educational aspect, I wanted a practical language.
That's why I began by narrowing down the options based on their adoption rate and popularity.

I came up with this short list -

* Rust
* Nim
* Go
* D

Although Go and D are the most mature and popular out of the bunch, they were dropped quite early on.

### Why I dropped Go

Go was dropped for several reasons. 
Feature-wise, it seemed quite lacking when compared to the others.
I believe that's because the authors tried to capture C's spirit.
As I mentioned before, simplicity can be a big win at certain situations, but I was looking for something more powerful.

Plus, it has mandatory garbage collection.
This certainly improves productivity, but it goes against my taste in systems programming languages.

That's mainly because I often find myself compiling to bare-metal targets.
As you can probably imagine, garbage collection doesn't work well on this platforms, and in real-time tasks in general.

Also, it impairs the language's ability to provide a proper foreign function interface (FFI).

### Why I dropped D

Honestly, D was dropped for coincidental reasons.

It is certainly the most adopted of the lot, but for some reason, it doesn't feel that way.

I ended up totally forgetting and neglecting it in my search. 

Maybe that's because people rarely mention it. Maybe because it never reaches pops up on Hackernews.
Who knows...

## Nim vs Rust

Amusingly, I initially picked up Nim.

Its python-like syntax and the fact that it compiled down to C attracted me.
It's probably no wonder since those are my beloved and trusty languages.

But, the honeymoon phase didn't last long.

Nim was too young and immature when I tried it.
This, Coupled with the fact that there's only a single person that does all the development makes it quite a shady bet.

Truthfully, my attitude here goes against the [FOSS]() spirit. That is, adapt early and contribute where you can.
This is usually not how I approach these things, but practicality and maturity were qualifying criteria here.

Nim's immaturity was apparent in multiple aspects.
The docs and learning resources were very lacking,
The library selection was quite minimal,
and the Emacs integration was very bare-bone.

That's quite unfortunate because apart from the garbage collection situation, I really liked Nim as a language.
It seems like a very productive language, and the feature-set is impressive.
Moreover, the community looks very friendly.

For now, I'll defer my Nim conquest to a later date.

I'll probably give it another go once it reaches a stable major version.
Stay tuned for that :)

## Rust is the Winner

By the process of elimination, I was left with Rust.

I initially picked Nim over Rust only because it seemed like I'd be more productive with it.
Of course, I looked over the fact that Nim has a garbage-collector.
The GC looked quite flexible and promised soft real-time performance.

But, even though that was my first choice, Rust had very appealing points as well.
The safety guarantees, the functional spirit, and the superb community almost won me over.

So I'm glad things turned the way they did. I'm glad I abandoned Nim and gave Rust an honest shot.
It truly surprised me, and It turned out to be better than what I expected.

Besides passing all my search criteria with flying colors, it also provided the satisfying paradigm shift I was looking for.

The way Rust handles its safety guarantees is absolutely genius.
Once you get over the initial compiler frustrations, 
it becomes very apparent how powerful the Ownership+Borrow+Lifetimes trifecta is.

These semantics completely eliminate huge classes of bugs.
No more segfaults. No more dangling pointer. No more data races. No more use after frees.
Amazing!

Plus, you get tons of awesome features for free.
Lazy iterators, pattern matching, traits system, type inference, real macros and much more.

## Epilogue

To conclude, I'd have to admit that if I'd known what I know today, 
I would have immediately picked up Rust without thinking twice.

The community is absolutely wonderful.
It's awesome to see how friendly everyone is.

Plus, the continuous progress Rust is making is incredible.
It makes you wonder how good it'll get, and how it'll look like in a few years.

If you are looking for a new systems language, or want to dip your toes in the "low-level" realm,
I strongly encourage you to give Rust a try.
