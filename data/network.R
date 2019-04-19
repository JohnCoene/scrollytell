library(dplyr)
library(graphTweets)

tt <- readRDS("./data/tidytuesday_tweets.rds")

# convert dates to incremental m/y as integers
posix2int <- function(created_at) {
  y <- format(created_at, "%Y")
  m <- format(created_at, "%m")
  y <- as.integer(y)
  m <- as.integer(m)

  mn <- min(y) + min(m) - 1

  (y + m) - mn
}

# keep month-year
my <- tt %>% 
  select(created_at) %>% 
  arrange(created_at) %>%
  pull(created_at) %>%  
  format("%m-%Y") %>% 
  unique()

# convert date
tt <- tt %>% 
  mutate(
    created_at = posix2int(created_at)
  )

# build network
net <- tt %>% 
  gt_edges(screen_name, mentions_screen_name, created_at) %>% 
  gt_nodes() %>% 
  gt_dyn() %>% 
  gt_collect()

c(edges, nodes) %<-% net

# prep for sigmajs
nodes <- nodes %>% 
  mutate(
    id = nodes,
    label = nodes,
    size = n,
    color = scales::col_numeric(c("#B1E2A3", "#98D3A5", "#328983", "#1C5C70", "#24C96B"), domain = NULL)(n)
  ) %>% 
  select(id, label, size, color, appear = start)

edges <- edges %>% 
  mutate(
    id = 1:dplyr::n()
  ) %>% 
  select(id, source, target, appear = created_at, weight = n)

save(my, edges, nodes, file = "./data/net.RData")