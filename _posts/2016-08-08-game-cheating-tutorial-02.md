---
layout: post
title:  "Game Cheating Tutorial (Part 2): Pokemon Strings Adventures"
categories: Tutorial
featured: false
comments: true
---

How to innovate your way out of a research challenge

<!--more-->

<img src="https://i.kinja-img.com/gawker-media/image/upload/s--mzuhsIk6--/c_scale,fl_progressive,q_80,w_800/u8h74soonwwomgtwsozk.jpg">

# Intro

My [last blog](http://www.garin.io/game-cheating-tutorial) was pretty popular. 
I was delighted to see the interest towards the video game cheating topic.

So, naturally, when I tried to come up with this post's topic, 
I thought it'd be a good idea to shed some more light on this practice.

This time, we'll explore a peculiar phenomenon I stumbled upon while researching [Pokemon Fire Red](https://en.wikipedia.org/wiki/Pok%C3%A9mon_FireRed_and_LeafGreen)'s ROM - 
The apparent lack of strings in it.

Unfortunately, I couldn't include the results of this research in the last post. They just weren't relevant to its agenda.
But, now I have a great opportunity to share this additional knowledge with you.

# No Strings? ☹

Being the curious hacker that I am, I couldn't resist taking a peek at the game's ROM.
Of course, that meant opening it up with the all-time favorite disassembly environment - [IDA](https://www.hex-rays.com/products/ida/).

When IDA finished its notoriously long initial processing, I began examining the binary's strings.
Since, as you might know, strings are often a quick&dirty shortcut in the realm of reverse engineering.

Cross-referencing a significant string is probably the shortest way to "strike gold".
i.e to pinpoint the exact location of the logic you're after (at the instruction level).

Shockingly, IDA produced a list that was completely void of useful strings.
All the names and dialogues that I was eager to see were nowhere to be found.

Admittedly, this was a bit discouraging at first, 

<img src="assets/img/firered/no_strings.png">

A quick Google search revealed that, indeed, the game is using a proprietary encoding scheme.

Being such old classics, the Pokemon games are already thoroughly researched and documented.
In fact, A convenient character translation table can be easily [found online](http://bulbapedia.bulbagarden.net/wiki/Character_encoding_in_Generation_III).

However, using this public table would be cheating (pun intended).
After all, I started this venture with the intention of learning and challenging myself.

**Pause here for a minute**. <br/>
*How would you solve this challenge? How would you find the missing strings?*

#  Finding the Strings

<img src="assets/img/firered/your_name.png">

Personally, I took a unique route while solving this riddle.

I leveraged the technique one would use to break a simple [substitution](https://en.wikipedia.org/wiki/Substitution_cipher) or a [XOR](https://en.wikipedia.org/wiki/XOR_cipher) "cipher"*.
That technique is none other than [Frequency Analysis](https://en.wikipedia.org/wiki/Frequency_analysis).

I encourage you to read the [wiki page](https://en.wikipedia.org/wiki/Frequency_analysis) on this technique.<br/>
In case you just want a quick TLDR, here is a summary - 

In short, Frequency Analysis exploits the non-uniform usage of individual characters in a given set.
In other words, this approach takes advantage of the fact that certain letters statistically appear more often than others.

So, for example, 'e' is the most used letter in the English Alphabet.
Specifically, 'e' usually accounts for ~13% of the letters in a given text (11.13% in this post).

<img src="http://wiki.stat.ucla.edu/socr/uploads/4/46/SOCR_Data_Dinov_EnglishLetterFrequency.png">

This uniformity exposes the underlying letters through the ciphered text.
One could simply count the number of times each letter appeared, 
and cross-reference that with the pre-computed frequency distribution of the given alphabet.
That will yield the substitution table.

Awesome! <br/>
We now know how to break simple ciphers!

As it happens, we could treat the game's proprietary encoding scheme as a cipher of sorts.
We know that the names and dialogues mostly consist of regular good-old' English letters.
Thus, armed with the power of Frequency Analysis, we have *almost* everything we need to tackle this nagging issue.

We could count the occurrences of each of the letters in the game ROM, 
and then cross reference those with the standard [English Alphabet Frequency Numbers](https://en.wikipedia.org/wiki/Letter_frequency).

By now, I bet you'll be asking something along these lines -
*"But, Itay! The ROM isn't just a big blob of text and letters. 
It has instructions, sprites, music and plenty of other unrelated elements.
Your counting will be severely inaccurate!"*

To that, I'd answer -<br/>
Keen eyes you have there kind sir.
That's precisely why I've stated that we have **almost** everything we need.

The last piece of the puzzle is **focusing our scan**.

\* *Check out the delightful [Cryptopals Crypto Challenges](https://cryptopals.com/) to learn more about this technique and many others like it.*

# Focusing Our Scan

Again, I've used an unorthodox method to accomplish the task at hand.

Since I'm quite a visual person, I was inclined to shape the ROM's data into something that would make sense.
Luckily, it turns out that there are quite a few [binary visualization](https://www.google.co.il/search?q=binary+visualization) tools online.

A good demonstration of why this technique works can be seen on [binglide's README](https://github.com/wapiflapi/binglide/blob/master/README.md).
It shows how different data types are transformed into profoundly different shapes and images.

Unfortunately, I've had a hard time installing and using most of the tools.
You might have better luck on your side.

The one app that did work was - [binvis.io](http://binvis.io/).
It's a simple online binary visualizer that does the job quite well.

With a few tweaks, it displayed the ROM like this -

<img src="assets/img/firered/binvis.png">

In the snapshot, the ROM's data is rendered into a two-dimensional array using a **linear scan curve**.
These fancy words simply mean that the 2D picture that you see matches the intuitive order of the bytes in memory. The pixels at the top of the image represents the first bytes of the file, 
while the bottom pixels represent the bytes at the end of the file.

<img src="assets/img/firered/binvis_scan.png">

The coloring is dialed in to be intuitive as well.
Binvis uses the term **magnitude** to describe this color scheme.
This scheme varies colors based on their increasing ordinal value (0 to 255).
Specifically, low values show up as dark black hues, while higher numbers show up as light blue hues.

<img src="assets/img/firered/binvis_magnitude.png">

When I initially examined the rendered data, the highlighted, mostly blue, block immediately grabbed my attention.
The adjacency to the code block at the beginning of the ROM, and the small spectrum of values (= color uniformity), 
made me suspect that this block contains lots and lots of our praised strings.

So I noted the block's location (offset ~0x173000 to ~0x1a0000), and used the 
following python function to gather the bytes frequency (histogram) -

```python
def bytes_histogram(data):
    histogram = dict()
    for byte in data:
        value = ord(byte)
        try:
            histogram[value] += 1
        except KeyError:
            histogram[value] = 0
    return histogram
```

# Analyzing The Results

The results were quite promising!

Here are the top 10 most frequent bytes and their appearance count -

```python
(0, 25120),
(217, 12957),
(227, 10135),
(232, 9871),
(213, 7996),
(226, 6234),
(221, 6211),
(231, 6117),
(220, 6060),
(230, 5740),
```

Right off the bet, the byte that stands out the most is zero. 
Its high score and the fact that it's a special value lead me to believe that it represents the space character.
After all, space is the most common letter in most modern languages.

Another interesting find was the adjacency of the other nine values. 
These neighboring values are well within the size of the English alphabet (26). 
That strengthens the assumption that we're dealing with text.

The easiest way to confirm this suspicion is to assume that 2nd most frequent byte represents the letter 'e'.
Since as I previously said, 'e' is the most common letter in the [English Alphabet](https://en.wikipedia.org/wiki/Letter_frequency).
This assumption will allow us to "resolve" the other eight bytes with ease. We simply need to take into account their distance from our "known" anchor.

for example, the 3rd most frequent byte is 227, which is greater than 'e' (217) by 10. 'e' + 10 = 'o'.

Repeating this procedure for the other bytes produces a familiar list (at least to those who've skimmed the [Letter Frequency Wiki page](https://en.wikipedia.org/wiki/Letter_frequency)).

```python
(' ', 25120),
('e', 12957),
('o', 10135,
('t', 9871,
('a', 7996,
('n', 6234,
('i', 6211,
('s', 6117),
('h', 6060,
('r', 5740,
```

These results are remarkably similar to the English Alphabet Letters Frequency!

<img src="assets/img/firered/wiki_eng_frequncy.png">

Thus, we can confirm that the assumption is **correct**. Undoubtedly, this is a string reservoir!

From this point, resolving the rest of the encoding table would be a matter of trial and error.
Knowing that, we can compare our findings to the [online encoding table](http://bulbapedia.bulbagarden.net/wiki/Character_encoding_in_Generation_III) with a clear conscience.

<img src="assets/img/firered/pokemon_encoding.png">

Indeed, our results match the online table perfectly! Great Success! 

# Using the Encoding Table

Admittedly, I couldn't find an easy way to get IDA (6.8) to use this propriety encoding scheme.
It seems that it only supports standard encodings (?).
If you know of a way to make this work, please let me know!


In the meantime, I've created a small encoding+decoding utility that does the translation for you.
You could use it to encode a known string into the propriety representation, and do a binary search in IDA.

Check it out here - [pokemon-strings-util](https://github.com/ItayGarin/pokemon-strings-util).

Now that we have strings, finding cheats and hacks will be much easier. 
Leveraging dynamic and static string searches can significantly cut down the ROM research efforts.
  
# Outro

Unlike the previous post, I've decided to close out this one with an open ending.
I won't provide a demonstration of a cheat this time.

I hope that by doing that, It'll encourage you to use these findings to research the ROM yourself.
Also, keeping the post short and concise will hopefully make it more "digestible".

Finally, besides motivating you, the primary goal here was to share a few unorthodox techniques that I've used. 
I wanted to demonstrate that thinking out of the box truly pays off in the RE world.

As Jeff Bezos said, "...One of the only ways to get out of a tight box is to invent your way out."
