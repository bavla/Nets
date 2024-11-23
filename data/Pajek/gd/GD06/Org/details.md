<?xml version="1.0" encoding="UTF-8" ?><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta http-equiv="content-type" content="application/xhtml+xml; charset=UTF-8"/>

    <title>
    GD 2006 - Contest Details</title>
    <link rel="shortcut icon" href="./images/logo_gd_16.ico" type="image/x-icon" />
    <link rel="stylesheet" type='text/css' href="./screen.css" />
      </head>
  <body>

        <table class="layout"><tr>
        <td class="layout" id="graphlogo">&nbsp;</td>

        <td class="layout" id="header">
        <table class="layout">
        <tbody>

                  <tr>
            <td id="gdname" colspan="2" rowspan="1">
              14th International Symposium on Graph Drawing
            </td>
            <td id="rightlogo" style="width: 30px;" colspan="1" rowspan="3"><a href="http://gd2006.org" class="plain"><img
              style="width: 30px; height: 154px;" alt=" GD2006 Logo "
              src="./images/gd_right.png" /></a></td>
          </tr>
          <tr>
            <td id="gddate">September 18 - 20, 2006<br />
            Karlsruhe, Germany
            </td>
            <td id="leftlogo" style="width: 103px;" colspan="1" rowspan="2"
              ><a href="http://gd2006.org" class="plain"><img
              style="width: 103px; height: 134px;" alt=" GD2006 Logo "
              src="./images/gd_left.png" /></a></td>
          </tr>
          <tr>
            <td id="headercontent"><h1>13th Graph Drawing Contest</h1></td>
          </tr>


        </tbody>
        </table>

        </td></tr>

        <tr><td class="layout"><ul id="menu">
        <li><h4 class="first"><a href="../index.php"
            class="menu">Overview</a></h4>
                <ul class="menu">
                <li class="menu"><a href="../index.php#news">News</a></li>
                <li class="menu"><a href="../index.php#dates">Dates</a></li>
                <li class="menu"><a
                    href="../index.php#contact">Contact</a></li>
                </ul>
        </li>
        <li><h4><a href="../cfp.php"
            class="menu">Call&nbsp;for&nbsp;Papers</a></h4>
                <ul class="menu">
                <!--<li class="menu"><a href="../authorinfo.php">Author&nbsp;Info</a></li>-->
                <li class="menu"><a href="../cfp.php#instructions">Author&nbsp;Info</a></li>
                <li class="menu"><a href="../cfp.php#pc">Committees</a></li>
                <li class="menu"><a
                    href="http://www.easychair.org/GD06/">Submission</a></li>
                </ul>
        </li>
        <li><h4><a href="../karlsruhe.php">Karlsruhe</a></h4>
                <ul class="menu">
                <li class="menu"><a href="../travel.php">Travel&nbsp;Info</a></li>
                <li class="menu"><a href="../hotel.php">Hotel&nbsp;Info</a></li>
                <li class="menu"><a href="../jaws/karlsruheflyer.jnlp">3D Karlsruhe Graph</a> (Java)</li>
                </ul>
        </li>
        <li><h4>Conference<!--<a href="conference.php"
            class="menu">Conference</a>--></h4>
                <ul class="menu">
                <li class="menu"><a
                  href="../registration.php">Registration</a></li>
                <li class="menu"><a href="../location.php">Location</a></li>
                <li class="menu"><a href="accepted.php">Accepted
                    Papers</a></li>
                <li class="menu"><a
                    href="../docs/program.pdf">Program</a></li>
                <li class="menu"><a
                    href="softwareexpo.php">Software&nbsp;Exhibition</a></li>
                </ul>
        </li>
        <li><h4><a href="../contest/">GD&nbsp;Contest</a></h4>
                <ul class="menu">
                <li class="menu"><a href="../contest/details.php">Competitions</a></li>
                <li class="menu"><a href="../contest/challenge.php">Challenge</a></li>
                </ul>
        </li>
        <li><h4><a href="http://www.graphdrawing.org/symposium/index.html"
                class="menu">GD Tradition</a></h4></li>
        </ul></td>

  <td class="layout">

<div class="content">


<h2 class="first"><a id="free"></a>Free-Style Competition</h2>

<p> The free-style category is the most general of the categories. Its purpose
is to encourage researchers to send in their most intriguing innovative
visualizations.</p>

<p>There are no specific requirements for the type of visualizations, and we
encourage submissions of all types of drawings. Judging will be based on
artistic merit and relevance to the graph drawing community. Consequently,
submitting a brief description of the relevance is instrumental in our
decision.</p>


<h2><a id="theory"></a>Theory Graph Competition</h2>

<p>The theory graph category presents a certain "mystery" graph of 101 nodes and
190 edges. Judging will be based on both the artistic and informational
merit.</p>

<h3>Data</h3>

<p>The data is presented in three formats:</p>

<ul>
<li><h4><a href="theory.txt">Edge List</a></h4>
<p>The first line is the number of nodes (N).
All other lines are pairs of vertex indices (0 to N-1) forming an (undirected)
edge.</p></li>

<li><h4><a href="theory.graphml">GraphML</a></h4>
<p>Details on this format are available on the
<a href="http://graphml.graphdrawing.org/">GraphML website</a>.
(Warning, the conversion from the raw format is still untested.
Please contact if there are any errors present).</p></li>

<li><h4><a href="theory.net">Pajek (.net)</a></h4>
<p>Courtesy of Vladimir Batagelj. Details on this format are available on the
<a href="http://vlado.fmf.uni-lj.si/pub/networks/pajek/">Pajek website</a>.
</p></li>
</ul>


<h2><a id="worldcup"></a>History of the World Cup Competition</h2>

