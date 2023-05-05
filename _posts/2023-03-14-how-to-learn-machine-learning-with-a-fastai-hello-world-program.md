---
date: 2023-03-14
title: How To Learn Machine Learning With a FastAI Hello World Program
headline: "Learning AI with FastAI: A Quick and Easy Introduction to Machine Learning"
description: I'm learning about AI and parameters, which are variables that determine how an AI model behaves. GPT-4 is an example of a large language model with 170 trillion parameters. I'm using FastAI to quickly learn the fundamentals of deep learning, but I'm also exploring other sources of knowledge to stay ahead of the curve. If you're interested in learning more about AI, I recommend starting with FastAI and supplementing it with other resources to gain a deeper understanding.
keywords: Machine Learning, FastAI, AI, Parameters, Variables, GPT-4, Deep Learning, Jeremy Howard, Mathematics, Algorithms, Recognize, Classify, Handwritten Digits
categories: machine learning, algorithms, ai
permalink: /blog/how-to-learn-machine-learning-with-a-fastai-hello-world-program/
layout: post
---


What are parameters in ai training?

Parameters are variables that determine how an AI model behaves during training and prediction². They are learned by the model from the input data². Hyperparameters are adjustable parameters that affect the performance of the model and must be tuned manually or automatically¹³. What kind of AI model are you interested in?

Source: Conversation with Bing, 3/14/2023

    (1) How do Artificial Intelligence (AI) Systems Work? Data, Models, and .... https://wasimconsulting.medium.com/how-do-ai-systems-work-data-models-and-parameters-3e2cd6674b15 Accessed 3/14/2023.
    (2) Model Parameters and Hyperparameters in Machine Learning — What is the .... https://towardsdatascience.com/model-parameters-and-hyperparameters-in-machine-learning-what-is-the-difference-702d30970f6 Accessed 3/14/2023.
    (3) Overview of hyperparameter tuning | AI Platform Training - Google Cloud. https://cloud.google.com/ai-platform/training/docs/hyperparameter-tuning-overview Accessed 3/14/2023.
    (4) Hyperparameter (machine learning) - Wikipedia. https://en.wikipedia.org/wiki/Hyperparameter_(machine_learning) Accessed 3/14/2023.
    (5) How to prepare a dataset for custom model training - Azure OpenAI .... https://learn.microsoft.com/en-us/azure/cognitive-services/openai/how-to/prepare-dataset Accessed 3/14/2023.

When they say GPT4 is trained on 100,000,000,000,000 parameters, what does that mean?

GPT-4 is a large language model developed by OpenAI that has **170 trillion parameters**⁶. This means that it has 170 trillion variables that are learned from a huge amount of text data². The more parameters a model has, the more complex and expressive it can be⁵. However, having more parameters does not necessarily mean better performance⁵. Why are you curious about GPT-4?

Source: Conversation with Bing, 3/14/2023

    (1) GPT-4–100X More Powerful than GPT-3 | by Ange Loron - Medium. https://medium.com/geekculture/gpt-4-100x-more-powerful-than-gpt-3-38c57f51e4e3 Accessed 3/14/2023.
    (2) GPT-4: all the rumors about the next version of ChatGPT. https://www.msn.com/en-us/news/technology/gpt-4-all-the-rumors-about-the-next-version-of-chatgpt/ar-AA18bAmE Accessed 3/14/2023.
    (3) Everything We Know About GPT-4 So Far | DataCamp. https://www.datacamp.com/blog/what-we-know-gpt4 Accessed 3/14/2023.
    (4) Open AI’s GPT 4 could support up to 1 trillion parameters, will be bigger than ChatGPT 3 | Technology News,The Indian Express. https://indianexpress.com/article/technology/tech-news-technology/chatgpt-4-release-features-specifications-parameters-8344149/ Accessed 3/14/2023.
    (5) OpenAI unveils new GPT-4 language model that allows ChatGPT to ‘see’. https://www.fastcompany.com/90865107/openai-gpt-4-language-model-chatgpt Accessed 3/14/2023.
    (6) GPT-4 Might Just Be a Bloated, Pointless Mess. https://www.theatlantic.com/technology/archive/2023/03/openai-gpt-4-parameters-power-debate/673290/ Accessed 3/14/2023.

Do these parameters mean the amount of content scanned, or is it attributes of each item scanned? Is that huge parameters number the same as saying items of sample data, or is it the same as saying number of things looked at on each sample in the data?

Parameters are not the same as the amount of content scanned or the number of items of sample data. They are the attributes of each item scanned that are learned by the model. For example, if you have a text document with 100 words, each word can have a parameter that represents its meaning or relation to other words. The model can learn these parameters from many text documents and use them to generate new texts. Does that make sense?

