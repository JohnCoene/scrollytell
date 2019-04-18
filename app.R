library(shiny)
library(shticky)
library(echarts4r)
library(waypointer)

init <- data.frame(
  x = runif(10, 1, 10),
  y = runif(10, 1, 20)
)

step1 <- data.frame(
  x = runif(100, 1, 10),
  y = runif(100, 1, 20)
)

longdiv <- function(...){
  div(
    ...,
    style = "height:100vh;"
  )
}

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
    echarts4rOutput("plot")
  ),
  longdiv(
    span(id = "waypoint1")
  ),
  longdiv(
    span(id = "waypoint2")
  ),
  longdiv()
)

server <- function(input, output, session) {

   w1 <- Waypoint$
    new(
      "waypoint1",
      offset = "50%"
    )$
    start()

   w2 <- Waypoint$
    new(
      "waypoint2",
      offset = "50%"
    )$
    start()

  # Our sticky plot
  shtick <- Shtick$
    new("#stick")$
    shtick()

  output$plot <- renderEcharts4r({
    init %>% 
      e_charts(x, draw = FALSE) %>% 
      e_scatter(y)
  })

  observeEvent(w1$get_direction(), {
    echarts4rProxy("plot") %>% 
      e_draw_p()
  })

  observeEvent(w2$get_direction(), {
    echarts4rProxy("plot") %>% 
      e_append1_p(0, step1, x, y)
  })
  
}

shinyApp(ui, server)