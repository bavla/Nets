<html>
 <head>
 <title>Pajek data: Centrality literature network.</title>
 <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
 <link rel=StyleSheet href="./esna.css" type="text/css" title="ESNA Style" media="screen, print">
 <style type="text/css"> </style>
 </head>
<body bgcolor="darkgreen">

<center>

<table width="650" bgcolor="lightyellow" cellpadding="10" border="0" bordercolor="brown"><tbody><tr><td>
<table><tr><td>
<img src="./pajek.gif" width="100"> &nbsp; &nbsp;</td><td><h1>Pajek datasets<br>
 <font size=3>from the book</font></h1>
 </td></tr></table>
<h2><font color=Navy>Exploratory Social Network Analysis with Pajek<br>
    <small>Wouter de Nooy, Andrej Mrvar, Vladimir Batagelj</small></font></h2>
<hr>

<h2>Centrality literature network.</h2>

<p><b>Dataset</b> &nbsp; <code>Centrality</code></p>
<p><b>Description</b></p>
<p>
<tt>Centrality_literature.net</tt>: 129 vertices (publications), 613 arcs (citations,
pointing towards the citing paper), no edges, no loops, line values (1 -
regular citation, 2 - double citation, which is possible if the citing paper or
the cited paper refers to two mutual citing papers shrunk to one
combined vertex).<br>
<tt>Centrality_literature_year.clu</tt>: a partition showing the year of publication of
the paper (129 vertices), which is also indicated by the last two digits in
the label of a vertex.
</p>
<p><b>Download</b></p>
<p>
<a href="./centrality.zip">complete dataset</a> (ZIP, 3.7K)
</p>
<p><b>Background</b></p>
<p>
In 1979, Linton Freeman published a paper which defined several kinds of
centrality. His typology has become the standard for network analysis.
Freeman, however, was not the first to publish on centrality in networks.
His paper is part of a discussion which dates back to the 1940s. The
network shows the papers that discuss network centrality and their cross-
references until 1979. Arcs represent citations; they point from the cited
paper to the citing paper.<br>
In principle, papers can only cite papers which appeared earlier, so the
network is acyclic. Arcs never point back to older papers just like parents
cannot be younger than their children. However, there are usually some
exceptions in a citation network: papers which cite one another, e.g.,
papers appearing at about the same time and written by one author. We
eliminated these exceptions by shrinking the papers by an author which are
connected by cyclic citations. In the centrality literature network, we used
the latter approach (e.g., two publications by Gilch in 1954 are shrunk to
one paper #GilchSW-54).
</p>
<h3>References</h3>
<ol>
 <li> N.P. Hummon, P. Doreian, &amp; L.C. Freeman, 'Analyzing the structure of
  the centrality-productivity literature created between 1948 and 1979' (in:
  Knowledge-Creation Diffusion Utilization, 11 (1990), 459-480).
 </li>
 <li> W. de Nooy, A. Mrvar, &amp; V. Batagelj, Exploratory Social Network
  Analysis with Pajek (Cambridge: Cambridge University Press, 2004),
  Chapter 11.</li>
</ol>
<h3>History</h3>
<ol>
 <li> Original author: N.P. Hummon (&#8224;2002), P. Doreian
  (<a href="mailto:pitpat+@pitt.edu"><code>pitpat+@pitt.edu</code></a>) &amp;
  L.C. Freeman
  (<a href="mailto:lin@aris.ss.uci.edu"><code>lin@aris.ss.uci.edu</code></a>).
 </li>
 <li> Data compiled into Pajek data files by @ (Pat Doreian?)</li>
</ol>

<!-- h3>Copyright</h3>
<p>
(Adapted) E-mail send to P. Doreian on December 23, 2003.
Free for noncommercial use.
</p -->
<hr>
2. January 2004 &nbsp;
<a href="../default.htm">Pajek datasets</a> /
<a href="./default.htm">Exploratory SNA</a>
</td></tr></tbody></table>
</center>
</body></html>
