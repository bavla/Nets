
<html>
<head>
	<title>The GraphMan Editor and the File Format</title>

</head>

<h3> GraphMan Editor</h3>

The GraphMan program is a basic graph manipulation tool that can be used for the Graph Drawing Contest. While we encourage participants to bring their own custom-designed tools, we will make GraphMan available on 10 machines during the contest. 
<p>

GraphMan is written in Java and so should run on a variety of platforms incluing Linux, Unix, Windows, and
MacOS.   To execute the program in Linux type "java -jar GraphMan.jar" and in Windows double
click the GraphMan.jar file.   The current version (GraphMan-0.6) is available here:
<UL>
<LI>Version 0.6: TarBall: <a href="GraphMan-0.6.tgz">GraphMan-0.6.tgz</a>
<LI>Version 0.6: Jar File <a href="GraphMan.jar">GraphMan.jar</a>
</UL>


<p>

GraphMan has the following features:
<ul>
<li> Loading/storing files in the GD04 ASCII format.
<li> Clicking on a node highlights its edges and allows the user to move the node.
<li> Double clicking on a node "PINS" it down. This feature prevents this node from
being moved by the spring-embedder feature, while manual movement is still possible.
<li> Tracking of the crossings is on by default - clicking the crossings button in the toolbar 
disables/enables this feature.
<li> Zoom In/Out/Fit to Window/and 1:1 scaling are available.
<li> The spring Embedder feature runs a simple force-directed algorithm. The spring-embedder parameters can be modified (repulsive, attractive forces, number of iterations, etc.)
<li> The undo feature only undoes Spring Embedder actions.

</ul>

<hr>

<h3> Graph Format </h3>


For the GD2004 contest, we will use a modified ASCII format described below. The contest graphs will be provided in this format and the submission should be prepared using the same format.
<ul>
<li>The first number indicates the number of nodes in the graph.
<li>The next 2N double values are X Y pairs for each node, indicating
its position, which initially are random values.
<li> The remaining values are integer pairs <a B> indicating an edge exists between nodes A and B.   

<li> The nodes are labeled from 0 to N-1 and the order from the input file must be used in the output file as well.

<li> The contest graphs will not contain comments though they are allowed.
<li> Edge order is not important.
<li> The contest graphs will have random start locations for the nodes.
</ul>

<hr>

<h3> Sample File </h3>
Below is a simple example:<br>

-----------------------------------------------------------------<br>

# Lines starting with # are comments and ignored<br>
# First value is NumNodes(N)<br>
4 <br>
# Next N pairs are X,Y (double) coordinate values of each node 0,1, N-1<br>
0.0 0.0  # Node 0<br>
0.0 5.0  # Node 1<br>
5.0 5.0  # Node 2<br>
5.0 0.0  # Node 4<br>

# Remaining pairs of INTEGER values are undirected edges Ns, Ne<br>
0 1      # Edge from Node 0 to Node 1<br>
0 2<br>
0 3<br>
1 2<br>
1 3<br>
2 3<br>
<br>
# Here we defined a 4-clique (with 1 crossing)<br>

-----------------------------------------------------------------<br>
<p>

Additional sample files can be found here: 
<ul>
<li><a href="sample1.gdc">sample1.gdc</a>
<li><a href="sample2.gdc">sample2.gdc</a>
<li><a href="sample3.gdc">sample3.gdc</a>
<li><a href="http://www.cs.miami.edu/~duncan/challenge.zip">challenge.zip</a> (Last year's challenge graphs)
</ul>


<p>
The program was written by <a href="http://www.cs.miami.edu/~duncan">Christian Duncan</a>, <a href="http://www.cs.arizona.edu/~kobourov">Stephen G. Kobourov</a>, and <a href="http://www.ece.arizona.edu/~chandanp">Chandan Pitta</a>.
<p>
</body>
</html>
