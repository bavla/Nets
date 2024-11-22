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

<h2> KEDS<br>The Kansas Event Data System</h2>

<p><b>Dataset</b> &nbsp; <code>KEDS</code>
<p><b>Description</b>
<p>
 <code>GulfLDays.net</code> directed multirelational temporal network with 174 vertices and 57131 arcs.
  From 'leads' Gulf event data, granularity is 1 day.<br>
 <code>GulfLMonths.net</code> directed multirelational temporal network with 174 vertices and 57131 arcs.
  From 'leads' Gulf event data, granularity is 1 month.<br>
 <code>GulfLDow.net</code> directed multirelational temporal network with 174 vertices and 57131 arcs.
  From 'leads' Gulf event data, in day of the week classes.<br>
 <code>GulfADays.net</code> directed multirelational temporal network with 202 vertices and 304401 arcs.
  From Gulf event data, granularity is 1 day.<br>
 <code>GulfAMonths.net</code> directed multirelational temporal network with 202 vertices and 304401 arcs.
  From Gulf event data, granularity is 1 month.<br>
 <code>LevantDays.net</code> directed multirelational temporal network with 485 vertices and 196364 arcs.
  From Levant event data, granularity is 1 day.<br>
 <code>LevantMonths.net</code> directed multirelational temporal network with 485 vertices and 196364 arcs.
  From Levant event data, granularity is 1 month.<br>
 <code>BalkanDays.net</code> directed multirelational temporal network with 325 vertices and 78667 arcs.
  From Balkan event data, granularity is 1 day.<br>
 <code>BalkanMonths.net</code> directed multirelational temporal network with 325 vertices and 78667 arcs.
  From Balkan event data, granularity is 1 month.
<p><b>Download</b>
<p><a HREF="./GulfLDays.zip">GulfLDays.net</a> (ZIP, 239K) <br>
   <a HREF="./GulfLMonths.zip">GulfLMonths.net</a> (ZIP, 197K) <br>
   <a HREF="./GulfLDow.zip">GulfLDow.net</a> (ZIP, 213K) <br>
   <a HREF="./GulfADays.zip">GulfADays.net</a> (ZIP, 1078K) <br>
   <a HREF="./GulfAMonths.zip">GulfAMonths.net</a> (ZIP, 941K) <br>
   <a HREF="./LevantDays.zip">LevantDays.net</a> (ZIP, 855K) <br>
   <a HREF="./LevantMonths.zip">LevantMonths.net</a> (ZIP, 735K) <br>
   <a HREF="./BalkanDays.zip">BalkanDays.net</a> (ZIP, 335K) <br>
   <a HREF="./BalkanMonths.zip">BalkanMonths.net</a> (ZIP, 288K)
</p>
<h3>Background</h3>
<p>
<a href="http://www.ku.edu/~keds/index.html"><b>KEDS</b></a> -
<b>The Kansas Event Data System</b>
uses automated coding of English-language news reports to generate
political event data focusing on the Middle East, Balkans, and
West Africa. These data are used in statistical early warning models
to predict political change. The ten-year project is based in the
Department of Political Science at the University of Kansas;
it has been funded primarily by the U.S. National Science Foundation.</p>

<h3>KEDS data sets</h3>
from <a href="http://www.ku.edu/~keds/data.html"><b>KEDS data collection</b></a>.
<p>
<b>Gulf data set:</b>
This data set covers the states of the Gulf region and the Arabian
peninsula for the period 15 April 1979 to 31 March 1999.
The source texts prior to 10 June 97 were located using a NEXIS
search command specifically designed to return relevant data.
There are two versions of the data:
 a set coded from the lead sentences only (57,000 events), and
 a set coded from full stories (304,000 events).
<br>
There are some errors in the GulfAll data. Events
118196 and 118197 have REUT-0 in place of the date;
and in event 173526 the first actor is missing.
In <tt>Gulf99All.dat</tt> the wrong dates are replaced with
890319, and the incomplete event is skiped.
</p>
<p>
<b>Levant data set:</b>
Folder containing WEIS-coded events (N=196,337)  for dyadic interactions
within the following set of countries: Egypt, Israel, Jordan, Lebanon,
Palestinians, Syria, USA, and USSR/Russia. Coverage is April 1979 to June 2004.
TABARI coding dictionaries are also included.<br>
There are some errors (333) in data set - relation codes
<tt>012]</tt>, <tt>O24</tt>, <tt>O53</tt>, <tt>213]</tt> are replaced with
<tt>012</tt>, <tt>024</tt>, <tt>053</tt>, <tt>213</tt> in <tt>Levant.dat</tt>.
Some events don't have description codes - they are marked with <tt>***</tt>
in relation labels in <tt>*.net</tt> files.
</p>
<p>
<b>Balkans data set, 1989-2003:</b>
Folder containing WEIS-coded events (N = 78,667) for the major actors
(including ethnic groups) involved in the conflicts in the former Yugoslavia.
Coverage is April 1989 through July 2003. TABARI coding dictionaries are
included in the folder.<br>
There are some errors (197) in data set - relation codes
<tt>---]</tt>, <tt>O24</tt>, <tt>O53</tt> are replaced with
<tt>000</tt>, <tt>024</tt>, <tt>053</tt> in <tt>Balkan.dat</tt>.
Some events don't have description codes - they are marked with <tt>***</tt>
in relation labels in <tt>*.net</tt> files.
</p>
<p>
The original data sets are on MAC files. They should be saved as PC files before
processing.
</p>

<h3>History</h3>
<p>
<ol>
<li> Program <tt>Recode</tt> (in Delphi) by Vladimir Batagelj, Ljubljana, July 25, 2003</li>
<li> Program <tt>KEDSrec</tt> adapted for KEDS from <tt>Recode</tt>;
     Gulf (leads) data recoded into Pajek's format,
     by Vladimir Batagelj, Ljubljana, November 3, 2003</li>
<li> Support for multiple relations networks added to program <tt>KEDSrec</tt>
     by Vladimir Batagelj, Ljubljana, November 22, 2004</li>
<li> <tt>KedsR</tt> - functionality of <tt>KEDSrec</tt> implemented in <b>R</b>;
     Gulf (leads) data recoded into Pajek's format (days, months, day of the week),
     by Vladimir Batagelj, Ljubljana, November 27, 2004</li>
<li> <tt>WeisR</tt> - commands from <tt>KedsR</tt> adapted for WEIS format (similar to
     KEDS but TAB delimited);
     Balkan and Levant data recoded into Pajek's format (days, months),
     by Vladimir Batagelj, Ljubljana, November 28, 2004</li>
<li> Gulf99All is a large data set - sapply commands in <tt>KedsR</tt> had to be replaced
     by while loops;
     Gulf (all) data recoded into Pajek's format (days, months),
     by Vladimir Batagelj, Ljubljana, November 29, 2004</li>
</ol>
</p>

<h3>References</h3>
<ol>
<li>
     <a href="http://www.macwindows.com/compress.html">StuffIt</a> - uncompress program
     for SIT files
     </li>
</ol>

<hr>
29. November 2004 / 24. November 2004
</td></tr></table>
</center>
</body>
</html>
<hr>

[Pajek network data sets](../README.md);
[Network data sets](../../README.md)