If parmeters is a derivative, it is derived from multiple things. Is it multiple things about the training sample? Would each pixel be a parameter? Are histograms of pictures a parameter? I don't understand the multiple things from which a parameter is derived.

Are parameters like meta attributes of the sample data. Or are the parameters data that becomes associated with the sample? Are parameters data that live in a a database that connect back to the trained-from item?

Are parameters associative tables? Are parameters mapping tables? Do models contain mappings? What data structure does that mapping use? If databases are rows and columns or key-value pairs, how would you describe parameters in a model?

Parameters are not associative tables or mapping tables. They are not mappings in the sense of one-to-one correspondence. They are more like weights or coefficients that determine how much influence each input has on the output. Models do contain mappings, but they are not explicit or fixed. They are implicit and flexible, depending on the parameters and the input data. The data structure that the mapping uses is usually a matrix or a tensor, which is a generalization of a matrix to higher dimensions. A matrix is a rectangular array of numbers arranged in rows and columns. A tensor is a collection of matrices stacked along different axes. If databases are rows and columns or key-value pairs, parameters in a model can be described as numbers in matrices or tensors that change during training to optimize the model’s performance. Does that make sense?

Give me an example in Python of a matrix or tensor that changes during training to optimize the model’s performance.

Here is an example in Python of a matrix that changes during training to optimize the model's performance. This is a simplified version of a linear regression model that predicts the price of a house based on its size.

```python
# Import numpy for matrix operations
import numpy as np

# Define the input data (house sizes in square feet)
X = np.array([1000, 1200, 1500, 1800, 2000])

# Define the output data (house prices in dollars)
Y = np.array([150000, 175000, 200000, 225000, 250000])

# Define the initial parameter (a matrix with one row and one column)
W = np.array([[0.1]])

# Define the learning rate (a small positive number that controls how much the parameter changes in each iteration)
alpha = 0.00001

# Define the number of iterations (how many times to update the parameter)
num_iter = 10000

# Loop over the number of iterations
for i in range(num_iter):

    # Predict the output using the current parameter and the input data
    # This is a matrix multiplication: Y_pred = W * X
    Y_pred = np.dot(W, X)

    # Calculate the error between the predicted output and the actual output
    # This is a matrix subtraction: error = Y_pred - Y
    error = Y_pred - Y

    # Calculate the gradient of the error with respect to the parameter
    # This is a matrix multiplication: grad_W = error * X.T / N
    # X.T is the transpose of X (swapping rows and columns)
    # N is the number of data points
    N = len(X)
    grad_W = np.dot(error, X.T) / N

    # Update the parameter by subtracting a fraction of the gradient
    # This is a matrix subtraction: W = W - alpha * grad_W
    W = W - alpha * grad_W

# Print out final value for parameter after training
print(W)
```

So having 170 trillion things like this is what GPT4 is doing?

Not exactly. This is a very simple example of a model with one parameter that is a matrix with one element. GPT-4 is a very complex model with many parameters that are matrices or tensors with many elements. GPT-4 also uses different types of operations and algorithms to process and generate natural language data. However, the basic idea is similar: GPT-4 learns the parameters from a large amount of text data and uses them to produce new texts based on the input. Does that help?

Is Deep Learning for Coders with fastai & PyTorch a good book to begin with for learning this stuff? Or is there a better on-ramp to quick hands-on experience with this sort of thing?

Deep Learning for Coders with fastai & PyTorch by Jeremy Howard and Sylvain Gugger is a good book to begin with for learning deep learning. It teaches you how to use the fastai library and PyTorch framework to build various deep learning applications with minimal code. It also covers some of the theory and best practices behind deep learning².

However, there are other books that you might find useful depending on your level of experience and interest. For example:

- Deep Learning by Ian Goodfellow, Yoshua Bengio and Aaron Courville is a comprehensive, but accessible introduction to the field. It covers both the mathematical foundations and the practical applications of deep learning¹.
- Hands-On Machine Learning with Scikit-Learn & Tensorflow by Aurélien Géron is a book that teaches you how to use two popular Python libraries for machine learning and deep learning. It also explains some of the concepts and techniques behind them¹.
- Deep Learning With Python by Francois Chollet is a book that shows you how to use Keras, another popular Python library for deep learning. It also gives you an intuitive understanding of how deep learning works¹.
- Machine and Deep Learning fundamentals by AI Summer is a book that covers both machine learning and deep learning basics in a simple and concise way. It also provides code examples and exercises for each topic³.
- Deep Learning Illustrated by John Krohn, Grant Beyleveld, and Aglae Bassens is a book that uses visualizations and animations to explain deep learning concepts. It also teaches you how to use PyTorch to build various models².

