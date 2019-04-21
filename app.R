library(shiny)
library(shinyjs)
library(shticky)
library(sigmajs)
library(waypointer)

source("./data/network.R")
source("functions.R")

OFFSET <- "50%"
ANIMATION <- "slideInUp"

ui <- fluidPage(
  tags$head(
    tags$link(rel = "stylesheet", href = "style.css"),
    tags$link(
      rel = "stylesheet",
      href = "https://use.fontawesome.com/releases/v5.8.1/css/all.css", 
      integrity = "sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf",
      crossorigin = "anonymous"
    )
  ),
  use_shticky(),
  use_waypointer(),
  div(
    id = "bg",
    div(
      id = "stick",
      style = "position:fixed;width:100%;",
      fluidRow(
        column(4),
        column(8, sigmajsOutput("graph", width = "100%", height = "100vh"))
      )
    ),
    longdiv(
      h1("Nine Months of #tidytuesday", class = "title"),
      br(),
      br(),
      h1(
        class = "subtitle",
        "Each", tags$i(class = "fas fa-circle sg"), "node is a twitter user,",
        "and each", tags$i(class = "fas fa-slash sg"), "is one tweet or more."
      ),
      br(),
      p(
        style = "text-align:center;",
        "Using the first dataset of #tidytuesday: #Rstats & #TidyTuesday Tweets", 
        tags$a(
          class = "sg",
          tags$i(class = "fas fa-external-link-alt"),
          target = "_blank",
          href = "https://github.com/rfordatascience/tidytuesday/tree/master/data/2019/2019-01-01"
        )
      ),
      br(),
      br(),
      br(),
      p(
        style = "text-align:center;",
        tags$i(class = "fas fa-chevron-down fa-3x")
      )
    ),
    longdiv(
      div(
        id = "m1",
        uiOutput("1"),
        uiOutput("apr")
      )
    ),
    longdiv(
      div(
        id = "m2",
        uiOutput("2"),
        uiOutput("may")
      )
    ),
    longdiv(
      div(
        id = "m3",
        uiOutput("3"),
        uiOutput("jun")
      )
    ),
    longdiv(
      div(
        id = "m4",
        uiOutput("4"),
        uiOutput("jul")
      )
    ),
    longdiv(
      div(
        id = "m5",
        uiOutput("5"),
        uiOutput("aug")
      )
    ),
    longdiv(
      div(
        id = "m6",
        uiOutput("6"),
        uiOutput("sep")
      )
    ),
    longdiv(
      div(
        id = "m7",
        uiOutput("7"),
        uiOutput("oct")
      )
    ),
    longdiv(
      div(
        id = "m8",
        uiOutput("8"),
        uiOutput("nov")
      )
    ),
    longdiv(
      div(
        id = "m9",
        uiOutput("9"),
        uiOutput("dec")
      )
    ),
    longdiv(
      id = "m10",
      class = "light",
      style = "text-align:center;",
      h1("Thank you", class = "title"),
      h1(
        class = "subtitle",
        tags$a(
          "Read the blog post",
          target = "_blank",
          class = "sg",
          href = "https://john-coene.com/post/scrollytell/"
        )
      )
    )
  )
)

server <- function(input, output, session) {

  w1 <- Waypoint$
    new("m1", offset = OFFSET, animate = TRUE, animation = ANIMATION)$
    start()
  w2 <- Waypoint$
    new("m2", offset = OFFSET, animate = TRUE, animation = ANIMATION)$
    start()
  w3 <- Waypoint$
    new("m3", offset = OFFSET, animate = TRUE, animation = ANIMATION)$
    start()
  w4 <- Waypoint$
    new("m4", offset = OFFSET, animate = TRUE, animation = ANIMATION)$
    start()
  w5 <- Waypoint$
    new("m5", offset = OFFSET, animate = TRUE, animation = ANIMATION)$
    start()
  w6 <- Waypoint$
    new("m6", offset = OFFSET, animate = TRUE, animation = ANIMATION)$
    start()
  w7 <- Waypoint$
    new("m7", offset = OFFSET, animate = TRUE, animation = ANIMATION)$
    start()
  w8 <- Waypoint$
    new("m8", offset = OFFSET, animate = TRUE, animation = ANIMATION)$
    start()
  w9 <- Waypoint$
    new("m9", offset = OFFSET, animate = TRUE, animation = ANIMATION)$
    start()
  
  w10 <- Waypoint$
    new("m10", offset = "80%", animate = TRUE, animation = ANIMATION)$
    start()

  output$`1` <- renderUI({
    req(w1$get_triggered())
    if(w1$get_triggered() == TRUE) render_month(1)
  })

  output$`2` <- renderUI({
    req(w2$get_triggered())
    if(w2$get_triggered() == TRUE) render_month(2)
  })
  
  output$`3` <- renderUI({
    req(w3$get_triggered())
    if(w3$get_triggered() == TRUE) render_month(3)
  })
  
  output$`4` <- renderUI({
    req(w4$get_triggered())
    if(w4$get_triggered() == TRUE) render_month(4)
  })
  
  output$`5` <- renderUI({
    req(w5$get_triggered())
    if(w5$get_triggered() == TRUE) render_month(5)
  })
  
  output$`6` <- renderUI({
    req(w6$get_triggered())
    if(w6$get_triggered() == TRUE) render_month(6)
  })
  
  output$`7` <- renderUI({
    req(w7$get_triggered())
    if(w7$get_triggered() == TRUE) render_month(7)
  })
  
  output$`8` <- renderUI({
    req(w8$get_triggered())
    if(w8$get_triggered() == TRUE) render_month(8)
  })
  
  output$`9` <- renderUI({
    req(w9$get_triggered())
    if(w9$get_triggered() == TRUE) render_month(9)
  })

  # Our sticky plot
  shtick <- Shtick$
    new("#stick")$
    shtick()

  output$graph <- renderSigmajs({
    sigmajs() %>% 
      sg_settings(
        edgeColor = "default",
        defaultEdgeColor = "#c3c3c3",
        font = "Raleway",
        fontStyle = "sans-serif",
        mouseWheelEnabled = FALSE,
        labelSize = "proportional",
        labelThreshold = 9999
      )
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
    Sys.sleep(2)
    sigmajsProxy("graph") %>% 
      sg_force_stop_p()
  })
  
  observeEvent(w10$get_direction(), {
    if(w10$get_direction() == "down") shtick$unshtick()
  })
  
}

shinyApp(ui, server)