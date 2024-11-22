<html>
<head>
  <meta HTTP-EQUIV="Content-Type" CONTENT="text/html;charset=UTF-8">
  <link rel=StyleSheet href="../../esna/esna.css" type="text/css" title="ESNA Style" media="screen, print">
</head>

<body bgcolor=darkgreen>
<center>
<table width=650 bgcolor=lightyellow cellpadding=10 border=0 bordercolor=brown><tr><td>
<h1><img src=../../pajek.gif width=100>Pajek datasets</h1>

<hr>

<h2> WordNet</h2>

<p><b>Dataset</b> &nbsp; <code>WordNet 1.7.1</code>
<p><b>Description</b>
<p>
 <tt>WordNet.net</tt> directed multirelational network with 82670  vertices and
     133445 arcs; word X is related to word Y.
<p><b>Download</b>
<p><a HREF="./WordNet.zip">WordNet.net</a> (ZIP, 17K)

<p><b>Background</b>
<p><a HREF="./5papers.pdf">5 papers</a> /
<a href="http://wordnetcode.princeton.edu/5papers.pdf">org</a>
</p>
<p></p>
<p>  It contains an older version 1.7.1 of the WordNet.
<br>
  The new version (not in Pajek format) is available at
<a href="http://wordnet.princeton.edu/">WordNet site</a>.


</p>
<p> There are essentially two files: the network file containing
  WordNet as multirelational network with relations:
<pre>
  1: hypernym pointers
  2: entailment pointers
  3: similar pointers
  4: member meronym pointers
  5: substance meronym pointers
  6: part meronym pointers
  7: cause pointers
  8: grouped verb pointers
  9: attribute pointers
</pre>
  and the partition file determining the type of words:
<pre>
  1 n - noun
  2 v - verb
  3 a - adjective
  4 r - adverb
  5 s - adjective~satellite
</pre>
</p>
<p></p>
<p></p>
<p></p>

<h3>History</h3>
<p>
<ol>
<li> WordNet transformed in Pajek format: V. Batagelj, A. Mrvar, 22. November 2004</li>
</ol>
</p>


<h3>References</h3>
<ol>
<li>
</ol>
<hr>
22. November 2004
</td></tr></table>
</center>
</body>
</html>
<hr>

[Pajek network data sets](../../README.md);
[Network data sets](../../../README.md)

