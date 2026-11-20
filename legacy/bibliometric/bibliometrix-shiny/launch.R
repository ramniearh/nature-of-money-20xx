library(bibliometrix)
biblioshiny() #opcional - para visualização interativa em browser

library(igraph)
#library(here)

M <- convert2df(file = "MANUAL-test0325.bib", dbsource = "wos", format = "bibtex")

# Optional: View basic info about your dataset
summary(biblioAnalysis(M))

# Create coupling matrix (you can choose different units: "authors", "sources", "countries", "references", "keywords")
coupling_matrix <- biblioNetwork(M, analysis = "coupling", network = "references", sep = ";")

# For a co-citation network (alternative approach if needed)
net_matrix <- biblioNetwork(M, analysis = "co-citation", network = "references", sep = ";")

# Create network plot
net <- networkPlot(coupling_matrix, 
                   n = 505, # Number of nodes to display
                   type = "auto", 
                   size = 5, 
                   size.cex = TRUE, 
                   #title = "Bibliographic Coupling Network", 
                   labelsize = 0.8)


# If you want to use igraph for more customization:
g <- graph.adjacency(coupling_matrix, mode = "undirected", weighted = TRUE)
plot(g, vertex.size = 5, vertex.label.cex = 0.7, edge.width = E(g)$weight)

# Community detection
communities <- cluster_walktrap(g)
plot(communities, g)

# Network metrics
degree_centrality <- degree(g)
betweenness_centrality <- betweenness(g)

# Three Fields Plot 
threeFieldsPlot(M, 
                fields = c("CR", "AU", "DE"),  # Cited References, Author, Author Keywords
                n = c(20, 20, 20))            # Top N items per field

