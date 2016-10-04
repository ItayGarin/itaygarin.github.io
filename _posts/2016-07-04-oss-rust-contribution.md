---
layout: post
title: "Picking a Rust Project to Contribute to"
featured: false
comments: true
---

In this post, I elaborate on how I selected an open-source Rust project to contribute to.
I'll be documenting my thought process and my method for comparing the projects.

<!--more-->

-------------------------------------------------------------------------------

<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-generate-toc again -->
**Table of Contents**

- [Intro](#intro)
- [The Criteria](#the-criteria)
- [Vagga](#vagga)
- [Redox](#redox)
- [Libpnet](#libpnet)
- [Final Pick](#final-pick)

<!-- markdown-toc end -->



# Intro

I've dabbled in Rust for a while now (see [here](http://www.garin.io/why-rust-as-next-lang), and [here](http://www.garin.io/rust-vs-c-pitfalls)).
Mainly doing [coding exercises](http://exercism.io/languages/rust) and reading the [official book](https://doc.rust-lang.org/book/).
This prep-work made me eager to put all the things I've learned into practice.

I could write a Rust utility, or even start with a bigger project.
But, I decided that the right thing to do would be to start contributing to an existing project.
That way, I'll be able to help out while learning all the nuances that go into a real-world project.

So, of course, I've hoped onto Github and started browsing through the trendiest and most exciting projects.

Sure enough, many projects made it to my initial list.
But, for the sake of brevity, I've narrowed them down to the top three - 

- Vagga
- Redox
- Libpnet

Here, I'll explain how I picked the "winning" one.

# The Criteria

I've scored each of the three projects on three unique criteria.

Please keep in mind the these are **very subjective**.

- **Impact Score** 
  - How will the growth of the project affect Rust's adaption?
  - Will it make the existing devs happier with the eco-system?
- **Contributor-Friendliness Score** 
  - How's the project's Documentation (both user facing and contributors facing)?
  - How's the project's test suite (serves as good documentation, and a helpful framework to validate your changes against)?
  - Does the project have an active IRC or a [Gitter](https://gitter.im/)?
  - How active is the project (How often are commits pushes, PRs merged and Issues Resolved)?
- **Personal Benefit Score** 
  - How much will I learn by contributing?
  - How relevant is my existing knowledge?
  - How much does the project interest me?

\* *The scoring is on a 1 to 10 scale.*

In the following paragraphs I'll present how each project fared, and the reasoning behind my scoring.

# Vagga

from Vagga's [Github Page](https://github.com/tailhook/vagga) -

*"Vagga is a fully-userspace container engine inspired by Vagrant and Docker, specialized for development environments."*

<img src="http://core0.staticworld.net/images/article/2015/04/container-489933_1280-100580895-primary.idge.jpg">

## Impact Score

Full disclosure, I only have a basic understanding of Vagga.
I've read the [README](https://github.com/tailhook/vagga/blob/master/README.rst) and the [about pages](http://vagga.readthedocs.io/en/latest/info.html), but I haven't played with it yet.
With that said, Vagga definitely looks promising.

I had a chance to use [Docker](https://www.docker.com/) and [Vagrant](https://www.vagrantup.com/) on several occasions, and I do appreciate the new things Vagga brings to the table.
It reminds me of [Otto](https://www.ottoproject.io/) (which I haven't tried either).

The impact potential of Vagga on Rust is quite clear.
As the interest in Vagga will rise, so will the interest in Rust.

That's very similar to the relationship between [Docker](https://github.com/docker/docker) and [Go](https://github.com/golang).

But, since this project isn't aimed to improve Rust's eco-system, its impact will probably only be indirect.

**Score: 4**

## Contributor-Friendliness Score

At first glance, it looks like a lot of effort has been made to make Vagga more friendly and easy to get started with.
There are excellent usage docs at [readthedocs.org](http://vagga.readthedocs.io/en/latest/). That's seriously impressive and praiseworthy.

Though, at the time of this writing, it seems like the project is missing a guide or a README that's geared towards contributors.
At least the Github issues are well documented and labeled nicely.

Another positive aspect of the project is its thorough systems tests suite.
They are automatically triggered by [Travis](https://travis-ci.org/tailhook/vagga) and seem pretty exhaustive.

Moreover, although not very active, the project has a nice [Gitter chat room](https://gitter.im/tailhook/vagga).
These chat rooms are very helpful when you're having a hard time fixing a bug or when you're wondering what a particular thing does.

Finally, it seems that the project is fairly active.
There are daily commits (mostly by the [main dev](https://github.com/tailhook)), and significant PRs + Issues activity.

**Score: 8**

## Personal Benefit Score

It's clear that contributing to Vagga has the potential of significantly improving my proficiency with Rust.
But that's a shared theme among the three contenders.

The unique learning opportunity is mostly derived from the domain-specific knowledge that each of the projects demands.
It serves as a practical way of getting closely familiar with a particular technology.

In this case, the domain is containerization and all the intricacies that go into doing that.

I do know a fair bit about operation system and their internal workings, but I've never really had a chance
to explore the containerization mechanisms. That's an excellent opportunity to do that.

Moreover, this realm is fascinating to me, and it seems like I'm not the only one who finds it interesting.
Containers are a very trendy topic in our industry right now.

**Score: 8.5**

# Redox

from [Redox's website](http://www.redox-os.org/) -

*"Redox is a Unix-like Operating System written in Rust, aiming to bring the innovations of Rust to a modern microkernel and full set of applications."*

<img src="https://raw.githubusercontent.com/redox-os/redox/master/img/screenshots/Desktop.png" width="600">

## Impact Score

Those of you who are familiar with Rust have probably heard of the Redox project.
It's one of the biggest Rust projects at the moment.

Personally, I remember it showed up on several occasions on Hackernews.
Showcasing the [operation system itself]() and the ambitious [re-write of coreutils]().

Similarly to [Vagga](#vagga), my contribution to Redox will have an indirect impact on Rust.
By helping Redox grow and mature, the public attention towards Rust will increase.
Hopefully, this awareness will lead to a higher adoption rate.

However, it should be noted that Redox is much more popular than Vagga at the moment.
This advantageous positive momentum will probably mean that the indirect impact will be more substantial in this case.

That might sound controversial or against the FOSS spirit, but in my opinion, Redox deserves a slightly 
higher score due to its popularity.

**Score: 5**

## Contributor-Friendliness Score

Although still a work-in-progress, the user and contributor friendliness of Redox is quite good.
Its [main website](http://www.redox-os.org/docs/) demonstrate this in the dedicated [Docs page](http://www.redox-os.org/docs/).

There's an [official book](https://doc.redox-os.org/book/) that is pretty incomplete at the moment.
However, judging by its table of contents, it should be awesome once it is finished.

Additional, there are extensive [api docs](http://www.redox-os.org/docs/) for the different side projects.
Also, there's a well written [CONTRIBUTING.md](https://github.com/redox-os/redox/blob/master/CONTRIBUTING.md) and a [chat server](https://github.com/redox-os/redox/blob/master/CONTRIBUTING.md#chat).

It should be noted that the project is **very** active. In fact, there are dozens of [side projects](https://github.com/redox-os) that have sprouted around the [main repo](https://github.com/redox-os/redox).
All of these are grown and maintained by the [Redox team](https://github.com/orgs/redox-os/people) (9 devs at the time of this writing) and a lot of minor contributors.

Unfortunately, aside from the automatic Travis builds, I couldn't find any automated tests.
I might have missed them, so do comment if I'm wrong here.

**Score: 9**

## Personal Benefit Score

Contributing to Redox would probably be a good use of my existing knowledge.
As I mentioned above, I know my way around the internal of operation systems.

Contributing to Redox will allow me to deepen and strengthen my knowledge in this domain significantly. 
Becoming much more intimate with the inner workings of OSes.

Aside from that, the side projects deal with a lot more domains that worth exploring.
I imagine that once one gets familiar with one of the projects in the Redox cluster the transition to
another would be pretty seamless.

Also, this is a great opportunity to get to know lots of awesome people.
Since as I said, many are involved.

**Score: 9.5**


# Libpnet

from Libpnet's [Github Page](https://github.com/libpnet/libpnet) -

*"libpnet provides a cross-platform API for low-level networking using Rust."*

<img src="http://eastav.net/wp-content/uploads/2014/02/ntw.jpg" width="600">

Compared to [Vagga](#vagga) and [Redox](#redox), Libpnet is an actual library that's intended to be used by Rust developers!

It provides a solution to a missing piece in the Rust eco-system.
That is - low-level networking and manipulation.

Over the last few years, I've found myself use Python's [Scapy](https://github.com/secdev/scapy) quite a lot.
It's so easy to compose network frames and use them how you see fit.

So, of course, when I got into Rust, I've looked for an equivalent library.
That's how I found out about Libpnet.

Admittedly, Libpnet isn't quite as complete or as ergonomic as Scapy,
but it looks well built and convenient enough.


## Impact Score

At first glance, it might appear obvious that Libpnet's impact on Rust would be greater.
After all, it is a "direct" impact since this is an actual developer facing library.
But, alas, I believe that this is not the case.

That's due to the fact that its usage volume is pretty low (searching through Github I found 10 or so small projects that are using it).

Since the library seems mature enough, I'd bet that there's just not much demand for this niche in the Rust community.
So for now, this resulted in an average score in my book.

**Score: 5**

## Contributor-Friendliness Score

Considering the small size of the library, the amount of effort and attention that 
has been put towards the documentation and build system is both remarkable and admirable.

Firstly, the API documentation is excellent. Pretty much everything is covered,
and the examples really help illustrate how to use the library.

Additionally, there's an IRC support channel on Freenode.
That will certainly come in handy for new users and contributors alike.

Unfortunately, at the time of this writing, it seems that project is pretty inactive.
There were no commits or issues solved in the past month. 
Hopefully, this is just a temporary downtime.

Finally, as I've eluded to, the automatic Travis build and the testing setup look fantastic.
There are plenty of tests and a nice set of benchmark tests as well!

**Score: 8**

## Personal Benefit Score

As I've mentioned above, I have quite a lot of experience with networking, protocols, and communication. 
Moreover, I've used tools like Scapy for a few years now.

This knowledge will probably prove pretty valuable 
if and when I'll contribute to Libpnet.

But, other than that, I'll probably won't be learning much domain specific knowledge.
Though, it will likely force me to strengthen my grasp on Rust's metaprogramming and macro facilities.

**Score: 6**

# Final Pick

Before starting to do the research for this post, I've had a hunch which of the projects will score the best.
Obviously, that fact and the subjective nature of this selection means I'm biased.

Nevertheless, documenting this process helped a lot.
Organizing these thoughts formally helped with making it clear what's important to me.

So, for now, **Redox is the winner**!

This might obviously change in the future, and I might end up contributing to more than one project. 

Hopefully, you found this interesting. 
I'll probably continue to journal my contribution attempts in the near future :)
