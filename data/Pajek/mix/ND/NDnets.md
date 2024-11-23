<html>
<head>
  <meta HTTP-EQUIV="Content-Type" CONTENT="text/html;charset=UTF-8">
  <link rel=StyleSheet href="../esna/esna.css" type="text/css" title="ESNA Style" media="screen, print">
</head>
<body bgcolor=darkgreen>
<center>
<table width=650 bgcolor=lightyellow cellpadding=10 border=0 bordercolor=brown><tr><td>
<h1><img src=../pajek.gif width=100>Pajek datasets</h1>
<hr>
<h2> Notre Dame<br>Self-Organized Networks Database</h2>
<p><b>Datasets</b> &nbsp; <code>NDwww</code>, <code>NDactors</code>, <code>NDyeast</code>
<p><b>Description</b>
<p>
<a href="http://www.nd.edu/~networks/database/index.html">Notre Dame Self-Organized Networks</a>:
<ol>
 <li><tt>NDwww.net</tt> directed network with 325729 vertices and 1497135 arcs (27455 loops);
  page X is linked to page Y.</li>
 <li><tt>NDactors.net</tt> undirected two-mode network with 520223 vertices
  (392400 players, 127823 movies) and 1470418 edges;
  player X plays in movie Y.</li>
 <li><tt>NDyeast.net</tt> undirected network with 2114 vertices and 2277 edges (74 loops);
  protein X interacts with protein Y.</li>
</ol>
<p><b>Download</b>
<p>
<a HREF="./NDwww.zip">NDwww.net</a> (ZIP, 2050K)<br>
<a HREF="./NDactors.zip">NDactors.net</a> (ZIP, 4150K)<br>
<a HREF="./NDyeast.zip">NDyeast.net</a> (ZIP, 7K)<br>
<!-- a HREF="./Geom.zip">Geom.net</a> (ZIP, 139K)<br>
<a HREF="./Geom.zip">Geom.net</a> (ZIP, 139K)<br -->

<p><b>Background</b>
<p>The networks <code>ND*.net</code> are based on the files from
<i>Notre Dame Self-Organized Networks Database</i>. To transform the data
into Pajek format: vertex 0 was replaced by the vertex number equal to the
number of vertices in a network; Pajek keywords were inserted; and the
network was saved in the short (as lists of neighbors) format.
</p>

<ol>
  <li><strong>World-Wide-Web:</strong>:
    Each number represents webpage within <tt>nd.edu</tt> domain.
    Arcs: From page -> To page<br>
    <b>R&eacute;ka
     Albert, Hawoong Jeong and Albert-L&aacute;szl&oacute; Barab&aacute;si:</b><br>
     <b>Diameter of the World Wide Web</b>, Nature <b>401</b>, 130 (1999)
     [ <a href="http://www.nd.edu/~networks/Papers/401130A0.pdf">PDF</a> ]<br>
     See also a decompostion of this network in V. Batgelj, A. Mrvar:
     <A HREF="http://vlado.fmf.uni-lj.si/pub/networks/doc/Pajek/HowTo.PDF">
     How to analyze large networks with Pajek?</A>
  <li><strong>Actor:</strong>
    Actor network data: (based on <a href="www.imdb.com"><tt>www.imdb.com</tt></a>)
    In the original ND network file: each line corresponds to one movie,
    each number represents actor:
    number_1 number_2 ... number_k    (k actors who play in the same movie).
    <br>
    <b>Albert-L&aacute;szl&oacute; Barab&aacute;si, R&eacute;ka Albert:</b><br>
     <b>Emergence of scaling in random networks</b>,
     Science <b>286</b>, 509 (1999)
     [ <a href="http://www.nd.edu/~networks/Papers/science.pdf">PDF</a> ]
  <!-- li><strong>Celluar Network:</strong> (for 43 organisms):
     Each number represents substrate in celluar network of corresponding organism
     Arcs: From -> To  (number larger than 1000000 corresponds to intermediate state).
     <a href="cellular/index.html">[Whole Cellular Network]</a> <a href="metabolic/index.html">[Metabolic Network Only]</a><br>
     <b>Hawoong Jeong, B&aacute;lint Tombor, R&eacute;ka
     Albert, Zolt&aacute;n N. Oltvai and Albert-L&aacute;szl&oacute; Barab&aacute;si:</b><br>
     <b>The large-scale organization of metabolic networks</b>
     Nature <b>407</b>, 651 (2000)
     [ <a href="http://www.nd.edu/~networks/Papers/metabolic.pdf">PDF</a> ]  -->
  <li><strong>Protein Interaction Network for Yeast:</strong>
     Each number represents protein in protein interaction network of yeast.
     Edges: From protein -> To protein.<br>
     For other datasets used in supplementary material, please refer indicated references.<br>
     <b>Hawoong Jeong, Sean Mason, Albert-L&aacute;szl&oacute; Barab&aacute;si and Zolt&aacute;n N. Oltvai:</b><br>
     <b>Centrality and lethality of protein networks</b>,
     Nature <b>411</b>, 41 (2001)
     [ <a href="http://www.nd.edu/~networks/Papers/protein.pdf">PDF</a> ]<br>
     See also <A HREF="http://vlado.fmf.uni-lj.si/pub/networks/data/bio/Yeast/Yeast.htm">
     Yeast data</A>
</ol>

<h3>History</h3>
<p>
<ol>
<li> <i>Notre Dame Networks Database</i> put on WWW by the Notre Dame team, 2001;</li>
<li> 23-25. July 2001: ND nets transformed in Pajek format by V. Batagelj.</li>
<li> 23. May 2004: ND nets in Pajek format transformed in short (lists of neighbors)
     Pajek format by V. Batagelj.</li>
</ol>
</p>


<h3>References</h3>
<ol>
<li> <a href="http://www.nd.edu/~networks/database/index.html">Self-Organized Networks Database</a>,
     University of Notre Dame.</li>
</ol>

<h3>Copyright</h3>

Extract from the <i>Notre Dame Networks Database</i> page:
"... <i><b>Feel free to use these data in your research.</b></i>"<br>
Mail to <a href="mailto:hjeong@nd.edu">Hawoong Jeong</a> (author of original ND networks).
<p>
<hr>
23. May 2004
</td></tr></table>
</center>
</body>
</html>
<hr>

[Pajek network data sets](../../README.md);
[Network data sets](../../../README.md)


