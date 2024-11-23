<html>

<head>
  <title>Graph Drawing Contest 2005 - Challenge A</title>
  <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>

<body>

<center>
<big><b>Evolving-Graph Drawing Competition</b></big>

</center>


<p>
The challenge of drawing large evolving graphs can be addressed in
various ways. Any visualizations based on the contest data, including
animations, static images, subgraphs and derivations of the contest
graph, are welcome as submission. In addition to the
visualizations, we encourage contestants to submit supplemental
material, such as background relevance of the graph, case studies,
concepts, algorithms, experiments, structural results, that address
the problem of visualizing this type of data in a meaningful way.  
</p>

<h4>Contest Data</h4>

<p>
A real-world data set is provided that is based on the 

<a href="http://www.imdb.com/">Internet Movie Database</a>.
<!-- at <a href="http://www.imdb.com/movie">http://www.imdb.com/movie</a>. -->
</p>

<p>
The graph is a bipartite graph where each node either corresponds to 
an actor or to a movie. There is an edge between a movie and each
actor of the movie.
</p>

<p>
Moreover, the data contain the following attributes at nodes:
</p>
<ul>
  <li>"movie"  indicating if node corresponds to a movie (type boolean)
  <li>"name" indicating name of movie resp. actor (type string)
  <li>year of the movie (type int); attribute is 0 if node is an actor or
      year is not known
  <li>genre of the movie (type string)

</ul>


<h4>Download</h4>

<p>
The graph is available in <a href="http://www.graphdrawing.org/graphml">GraphML</a> format
(compressed with <a href="http://www.bzip.org/">bzip2</a>):
</p>
<ul>
  <li><a href="imdb.graphml.bz2">imdb.graphml.bz2</a> (26MB)

</ul>

</body>

</html>
