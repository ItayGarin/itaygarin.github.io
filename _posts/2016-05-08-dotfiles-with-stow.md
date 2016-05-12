---
layout: post
title:  "How to Manage Your Dotfiles with GNU Stow"
categories: Workflow
featured: false
comments: true
---

A concise tutorial on how to do what you know you should do...

<!--more-->

<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-generate-toc again -->
**Table of Contents**

- [Prologue](#prologue)
- [Overview](#overview)
- [Installing GNU Stow](#installing-gnu-stow)
- [Setting up a Dotfiles Git Repository](#setting-up-a-dotfiles-git-repository)
- [Resources](#resources)

<!-- markdown-toc end -->

## Prologue 

This tutorial is intended to be a very short and concise guide on how to manage your dotfiles with [GNU Stow](https://www.gnu.org/software/stow/).
If you'd like to learn more, please check out the [Resources](#resources) section towards the end.

I won't elaborate on why it's a good idea to keep your dotfiles and configs in a 
backed up version control system. Just trust me on this one :)

## Overview

The biggest obstacle to managing your dotfiles is the fact that they are located in your home directory.
That's a pain because the contents of this directory are mostly irrelevant.
If you'd try to exclude them manually, it would become daunting very quickly.

Many solutions have been devised to solve this problem.
Most of them simply automate the process of replacing the dotfiles with symlinks.
That way, you'll be able to move these files to a dedicated directory that
will be version controlled and backed-up.

## Installing GNU Stow

If you're running a mature Linux distro, installing Stow should be a breeze.

On Ubuntu, you'd do this - 

```shell
sudo apt-get install stow
```

For other platforms, consult the [Download](https://www.gnu.org/software/stow#download) section on the official site.

## Setting up a Dotfiles Git Repository

For this guide, I'll use [my personal dotfiles](https://github.com/ItayGarin/dotfiles) as an example.

At the time of this writing, my home directory (/home/itayg/) had three dotfiles that were essential to my workflow.
Those were: my `.spacemacs` config, my `.zshrc` and my i3 config file.

The following is the representative directory tree structure -

```
/home/itayg/
├── .i3
│   └── config
├── .spacemacs
└── .zshrc
```

Now that it's clear what we're dealing with, let's start off by creating our `~/dotfiles` repository.

```shell
mkdir dotfiles
cd dotfiles
git init
```

Now we can move on to organize `~/dotfiles` for working with Stow.
But to do that, you should understand the basics of how Stow works.

The `stow` command takes a directory as an argument and creates symlinks to its content.
These symlinks are placed in the parent directory relative to your current working directory.

That's the simplest use case and the one we'll utilize.

With that said, let's setup `~/dotfiles` -   
(Before continuing, *PLEASE* make sure to backup your dotfiles!)

```shell
mkdir spacemacs
mv ~/.spacemacs spacemacs

mkdir zsh
mv ~/.zshrc zsh

mkdir i3
mv ~/.i3 i3
```

Don't forget to commit your changes - 

```shell
git add .
git commit -m "Add my awesome dotfiles"
```

That's it. We're almost done!
Wasn't so bad, right?

All we have to now is invoke `stow`.
Make sure you're in the `dotfiles` directory!

```shell
cd ~/dotfiles
stow spacemacs
stow zsh
stow i3
```

If I want to go the extra mile, you could even extract the `stow` commands
to a bash script. Say, `~/dotfiles/setup.sh`.
You can take a look at my [setup.sh](https://github.com/ItayGarin/dotfiles/blob/afb7466d85c39f3095c35d522613e4c3f965bdfa/setup.sh).

## Resources

* [GNU Stow](https://www.gnu.org/software/stow/)
* [Git](https://git-scm.com/)
* [Create a Repo on Github](https://help.github.com/articles/create-a-repo/)
* [My Dotfiles](https://github.com/ItayGarin/dotfiles)

***

Copyright © [Itay Garin](http://www.garin.io/) 2016.
