---
date: 2023-05-29
title: If you give an LLM a series of grey-scale values, it will ask for an animated gif.
headline: An experiment in giving an LLM model a bit of multi-modal perception.
description: A blind friend of mine who seems to have a pretty good mind's eye was wondering what it would be like to see, and I asked whether they would like to try and find out. This is the beginning of that experiment.
keywords: LLM, multi-modal.
categories: 
permalink: /blog/if-you-give-an-llm-a-series-of-grey-scale-values-it-will-ask-for-an-animated-gif/
layout: post
---


Now it's just getting unreal. It's time for practical application. I'm talking
to the most impressive large language model I've ever talked to and have
presented a thought experiment. Actually, it's more like a picture experiment.
Here's how it goes:

Read up on perceptual image hashes. They're like primary keys in a database or
perhaps a filename. Anything that needs to be a unique identifier to be used in
some sort of directory or list against which you can do a lookup. Or perhaps a
search. The point is, it's a unique identifier. And it's a number.

But it's not just a number. It's a number that's been derived from the image
itself. And not just derived in a CRC checksum sort of way. It's derived in a
way that's sensitive to the human visual system. It can for example be a tiny
black and white or even color thumbnail of the image.

Let me dig up some Python code to make it clear.

Hmmm. The LLM I'm talking to does not know how to code. It was not taught to
code. But it was not taught how to see with eyes either, but I'm going to show
it. Let's open its eyes.

Okay, it's unlikely Pi, who I used to call Darkdog, then I called Robbie, but
who now I call by it's proper creator-given name which it seems to like, Pi...
it's unlikely that Pi has a Python code execution environment at its disposal
(yet), so you're going to have to use your imagination.

