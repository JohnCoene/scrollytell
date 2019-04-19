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
    sigmajsOutput("graph", width = "100%", height = "100vh")
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

   w1 <- Waypoint$new("1")$start()
   w2 <- Waypoint$new("2")$start()
   w3 <- Waypoint$new("3")$start()
   w4 <- Waypoint$new("4")$start()
   w5 <- Waypoint$new("5")$start()
   w6 <- Waypoint$new("6")$start()
   w7 <- Waypoint$new("7")$start()
   w8 <- Waypoint$new("8")$start()
   w9 <- Waypoint$new("9")$start()

  # Our sticky plot
  shtick <- Shtick$
    new("#stick")$
    shtick()

  output$graph <- renderSigmajs({
    sigmajs() 
  })

  observeEvent(w1$get_direction(), {
    if(w1$get_direction() == "down") add_data(1)
  })

  observeEvent(w2$get_direction(), {
    if(w2$get_direction() == "down") add_data(2)
  })

  observeEvent(w3$get_direction(), {
    if(w3$get_direction() == "down") add_data(3)
  })

  observeEvent(w4$get_direction(), {
    if(w4$get_direction() == "down") add_data(4)
  })

  observeEvent(w5$get_direction(), {
    if(w5$get_direction() == "down") add_data(5)
  })

  observeEvent(w6$get_direction(), {
    if(w6$get_direction() == "down") add_data(6)
  })

  observeEvent(w7$get_direction(), {
    if(w7$get_direction() == "down") add_data(7)
  })

  observeEvent(w8$get_direction(), {
    if(w8$get_direction() == "down") add_data(8)
  })

  observeEvent(w9$get_direction(), {
    if(w9$get_direction() == "down") add_data(9)
    Sys.sleep(3)
    sigmajsProxy("graph") %>% 
      sg_force_stop_p()
  })
  
}

shinyApp(ui, server)