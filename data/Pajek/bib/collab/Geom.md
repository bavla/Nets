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

<h2> Geom<br>Collaboration network in computational geometry</h2>

<p><b>Dataset</b> &nbsp; <code>Geom</code>
<p><b>Description</b>
<p>
 <tt>Geom.net</tt> valued undirected network with 7343 vertices and 11898 edges;
  author X wrote a joint work with author Y; value is the number of joint works.

<p><b>Download</b>
<p><a HREF="./geom.zip">Geom.net</a> (ZIP, 139K)

<p><b>Background</b>
<p>The network <code>Geom.net</code> is based on the file
<code>geombib.bib</code>  that contains <i>Computational Geometry Database</i>,
 version February 2002.
</p>
<p>
The <i><b>authors collaboration network</b></i> in computational geometry
was produced from the BibTeX  bibliography [Beebe, 2002]
obtained from the <i><b>Computational Geometry Database</b></i>
<code>geombib</code>, version February 2002 [Jones, 2002].
</p><p>
Two authors are linked with an edge, iff they wrote a common work (paper, book, ...).
The value of an edge is the number of common works.
Using a simple program written in programming language Python,
the BibTeX data were transformed into the corresponding network,
and output to the file in Pajek format.
</p><p>
The obtained network has 9072 vertices (authors) and 22577 edges
(common papers or books) / 13567 edges as a simple network -
multiple edges between a pair of authors are replaced with a
single edge.
</p><p>
The problem with the obtained network is that, because of non standardized
writing of the author's name, it contains several vertices
corresponding to the same author. For example:
<blockquote>
R.S. Drysdale,
Robert L. Drysdale,
Robert L. Scot Drysdale,
R.L. Drysdale,
S. Drysdale,
R. Drysdale, and
R.L.S. Drysdale;
</blockquote>
or:
<blockquote>
Pankaj K. Agarwal,
P. Agarwal,
Pankaj Agarwal, and
P.K. Agarwal
</blockquote>
that are easy to guess; but an 'insider' information is needed
to know that Otfried Schwarzkopf and Otfried Cheong are the same person.
Also, no provision is made in the database to discern two persons with the same name.
We manually produced the name equivalence partition and then shrank (in Pajek) the
network according to it.
</p><p>
The reduced simple network contains 7343 vertices and 11898 edges.
It is a sparse network - its average degree is 2m/n = 3.24.

</p>
<p></p>

<h3>History</h3>
<p>
<ol>
<li> <i>Computational Geometry Database</i> started in 1986 by merging two
     lists of references - one compiled by Edelsbrunner and van Leeuwen and the other
     by Guibas and Stolfi;</li>
<li> <i>Computational Geometry Database</i>, February 2002 Edition;</li>
<li> March-April 2002: <code>Geom.bib</code> transformed in Pajek format and 'cleaned' by
     V. Batagelj and M. Zaver&#353;nik.</li>
</ol>
</p>


<h3>References</h3>
<ol>
<li> Beebe, N.H.F. (2002):
    <a href="http://www.math.utah.edu/~beebe/bibliographies.html">
     <i>Nelson H.F. Beebe's Bibliographies Page</i></a>.</li>
<li> Jones, B., <i>Computational Geometry Database</i>, February 2002;
    <a href="ftp://ftp.cs.usask.ca/pub/geometry/">FTP</a> /
    <a href="http://compgeom.cs.uiuc.edu/~jeffe/compgeom/biblios.html">HTTP</a></li>
</ol>
<hr>
27. January 2004
</td></tr></table>
</center>
</body>
</html>
<hr>

[Pajek network data sets](../../README.md);
[Network data sets](../../../README.md)

