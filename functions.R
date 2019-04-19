# creates 100vh div
longdiv <- function(...){
  div(
    ...,
    style = "height:100vh;"
  )
}

# empty span as waypoint
wp <- function(id){
  span(id = id)
}

# add data.
add_data <- function(wp){
  n <- nodes %>% 
    filter(appear == wp)
  
  e <- edges %>% 
    filter(appear == wp)

  sigmajsProxy("graph") %>% 
    sg_read_nodes_p(n, id, label, color, size) %>% 
    sg_read_edges_p(e, id, source, target, weight) %>% 
    sg_read_exec_p()
}
