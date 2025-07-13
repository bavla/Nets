# Blockmodeling

## French Political Blogosphere network

[original data](./blog.rda); [igraph network](./blog.rds)

French Political Blogosphere network dataset consists of a single day snapshot of over 200 political blogs automatically extracted the 14 october 2006 and manually classified by the ''Observatoire Presidentielle'' project. This project is the result of a collaboration between RTGI SAS and Exalead and aims at analyzing the French presidential campaign on the web.

196 political blogs described by their political origin and connections. Besides the (symmetrized) graph 'blogA contains a hyperlink to blogB' the node property party provides a partition of blogs to political groups.

In this data set, nodes represent hostnames (a hostname contains a set of pages) and edges represent hyperlinks between different hostnames. If several links exist between two different hostnames, they were collapsed into a single one. Note that intra domain links can be considered if hostnames are not identical. Finally, in this experimentation we consider that edges are not oriented which is not realistic but which does not affect the interpretation of the groups. This network presents an interesting communities organization due to the existence of several political parties and
commentators. We assume that authors of these blogs tend to link, by political affinities, blogs with similar political positions. 

Six known communities compose this network : **G**auche (''french democrat''), **D**ivers **C**entre (Moderate party), **D**roite (french republican),  **E**cologiste (green), **L**iberal (supporters of economic-liberalism), and finally **A**nalysts. 

### References
  1. http://www.observatoire-presidentielle.fr/
  2. https://cran.r-project.org/src/contrib/Archive/mixer/
  3. https://www.sciencedirect.com/science/article/pii/S0031320308002483

Converted to igraph by Vladimir Batagelj, July 13, 2025