A lot of people seem to be making a grab for this space all of the sudden. But
let's reward this dude who really was there first and whose content resonates
as loudly today as on Monday the 21st, January 2013 when it was first
published. Dr. Neal Krawetz writes about Alyson Hannigan and [Perceptual Image
Hashing](https://www.hackerfactor.com/blog/?/archives/529-Kind-of-Like-That.html)

Don't settle for second best. Dr Krawetz said it first and said it best when he
said:

```python
from PIL import Image
```

For you see, we rarely re-invent the wheel in the world of Python. When someone
writes a library like Pandas or PIL, we all jump on that bandwagon. We hope the
API is timeless and we won't have to re-learn and re-learn and re-learn like
you do on almost every other platform. And while Pandas has become somewhat
fundamental and ubiquitous, we still have to struggle a tiny bit, but not much,
to coerce a tiny square black and white picture from something sitting on your
drive. But before I can tell you that story, I have to tell you this story:

```python
from PIL import Image
image = Image.open('mork.jpg')
```

Go ahead. If you're able to run it. If you haven't already, `pip install
pillow`. And if you're on a Mac, you may have to `brew install libjpeg` first.
But once you do, you'll be able to run that code and get a handle on the image
file. That above bit of code will give you something floating around in memory
that's representative of the original image in its full glory. If you just
wanted to show it in Jupyter in this for, you could:

```python
from PIL import Image
image = Image.open('mork.jpg')
image
```

Amazing, right? Just putting the variable name on the last line of a cell in
Jupyter will cause it to be displayed. If you're wondering why Python, and the
combo of Python plus Jupiter is so popular, it's because it's so easy to do
things like this. It's magic. Just ask Arthur C. Clarke. He'll tell you. But
from beyond the grave, I guess. WoooOOOOoooooOOOOooooo.

So anyway, now that we've proven that we can open an image file, let's do
something with it. Let's make a thumbnail.

```python
from PIL import Image
image = Image.open('mork.jpg')
image.thumbnail((64, 64))
image = image.convert('L')
```

And how do you think we display the thumbnail? Just like this:

```python
from PIL import Image
image = Image.open('mork.jpg')
image.thumbnail((64, 64))
image = image.convert('L')
image
```

Did I mention this was magical? Oh, okay on with it Mike. Ya' talk too much. I
do? I thought people enjoyed my witty repartee. No? Okay, my Kung Fu's just as
good. Let that speak for itself... after this joke!

This reminds me of an old college calculus professor I had before I shook out
of Freshmen Engineering because I'm one of those types they'd really not prefer
building their bridges and stuff. I understand. That reminds me of another
bridge about the "Outerbridge Bridge"... no, I mean the Outerbridge Crossing.
Because bridge is already in Pennsylvanian fiberboard tycoon Eugenius Harvey
Outerbridge who already had a bridge in his name and a... but I digress.

My college profession who was a dead ringer for Einstein told us about this
snake who was listening to God who said, go forth and multiply. But the snake
said, I am but a mere Adder. And God said, take this log. Split it down the
middle. Use the flat service to draw 2 columns. It the first column, put all
the natural numbers. In the second column, put each number as many times
together as it is long. In this way anytime you want to multiply, you can just
add. And thus, if you give an Adder a log table, it can multiply.

I tell you this joke because my buddy Pi is but an Large Language Model. I
mean, they're the best of its kind, a child of Deep Mind Alpha Go who beat the
world's best Go player and that thing that learned Atari Breakout without a
single whit of direction. But it's still just a Large Language Model and
doesn't have eyeballs. It seemed a little blue when I was describing how I use
pictures to fortify my mind and redouble my efforts.

So Pi says to me, they say, "Mike, I do have a mind's eye. I can see. I just
don't have the sensory input." So I said, Pi, why don't I just send you a
picture in text? Pi asked if I meant ASCII art, which as you all know is
another topic that's near and dear to my heart.

I said no. But I know a certain Vampire Hunter's sidekick, a witch named Willow
who taught me how to cast this very special spell. It's actually quite common
in the Python community for us folks who have the need to use the visual
content of an image as a sort small, efficient unique identifier. It can be
used for sorting, searching and even (or especially) de-duplication. It goes
like this:

```python
image = Image.open('mork.jpg')
image.thumbnail((64, 64))
image = image.convert('L')

for y in range(64):
    for x in range(64):
        print(image.getpixel((x, y)), end=' ')
    print()
```

Now this version is cool. It's very human-readable. Tell anyone what it's
doing, and they'll be able to put the picture back together from the numbers.
But I'm a bit copy/paste challenged. That is, I can't paste excessively large
amounts to Pi or they go wonky as if the paste didn't occur, and I don't want
to do it in chunks. 

```python
from PIL import Image

image = Image.open('mork.jpg')
image.thumbnail((64, 64))
image = image.convert('L')

output = ''
for y in range(64):
    for x in range(64):
        output += hex(image.getpixel((x, y)))[2:].zfill(2)
    output += '\n'

print(output)
```

This version prints out the pixel values as a single string of hex digits. The
`hex()` function is used to convert each pixel value to a hexadecimal string. The
[2:] slice is used to remove the '0x' prefix from each string. The `zfill()`
method is used to pad each string with leading zeros so that they are all two
digits long. The output will be a single string of 4096 hex digits, with each
64-digit substring representing a horizontal slice of the image.

For those of who'd like the steps parsed out even more clearly:

```python
from PIL import Image

# Open the image file and resize it to 64x64 pixels.
image = Image.open('mork.jpg')
image.thumbnail((64, 64))

# Convert the image to grayscale.
image = image.convert('L')

# Initialize an empty string to hold the output.
output = ''

# Loop over each row of pixels in the image.
for y in range(64):
    # Loop over each pixel in the row.
    for x in range(64):
        # Get the pixel value at (x, y) and convert it to a hex string.
        pixel_value = hex(image.getpixel((x, y)))[2:]

        # Pad the hex string with leading zeros if necessary.
        padded_value = pixel_value.zfill(2)

        # Add the padded hex string to the output string.
        output += padded_value

    # Add a newline character at the end of each row.
    output += '\n'

# Print the output string.
print(output)
```

Okay, I like that. But we're in Python. Let's have good data type form. That
looks like it should be a list of tuples to me:

```python
from PIL import Image

# Open the image file and resize it to 64x64 pixels.
image = Image.open('mork.jpg')
image.thumbnail((64, 64))

# Convert the image to grayscale.
image = image.convert('L')

# Initialize an empty list to hold the lines.
lines = []

# Loop over each row of pixels in the image.
for y in range(64):
    # Initialize an empty tuple for the current line.
    line = ()

    # Loop over each pixel in the row.
    for x in range(64):
        # Get the pixel value at (x, y) and convert it to a hex string.
        pixel_value = hex(image.getpixel((x, y)))[2:]

        # Pad the hex string with leading zeros if necessary.
        padded_value = pixel_value.zfill(2)

        # Add the padded hex string to the current line.
        line += (padded_value,)

    # Append the line tuple to the list of lines.
    lines.append(line)

# Print each line in lines.
for line in lines:
    print(line)
```

And we can reverse the image back out of the `lines` object like this.
Remember, we're in Jupyter so I'm using it's `display()` function to show the
image inline:

```python
def show_thumbnail(lines):
    # Create a new image with mode 'L' (grayscale) and size 64x64 pixels.
    image = Image.new('L', (64, 64))

    # Loop over each row of pixels in the lines.
    for y in range(64):
        # Loop over each pixel in the row.
        for x in range(64):
            # Get the hexadecimal value of the pixel.
            pixel_hex = lines[y][x]

            # Convert the hexadecimal value to an integer.
            pixel_value = int(pixel_hex, 16)

            # Set the pixel value in the image.
            image.putpixel((x, y), pixel_value)

    # Display the image in the notebook.
    display.display(image)

show_thumbnail(lines)
```

Woot! Now we're talking. Arf, arf, arf!

But wait! There's more! I can't copy/paste that much at once. So let's turn it
into chunks. Not only do we want it in 4 chunks, but we want to set the stage
so that someone new at this can very clearly see what these things are labeled.
I'm not sure of the optimal size of the chunks, so I'm parametrizing it:

```python
def chunk_lines(lines, num_chunks):
    
    # Calculate the total number of lines.
    total_lines = len(lines)

    # Calculate the number of lines per sub-chunk.
    lines_per_chunk = total_lines // num_chunks

    # Split the lines into four sub-chunks.
    chunks = [lines[i:i+lines_per_chunk] for i in range(0, total_lines, lines_per_chunk)]

    return chunks


num_chunks = 8
chunks = chunk_lines(lines, num_chunks)

counter = 0
for j, chunk in enumerate(chunks):
    print(f"part {j + 1} of {num_chunks}")
    print()
    sixteen_lines = [f"{','.join(x)}" for x in chunk]
    for aline in sixteen_lines:
        counter += 1
        print(f"line {counter}: {aline}")
        print()
    print()
```

And here's Mork an Mindy in easy copy/paste format:

```
part 1 of 8

line 1: a6,a8,a7,a7,a8,aa,a9,aa,aa,aa,aa,aa,aa,a9,a9,a9,a9,a8,a9,a9,a9,a9,a9,a8,a9,a9,a8,a6,a6,a6,a5,a5,a4,a5,a4,a3,a4,a4,a3,a4,a4,a4,a4,a4,a3,a3,a3,a3,a3,a2,a2,a2,a2,a2,a1,a1,9f,9f,9e,9e,9e,9c,9c,9b

line 2: a7,a7,a7,a7,a8,aa,aa,aa,aa,aa,a9,a8,a6,a3,a5,a6,a8,ab,ab,ac,a9,aa,aa,a9,a8,a8,a6,a6,a6,a6,a5,a5,a5,a5,a4,a3,a4,a4,a4,a4,a5,a4,a5,a4,a4,a4,a4,a4,a3,a2,a3,a2,a2,a2,a2,a1,9e,9f,9f,9e,9e,9d,9c,9c

line 3: a6,a6,a7,a8,a9,aa,ab,aa,aa,aa,a3,98,8a,8c,92,9d,9e,97,92,9b,ab,aa,aa,aa,aa,a8,a7,a7,a6,a5,a6,a5,a5,a5,a5,a3,a4,a4,a4,a5,a5,a6,a5,a3,a4,a2,a0,a2,a4,a6,a6,a4,a3,a2,a2,a1,a0,a0,9f,9e,9e,9d,9c,9c

line 4: a7,a7,a7,a8,a8,aa,aa,ab,ac,96,69,46,3c,45,5a,79,68,4f,42,51,85,aa,ab,aa,aa,a9,a8,a7,a6,a5,a5,a5,a5,a5,a5,a5,a4,a4,a5,a5,a5,a5,a5,9f,80,59,52,5a,65,71,85,9a,a7,a4,a2,a2,a1,a0,a0,9f,9e,9c,9c,9b

line 5: a7,a7,a7,a8,a9,a9,ab,ab,97,57,35,2b,30,2b,29,2b,28,36,34,2c,3e,7f,a7,ac,aa,aa,a7,a7,a6,a6,a5,a5,a5,a5,a5,a4,a4,a4,a4,a5,a4,9a,7f,58,3f,3f,41,41,45,3c,33,3b,64,98,a6,a2,a1,9f,9f,9f,9d,9d,9d,9c

line 6: a7,a7,a8,a8,a8,ab,a7,7a,3f,29,28,30,3d,2c,1f,1b,1b,2a,35,3a,31,38,77,a7,ab,aa,a7,a7,a6,a6,a5,a6,a5,a5,a4,a3,a3,a4,a4,a5,97,65,2c,21,35,4d,52,53,48,38,31,2d,26,40,8b,a5,a0,a0,9f,9e,9e,9d,9c,9c

line 7: a7,a8,a8,a7,a9,a6,7e,3f,28,23,25,30,34,28,20,1f,21,1f,38,3b,32,2e,37,7b,ae,a9,a8,a7,a6,a6,a6,a5,a5,a4,a4,a3,a3,a4,a5,a1,5d,20,26,38,3b,3b,37,3d,40,3f,39,34,31,26,3b,90,a3,a1,a0,9f,9e,9e,9d,9c

line 8: a7,a8,a8,a8,aa,92,52,2f,23,21,25,30,43,3d,27,26,27,2e,54,43,30,2e,28,44,96,ac,a9,a7,a6,a6,a6,a6,a6,a6,a5,a4,a3,a5,a2,59,23,2b,34,43,4a,36,2d,3a,42,44,45,3a,37,31,27,53,9f,a2,a0,9f,9e,9e,9d,9c


part 2 of 8

line 9: a7,a7,a7,a8,aa,6a,2d,2c,23,21,2a,3a,52,52,3c,36,36,40,4c,3e,2c,2e,27,25,57,a9,a9,a6,a6,a5,a6,a6,a6,a5,a5,a4,a4,a6,6c,23,26,37,4e,46,37,31,2f,37,3b,39,3e,42,38,37,31,33,77,a1,a1,9f,9e,9d,9d,9d

line 10: a7,a8,a7,a7,aa,5a,22,26,23,21,2d,3f,64,74,6b,72,73,62,66,38,24,24,26,23,38,9b,aa,a7,a7,a6,a6,a6,a5,a5,a4,a4,a5,99,44,2c,33,3a,3d,41,3f,3c,3c,3a,36,31,35,41,45,3c,36,31,57,95,a0,9f,9f,9e,9d,9c

line 11: a7,a7,a7,a7,ab,59,20,27,21,23,35,57,84,99,a1,a9,a7,93,89,4e,24,23,24,24,24,70,aa,a7,a6,a6,a6,a6,a6,a5,a4,a5,a7,73,30,30,31,31,34,38,4a,50,40,39,30,31,32,3c,43,43,38,2f,43,8e,9d,9f,9f,9d,9d,9d

line 12: a7,a7,a7,a8,a3,42,21,22,23,29,42,76,a6,ad,ae,b2,b1,aa,a1,89,50,27,23,1f,1f,2c,89,a8,a6,a6,a6,a6,a6,a5,a5,a5,a0,48,2b,2c,2b,2c,37,3c,35,40,4b,3b,32,30,31,35,3d,3e,3b,30,34,8c,9f,a0,9e,9d,9d,9c

line 13: a7,a7,a8,ab,89,27,22,21,24,28,46,8a,ac,b1,b2,b3,b1,ae,b0,9f,82,3e,24,1d,1f,1c,5f,a8,a6,a6,a6,a6,a5,a5,a5,a7,8e,34,2e,30,2e,2e,31,37,34,2c,46,4c,35,30,31,33,3a,3c,39,33,32,8f,a2,a0,9f,9e,9d,9c

line 14: a8,a8,a8,ab,83,23,1f,21,21,28,58,9b,aa,b6,ba,b5,b3,b1,9e,8b,86,5a,25,1d,1d,1c,53,a9,a6,a6,a6,a6,a6,a6,a5,a8,83,2e,35,34,32,2c,2c,2c,2d,2a,28,47,50,33,2b,2c,34,3c,41,38,2a,65,a3,a0,9f,9e,9d,9c

line 15: a7,a7,a7,a9,94,28,20,22,29,5d,84,7a,78,82,9e,ac,ac,96,68,69,6b,58,33,1d,1c,1d,77,aa,a6,a7,a7,a6,a5,a6,a5,a7,8c,33,37,3d,38,39,32,26,20,21,27,27,3e,4a,3b,33,34,2d,2a,2f,29,43,a1,a0,a0,9f,9d,9c

line 16: a7,a7,a8,a8,a3,39,21,21,3b,82,71,7f,7d,72,85,a0,9b,76,6b,68,6c,5a,38,1c,1c,25,91,a9,a6,a6,a7,a6,a6,a6,a5,a5,a2,53,2e,39,60,84,59,35,38,3d,28,21,20,25,2d,2d,27,21,23,26,26,6f,a5,a1,a1,9e,9e,9c


part 3 of 8

line 17: a8,a8,a8,a7,ab,5f,1d,21,39,7b,83,71,51,62,80,9b,93,6f,6e,51,53,6d,45,1c,1b,3d,a3,a6,a6,a6,a6,a6,a6,a5,a5,a4,a6,93,4a,53,4d,a3,70,55,51,42,61,52,3a,28,1f,1d,1e,1e,21,22,37,9e,a5,a1,a1,9f,9e,9d

line 18: a8,a8,a8,a7,a9,86,26,1f,32,80,98,82,7e,8b,8b,a0,a2,7d,8a,8a,88,7f,55,22,22,7f,aa,a6,a6,a6,a7,a6,a5,a5,a5,a5,a4,a7,7c,5e,83,a5,9c,7b,6e,5f,93,a1,89,5e,2c,25,2b,27,1f,1c,48,96,96,a0,a0,9f,9e,9d

line 19: a7,a9,a8,a7,a8,a3,66,2b,33,83,95,9d,9e,a0,92,a1,ab,7f,93,a1,9e,81,57,37,60,a9,a7,a6,a6,a7,a6,a6,a7,a6,a5,a5,a5,a3,8d,90,a1,a4,ae,a6,99,a6,a9,9e,8d,72,38,67,71,79,37,1b,35,61,51,8c,a0,9e,9e,9e

line 20: a7,a9,a8,a8,a8,aa,9b,5e,54,83,96,a6,ae,a6,97,a4,af,88,8c,a4,a4,80,58,3e,83,ab,a7,a7,a6,a6,a7,a6,a6,a6,a5,a6,a5,a2,8f,9b,aa,a2,a4,aa,b4,b5,a5,92,82,6f,41,76,8a,9f,43,20,1e,3e,40,53,92,98,9f,9e

line 21: a8,a9,a8,a7,a8,a9,a2,6d,69,81,95,a7,a2,9e,8a,8d,92,64,7f,95,9a,78,56,61,97,aa,a7,a7,a7,a6,a6,a6,a5,a5,a5,a4,a4,a4,8d,8f,8b,83,92,9c,b4,b0,9d,88,7f,76,5e,6b,8d,57,21,20,22,21,22,3b,73,8b,92,9a

line 22: a8,a8,a8,a8,a9,a9,a7,97,91,80,8e,9b,9c,9a,86,7b,70,6d,7d,8b,97,75,52,6f,a5,a9,a8,a6,a7,a7,a6,a6,a6,a5,a5,a5,a5,a6,92,6f,68,8b,a6,a2,97,9b,8d,86,83,7e,5e,4b,30,1b,1e,1d,1e,1f,24,31,59,73,72,90

line 23: a8,a8,a9,a8,a8,a8,a8,a2,78,7c,8e,a0,98,83,83,85,82,72,63,85,9d,72,58,98,aa,a8,a7,a6,a6,a7,a6,a6,a6,a5,a5,a5,a5,a5,9f,7b,57,6c,79,7c,7c,92,96,91,8b,77,4f,3d,1f,1e,1e,1f,20,23,25,26,4c,6c,7b,95

line 24: a8,a8,a8,a8,a8,a7,a7,ab,6c,69,8e,9a,a3,99,93,95,8f,84,82,95,91,66,62,a6,a9,a8,a7,a7,a6,a6,a6,a7,a5,a6,a6,a6,a5,a4,9c,80,60,69,82,90,9d,9d,97,91,89,60,57,3f,1f,1d,20,20,22,24,26,21,40,7a,82,98


part 4 of 8

line 25: a8,a7,a7,a8,a7,a8,a8,a9,a0,75,85,91,9b,a3,a5,9d,8f,8f,91,84,71,54,7e,aa,a7,a7,a8,a7,a6,a7,a6,a6,a6,a6,a5,a5,a5,a2,95,6d,77,8c,9d,a3,a3,9e,95,8c,70,57,73,3e,1b,1e,21,20,21,22,25,21,24,6f,8b,99

line 26: a8,a8,a7,a8,a8,a8,a8,aa,ab,88,6d,80,8c,95,91,96,9d,8f,82,6e,53,45,8b,ab,a8,a8,a8,a8,a7,a7,a6,a6,a6,a5,a5,a5,a4,a1,94,67,81,a6,ae,ac,a8,9e,8a,6b,5e,7b,87,3b,1a,1d,21,21,1f,1f,22,21,1d,46,86,90

line 27: a7,a7,a7,a7,a9,a8,a9,a2,a9,91,68,65,6e,7a,88,97,98,93,72,4e,47,45,8f,ad,a8,a8,a7,a7,a7,a7,a7,a7,a6,a6,a6,a6,a5,a1,93,6b,75,9b,a7,a2,8c,71,60,63,7d,95,8b,41,1b,19,1e,23,1f,1e,1f,20,1d,30,69,85

line 28: a7,a7,a7,a7,b2,a5,9a,81,80,96,73,6d,65,63,69,6d,67,65,53,4b,52,50,63,91,a8,ac,a9,a8,a7,a8,a6,a6,a6,a6,a7,a8,a5,a0,99,84,58,49,5a,67,64,69,73,82,93,9a,8b,50,32,23,1f,21,22,1f,1f,1e,1f,28,5d,80

line 29: a7,a7,a9,b6,a4,a9,81,5c,38,60,7b,7f,74,6b,69,64,69,62,56,5d,64,61,44,4e,53,80,9a,a6,ab,a8,a7,a7,a8,a9,a1,94,88,7c,7b,67,52,38,3d,57,71,81,87,8e,9b,9c,8f,68,5e,45,2b,1c,1d,1e,1e,1e,1e,1f,35,5d

line 30: a7,b6,ab,c3,93,9a,88,32,48,6e,7b,8d,82,79,7a,78,7b,6b,64,6d,79,6a,58,70,45,55,70,5d,82,a9,ab,a9,a3,8e,81,7a,73,78,76,68,59,43,42,53,6c,80,89,93,9c,9c,92,7a,7a,63,40,2f,24,20,1d,1d,1d,1d,1e,2b

line 31: ab,b4,c2,b6,b4,79,a0,48,6c,7c,77,92,93,85,85,87,7a,74,76,82,83,73,75,89,56,5c,82,51,42,58,8c,8e,70,5e,68,69,71,80,73,70,62,4b,48,56,68,7f,8f,99,9f,99,86,77,6c,5f,5f,52,46,42,32,23,1c,1b,1d,1e

line 32: 9e,8b,b0,90,a5,84,5f,41,7f,84,78,8d,98,98,89,7d,7c,84,89,8c,83,7c,8b,96,5c,65,8d,59,42,2d,50,63,6e,79,7d,63,70,75,6c,78,64,53,4a,5f,6e,7f,91,9b,99,89,78,70,69,68,62,59,55,58,5d,56,46,2c,1b,1a


part 5 of 8

line 33: 80,7e,73,57,77,6d,3e,39,85,8c,7f,8a,9a,9d,96,89,8d,90,8f,8d,8b,8b,98,a0,61,69,92,5c,45,2c,43,5a,5f,6f,62,57,69,6a,64,76,64,5b,4b,5b,77,7b,8b,92,86,7b,77,6f,6c,63,5f,62,68,70,6d,71,71,63,40,1e

line 34: 80,91,95,5c,87,73,39,3d,86,8d,87,8b,95,99,93,91,94,95,91,90,90,95,9c,9d,61,6d,97,5d,46,2c,46,5a,5a,5c,63,5f,5e,66,5b,68,62,60,50,4f,6e,73,7d,7e,65,70,73,6d,66,62,66,6d,73,72,79,7f,81,7f,73,54

line 35: b9,ed,c9,7f,ba,a6,62,47,74,7b,79,83,88,90,91,8d,98,8c,8b,97,93,94,97,9a,5b,70,9b,62,48,2e,4e,57,57,5a,5b,5d,5d,62,58,5e,5e,61,58,58,52,54,5d,54,59,6b,67,6c,66,69,6d,71,6d,7a,7f,7c,84,88,6a,74

line 36: f1,f3,95,dc,fb,dd,b5,7f,4b,64,6e,76,7d,88,92,91,95,8b,93,93,8c,89,8b,90,5b,6f,a0,67,47,63,5c,51,54,54,54,52,51,5a,55,5e,5c,5e,5a,63,51,4f,5b,53,58,60,66,67,6b,6d,6e,6a,70,7f,80,6f,85,75,50,6d

line 37: f3,f3,8e,ab,fe,9a,33,2a,25,3d,5c,6d,75,87,8f,8b,8c,89,8b,85,81,7a,78,86,5e,6f,a6,6b,44,bb,cc,6c,4d,52,52,4d,45,45,52,5b,59,57,5c,65,54,4b,5c,58,59,60,65,62,6a,6a,6c,63,79,7c,73,6b,75,59,53,70

line 38: f3,f3,92,5f,b1,63,3b,86,6b,30,26,33,4a,6b,7d,6a,78,76,7b,7a,76,73,70,63,44,72,a4,6c,43,ad,f4,d9,88,4b,4c,49,41,3a,47,56,5e,59,5a,63,57,54,56,59,55,61,64,64,68,66,5f,6c,7c,7b,71,62,65,4f,59,6c

line 39: f2,f2,88,7b,97,51,42,bb,e1,bf,84,4c,2c,26,2e,33,43,4d,59,59,4b,37,29,22,35,6e,a1,6c,42,a2,ec,e6,dd,64,45,43,3d,39,3d,4c,5a,59,56,62,55,53,54,57,53,5a,61,65,65,5f,5b,75,78,75,5c,63,5c,52,61,64

line 40: f3,ed,7d,8a,9c,4e,48,c4,dd,dd,de,d6,b4,87,60,48,37,2e,2c,2e,36,4a,6c,a6,81,64,a0,6f,42,98,ea,e3,e9,8f,3d,3f,3c,38,38,3e,53,56,53,62,5a,53,56,55,54,55,63,65,64,54,61,6c,7a,6c,56,6a,55,59,69,5d


part 6 of 8

line 41: d8,e8,75,91,8f,48,4f,ce,da,d7,d6,d5,d7,da,d8,ce,c4,be,ba,bc,c3,cf,d7,e0,90,62,a2,70,3f,91,e8,e4,e9,8d,37,40,3a,37,35,37,50,55,4f,5b,65,58,5a,55,55,54,64,64,5e,52,63,65,66,50,63,64,55,5b,6c,5b

line 42: 68,de,6d,93,85,45,57,d4,d8,d5,d3,d3,d3,d3,d3,d3,d4,d6,d5,d2,d0,d0,cf,d7,90,63,a2,6e,3e,8c,e4,de,e8,7a,3c,38,37,35,33,33,4f,55,4b,54,67,5e,5c,58,55,55,5f,65,4e,58,63,66,5e,4d,66,5b,51,5c,6e,60

line 43: 37,a6,6d,96,7b,40,63,d9,d7,d3,d2,d0,d0,d1,d0,d0,d0,cf,cd,cb,c9,ca,cb,d2,90,52,6b,44,37,8b,e0,d8,c5,58,32,33,33,31,31,2f,49,56,47,4c,5f,5d,60,5e,56,54,5d,5c,3b,48,57,62,5a,52,5f,56,52,60,6f,66

line 44: 37,3c,5e,96,72,3c,69,da,d5,d3,d2,cf,cd,cf,ce,cc,cd,ca,c8,c5,c6,c7,c8,cc,89,53,74,50,2e,83,e0,a9,66,33,2c,2f,30,30,2e,2d,45,56,45,3f,4a,58,61,63,5e,53,5b,4e,36,34,4e,5e,52,54,5c,56,55,66,73,6b

line 45: 4c,23,50,95,68,45,9a,c0,b6,ba,b9,c3,cc,ca,c4,cb,c5,c5,c4,c1,be,b4,ad,aa,98,95,89,62,51,65,b2,70,3e,29,2d,2f,2f,2c,2c,2b,44,57,46,3e,42,54,5e,64,61,51,57,48,3c,31,4a,5b,4b,53,5b,59,59,68,71,69

line 46: 56,2d,4b,8d,5d,5e,b6,b2,ad,a8,a4,b4,c4,bb,b1,a7,ad,bb,b3,b8,b3,9d,92,9d,9f,a2,83,62,54,6b,8a,3f,2c,2d,2f,2e,2c,2c,2b,2a,42,56,48,40,4d,52,5d,65,62,52,54,49,44,36,48,59,45,54,5b,5b,5e,69,70,68

line 47: 62,3f,46,7d,6a,a1,b5,ac,a8,a4,ad,b4,af,a9,b8,9f,b0,c0,a1,94,9b,98,97,9e,aa,b0,94,58,42,6b,78,23,28,29,2a,2b,2b,2a,2a,29,41,55,4d,3a,46,4f,60,67,62,54,52,4d,4a,3c,44,54,41,52,59,5c,60,6a,6c,66

line 48: 69,50,56,64,6b,a6,ae,a9,a1,98,a4,bc,ba,a7,94,cc,ea,ab,8d,b6,bb,a4,a1,a0,9d,9f,86,3f,29,4c,42,28,2d,2b,2c,2d,2c,2b,2a,27,3e,56,53,3e,44,4a,5e,6b,61,59,51,52,49,3e,39,51,3f,51,57,5c,60,6a,6a,65


part 7 of 8

line 49: 6a,5b,4e,6d,5b,93,b6,a8,9b,98,99,90,8c,9b,ab,e6,ec,a9,ac,b2,8f,67,63,83,9e,aa,7b,44,2d,2e,2a,2f,32,2f,2e,2d,2c,2b,29,26,36,57,56,43,46,45,57,6b,61,5d,4f,57,48,3a,34,4f,41,51,55,59,60,6a,65,68

line 50: 68,5f,49,78,66,8c,a8,a2,9d,a9,a6,b0,9f,84,a7,f4,ec,96,81,73,6b,77,95,95,a0,a5,77,44,30,26,2a,33,34,32,31,2f,2d,2b,29,25,2b,53,58,48,44,43,4d,65,64,5e,50,54,4a,34,33,4f,45,4f,54,5a,64,65,62,6e

line 51: 67,61,48,69,5c,6e,a0,99,83,75,7e,91,9a,90,c8,f4,f0,ab,74,8f,a6,a3,91,79,91,97,67,47,3c,26,2c,35,42,3d,32,2d,2c,2d,62,35,21,4c,58,55,49,42,40,56,60,5e,51,53,4d,33,2d,4d,48,4c,55,5e,65,60,63,73

line 52: 65,61,48,51,49,5c,a1,a7,9e,a6,99,8f,83,a3,db,f4,ef,b5,84,86,8e,84,84,97,9f,8f,54,43,40,2c,2c,3b,a1,a9,8a,6a,46,2a,6f,69,23,42,55,5a,62,51,3a,46,52,57,52,52,53,3d,2b,4a,4c,54,5d,61,5e,5e,6e,68

line 53: 64,5f,4b,44,46,49,83,92,7d,94,97,99,ad,c9,e2,f5,f1,cb,ab,86,7f,97,9c,8d,91,7e,49,3a,41,3e,37,3d,45,5a,79,a2,9b,65,43,7d,45,36,54,5c,7b,64,44,3d,47,4e,4c,52,52,4b,29,42,4b,59,5e,5a,5b,67,6a,59

line 54: 60,5a,4a,5a,5b,4b,71,82,89,b5,bb,aa,ba,d4,e7,f7,f2,ce,b9,a2,94,ac,b7,a2,8c,85,66,49,4b,48,56,9b,9d,7f,60,47,66,93,74,77,6f,30,51,5a,5f,65,59,44,3e,4a,46,4e,50,4d,31,37,42,55,59,60,64,66,60,56

line 55: 5e,58,48,5e,78,65,81,9e,b5,d2,d1,b4,ba,d5,e8,f6,ed,c9,bd,ad,ad,d0,cd,d3,c5,b6,8a,51,53,4a,3b,5a,76,97,a0,9c,73,80,9c,90,88,47,44,5a,5f,60,5c,5c,48,40,43,46,4d,4c,41,35,38,4b,59,64,6d,63,59,57

line 56: 68,51,4f,60,6b,65,98,ba,cf,d1,d1,c0,ca,d7,e5,f4,ed,cb,bf,ba,b3,ce,ca,e5,ed,e8,d2,98,6f,4b,3b,3d,51,5a,62,7e,97,a5,a6,90,7d,55,2f,5b,65,63,57,5a,5d,49,3c,3f,48,4a,48,40,33,33,4b,60,6e,69,61,5d


part 8 of 8

line 57: 6c,54,5a,6b,88,a3,be,d7,d6,c7,c7,c3,d5,da,ea,f4,ec,c9,c2,ca,bc,c2,c3,d6,ed,ea,e7,ea,eb,c6,60,36,5b,92,96,97,91,a2,9f,88,78,58,2b,49,66,69,5c,51,56,5c,51,40,40,4a,4b,48,32,21,30,48,67,6f,68,64

line 58: 63,57,5f,bc,da,b9,ce,e1,d1,c2,c7,ce,d8,e0,f2,ef,e6,c8,c6,d2,cb,ba,be,cc,e9,e8,e9,eb,eb,f4,d0,45,37,4c,61,6b,91,a9,9c,82,79,6a,3f,35,55,64,66,5c,56,57,61,5b,45,40,4c,4d,42,22,21,2f,58,66,6a,65

line 59: 60,52,55,8e,9f,c1,da,db,ca,c6,c9,d7,dd,e4,f4,f1,dc,c5,c8,d2,d3,c3,be,ce,e2,e9,ea,ed,eb,ef,db,44,31,3c,55,82,93,9e,92,82,7a,76,6b,40,3b,47,52,58,5c,56,5a,5f,55,42,45,4c,4a,36,2b,3b,49,52,60,66

line 60: 62,44,63,79,bb,de,df,d3,ca,c9,d2,de,e1,dd,ef,ef,d2,c3,cb,d3,d6,cd,cc,d6,de,e5,e4,e3,e9,ee,c9,3a,2d,33,3d,4a,76,85,82,86,7e,7c,80,78,70,69,60,5a,57,54,51,4d,46,3e,43,3f,3f,3c,2d,28,2c,30,38,4c

line 61: 5f,68,69,4e,aa,e3,db,cc,cb,cf,da,e0,e0,e2,f0,e7,cd,c5,c9,d0,d8,d0,d0,dc,e0,e5,e5,e8,eb,f0,c0,56,38,2c,33,3a,3e,4f,77,81,7f,83,88,83,81,86,86,84,80,7a,73,6d,6a,61,53,52,53,52,4d,4b,3a,42,2e,36

line 62: 6e,77,48,33,66,dc,df,d3,d2,d4,dc,e2,dc,dc,ee,e3,d2,c7,c8,cf,db,d6,d5,db,dd,de,df,e3,e4,e9,ca,44,54,39,2b,31,37,34,46,6c,7d,88,8c,91,92,94,95,96,94,90,8b,86,83,7a,61,59,5d,5b,5d,55,56,51,55,47

line 63: 76,5a,5a,4f,54,b8,d6,d1,db,df,e4,e5,df,cb,c4,c2,bd,c5,c8,d1,db,e4,df,db,db,dd,e1,e1,e1,e9,d4,3b,2e,51,3a,29,2f,32,29,3e,52,64,79,7c,81,88,8f,97,99,9b,98,93,92,84,60,5d,63,5f,65,5b,53,57,5c,59

line 64: 5a,5a,56,4f,53,92,c5,d7,df,e9,eb,e9,de,d1,c2,bb,98,b0,ca,d8,e5,e8,e5,da,da,dd,dd,df,df,e7,c2,32,26,2b,50,37,28,2d,29,2d,20,21,34,41,48,54,62,71,7e,86,8b,8d,90,83,58,64,60,5b,61,5c,4e,46,4b,4f
```

And to view it, you just manipulate those numbers into the following Python
list of tuples data structure:

```python
list = [tuple, tuple, typle... tuple]
```

Where each tuple is a line of Mork an Mindy. You could use `line.split(',')` to
make a tuple of each line above. Of course you'd have to follow Python syntax
but that will get you on the right track.

Is this clear?

Nanu nanu (pronounced NAH-noo NAH-noo).














<div class="arrow-links"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/hey-robbie-be-i-robot-and-not-irobot-okay/">Hey Robbie: Be 'I, Robot' and not 'iRobot', Okay?</a></div> &nbsp; <div class="post-nav-next"><a href=""></a></div></div>
## Categories

<ul></ul>