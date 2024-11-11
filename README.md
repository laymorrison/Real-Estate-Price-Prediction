# Real-Estate-Price-Prediction
Project#1 Deployment: From AVM Model to Production

* Laymoni Morrison & Radhika Puri
* Email: lamorrison@chapman.edu & rapuri@chapman.edu 
* Course: MGSC-410-02
* Link to Powerpoint: https://docs.google.com/presentation/d/1-LSe8VO1pPurVkjoX7xtJhLGe6xbOeetKCztu3tnnaA/edit?usp=sharing 
* Video demonstration displayed below

# Real Estate Price Prediction Shiny App

This project is a Shiny web application designed to predict the price of real estate properties based on various features and sentiments from property descriptions. Users can input specific property characteristics, set a sentiment score reflecting the tone of the description, and see an estimated property price.

## Project Overview

The **Real Estate Price Prediction Shiny App** allows users to explore how different features influence the predicted price of a property. Built using R and Python, the application utilizes a pre-trained Random Forest model to generate price predictions based on selected property descriptions.

### Key Features
- **Sentiment Slider**: Users can set a sentiment score from -1 to 1, where -1 represents a negative sentiment and 1 represents a positive sentiment.
- **Feature Selection**: Users can choose from a variety of property features (e.g., amenities, room types, and attributes) to specify the characteristics of their property.
- **Predicted Price Display**: The app displays the predicted price dynamically based on the user's inputs.

### Technical Details
- The machine learning model was built in Python and saved as a `.pkl` file, loaded into R using the `reticulate` package.
- The app uses Shiny for the interactive UI and allows users to adjust inputs easily to see real-time predictions.

### How to Use
1. Set the **Description Sentiment** to reflect the tone of the property.
2. Select the **features** that describe your property under each category.
3. View the **Predicted Price** displayed on the main panel.

