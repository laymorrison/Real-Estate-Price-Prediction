library(shiny)
library(reticulate)
library(bslib)

# Set up Python environment
use_python("C:/Users/Laymoni/AppData/Local/Programs/Python/Python310/python.exe")

# Load joblib and the Random Forest model using the full path
py_run_string("import joblib")
py_run_string("model = joblib.load('C:/Users/Laymoni/Desktop/MGSC_410/MGSC_410/random_forest_model.pkl')")

# Define all features used in the original model training
all_features <- c("description_sentiment", "access", "air", "appliances", "area", "backyard", 
                  "bath", "bathroom", "beautiful", "bedroom", "bedrooms", "built", "car", 
                  "central", "community", "covered", "dining", "dishwasher", "enjoy", "family", 
                  "features", "fenced", "fireplace", "floor", "flooring", "garage", "home", 
                  "kitchen", "large", "light", "living", "located", "modern", "new", "offers", 
                  "open", "patio", "perfect", "primary", "private", "property", "remodeled", 
                  "room", "space", "spacious", "storage", "updated", "walk", "windows", "wood", 
                  "yard")

# Define the Shiny UI
ui <- fluidPage(
  theme = bs_theme(bootswatch = "cerulean"),
  titlePanel("Real Estate Price Prediction"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("description_sentiment", "Description Sentiment:", min = -1, max = 1, value = 0),
      checkboxGroupInput("selected_keywords", "Select Property Descriptions:", choices = all_features),
      style = "column-count: 2;"
    ),
    mainPanel(
      # Prediction result with larger font
      div(
        textOutput("prediction_result"),
        style = "font-size: 24px; font-weight: bold; color: #007bff;"
      ),
      br(),
      
      # Instructions above feature categories
      h4("Instructions:"),
      p("Think about the features of a house you would like to predict the price for. Set the 'Description Sentiment' slider to reflect the overall tone of the property description: move it toward 1 if the description is very positive or appealing, 0 for neutral, or -1 if the description is less appealing. Then, look at the feature categories below and select the features that match your house. Once you have made your selections, see the predicted price."),
      
      h4("Feature Categories:"),
      
      p(
        strong("Room Features: "),
        "bath, bathroom, bedroom, bedrooms, dining, family, kitchen, living, room"
      ),
      p(
        strong("Amenities: "),
        "access, air, appliances, central, dishwasher, fireplace"
      ),
      p(
        strong("Property Features: "),
        "area, backyard, built, car, covered, fenced, floor, flooring, garage, home, light, modern, new, open, patio, primary, private, property, remodeled, space, spacious, storage, updated, windows, wood, yard"
      ),
      p(
        strong("Descriptions/Attributes: "),
        "beautiful, enjoy, features, large, located, offers, perfect, walk"
      ),
      p(
        strong("Community Features: "),
        "community"
      )
    )
  )
)

# Define the Shiny Server Logic
server <- function(input, output) {
  output$prediction_result <- renderText({
    # Initialize a data frame with all features set to 0
    keyword_data <- as.data.frame(matrix(0, nrow = 1, ncol = length(all_features)))
    colnames(keyword_data) <- all_features
    
    # Set selected keywords to 1 based on user input
    if (!is.null(input$selected_keywords)) {
      keyword_data[input$selected_keywords] <- 1
    }
    
    # Set sentiment value from user input
    keyword_data$description_sentiment <- as.numeric(input$description_sentiment)
    
    # Print the structure of keyword_data to confirm it matches expected features
    print(keyword_data)
    
    # Predict with the model
    prediction <- py$model$predict(as.data.frame(keyword_data))[[1]]
    paste("Predicted Price: $", round(prediction, 2))
  })
}

# Run the Shiny App
shinyApp(ui = ui, server = server)
