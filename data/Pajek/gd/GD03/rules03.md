<!DOCTYPE doctype PUBLIC "-//w3c//dtd html 4.0 Transitional//EN"><html><head><title>GD2003: Graph Drawing Contest</title>
    
									 <!-- Changed by: Andreas Pick, 22-Aug-2003 -->

  <body background="http://www.gd2003.org/images/sfondo1.jpg">

<hr>
<h1>GD03: Graph Drawing Contest</h1>
<h1>"Drawing Graphs within Graphs"</h1>
  
<h3>Organized by Franz J. Brandenburg (University of Passau)</h3>
<p> </p>
<hr>

<h2>Introduction</h2> 

<p>
The tenth annual graph-drawing contest will be held in conjunction 
with 11th International Symposium on Graph Drawing 2003.
<br> <br>
By the experience from the previous contests, we have revised the concept 
for this year. We wish to address more participants, and hope that 
the theme will attract both young and experienced researchers, and other 
participants from within and outside the graph drawing community.
<br> <br>
Rather than asking for "nice" drawings of certain challenge graphs 
and awarding the best drawings in each category, we set a theme for 
the contest which can be addressed in various ways.
Furthermore, we give authors more room for a presentation of their 
work. The authors of accepted/awarded submissions will be recommended for an 
invitation to submit their contribution in a special section of the special issue 
of the Journal of Graph Algorithms and Applications devoted to Graph 
Drawing 2003. Besides, the Report on the Graph Drawing Contest in the 
Proceedings of GD2003 will summarize all accepted/awarded submissions.
Finally, the winning entry is awarded a prize fund of EUR 1,000.
<br> <br>
Reports on previous contests can be found in the proceedings of the Symposium
on Graph Drawing, published in the Springer Lecture Notes in Computer Science.
</p>
<h2>Theme for 2003</h2>
<p>
The theme of this year's contest is "drawing graphs within graphs".
<br> <br>
It emphasizes the largely open question of how to visualize 
distinguised graph structures that are contained in larger graphs in 
a distinct way.  While any question related to this general theme may 
be addressed, we give some examples to spark your creativity:
</p>

  <ul>
    <li>Given a distinguished subgraph (structurally or extrinsically defined).
   Produce a drawing that makes the structure of the subgraph apparent and well
    visible (for example a provider's subnet in a telecommuncation network).
   Show the existence of such a subgraph and display it by a graph drawing
   algorithm.
   (for example a (or all) K<sub>{3,3}</sub> or K<sub>5</sub> in a non-planar graph).
   Modify a drawing of the subgraph minimally to accomodate the rest
   (as in an evolving sequence of graphs).</li>
    <li>Given a (partial) drawing of a graph, embed the distinguished 
subgraph into the drawing in a suitable way. </li>
    <li>Given a large graph, make all occurrences of a set of small graphs visible.
   Show how they are distributed over the graph, or how they relate to each
   other. </li>
    <li>Make isomorphic subgraphs recognizable.</li>
    <li>Given a nested graph, place contained graphs in a layout of their containers
   or vice versa.</li>
    <li>Draw a graph using templates for certain subgraphs. </li>
  </ul>

<h2>Contest Data</h2>
<p>
Two real-world data sets are provided that can be used to illustrate 
your results towards the theme. (The files provide additional information
about the graphs; note that you may also use your own data).</p>
  <ol>
    <li>A biological network representing the transcriptional regulation 
        of Escherichia coli, in which recurring motifs (small isomorphic 
        subgraphs) are of interest (courtesy of 
        <a href="http://www.weizmann.ac.il/mcb/UriAlon/">Uri Alon</a>, 
        The Weizmann Institute).<br>
		<a href="http://www.infosun.fmi.uni-passau.de/br/lehrstuhl/GraphDrawing/GD2003/graphs/biological_network.ascii">ascii</a> - 
		<a href="http://www.infosun.fmi.uni-passau.de/br/lehrstuhl/GraphDrawing/GD2003/graphs/biological_network.ascii.txt">File description</a><br>
		<a href="http://www.infosun.fmi.uni-passau.de/br/lehrstuhl/GraphDrawing/GD2003/graphs/biological_network.xml">GraphML</a><br>
		<a href="http://www.infosun.fmi.uni-passau.de/br/lehrstuhl/GraphDrawing/GD2003/graphs/biological_network.gml">GML</a> <br>
		<a href="http://www.infosun.fmi.uni-passau.de/br/lehrstuhl/GraphDrawing/GD2003/graphs/biological_network.leda.gml">LEDA</a> - 
		<a href="http://www.infosun.fmi.uni-passau.de/br/lehrstuhl/GraphDrawing/GD2003/graphs/biological_network.leda.gml.txt">File description</a><br>
    </li>
    <li>A social network representing informal communication among organizations
        involved in drug policy making, in which the edge-induced subgraph of 
        confirmed relations is of interest (courtesy of 
        <a href="http://www.uvt.nl/webwijs/show.html?anr=986135&lang=en">Patrick Kenis</a>, 
        Tilburg University).<br>
		<a href="http://www.infosun.fmi.uni-passau.de/br/lehrstuhl/GraphDrawing/GD2003/graphs/social_network.ascii">ascii</a> - 
		<a href="http://www.infosun.fmi.uni-passau.de/br/lehrstuhl/GraphDrawing/GD2003/graphs/social_network.ascii.txt">File description</a><br>
		<a href="http://www.infosun.fmi.uni-passau.de/br/lehrstuhl/GraphDrawing/GD2003/graphs/social_network.xml">GraphML</a><br>
		<a href="http://www.infosun.fmi.uni-passau.de/br/lehrstuhl/GraphDrawing/GD2003/graphs/social_network.gml">GML</a> <br>
		<a href="http://www.infosun.fmi.uni-passau.de/br/lehrstuhl/GraphDrawing/GD2003/graphs/social_network.leda.gml">LEDA</a> - 
		<a href="http://www.infosun.fmi.uni-passau.de/br/lehrstuhl/GraphDrawing/GD2003/graphs/social_network.leda.gml.txt">File description</a><br>
	</li>
  </ol>
<p>

</p>
<h2>Call for contributions</h2>
<p>
Contributions are solicited that address the theme "graphs within 
graphs" from a graph drawing point of view.
<br> <br>
We particularly encourage young researchers to start working on the 
topic and take the chance of publishing first results or novel, but 
potentiallynot fully developed, ideas in a respected journal.
<br> <br>
Submissions may contain visualizations, drafts, case studies, 
concepts, algorithms, experiments, structural results, etc., and may 
be in the form of textual descriptions (no more than 6 pages), 
drawings, videos, implementations, or other content.  The only set 
requirement is that they must contain visualizations related to the 
theme (at least one drawing/picture).
<br> <br>
Submissions should be sent (preferably in electronic form in .ps, pdf,) to
<br> <br>
<a href="mailto:brandenb@informatik.uni-passau.de">brandenb@informatik.uni-passau.de</a> (Franz J. Brandenburg, University of Passau, 94030 Passau, Germany)
<br> <br>
and must be received by August 15, 2003.  They will be reviewed by a 
panel of experts on the basis of their originality, novelty, 
creativity, and soundness.
<br> <br>
Accepted submissions as well as a special award for the most 
outstanding contribution will be announced during the GD 2003 
conference dinner, and shall be published on the conference web pages 
soon after.
<br> <br>

</p>
<h2>Awards</h2>
<p>
The accepted submissions will be recommended by the jury for invitation
as short submissions to the GD 2003 special issue of JGAA.

<!-- Authors of accepted/awarded submissions will be invited to prepare a 
short paper on their contribution, which will be published in an 
edited special section of a special issue of the Journal of Graph 
Algorithms and Applications devoted  to GD 2003. -->
<br> <br>
The best contribution is awarded with a prize money of EURO 1000.
<br> <br>
</p>

<h2>Contest Jury</h2>
<p>
The following experts will evaluate submissions and decide on which
submissions are considered for a short publication in the Journal of
Graph Algorithms and Applications and on the best contribution.
</p>

  <ul>
    <li>Franz J. Brandenburg (Passau)
    </li>
    <li>Ulrik Brandes (Passau)
    </li>
    <li>Peter Eades (Sydney)</li>
    <li>Joe Marks (MERL, Cambridge)
<br> <br>
    </li>
  </ul>

<h2>Sponsors</h2>
<p>
AT&T Research<br>
MERL - Mitsubishi Research Lab
</p>

<h2>Contact</h2>
<p>
Prof. Dr. Franz J. Brandenburg<br>
<a href="mailto:brandenb@informatik.uni-passau.de">brandenb@informatik.uni-passau.de</a>
</p>

  </body></html>
