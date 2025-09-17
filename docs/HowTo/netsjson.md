# NetsJSON

## Reporting network data

Guidelines for reporting network data, such as those proposed by the GRAND project and integrated into the Social Networks in Health Research (SoNHR) guidelines, emphasize clarity, reproducibility, and ethical considerations. Key recommendations include: clearly defining network components (nodes, ties), explaining data collection methods and handling missing data, transparently reporting statistical analyses and visualizations, providing access to reproducible code, and considering the ethical implications and potential harms to data subjects. 

### Key Aspects of Reporting Guidelines
- Findability: Network data should be stored in a searchable repository with a unique identifier, like a Digital Object Identifier (DOI). 
- Accessibility: Data should be freely available and accessible to others. 
- Interoperability: Data should be in a standardized format to ensure it can be easily used and understood across different systems and analyses. 
- Reusability: Data should come with thorough documentation and a clear license to govern their use. 
- Reproducibility: Researchers should provide access to the necessary data and reproducible programming code to allow others to replicate their findings. 

### Specific Recommendations from SoNHR
These guidelines offer a framework for researchers in social networks, covering five main domains: 
- Conceptualization: Clearly state the research questions and how network analysis provides unique insights into them. 
- Operationalization: Define what nodes and ties represent, specifying if ties are directed, undirected, or weighted. 
- Data Collection & Management: Detail the data collection process, tools, and data management procedures, including how missing data was handled. 
- Analyses & Results: Explain the theoretical foundations of models, specify model mechanisms and outcomes, report network statistics with clear real-world meaning, and ensure visualizations are clear and informative. 
- Ethics & Equity: Address ethical concerns related to human subjects, equity, and social justice, ensuring data sharing minimizes harm and promotes benefit for data subjects. 

### Broader Context
- FAIR Principles: The concepts of Findability, Accessibility, Interoperability, and Reusability (FAIR) are central to ensuring network data can be effectively shared and reused. 
- Ethical Considerations: Guidelines also highlight the importance of ethical principles like collective benefit, subject authority, and fostering respectful relationships with communities providing data. 
- Community Engagement: Supporting data sharing requires institutional effort from journals, universities, and professional associations to encourage researchers to share data and reward this as a form of productivity. 

### GRAND

```
grand_manual(
  G,
  name = NA,
  doi = NA,
  url = NA,
  vertex1 = NA,
  vertex2 = NA,
  positive = NA,
  negative = NA,
  weight = NA,
  level = NA,
  mode = NA,
  year = NA
)
```

### Links

1. https://www.geeksforgeeks.org/r-language/network-visualization-in-r-using-igraph/
1. https://inarwhal.github.io/NetworkAnalysisR-book/ch4-Missing-Network-Data-R.html
1. https://github.com/JeffreyAlanSmith/Integrated_Network_Science/
1. https://research.ceu.edu/ws/portalfiles/portal/4951245/Peixoto-Tiago-P1-2024.pdf
1. https://www.nascol.net/packages/
1. https://pmc.ncbi.nlm.nih.gov/articles/PMC11129050/
[PDF](https://pmc.ncbi.nlm.nih.gov/articles/PMC11129050/pdf/bmjopen-2023-078872.pdf)
1. https://www.zacharyneal.com/grand
1. https://cran.r-project.org/web/packages/grand/refman/grand.html
1. https://github.com/JeffreyAlanSmith/Integrated_Network_Science/

```
## archiving networks in JSON

> library(jsonlite)
> write_graph_netsJSON(T,file="test1.json")
> TT <- netsJSON_to_graph(fromJSON("test1.json"),directed=TRUE)
> TT
IGRAPH 0e9ae04 DNW- 9 13 -- 
+ attr: by (g/c), cdate (g/c), title (g/c), network (g/c), org (g/n), nNodes (g/n),
| nArcs (g/n), nEdges (g/n), meta (g/x), name (v/c), age (v/n), sex (v/l), x (v/n), y
| (v/n), fact (v/n), deg (v/n), type (e/c), weight (e/n)
+ edges from 0e9ae04 (vertex names):
 [1] Ana  ->Bor   Ana  ->Cene  Eva  ->Bor   Cene ->Ana   Jan  ->Gaj   Gaj  ->Dana  Iva  ->Franc
 [8] Cene ->Gaj   Gaj  ->Ana   Bor  ->Franc Franc->Dana  Gaj  ->Bor   Iva  ->Jan  
> V(TT)[[]]
+ 9/9 vertices, named, from 0e9ae04:
   name age   sex      x      y   fact deg
1   Ana  20  TRUE 0.1429 0.4882 0.2500   4
...
9   Jan  19 FALSE 0.7615 0.7889 0.5000   2
> E(TT)[[]]
+ 13/13 edges from 0e9ae04 (vertex names):
    tail  head tid hid type weight
1    Ana   Bor   1   2  arc      3
...
13   Iva   Jan   8   9  arc      5
>


```



```

```

<hr />

[How to](./README.md)
