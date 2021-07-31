# Instagram ML Prediction

## Project Scope

The idea of this project is to build an application that can merge social media with e-commerce in order to create a great shopping experience for users. We will use machine learning to retrieve features from an Instagram image. Send it to an API that has a deployed model to do the classification and return the data to the user. First, the mobile application will get the data from the database, once the user decides to retrieve information about a product, the mobile application will send the image to the API in order to classify it.

This project is divided into multiple services:

1. Machine Learning Model that classifies a given image.
2. Python Flask application to serve the ML Model as an API.
3. This iOS application that provides a graphical interface for the user. 
4. Firebase Database that holds the data used in this project.

## iOS Application
In order to communicate a visual representation of our result from the Machine Learning model. The mobile application is a replica of the Instagram layout except it has now a new functionality of retrieving data from shoe posts. It works by sending the shoe image to the deployed model in order to extract information regarding the item. Results include the shoe’s name, price, and a link to the official Nike website so that the user can buy it.

## Demo
![](https://media.giphy.com/media/XinWNcBulDAjl4RdGU/giphy.gif)
