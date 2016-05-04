---
layout: post
title:  "How Repetitive Strain Injury (RSI) Can Make You a Better Developer"
categories: Workflow
featured: false
comments: true
---

Learn through my journey of dealing with RSI, and how it made me more productive.

<!--more-->


## TL;DR

1. If you're dealing with [Repetitive Strain Injury](https://en.wikipedia.org/wiki/Repetitive_strain_injury), view it as an opportunity to become more productive.
2. If not, I'd still recommend you reconsider your workflow.  
What are your most common keystrokes? Do they involve smaller/weaker fingers? 
3. Look into the [DIY Keyboard Movement](https://geekhack.org). My favorite one is the [ErgoDox](http://ergodox.org/).
4. Give [Spacemacs](http://spacemacs.org/) a try! It's the best editing experience I've had.

## Prologue

Since this is an introductory post, I thought I'd start off with sharing
the story of how my development workflow came to be what it is today.

Hopefully, it'll motivate you to reconsider your workflow,
and optimize it so that you'll be as productive as possible.

As a bonus, you'll also be one step closer to warding off the threat of RSI.

## The Early Days

One of the earliest memories I have from my journey as a software developer,
is witnessing the magical powers of Emacs for the first time.

It happened when one of my teachers demonstrated his Emacs-fu at class.  
It was truly inspiring.  
He wielded his editor like a master ninja would wield his katana.
I was, of course, compelled to try Emacs myself.

I started off with the vanilla Emacs experience.  
It was very awkward, and I soon found myself patching-in snippets of Elisp into my config.  
This grew old quite quickly, so I decided to bootstrap my setup with something that was more mature.

After a bit of researching, I settled on what seemed like that best offering at that time.
That was none other then [Bozhidar Batsov](https://github.com/bbatsov)'s [Prelude](https://github.com/bbatsov/prelude) Emacs Distribution.  
It was very refreshing, and it certainly made me much more productive.  
I even got my colleagues to convert to it once they saw the potential it had.

I've used this setup for a long while, but alas, like all good stories, something had to go wrong.

As I'm sure many of you know, working with Emacs involves using a lot of its "key chords".
These key chords are a combination of some modifier key (usually Ctrl) and a sequence of other keys.
They are very easy to get used to at first because it's the de-facto standard for key-bindings everywhere.
But, they also have a nasty dark side.

## The "Emacs Pinky"

![Not-Your-Standard-Editor](http://i.imgur.com/fX58Bw2.png)

After a while, and a considerable amount of typing hours, these "key chords" have a toll on your hands.
Specifically, on the pinky finger of the left hand. This phenomenon is quite funny, yet, it's a real concern. 

The community has coined the appropriate term - ["Emacs Pinky"](https://en.wikipedia.org/wiki/Emacs#Emacs_pinky) - to describe this injury.
It falls under the category of repetitive strain injuries (a.k.a RSI).

As you've probably guessed by now, I, too, have started seeing signs of this injury.
It was just slightly annoying at first, but soon I wasn't able to use my pinky to write code.

It sucked, but being the hacker that I am, I started searching for innovative ways to solve this problem.

## The Experimentation Phase

My first few attempts didn't pan out.
I initially converted to pressing the Ctrl key with the fleshy part under the left pinky.
To my surprise, it did work. But, it was too slow and uncomfortable.

So I searched for alternatives.
I found out about [ergoemacs-mode](https://github.com/ergoemacs/ergoemacs-mode), [Voice Programming](https://www.youtube.com/watch?v=8SkdfdXWYaI), and [Foot Pedals](https://www.emacswiki.org/emacs/FootSwitches).
None of these seemed appropriate. I wanted to leverage this opportunity to improve
my workflow and make myself more productive.

## Joining the Dark (Evil) Side

![evil-mode](https://www.emacswiki.org/pics/static/EvilLogo)

Eventually, after being teased and pushed by my co-workers, I gave Vim an honest try.
Again, I figured that the best way of learning it was starting with the vanilla experience.
So that's what I did for a few weeks. I only used Vim for my daily work.
The learning curve was present, and my productivity did take a hit, but modal editing just clicked for me. Right off the bat it seemed very logical, and it made sense to me.
That motivated me and kept me going. 

After that initial period has passed, I felt like I'm ready to try out [evil-mode](https://www.emacswiki.org/emacs/Evil).
Of course, since [Prelude](https://github.com/bbatsov/prelude) offers this option out-of-the-box it was easy to set this up.

I found it to be very lovely. I seriously had a hard time finding differences between the two.
It even allowed my pinky to recover fully!

So with that, I've felt like I won the [Editor War](https://en.wikipedia.org/wiki/Editor_war). 
I was ready to march on, wielding both Vim and Emacs in my hands.

## The ErgoDox

![ErgoDox](http://res.cloudinary.com/indiegogo-media-prod-cld/image/upload/c_limit,w_620/v1435062448/e209onukdbrkpy4fygew.png)

Concurrently, I've stumbled upon the [Keyboard DIY Movement](https://geekhack.org). The concept immediately drew me in.
So I kept on digging, and eventually, I found the hottest DIY keyboard at that time - The [ErgoDox](http://ergodox.org/).

I liked the design and features of the ErgoDox.
Plus, the fact that you had to assemble it yourself made it seem like an awesome weekend project.

So I ordered a kit with [Clear Cherry MX Switches](https://deskthority.net/wiki/Cherry_MX_Clear) through [Massdrop](https://www.massdrop.com) and soldered it up.

The experience was unique and truly magnificent.
Though sadly, I've only later figured out that I won't be able
to use it due to work policies.

A bummer. But no worries!
Something better and magnificent was just around the corner.

## Spacemacs

![Spacemacs](https://camo.githubusercontent.com/f64bd3e47045358060788cfc035e3bf1961439aa/687474703a2f2f7777772e6e61737333722e636f6d2f73706163656d6163732e706e67)

A year or so after moving to [evil-mode](https://www.emacswiki.org/emacs/Evil) I discovered [Spacemacs](http://spacemacs.org/).
I was blown away by it. Using Space as a [Leader Key](http://usevim.com/2012/07/20/vim101-leader/) was absolutely genius.
And on top of that, the execution was top-notch. The documentation was fantastic,
and the community was very friendly.

It was truly "love at first strike".  
Nothing I've used before felt this good.
So, of course, I've switched to it immediately.

In fact, this is still my setup today.
I've kept on honing my Spacemacs skills, 
and I honestly can't imagine using anything else.

Moreover, I'm glad to report that since switching to evil and Spacemacs, 
RSI has never been an issue.

Thus, if you haven't tried Spacemacs yet, I strongly urge you to give it a shot!

***

Copyright © [Itay Garin](http://www.garin.io/) 2016.
