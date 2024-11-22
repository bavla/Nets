<html>
<head>
  <meta HTTP-EQUIV="Content-Type" CONTENT="text/html;charset=UTF-8">
  <link rel=StyleSheet href="../esna/esna.css" type="text/css" title="ESNA Style" media="screen, print">
</head>
<body bgcolor=darkgreen>
<center>
<table width=650 bgcolor=lightyellow cellpadding=10 border=0 bordercolor=brown><tr><td>
<h1><img src=../../pajek.gif width=100>Pajek datasets</h1>

<hr>

<h2> KDD Cup 2003<br>High Energy Particle Physics (HEP) literature</h2>

<p><b>Dataset</b> &nbsp; <code>hep-th</code>
<p><b>Description</b>
<p>
 <tt>hep-th.net</tt> directed network with 27240 vertices and 342437 arcs (39 loops).<br>
 <tt>hep-th-new.net</tt> directed network with 27770 vertices and 352807 arcs (39 loops).<br>
 <tt>date-new.vec</tt> integer vector on 27770 vertices.<br>
 <tt>year-new.vec</tt> integer vector on 27770 vertices.
<p><b>Download</b>
<p><A HREF="https://github.com/bavla/Nets/raw/refs/heads/master/data/Pajek/bib/hep-th/hep-th.zip">complete dataset</A> (ZIP, 2607K)

<p><b>Background</b>
Citation data from KDD Cup 2003, a knowledge discovery and data mining
competition held in conjunction with the Ninth Annual ACM SIGKDD Conference.<p>
The Stanford Linear Accelerator Center SPIRES-HEP database has been
comprehensively cataloguing the High Energy Particle Physics (HEP) literature
online since 1974, and indexes more than 500,000 high-energy physics related
articles including their full citation tree.<p>
The network contains a citation graph of the hep-th portion of the arXiv.
The units names are the arXiv IDs of papers; the relation is  X cites Y .
Note that revised papers may have updated citations. As such, citations may
refer to future papers, i.e. a paper may cite another paper that was published
after the first paper. <p>
The SLAC/SPIRES dates for all hep-th papers are given. Some older papers were
uploaded years after their intial publication and the arXiv submission date
from the abstracts may not correspond to the publication date. An alternative
date has been provided from SLAC/SPIRES that may be a better estimate
for the initial publication of these old papers.
<p>
The first version of data was updated on May 12, 2003.
<p>
<code>hep-th.net</code> X cites Y relation, first version. <br>
<code>hep-th-new.net</code> X cites Y relation, updated version. <br>
<code>date-new.vec</code> SLAC date of paper was transformed to
  the number of days since August 1, 1991, updated version. <br>
<code>year-new.vec</code> year from the SLAC date of paper, updated version.


<p><b>References</b>
<ol>
 <li> <A HREF="http://www.cs.cornell.edu/projects/kddcup/index.html">KDD Cup 2003</A>
 <li> <A HREF="http://arxiv.org/">arXiv</A>
</ol>
Transformed in Pajek format by V. Batagelj, 26. July 2003
<hr>
26. July 2003
</td></tr></table>
</center>
</body>
</html>
<hr>

[Pajek network data sets](../../README.md);
[Network data sets](../../../README.md)

