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

<h2> FreeAssoc<br>The University of South Florida word association, rhyme, and word fragment norms</h2>

<p><b>Dataset</b> &nbsp; <code>FreeAssoc</code>
<p><b>Description</b>
<p>
 <tt>PairsP.net</tt> directed network with 10617 vertices and 72168 arcs (4 loops);
     cue X is associated with target Y N times.<br>
 <tt>PairsFSG.net</tt> directed network with 10617 vertices and 72168 arcs (4 loops);
     the strength of assocition (FSG) of cue X to target Y is Z.<br>
 <tt>cue.clu</tt> cue word partition: 1 - a cue word; 0 - not a cue word.<br>
 <tt>pofs.clu</tt> part of speech partition:
  0 - undefined;         1 - N - noun;          2 - V - Verb;
  3 - AJ - Adjective;    4 - AD - Adverb;      5 - P - Pronoun;
  6 - PP - Preposition;  7 - I - Interjection;  8 - C - Conjunction.
 </p>
<p>
Both derived networks are multi-relational: relation 1 - target normed;
relation 2 - target not normed.
</p>

<p><b>Download</b>
<p><a HREF="https://github.com/bavla/Nets/raw/refs/heads/master/data/Pajek/dic/FA/Pairs.zip">USF Free Association Norms</a> (ZIP, 764K)

<h3>Background</h3>
<p>More than 6,000 participants produced nearly three-quarters of
a million responses to 5,019 stimulus words. Participants were asked
to write the first word that came to mind that was meaningfully
related or strongly associated to the presented word on the blank
shown next to each item. For example, if given BOOK _________,
they might write READ on the blank next to it. This procedure is
called a discrete association task because each participant is
asked to produce only a single associate to each word.</p>
<p>For additinal details see the original
<a href="http://w3.usf.edu/FreeAssociation/Intro.html">Introduction</a>
and the
<a href="http://w3.usf.edu/FreeAssociation/AppendixA/index.html">Description of the data</a>.</p>

<h4>USF Free Association Norms into Pajek format</h4>
<p>To transform the USF Free Association Norms into Pajek format we
glued the partial files from
<a href="http://w3.usf.edu/FreeAssociation/AppendixA/index.html">Appendix A</a>
back into a single file. Then using a simple program in Python we obtained
some files in Pajek Format. Since the coding of the parts of speech in
the original data is not consistent the partition <tt>pofs.clu</tt> still
needs some checking.
<a href="./traceShort.txt">Here</a>
is a list of inconsistencies in labelings. We deleted the inconsistency
pairs (AJ - ADJ). The label A in <tt>pofs.clu</tt> was assigned the code 9.
</p>

<h4>USF Free Association Norms - simple islands</h4>
<p><a href="./simple.pdf">Simple FSG islands</a></p>.

<h3>History</h3>
<p>
<ol>
<li> Original FA (1998): Nelson, D.L., McEvoy, C.L., & Schreiber, T.A.
  (collection started in 1973).</li>
<li> transformed in Pajek format: V. Batagelj, 24. February 2007.</li>
</ol>
</p>

<h3>References</h3>
<ol>
<li>Nelson, D.L., McEvoy, C.L., & Schreiber, T.A.: <a href="http://w3.usf.edu/FreeAssociation/">
  The University of South Florida Word Association, Rhyme and Word Fragment Norms</a></li>
<li> <a href="http://www.eat.rl.ac.uk/">
  The Edinburgh Associative Thesaurus</a>  </li>
<li> <a href="http://www.cogsci.princeton.edu/%7Ewn/">WordNet</a></li>
<li><a href="http://www.psych.rl.ac.uk/">
  MRC Psycholinguistic Database</a></li>
<li>See also Pajek data: <a href="../eat/eat.md">
  EAT</a> and
  <a href="../wordnet/wordnet.md">WordNet</a></li>
</ol>
<hr>
24. February 2007
</td></tr></table>
</center>
</body>
</html>
<hr>

[Pajek network data sets](../../README.md);
[Network data sets](../../../README.md)

