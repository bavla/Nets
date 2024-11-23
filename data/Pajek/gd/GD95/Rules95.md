
GD95 Graph-Drawing Competition
------------------------------

Organized by Peter Eades and Joe Marks


Introduction
------------
As a follow-on to the successful GD94 graph-drawing contest,
another competition will be held in conjunction with the
GD95 Workshop.  This year's contest will focus on three graphs
inspired by drawings that have been used to visualize real-world
data.  The primary judging criterion will be how well the
drawings convey the information in the graphs: node identifiers,
node types, and node interconnectivity.  A secondary criterion will
be the degree to which manual editing was employed to produce the
drawing: the less manual intervention, the better.  A winning entry
for each graph will be chosen by a panel of experts.  All drawings
must be submitted electronically to marks@merl.com as PostScript
files before midnight, September 3, 1995.  Prizes will be awarded
for each winning entry.  A selection of submitted drawings and
hand-drawn counterparts will be published in the workshop
proceedings.

How to Enter the Competition
----------------------------
Files A, B, and C are available by anonymous ftp from
ftp.cs.brown.edu:/pub/gd95/competition.  They contain specifications
of three graphs. In each specification, nodes are represented
by integers.  Each node has a string identifier associated with
it.  Node identifiers are listed first in the file, using the
following format:

	IDENTIFIERS:
	1	Identifier #1
	2	Identifier #2
	3	Identifier #3
	:	    :      :

Node types are listed next, using a similar format:

	TYPES:
	1	Type X
	2	Type Y
	3	Type X
	:	  :

Finally, node interconnectivity is indicated as shown here:

	CONNECTIVITY:
	1	2 3 4
	2	7 8
	4	3
	:	:

Note that graphs A and B are directed, so the first line in the
sample specification above indicates that there are directed edges
from node 1 to nodes 2, 3, and 4, respectively.  However,
graph C is undirected; if node a occurs in the adjacency list
for node b, then node b also occurs in the adjacency list for
node a.

You are free to use any visual or textual mechanism in your
drawing to communicate the information in the specification.
Drawings will be judged primarily on how well they communicate
the specified information.
 
Submit drawings of any or all of these graphs to marks@merl.com
as PostScript files before midnight, September 3.  Your drawings
*must* each include the following information:
  (1) your name and email address, and
  (2) a brief description of how the drawing was generated,
      detailing in particular the respective roles of the
      user and computer (e.g., "manually computed layout
      using MacDraw", or "Sugiyama layout using GraphEd,
      followed by some manual editing to reposition nodes
      and tidy text labels").
This information should be included in the PostScript file.

Questions or comments should be directed to Joe Marks (marks@merl.com).

Sponsors (to be confirmed): AT&T Bell Labs, Mitsubishi Electric
Research Laboratories, and the University of Passau.
