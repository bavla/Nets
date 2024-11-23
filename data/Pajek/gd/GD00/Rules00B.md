<!doctype html public "-//w3c//dtd html 4.0 Transitional//EN">
<html>
 <head>
<title>GD2000: Graph Drawing Contest - Graph B</title>
</head>

<body bgcolor="#FFFFFF">
<hr>
<a href=http://www.cs.virginia.edu/~gd2000/><img src=./graph3-3s.jpg alt="GD 2000"></a>
<h1><a href="./Rules00B.htm">GD2000: Graph Drawing Contest</a></h1>
<h2>Graph B</h2>
<p>Contributed by <em>Ulrik Brandes</em>, University of Konstanz.</p>
<hr>

<h2>Background</h2>

<p>
<b>Disclaimer:</b>
<i>
This is a real-world task on real-world data.
However, all references to entities in the real world
have been anonymized to keep their privacy.
We are grateful to Maryann M. Durland, who is working
as an independent business consultant, for posing the problem.
</i>
</p>

<p>
A large organization asked for an evaluation of its project teams.
The teams in this organization are to channel information from
internal experts (<i>resources</i>) to customers (<i>clients</i>).
Both have been trained to work with clients and resources following
a specific model.  Data on the contact structure was gathered
as a potential indicator of team performance.
</p>

<p>
The two particular teams below were selected for this contest,
because a significant difference in their structure of contacts
within the team, and with clients and resources, is to be expected.
</p>

<h2>Task</h2>

<p>
You should produce one or more graph drawings
that depict the teams' structures
and thus enable a comparison
of the two teams with respect to their duties.
</p>

<h2>Data</h2>

<p>
To gather the data, each member of a given team
was presented a list with the names of their team members.
Each team member was also asked to list both the clients
and the experts they had contact with.
The team members were asked to indicate the frequency of contact
with each of the other individuals on the following scale:
</p>
<pre>
	0	no contact
	1	weekly
	2	biweekly
	3	monthly
	4	quarterly
</pre>
<p>
Both data sets are thus given as a directed graph with edge weights
ranging from 1 to 4, corresponding to the frequency of contact.
Vertices are colored green (team), blue (resource), or yellow (client).
Note that you are not obliged, e.g.,
to represent clients and resources as vertices,
or to use labels and colors for frequency and status, respectively.
</p>

<p><b>Team A:</b>
adjacency matrix in <a href=A.txt>ASCII</a> format /
graph in <a href=A.gw>LEDA's gw</a> format /
graph in <a href=A.gml>GML</a> format<br>
<img src=A.jpg alt="Team A">
</p>

<p><b>Team B:</b>
adjacency matrix in <a href=B.txt>ASCII</a> format /
graph in <a href=B.gw>LEDA's gw</a> format /
graph in <a href=B.gml>GML</a> format<br>
<img src=B.jpg alt="Team B">
</p>

<hr>

</body>
</html>
