# creates 100vh div
longdiv <- function(...){
  div(
    ...,
    class = "container",
    style = "height:100vh;"
  )
}

edge_colors <- colorRampPalette(c("#575b73", "#8592b0", "#8da0bb"))(9)

months <- c("April", "May", "June", "July", "August", "September", "October", "November", "December")

# add data.
add_data <- function(wp){
  
  n <- nodes %>% 
    filter(appear == wp)
  
  e <- edges %>% 
    filter(appear == wp)
  
  ec <- edges %>% 
    filter(appear <= wp) %>% 
    mutate(
      new_color = edge_colors[wp]
    )

  sigmajsProxy("graph") %>% 
    sg_force_kill_p() %>% 
    sg_read_nodes_p(n, id, label, color, size) %>% 
    sg_read_edges_p(e, id, source, target, weight) %>% 
    sg_read_exec_p() %>% 
    sg_change_edges_p(ec, new_color, "color") %>% 
    sg_refresh_p() %>% 
    sg_force_start_p(strongGravityMode = TRUE, slowDown = 5)
}

render_month <- function(wp, cl = "dark"){
  tagList(
    h1(months[wp], class = paste(cl, "big")),
    render_count(wp)
  )
}

.get_tweet_count <- function(wp){
  n_tweets %>% 
    filter(created_at == wp) %>% 
    pull(cs) %>% 
    prettyNum(big.mark = ",") %>% 
    span(
      class = "sg-dark emph"
    )
}

render_count <- function(wp, cl = "dark"){
  p(
    "By", months[wp], .get_tweet_count(wp), "Twitter users have tweeted about #tidytuesday.",
    class = cl
  )
}