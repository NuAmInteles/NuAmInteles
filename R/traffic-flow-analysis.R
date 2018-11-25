setwd("Desktop/traffic-flow-analysis/")

df <- list()

for(i in 1:length(list.files("DataSet/"))){
  df[[i]] <- read.csv(paste("DataSet/",list.files("DataSet/")[i],sep="",collapse = ""))
}


#create the adjancency matrix 
adj_matrix <- matrix(nrow=length(df),ncol=length(df))
adj_matrix[] <- 0



# 
# for(i in 2:(nrow(adj_matrix)-2)){
#   adj_matrix[i,i-2]<- 1
#   adj_matrix[i,i-1]<- 1
#   adj_matrix[i,i+1]<- 1
#   adj_matrix[i,i+2]<- 1
# }

graph <- igraph::graph_from_adjacency_matrix(adj_matrix)


make_matrix <- function(rows,cols){
  rows = 35
  cols = 35
  n = rows * cols 
  M = matrix(nrow = n, ncol = n)
  M[] <- 0
  for(r in 1:rows){
    for(c in 1:cols){
      i = r * cols + c 
      if(c > 0){
        M[i-1,i] <- 1
        M[i,i-1] <- 1
      }
      # Two outer diagonals
      if(r > 0){
        M[i-cols,i] <- 1
        M[i,i-cols] <- 1
      }
    }
  }
  return(M)
}


adj_matrix <- make_matrix(35,35)