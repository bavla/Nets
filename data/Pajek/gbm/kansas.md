<html>
 <head>
 <title>Pajek data: Generalized Blockmodeling / Kansas SAR</title>
 <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
 <style type="text/css"> </style>
 <link rel=StyleSheet href="./GBM.css" type="text/css" title="GBM Style" media="screen, print">
 </head>
<body bgcolor="darkgreen">

<center>

<table width="650" bgcolor="lightyellow" cellpadding="10" border="0" bordercolor="brown"><tbody><tr><td>
<table><tr><td>
<img src="../pajek.gif" width="100"> &nbsp; &nbsp;</td><td><h1>Pajek datasets<br>
 <font size=3>from the book</font></h1>
 </td></tr></table>
<h2><font color=Navy>Generalized Blockmodeling<br>
    <small>Patrick Doreian, Vladimir Batagelj, Anu&#353;ka Ferligoj</small></font></h2>
<hr>

<h2>Kansas <i>Search and Rescue</i> Network [KS]</h2>

<p><b>Dataset</b> &nbsp; <code>Kansas</code></p>
<p><b>Description</b></p>
<p>
<tt>Kansas.mat</tt>: 20 vertices (organizations),
    Original directed valued matrix.<br>
<tt>KansasBin.mat</tt>: 20 vertices (organizations),
    Derived directed binary matrix .<br>
<tt>KansasLab.nam</tt>: vertex labels. <br>
<tt>KansasLong.nam</tt>: vertex long names.
</p>
<p><b>Download</b></p>
<p>
<a href="./kansas/Kansas.zip">complete dataset</a> (ZIP)
</p>
<p><b>Background</b></p>
<p>
When disasters strike human communities, there will be physical
damage, human suffering and social loss. Both organizations and individuals
respond to the needs created by disasters. Their responses are more
effective if their actions are coordinated in some fashion. In general, this
coordination takes the form of an inter-organizational network that forms to
create an overall Search and Rescue Operation (SAR) mission. Drabek T.E. et al.(1981)
report a variety of these networks and discuss their formation through time,
the structure(s) generated and their operation.
<p>
An inter-organizational SAR network formed after a small tornado flipped a
pleasure boat on Lake Pomona, in Kansas. Although many individuals and
organizations responded, Drabek T.E.  et al. argue that the bulk of the SAR effort
involved the 20 organizations. They include law
enforcement agencies, fire departments, underwater rescue teams, general
emergency agencies as well as county, state and federal agencies.
<p>
The County Sheriff (A) took control of the SAR effort once the County
Attorney (D) assured him of his legal authority to do so. A command post was
created in a Highway Patrol (E) facility. Lake Pomona had been created by a
dam that was built and operated by the U.S. Army Corps of Engineers (I). The
State Park that included the lake was under the control of the State Parks
and Resources Authority (F) with the responsibility shared by the State Game
and Fish Commission (G). A temporary morgue was established under the
control of the County Coroner (C) at the offices of the Army Corps. Bodies
were brought to this location while survivors were brought to the office of
the state park. There were two ambulance services (K, L), two fire
departments (R, S), two police departments (O, P) and three organizations
defined in terms of their expertise in underwater rescue (M, N, T).
Additionally, there was the Civil Defense Office (B) for the county and the
Red Cross (Q).
<p>
The communication data among these organizations are collected in
a matrix of the <tt>Kansas</tt> network.
The values in the matrix represent relative magnitudes (they are reverse
coded from the original data source so that higher values
represent higher rates of communication) of communication intensity: (4)
continuous; (3) about once an hour; (2) every few hours; (1) about once a
day and (0) no communication.
<p>
One goal of blockmodeling is the establishment of the basic
structure of a network.
</p>
<h3>References</h3>
<ol>
 <li> Drabek, T.E. et al.(1981).
   Managing Multiorganizational Emergency Responses.
   Boulder: University of Colorado, IBS.
 </li>
</ol>
<h3>History</h3>
<ol>
 <li> Original authors: Drabek, T.E. et al.(1981).
 </li>
 <li> Transformed in Stran format by P. Doreian.</li>
 <li> Transformed in Pajek format by P. Doreian.</li>
 <li> Prepared for GBM dataset by V. Batagelj, 2. January 2007.</li>
</ol>

<!-- h3>Copyright</h3>
<p>
(Adapted) e-mail to Valentina Hlebec, on December 23, 2003.
</p -->
<hr>
2. January 2007 &nbsp;
<a href="../default.htm">Pajek datasets</a> /
<a href="./default.htm">GBM</a>
</td></tr></tbody></table>
</center>
</body></html>
