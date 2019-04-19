library(shiny)
library(shticky)
library(sigmajs)
library(waypointer)

load("./data/net.RData")
source("functions.R")

ui <- fluidPage(
  tags$head(
    tags$link(
      href = "https://fonts.googleapis.com/css?family=Montserrat",
      rel = "stylesheet"
    )
  ),
  use_shticky(),
  use_waypointer(),
  div(
    id = "stick",
    sigmajsOutput("graph")
  ),
  longdiv(
    wp(1)
  ),
  longdiv(
    wp(2)
  ),
  longdiv(
    wp(3)
  ),
  longdiv(
    wp(4)
  ),
  longdiv(
    wp(5)
  ),
  longdiv(
    wp(6)
  ),
  longdiv(
    wp(7)
  ),
  longdiv(
    wp(8)
  ),
  longdiv(
    wp(9)
  )
)

server <- function(input, output, session) {

   w1 <- Waypoint$
    new(
      "1"
    )$
    start()

   w2 <- Waypoint$
    new(
      "2"
    )$
    start()

  # Our sticky plot
  shtick <- Shtick$
    new("#stick")$
    shtick()

  output$graph <- renderSigmajs({
    sigmajs()
  })

  observeEvent(w1$get_direction(), {
    if(w1$get_direction() == "down")
      add_data(1)
  })

  observeEvent(w2$get_direction(), {

  })
  
}

shinyApp(ui, server)