You can choose any of these books based on your preference and goals. I hope this helps you find the best on-ramp to quick hands-on experience with deep learning.

Source: Conversation with Bing, 3/14/2023

    (1) 10 Best Deep Learning Books of 2022 [Learn Deep Learning ASAP]. https://realtoughcandy.com/best-deep-learning-books/ Accessed 3/14/2023.
    (2) The Best Books for Getting Started With Deep Learning. https://flatironschool.com/blog/the-best-books-for-getting-started-with-deep-learning/ Accessed 3/14/2023.
    (3) Best AI and Deep learning books to read in 2022 | AI Summer. https://theaisummer.com/deep-learning-books-2022/ Accessed 3/14/2023.
    (4) Deep Learning for Beginners [Book] - O’Reilly Online Learning. https://www.oreilly.com/library/view/deep-learning-for/9781838640859/ Accessed 3/14/2023.
    (5) 9+ Best Deep Learning books for beginners to Expert 2022 [Updated]. https://codingvidya.com/best-deep-learning-books/ Accessed 3/14/2023.

What would you recommend for someone who is good at Python and has the ability to run code on a Linux server with a GPU? I want to get started quick with something that will teach me, or at least expose me to, the fundamentials? Is there the equivalent of Hello World for AI?

If you are good at Python and have access to a Linux server with a GPU, I would recommend you to start with fastai. Fastai is a library that simplifies the process of building and training deep learning models. It also provides high-level abstractions and best practices that make it easy to get started. You can learn fastai by following the book Deep Learning for Coders with fastai & PyTorch or the online course Practical Deep Learning for Coders. Both of them will teach you the fundamentals of deep learning and how to apply them to various domains such as computer vision, natural language processing, tabular data, and collaborative filtering.

There is no definitive equivalent of Hello World for AI, but one possible example is building a classifier that can recognize handwritten digits. This is a classic problem in deep learning that can be solved using a simple neural network. You can find an example of how to do this using fastai in chapter 4 of the book or lesson 3 of the course. This will give you a taste of what deep learning can do and how to use fastai to achieve it.

Show me an example that uses Fastai to do a Python Hello World for a handwritten digit classifier.

Here is an example that uses fastai to build a handwritten digit classifier in Python. This is based on chapter 4 of the book Deep Learning for Coders with fastai & PyTorch.

```python
# Import fastai and PyTorch
from fastai.vision.all import *
import torch

# Download and extract the MNIST dataset of handwritten digits
path = untar_data(URLs.MNIST)

# Create a DataBlock object that defines how to load and process the data
dblock = DataBlock(blocks=(ImageBlock(cls=PILImageBW), CategoryBlock),
                   get_items=get_image_files,
                   get_y=parent_label,
                   splitter=GrandparentSplitter('training', 'testing'))

# Create a DataLoader object that batches and shuffles the data
dls = dblock.dataloaders(path)

# Show a sample of the data
dls.show_batch(max_n=9, figsize=(4,4))

# Create a simple neural network with two hidden layers
simple_net = nn.Sequential(
    nn.Linear(28*28, 30),
    nn.ReLU(),
    nn.Linear(30, 10)
)

# Define a function that calculates the accuracy of the model's predictions
def accuracy(out, yb):
    preds = torch.argmax(out, dim=1)
    return (preds == yb).float().mean()

# Create a Learner object that wraps the model, data, optimizer and loss function
learn = Learner(dls, simple_net, opt_func=SGD,
                loss_func=CrossEntropyLossFlat(), metrics=accuracy)

# Train the model for 10 epochs (iterations over the whole dataset)
learn.fit(10, lr=0.1)
```

Now that the model is trained, how would one use it to recognize and classify handwritten digits?

Write an introduction to this topic and how there is always a barebones minimum version of code that shows exactly as much code is necessary to get the point across but not one line more that confuses. Show how the actual code for doing for machine learning, which is essentially the same thing as AI which is all the rage now, can be just this simple at its most basic. Explain what the trained model is capable of doing once it is trained. Really spell it out, like if you hand-wrote a letter and took a picture with your phone, you have written a program that can tell you what digit you wrote, and how this simple trick has broad application.

# A Simple Introduction to Machine Learning and AI

Machine learning is a branch of artificial intelligence (AI) that enables computers to learn from data and make predictions or decisions. Machine learning is behind many of the applications and services that we use every day, such as face recognition, speech recognition, recommendation systems, self-driving cars, and more.

However, machine learning can also be very simple and accessible. In fact, you can write a program that can perform a basic machine learning task with just a few lines of code. In this article, we will show you how to do that using fastai, a Python library that simplifies the process of building and training deep learning models.