<p>Every four years, FIFA's World Cup phenomenon sweeps the globe, as it did
this year. In honor of its long history, and as a curiosity of the tournament of
the world's best footballers, this category is dedicated to analyzing and
visualizing the evolution of the game. In particular, we provide the results for
all matches played in the final rounds since the Cup's founding in 1930.</p>

<p> The object is to come up with a creative and informative visualization of
the evolution of the game, as an animated (<b>movie</b>) graph. Clearly, one
starting point is to represent each year as a different graph with each team
being a (labeled) node and each (directed, labeled) edge representing a game
played between two opponents. In this scenario, one would show how the graph
evolved over the years. Of course, other possible scenarios are conceivable. As
with the other categories, a description of the visualization is essential to
the judge's understanding of the information presented.</p>

<p> You are allowed to include other relevant information into the
visualization. For example, the political changes in the participating countries
(example: Germany -> W. Germany, E. Germany -> Germany), or the locations of the
tournaments.</p>

<p>Soon, we shall update the data with the results of WC 2006.</p>

<h3>Data</h3>

<p>The data is presented in two formats:</p>

<ul>
<li><h4><a href="WCData/">Raw data</a></h4>
<ol>
<li><a href="WCData/WCDescr.txt">WCDescr.txt</a> is a description of the format.</li>
<li><a href="WCData/WCClean.txt">WCClean.txt</a> is the pure raw data gathered on the
tournament.</li>
<li><a href="WCData/WCNodes">WCNodes</a> and <a href="WCData/WCEdges">WCEdges</a> are the
nodes and edges of the "graphs".</li>
</ol>
<p>All files are also available in a <a href="WCData/WCData.zip">zip</a>
archive.</p></li>

<li><h4><a href="WCData/WCData.graphml">GraphML</a> (coming soon)</h4>
<p>Details on this format are available on the
<a href="http://graphml.graphdrawing.org/">GraphML website</a>.
(Warning, the conversion from the raw format is still untested.
Please contact if there are any errors present).</p></li>
</ul>


<h2>Java (Compile-Time) Dependency Competition</h2>

<p>The Java Compile-Time Dependency graph consists of nodes representing Java
classes and directed edges representing compile-time dependencies between two
classes. For example, the class <tt>java.util.Calendar</tt> depends (among
others) on the class <tt>java.util.Hashtable</tt>. The data provided contains
the dependencies for all classes under the java.* packages for JDK 1.4.2.
Dependencies between a provided class and one outside the java.* realm are not
shown. In particular, classes in the javax.* packages are not represented.
Additionally, we have removed any class that has no dependency relationship (no
incoming or outgoing edge).</p>

<p> The task for this category is to develop a good (aesthetic <em>and</em>
informative) visualization of the Java compile-time dependency graph. For
example, one can visualize the graph in its entirety, interactively (submit a
demo movie to illustrate the use), or as various interesting subgraphs.</p>

<h3>Data</h3>

<p>The data is presented in three formats:</p>

<ul>
<li><h4><a href="JCTData/">Raw data</a></h4>
<ol>
<li><a href="JCTData/README">README</a> is a brief description of the content.</li>
<li><a href="JCTData/Nodes">Nodes</a> is a list of the Java classes included.
(1538)</li>
<li><a href="JCTData/Edges">Edges</a> is a list of Class compile-time dependencies
(8032)</li>
</ol>
<p>All files are also available in a <a href="JCTData/JCTData.zip">zip</a>
archive.</p></li>

<li><h4><a href="JCTData/JCTData.graphml">GraphML</a></h4>
<p>Courtesy of Vladimir Batagelj. Details on this format are available on the
<a href="http://graphml.graphdrawing.org/">GraphML website</a>.
(Warning, the conversion from the raw format is still untested.
Please contact if there are any errors present).</p></li>

<li><h4><a href="JCTData/JCTData.net">Pajek (.net)</a></h4>
<p>Courtesy of Vladimir Batagelj. Details on this format are available on the
<a href="http://vlado.fmf.uni-lj.si/pub/networks/pajek/">Pajek website</a>.
</p></li>
</ul>

<h3>Brief Compile-Time Dependency Description</h3>

<p>In the Java programming language, as with other object-oriented languages,
projects are organized around Objects of Classes. These Classes provide various
means of storing (variables) and manipulating (methods) information. Besides
using methods defined in a particular class and its parents (via inheritance), a
class may also use methods and data available from other classes. During
compilation, if Class A explicitly uses another Class B, then we say that A
<tt>depends</tt> on B. That is, in order for the compiler to compile class A, it
must first have a compiled version of class B available. For example, the
following class depends on the presence of the <tt>java.util.Vector</tt> and
<tt>java.lang.String</tt> classes.</p>

<pre>
import java.util.Vector;

public class Foo {
    public String combine(Vector v) {
        // ...
    }
}
</pre>

<p>The compile-time dependency graph is the graph formed by representing classes
as nodes and class dependencies as directed edges. This graph identifies which
other classes must be known in order to compile a class. Unlike a typical
inheritance graph, cycles occur in this dependency graph, and it is very
important to detect them, because all classes in a cycle must be compiled
together and cannot be compiled one by one.</p>
</div>

  <div id="footer">GD'06 Organizing Committee <br />
    this page as <a
    href="http://www.aharef.info/static/htmlgraph/?url=http%3A%2F%2Fgd2006.org%2Fcontest%2Fdetails.php"
    >graph</a> &middot;  valid <a
    href="http://validome.org/referer">XHTML 1.1</a> and
    <a href="http://jigsaw.w3.org/css-validator/check/referer">CSS</a>
  </div>

  </td>
  </tr></table>

  </body>
</html>

