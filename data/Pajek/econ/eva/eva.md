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

<h2> EVA<br>Extraction, Visualization &amp; Analysis of corporate inter-relationships</h2>

<p><b>Dataset</b> &nbsp; <code>EVA</code>
<p><b>Description</b>
<p>
 <code>EVA.net</code> directed network with 8343 vertices and 6726 arcs.
<p><b>Download</b>
<p><a HREF="https://github.com/bavla/Nets/raw/refs/heads/master/data/Pajek/econ/eva/eva.zip">EVA.net</a> (ZIP, 204K); included also original files
<code>names.txt</code> and <code>ownership.txt</code>.

<h3>Background</h3>
<p>
 <tt>EVA</tt> / <a href="http://denali.berkeley.edu/eva/">Denali</a>
 is a multidisciplinary research project combining information extraction,
 information visualization, and social network analysis techniques to bring greater
 transparency to the public disclosure of inter-relationships between corporations.
 The project is described in the paper [1].
</p>
<p><b>Abstract:</b>
We present EVA, a prototype system for extracting, visualizing, and analyzing
corporate ownership information as a social network. Using probabilistic information
retrieval and extraction techniques, we automatically extract ownership relationships
from heterogeneous sources of online text, including corporate annual reports (10-Ks)
filed with the U.S. Securities and Exchange Commission (SEC). A browser-based
visualization interface allows users to query the relationship database and explore
large networks of companies. Applying the system and methodology to the
telecommunications and media industries, we construct an ownership network with
6,726 relationships among 8,343 companies. Analysis reveals a highly clustered network,
with over 50% of all companies connected to one another in a single component.
Furthermore, ownership activity is highly skewed: 90% of companies are involved in
no more than one relationship, but the top ten companies are parents for over 24% of
all relationships. We are also able to identify the most influential companies in
the network using social network analysis metrics such as degree, betweenness,
cutpoints, and cliques. We believe this methodology and tool can aid government
regulators, policy researchers, and the general public to interpret complex
corporate ownership structures, thereby bringing greater transparency to the
public disclosure of corporate inter-relationships.
</p>
<p>
Note that we do not have ownership relationships for all companies,
so there will be companies without links.</p>
<p>
An arc (X,Y) from company X to company Y exists in the network if
in the company X is an owner of company Y.
</p><p>
<b>Copyright</b> 2002 by Denali Project.
If you use this dataset in your research, please use the
citation to paper [1] as the source of the data.
</p><p>
"Denali" is the Native American name for the tallest peak in North America.
It means "the Great One."
</p><p>
If you have any questions, please contact:
<A HREF="mailto:chuang@sims.berkeley.edu">John Chuang</A>,
<A HREF="mailto:mgebbie@sims.berkeley.edu">Mike Gebbie</A>,
<A HREF="mailto:glucas@sims.berkeley.edu">Gabe Lucas</A>,
<A HREF="mailto:knorlen@sims.berkeley.edu">Kim Norlen</A>.
</p>

<h3>History</h3>
<p>
<ol>
<li> 2002 collection of original data by the EVA group;</li>
<li> March 6, 2004: original data transformed into Pajek format <tt>EVA.net</tt>
     by V. Batagelj.</li>
</ol>
</p>

<h3>References</h3>
<ol>
<li> Kim Norlen, Gabriel Lucas, Mike Gebbie, and John Chuang.
     <i>EVA: Extraction, Visualization and Analysis of the Telecommunications
      and Media Ownership Network</i>. Proceedings of International
      Telecommunications Society 14th Biennial Conference, Seoul Korea,
      August 2002.
      (paper
     <a href="http://denali.berkeley.edu/eva/its-paper.pdf">berkeley</a> /
     <a href="./its-paper.pdf">local</a>; slides
     <a href="http://denali.berkeley.edu/eva/its-slides.pdf">berkeley</a> /
     <a href="./its-slides.pdf">local</a>)
     </li>
</ol>

<hr>
6. March 2004
</td></tr></table>
</center>
</body>
</html>
<hr>

[Pajek network data sets](../../README.md);
[Network data sets](../../../README.md)

