
library(visNetwork)
library(igraph)
library(graphTweets) 
library(dplyr)

##cargobases

load("~/rcuali2022/Clase3/Material/total_luc.RData")


##filtramos

total_luc=total_luc %>%
  filter(created_at >= "2022-02-10 08:28:34 UTC" &
           created_at <= "2022-02-28 05:59:48 UTC")



##LUC


luc_retweets_network <- total_luc %>% 
  gt_edges(screen_name, retweet_screen_name, text) %>%            
  gt_graph()


luc_retweets_nodes <- igraph::as_data_frame(luc_retweets_network, what = "vertices")

luc_retweets_nodes <- luc_retweets_nodes %>% 
  mutate(id = name) %>% 
  mutate(label = name) %>% 
  mutate(title = name) %>% 
  mutate(degree = degree(luc_retweets_network)) %>% 
  mutate(value = degree)

luc_retweets_edges <- igraph::as_data_frame(luc_retweets_network, what = "edges")


luc_retweets_edges <- luc_retweets_edges %>% 
  mutate(title = text)


luc_retweets_nodes <- luc_retweets_nodes %>% 
  mutate(group = membership(infomap.community(luc_retweets_network)))


visNetwork(luc_retweets_nodes, luc_retweets_edges, main = "Análisis de redes: luc") %>% 
  visIgraphLayout(layout = "layout_nicely") %>% 
  visEdges(arrows = "to") %>%   
  visOptions(highlightNearest = T, nodesIdSelection = T)


