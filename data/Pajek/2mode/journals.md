<html><head>
 <title>Pajek data: Slovenian magazines and journals 1999 and 2000</title>
 <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
 <link rel=StyleSheet href="../esna/esna.css" type="text/css" title="ESNA Style" media="screen, print">
</head>
<body bgcolor="darkgreen">

<center>

<table width="650" bgcolor="lightyellow" cellpadding="10" border="0" bordercolor="brown"><tbody><tr><td>

<h1><img src="../pajek.gif" width="100">Pajek datasets</h1>

<hr>

<h2>Slovenian magazines and journals 1999 and 2000</h2>

<p><b>Dataset</b> &nbsp; <code>Journals</code>
</p><p><b>Description</b>
</p><p>
<tt>Revije.net </tt> - valued network with 124 vertices<br>
<tt>Revije.clu </tt> - partition with 124 vertices<br>
<tt>Revije.paj</tt> - Pajek project file with complete dataset.
</p><p><b>Download</b>
</p><p><a href="./Revije.zip">complete dataset</a> (ZIP, 3K)

</p>
<p><b>Background</b></p><p>
Over 100.000 people have been asked which magazines and
journals they read (survey conducted in 1999 and 2000, source CATI Center Ljubljana).
They listed 124 different magazines and journals.
The collected data can be represented as 2-mode network:
<pre>
                 Delo    Dnevnik   Sl.novice ...
Reader1            X                   X     ...
Reader2                     X                ...
Reader3            X                         ...
............     .....   .......   ......... ...
</pre>

<p><b>Obtaining 1-mode network</b></p><p>

From 2-mode network reader/journal we generated ordinary network,
where the vertices are journals
<ul>
  <li> undirected edge with value <i>a</i> between journals
       means the number of readers of both journals.
  <li> loop on selected journal means the number of all
       readers that read this journal.
</ul>

Obtained matrix (<i>A</i>):
<pre>
                 Delo    Dnevnik   Sl.novice ...
Delo            20714       3219        4214 ...
Dnevnik                    15992        3642 ...
Sl. novice                             31997 ...
........        ......     .....       ..... ...
</pre>

The second ordinary network on readers would be huge (more than 100.000 vertices)
containing large cliques (readers of particular journal).
</p>
<h3>History</h3>
<ol>
 <li> Transformed in journal X journal matrix, 26. December  2000.</li>
 <li> Transformed in Pajek format by V. Batagelj, 21. December 2003.</li>
</ol>

</p><h3>References</h3>
<ol>
 <li> Dagstuhl seminar:
 <A HREF="http://vlado.fmf.uni-lj.si/pub/networks/doc/dagstuhl/casniki.htm">
 Link Analysis and Visualization</A>, Dagstuhl 1-6. July 2001</li>
</ol>
<hr>
<a href="../default.htm">Pajek Data</a>;
<a href="http://vlado.fmf.uni-lj.si/pub/networks/pajek/default.htm">Pajek Home</a>
<hr>
21. December 2003
</td></tr></tbody></table>
</center>
</body></html>
