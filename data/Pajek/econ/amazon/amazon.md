<html>
<head>
  <title>Pajek data: Amazon</title>
  <meta HTTP-EQUIV="Content-Type" CONTENT="text/html;charset=UTF-8">
  <link rel=StyleSheet href="../../esna/esna.css" type="text/css" title="ESNA Style" media="screen, print">
</head>

<body bgcolor=darkgreen>

<center>

<table width=650 bgcolor=lightyellow cellpadding=10 border=0 bordercolor=brown><tr><td>

<h1><img src=../../pajek.gif width=100>Pajek datasets</h1>

<hr>

<h2> Amazon<br>"Customers who bought this item also bought these items ..."</h2>

<p><b>Dataset</b> &nbsp; <code>Amazon</code>
<p><b>Description</b>
<p>
 <code>AmazonBk.net</code> directed network with 216737 vertices and 982296 arcs.<br>
 <code>AmazonBkLong.nam</code> long names (author and title).<br>
 <code>AmazonBkShort.nam</code> short names (Amazon IDs).<br>
 <code>AmazonCD.net</code> directed network with 79244 vertices and 526271 arcs.<br>
 <code>AmazonCDLong.nam</code> long names (author and title).<br>
 <code>AmazonCDShort.nam</code> short names (Amazon IDs).
<p><b>Download</b>
<p><a HREF="./AmazonBk.zip">AmazonBk.net</a> (ZIP, 204K); included also original files <br>
<p><a HREF="./AmazonCD.zip">AmazonCD.net</a> (ZIP, 204K); included also original files

<h3>Background</h3>
<p>
<a href="http://www.amazon.com/"><b>Amazon</b></a>
opened its virtual doors in July 1995
with the mission to use Internet to transform book buying into the fastest and easiest way.
The Company's principal corporate offices are located in Seattle, Washington.
It is one of the leading online shopping sites. It offers huge selection of products, including
books, CDs, videos, DVDs, toys and games, electronics, kitchenware, computers etc.
</p>
<p>
The <b>vertices</b> in Amazon networks are books / CDs; while the <b>arcs</b>
 are determined based on the list of products (CDs/books) under the title:
<b>"Customers who bought this CD/book also bought"</b>
</p>
<p>
Using relatively
<a href="./amazon.py">simple program</a>
written in <a href="http://www.python.org/">Python</a>
we 'harvested' the books network from June 16 till June 27, 2004; and the CDs
network from July 7 till July 23, 2004.
We harvested only the portion of each network reachable from the selected
starting book/CD.
</p>
<p>
The books network has 216737 vertices and 982296 arcs
(number of arcs = 983374, loops=831, mult.lines=289).
The CDs network has 79244 vertices and 526271 arcs.
</p>
<p>
By the construction both networks have limited out-degree and are
weakly connected. 178281 books have the out-degree 5; and
55373 CDs have out-degree 8.
</p>

<h3>History</h3>
<p>
<ol>
<li> June-July 2004 harvesting of original data from Amazon;</li>
</ol>
</p>

<!-- h3>References</h3>
<ol>
<li>
     <a href="./its-slides.pdf">local</a>)
     </li>
</ol -->

<hr>
<a href="../../default.htm">Pajek Data</a>;
<a href="http://vlado.fmf.uni-lj.si/pub/networks/pajek/default.htm">Pajek Home</a>
<hr>
24. November 2004
</td></tr></table>
</center>
</body>
</html>
