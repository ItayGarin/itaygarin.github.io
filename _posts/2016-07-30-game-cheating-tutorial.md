---
layout: post
title:  "Game Cheating Tutorial: God-Mode in GBA Pokemon"
categories: Tutorial
featured: false
comments: true
---

A guide for cheating games through memory modification

<!--more-->

<img src="https://i.kinja-img.com/gawker-media/image/upload/s--mzuhsIk6--/c_scale,fl_progressive,q_80,w_800/u8h74soonwwomgtwsozk.jpg">

## Intro

People have been cheating in games for almost their entire history.
There just seems to be something thrilling about breaking rules and laws.
That is, until you get bored from the lack of challenge.

Over the decades, hackers have developed plenty of [techniques](https://en.wikipedia.org/wiki/Cheating_in_video_games) to make gaming easier.
[Creating bots](https://en.wikipedia.org/wiki/Cheating_in_video_games#Bots) that automate the player's actions, [injecting their code](https://en.wikipedia.org/wiki/Cheating_in_video_games#Code_injection) into the game and [editing the save files](https://en.wikipedia.org/wiki/Cheating_in_video_games#Saved_game_editors).

In this post, I'll focus on the [Memory Editing](https://en.wikipedia.org/wiki/Cheating_in_video_games#Memory_editing) technique.
This method is widely applicable, and it's pretty straightforward.

I'll demonstrate this technique on the classic [Pokemon Fire Red](https://en.wikipedia.org/wiki/Pok%C3%A9mon_FireRed_and_LeafGreen).

When I was younger, I played a lot of Pokemon games on the Gameboy platforms.
Of course, I've used lots of [publicly available cheats](http://www.supercheats.com/gameboyadvance/pokemonfireredcodes.htm) and always wanted to be able to find them myself.

Fire Red runs on the [Gameboy Advance](https://en.wikipedia.org/wiki/Game_Boy_Advance) console, but the following methodology
can be applied to any game on any platform.

## Memory Editing

Before diving into the technical details, an explanation of the [Memory Editing](https://en.wikipedia.org/wiki/Cheating_in_video_games#Memory_editing) technique is due.

Traditionally, the goal of this technique is to find key memory variables that are a part of the game's state. 
Then it's just a matter of manipulating their value to gain a certain advantage.

For example, as I'll demonstrate soon, you could search for the variable that holds your Pokemon's Health Points (HP).
Once found, it's possible to increase this value and make it much harder to defeat your Pokemon.

Hackers often compile these modifications into a "[Game Trainer](https://en.wikipedia.org/wiki/Trainer_(games))".
This "trainer" attaches itself to the game and provides the users with a graphical interface
that lets them activate these cheats without any technical knowledge.

## Setting Up the Research Environment

To find these variables we'll need to set-up a research environment.

This environment will allow us to run the game while having the ability to examine its memory.

I'll provide the installation steps for Ubuntu (16.04) since that's the platform I've used.
However, you can easily emulate these steps on other operation systems.

#### Installing the Emulator

<img src="https://1.bp.blogspot.com/-D5d2J3FEGXI/VuzdXiwbU3I/AAAAAAAAAKc/OoSGqHrUJss38ZZTW8IwKebhdJg2Y3zkA/s1600/vba.png" width="300px">

Using a [Gameboy Advance emulator](https://en.wikipedia.org/wiki/VisualBoyAdvance) will make the cheating process a lot easier.
It will allow us to search the memory and make modifications without being dependent 
on external hardware.

We'll be using the [VisualBoyAdvance](https://en.wikipedia.org/wiki/VisualBoyAdvance) emulator -

```shell
sudo apt-get install visualboyadvance
```

#### Installing the Debugger

<img src="http://3.bp.blogspot.com/-tSXnTaZYdGo/U-OGZrwTPGI/AAAAAAAAHEw/2jFvGY7v-fQ/s1600/gdb-logo.png" width="300px">

We'll be using the [gdb](https://en.wikipedia.org/wiki/GNU_Debugger) debugger for this tutorial.
gdb will allow us to "freeze" the game's execution and to manipulate its memory freely.

```shell
sudo apt-get install gdb-arm-none-eabi
```

Notice that we're installing a gdb version that has been targeted to the ARM architecture.
Indeed, the [Gameboy Advance](https://en.wikipedia.org/wiki/Game_Boy_Advance) has an [ARM](https://en.wikipedia.org/wiki/ARM_architecture) processor (the [ARM7TDMI](https://en.wikipedia.org/wiki/ARM7)).

#### Running the Game

Assuming you already own a digital copy of the game's cartridge, it's time to try to run it.

VisualBoyAdvance makes it easy for us - 

```shell
VisualBoyAdvance red.gba
```

This command should open up a window with running game!

Check out this [link](https://github.com/visualboyadvance/visualboyadvance/blob/master/doc/ReadMe.SDL.txt) for a full list of the emulator's keybindings

#### Debugging the Game

Conveniently, the new versions of VisualBoyAdvance support remote debugging with gdb.
This can be done either on a TCP connection or a Unix PIPE.

Since PIPE debugging is much faster, we'll be using that method.
You can find the full documentation for gdb's support in VisualBoyAdvance [here](https://github.com/edwardbadboy/VisualBoyAdvance/blob/master/README#L128).

The following are the steps for launching a debug session - 

```shell
arm-none-eabi-gdb
(gdb) target remote | VisualBoyAdvance -Gpipe red.gba
```

Upon issuing the last command, a "frozen" game window should open up.
You should also see a prompt in gdb that is indicating we've stopped at address [0x08000000](http://problemkaputt.de/gbatek.htm#gbamemorymap).

[This address](http://problemkaputt.de/gbatek.htm#gbamemorymap) is the first instruction in the game ROM!

To resume the game's execution, we'll issue the `continue` gdb command.
If we'll want to pause the execution again, the `F11` keybinding should be used.

To quit, press the `ESC` keybinding while the game is running.

With that, we have our desired setup!
If you've made it this far, feel free to pat yourself on your shoulder.

**Bonus**: There's a one-liner that will make it much easier to start a debugging session -

```shell
arm-none-eabi-gdb -ex "target remote | VisualBoyAdvance -Gpipe red.gba" -ex "continue"
```

<iframe width="1280" height="720" src="https://www.youtube.com/embed/WOE2myqpUaM" frameborder="0" allowfullscreen></iframe>
<br/>

## Finding the HP 

As I've previously mentioned, our goal is to find the HP variable of our Pokemon.
With that variable, we'll be able to set the Pokemon's Health to its max value.  Achieving a [god-mode](https://en.wikipedia.org/wiki/Glossary_of_video_game_terms#God_mode) state.

To accomplish that we'll take a simple black box approach.
We'll repeatedly search the memory until the HP variable emerges.

Specifically, we'll start off by scanning the game's RAM for the initial value.
We'll probably encounter multiple matches so we'll narrow them down by changing 
the HP through the game, and scanning the RAM again.

Each scan will filter out the addresses that no longer reflect the current HP value.
Hopefully, we'll be left with a single matching address.

Note that you'll have to make educated guesses about the variable.
How is it stored? Is it a signed or unsigned? How big is the variable?
These are things you must consider before you start the search.

If you don't end up with a single result after a few scans, 
your assumptions about the variable are probably wrong.
Tweak those and try again.

## Searching with PythonGDB

The easiest way to interact with the game's memory is through the Python interpreter that's embedded inside gdb.
Recent versions of the debugger ship with this helpful interpreter. 
It lets you control gdb through the [PythonGDB](https://sourceware.org/gdb/onlinedocs/gdb/Python-API.html) interface.

Specifically, we'll be using the memory manipulation methods that are exposed through the [gdb.Inferior](https://sourceware.org/gdb/onlinedocs/gdb/Inferiors-In-Python.html) class.
These are the [search_memory](https://sourceware.org/gdb/onlinedocs/gdb/Values-From-Inferior.html#Values-From-Inferior), [write_memory](https://sourceware.org/gdb/onlinedocs/gdb/Values-From-Inferior.html#Values-From-Inferior) and [read_memory](https://sourceware.org/gdb/onlinedocs/gdb/Values-From-Inferior.html#Values-From-Inferior) methods.

For example, if we wanted to find the first occurrence of the value 100 in the game's RAM,
we might do the following -

```python
1: (gdb) python-interactive
2: >>> inferior = gdb.inferiors()[0]
3: >>> ram_addr, ram_size = (0x02000000, 1024 * 256)
4: >>> pattern = "\x00\x64"
5: >>> first_match = inferior.search_memory(ram_addr, ram_size, pattern)
   >>> hex(first_match)
6: '0x20040e7L
```

1. Beginning with gdb's prompt, we get into the python interactive mode.
   You could also use the abbreviated `pi` command to accomplish the same thing.
2. Using the baked-in `gdb` namespace, we access the underlying `Inferior` object.
   This object represents the program that is being run under gdb.
3. Fire Red's General Purpose RAM begins at [0x02000000](http://problemkaputt.de/gbatek.htm#gbamemorymap) and is 256KB
4. We search for the value 100 (0x64 in hexadecimal). 
   Notice that we assume that the value is stored in an halfword variable (= 2 bytes).
5. We invoke Inferior.search_memory(). Notice that it returns only the first address that matched.

<iframe width="1280" height="720" src="https://www.youtube.com/embed/bfoEMg-Q0Cw" frameborder="0" allowfullscreen></iframe>
<br/>

With search_memory() working, all we need now is a way to automate the iterative calls to this method.

## Enter "[gdb-cheat-engine](https://github.com/ItayGarin/gdb-cheat-engine)"

I've implemented a small Python class that helps with the iterative searching.
For those of you who are familiar with the good-old [Cheat Engine](https://en.wikipedia.org/wiki/Cheat_Engine), it behaves quite similarly to it.

You can check out this framework here - [gdb-cheat-engine](https://github.com/ItayGarin/gdb-cheat-engine).
The code is well documented so don't be afraid to [take a peak](https://github.com/ItayGarin/gdb-cheat-engine/blob/master/gdb_ce.py).

The following [example](https://github.com/ItayGarin/gdb-cheat-engine/blob/master/README.md#example) demonstrates how to search the memory repeatedly
for the changing HP value using gdb-cheat-engine.

```python
$ gdb
  (gdb) source gdb_ce.py
  (gdb) python-interactive
   >>> inferior = gdb.inferiors()[0]
   >>> ram_addr, ram_size = (0x02000000, 1024 * 256)
1. >>> ce = GdbCheatEngine(inferior, ram_addr, ram_size)
 
2. >>> initial_hp = "\x00\x64" # 100 HP. Assumes that the counter is an unsigned 16bits variable
3. >>> ce.search_ram(initial_hp)
4. set([0x02000004, 0x0200..., ....])
 
5. # Reduce the HP...
 
   >>> new_hp = "\x00\x60"
6. >>> ce.search_ram_again(new_hp)
7. set([0x02000004])
 
   >>> hp_counter_addr = 0x02000004
```

1. This time, we being by initializing a [GdbCheatEngine](https://github.com/ItayGarin/gdb-cheat-engine/blob/master/gdb_ce.py#L3) instance with our search parameters
2. We observed that our Pokemon has 100 HP
3. We search the RAM for the initial HP pattern using the [search_ram()](https://github.com/ItayGarin/gdb-cheat-engine/blob/master/gdb_ce.py#L84) method. 
   Note that the search is stateful. I.e. the results are being saved for further filtering.
4. This time, we get back all of the matches as a `set` 
5. To speed up the filtering, we'll reduce our Pokemon's HP. For example, by getting him attacked
   by another Pokemon.
6. We'll search the ram again for the 2nd value. the [search_ram_again()](https://github.com/ItayGarin/gdb-cheat-engine/blob/master/gdb_ce.py#L93) method intersects 
   The new matches with the previous ones. I.e. only addresses that matched in both searches will be returned.
   It's possible to reset this cache/state by starting a new search with [search_ram()](https://github.com/ItayGarin/gdb-cheat-engine/blob/master/gdb_ce.py#L84) 
7. We are only left with one result. The HP counter address!

## Modifying the HP Counter

All that's left to do it reap the rewards of our hard work.
Now that we have the HP's address, we can manipulate it to our heart's content.

As you've probably guessed by now, we'll be using the [Inferior.write\_memory()](https://sourceware.org/gdb/onlinedocs/gdb/Inferiors-In-Python.html) method to do that.
It's also possible to use the wrapper method [GdbCheatEngine.write\_memory()](https://github.com/ItayGarin/gdb-cheat-engine/blob/master/gdb_ce.py#L102)

In the following video, I demonstrate finding the HP address and changing its value -

<iframe width="1280" height="720" src="https://www.youtube.com/embed/VxyZCO2NnqQ" frameborder="0" allowfullscreen></iframe>
<br/>

## Outro

That's it folks. 

Hopefully, this post has motivated you to venture out on your own
and try to find cheats and tricks yourself.

Not for the sake of cheating, but for the sake of challenging yourself 
and exploring new possibilities.

Please feel free to ask me any questions directly
or in the comment section below.
Also, Pull Requests are more than welcome :)