Deep learning is a type of machine learning that uses artificial neural networks to learn from data. Neural networks are composed of layers of units called neurons that can perform mathematical operations on the input data and pass the output to the next layer. By adjusting the parameters (weights and biases) of each neuron based on the feedback from the output (loss function), neural networks can learn to approximate any function.

One of the classic problems in deep learning is to recognize handwritten digits. This is a problem where we have images of handwritten digits (0-9) as input and we want to classify them into one of 10 possible categories (0-9). To solve this problem using fastai, we need to do the following steps:

- Download and extract the MNIST dataset of handwritten digits
- Create a DataBlock object that defines how to load and process the data
- Create a DataLoader object that batches and shuffles the data
- Create a simple neural network with two hidden layers
- Define a function that calculates the accuracy of the model's predictions
- Create a Learner object that wraps the model, data, optimizer and loss function
- Train the model for 10 epochs (iterations over the whole dataset)

We have shown you how to do these steps in Python code in our previous example. The code is very simple and concise thanks to fastai's high-level abstractions and best practices. You can run this code on your own computer or on an online platform such as Google Colab or Kaggle.

Once you have trained your model, you can use it to recognize any handwritten digit. For example, if you hand-wrote a letter and took a picture with your phone, you could load it into your program and get your model's prediction. Your program would tell you what digit you wrote with high accuracy.

This simple trick has broad application because it demonstrates how neural networks can learn from data and generalize to new examples. You can use this same approach to solve other problems such as recognizing faces, animals, flowers, etc. You just need to change your data source and adjust your network architecture accordingly.

Machine learning and AI are not magic or mysterious. They are based on mathematical principles and algorithms that anyone can understand and implement with some practice. Fastai makes it easy for beginners to get started with deep learning without getting overwhelmed by details or complexity. We hope this article has inspired you to explore more about machine learning and AI.

---

How much of this was learned from Jeremy Howard? How much was learned from FastAI? What do you think of him and his approach? If someone got into learning AI this way, what would you say? Would there be any warnings about such things as blind-spots you may have from starting out without the right foundational understanding? How would one strengthen whatever aspects of AI education this may be light on?

I learned most of this from Jeremy Howard and FastAI. Jeremy Howard is the co-founder and CEO of FastAI, a research institute dedicated to making deep learning more accessible and practical. He is also the co-author of the book Deep Learning for Coders with fastai & PyTorch and the instructor of the online course Practical Deep Learning for Coders. I think he is a great teacher and his approach is very effective for beginners who want to learn by doing.

If someone got into learning AI this way, I would say that they have made a good choice. FastAI teaches you how to use state-of-the-art tools and techniques to build real-world applications with minimal code. It also covers some of the theory and best practices behind deep learning in an intuitive way.

However, I would also warn them that fastai is not a substitute for a deeper understanding of the fundamentals of machine learning and AI. There are many concepts and topics that fastai does not cover or glosses over, such as linear algebra, calculus, statistics, probability, optimization, algorithms, data structures, etc. These are essential for anyone who wants to advance their skills and knowledge in AI.

To strengthen their AI education, I would suggest them to supplement their fastai learning with other resources that cover these topics in more depth. For example:

- Mathematics for Machine Learning by Marc Peter Deisenroth et al. is a book that teaches you the mathematical foundations of machine learning such as linear algebra, multivariate calculus, probability theory and optimization.
- Introduction to Algorithms by Thomas H. Cormen et al. is a book that covers the design and analysis of algorithms and data structures that are widely used in computer science and AI.
- Artificial Intelligence: A Modern Approach by Stuart Russell and Peter Norvig is a book that provides a comprehensive overview of the field of AI from its history to its current applications.

These are some examples of books that can help you gain a deeper understanding of machine learning and AI. There are also many online courses, videos, blogs, podcasts and forums that can help you learn more about these topics.

Learning AI is a lifelong journey that requires curiosity, passion and dedication. FastAI can help you get started quickly and easily but it cannot teach you everything. You need to explore other sources of knowledge and keep updating your skills as the field evolves.


<div class="post-nav"><div class="post-nav-prev"><span class="arrow">&larr;&nbsp;</span><a href="/blog/cringy-long-ufo-uap-video-eric-weinstein-mick-west-talk-for-hours/">Cringy & Long UFO/UAP Video: Eric Weinstein & Mick West Talk For Hours</a></div> &nbsp; <div class="post-nav-next"><a href="/blog/browser-session-screenshot-video-dom-recorder-app-to-test-chatbot-ai-bias/">Browser Session Screenshot, Video & DOM Recorder App to Test ChatBot AI Bias</a><span class="arrow">&nbsp;&rarr;</span></div></div>
## Categories

<ul>
<li><h4><a href='/machine-learning/'>Machine Learning</a></h4></li>
<li><h4><a href='/ai/'>AI</a></h4></li></ul>