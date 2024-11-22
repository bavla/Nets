<HTML>
<HEAD>
 <TITLE>SVG</TITLE>
 <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1250">
</HEAD>
<BODY bgcolor=Green>

<center>
<table width="80%" bgcolor=lightyellow cellpadding=10><tr><td>


<h1 align=center><font color=blue>Example: Football (soccer) players</font></h1>

<h2>Data</h2>

Network example describes the 32 soccer teams which participated
in the World Championship in Korea / Japan, 2002.

Players of the national team often have contracts in other countries.
This constitutes a players market where national teams export players
to other countries. Members of the 32 teams had contracts in altogether
44 countries.

Counting which team exports how many players to which country
can be described with a valued, asymmetric graph.
The graph is highly a   symmetric: some countries only export players,
some countries are only importers (data collected by Lothar Krempel).

<hr>
<A HREF="co.htm">SVG layout - export</A>
<hr>

<br>

<h2>Network Analysis</h2>


<h3>Hubs and authorities</h3>

In directed networks we can
usually identify two types of important vertices:
<i>hubs</i> and <i>authorities</i>.  A vertex is a good hub, if it points to
many good authorities, and it is a good authority, if it is pointed to
by many good hubs. Hubs and authorities are related to eigenvector centrality.
<br>
See:<br>
KLEINBERG, Jon M.:<br>
<em>Authoritative Sources in a Hyperlinked Environment.</em>
Proceedings of the 9th ACM-SIAM Symposium on Discrete Algorithms,
edited by Howard Karloff (SIAM/ACM-SIGACT, 1998).

<br>

<pre>
---------------------------------------------------------------
                                             Valued   Valued
         Input       Output                  Input    Output
         Degree      Degree  Hubs     Auth.  Degree   Degree
---------------------------------------------------------------
ARG      1           7       0.177    0.003     3       20
AUT      2           0       0.000    0.006     3        0
BEL      5           3       0.078    0.032    10        7
BGR      1           0       0.000    0.004     1        0
BRA      2           5       0.089    0.007     2       11
CAM      0           8       0.271    0.000     0       23
CHE      2           0       0.000    0.018     4        0
CHI      1           0       0.000    0.001     1        0
CHN      1           2       0.035    0.005     1        2
CRI      0           4       0.040    0.000     0        4
CZE      1           0       0.000    0.002     1        0
DEU     18           2       0.070    0.184    39        3
DNK      2           8       0.230    0.037     5       20
ECU      1           1       0.057    0.001     1        2
ENG     21           1       0.006    0.840    78        1
ESP     13           1       0.009    0.178    35        1
FRA     15           4       0.312    0.355    51       18
GRC      6           0       0.000    0.053     9        0
HRV      0           5       0.177    0.000     0       18
IRL      0           1       0.636    0.000     0       22
ISR      2           0       0.000    0.007     2        0
ITA     20           1       0.006    0.286    55        1
JPN      2           3       0.071    0.004     6        4
KOR      0           3       0.011    0.000     0        7
MAR      1           0       0.000    0.008     1        0
MEX      3           2       0.030    0.011     5        4
NIG      0          12       0.151    0.000     0       21
NLD      9           0       0.000    0.098    17        0
NOR      1           0       0.000    0.007     1        0
POL      0           8       0.110    0.000     0       15
PRT      4           4       0.121    0.012     5        9
PRY      0           9       0.036    0.000     0       13
RUS      2           6       0.050    0.024     5        9
SCO      3           0       0.000    0.038     5        0
SDA      2           0       0.000    0.014     2        0
SEN      0           2       0.257    0.000     0       22
SLO      0          10       0.070    0.000     0       18
SWE      1           8       0.238    0.007     1       20
TUN      0           5       0.066    0.000     0        9
TUR      4           4       0.144    0.033     6       10
URU      0           4       0.142    0.000     0       15
USA      0           4       0.182    0.000     0       11
YUG      1           0       0.000    0.002     1        0
ZAF      0          10       0.122    0.000     0       16
---------------------------------------------------------------
</pre>


<ul>
<li> <i>Degree Centrality</i>
<ul>
<li> There exist countries that are only exporters:
Cameroon, Croatia, Ireland...
<li> There exist countries that are only importers:
Austria, Bolgaria...
<li> England imports players from the highest number of different countries (21);
following by Italy (20) and Germany importing from 18 countries.
<li> Nigeria exports players into the highest number of different countries (12).
<li> Altogether 78 players are imported to England, 55 to Italy, 51 to France...
<li> Cameroon exports altogether 23 players, Ireland and Senegal 22...
</ul>

<li> <i>Hubs and Authorities</i><br>

Authorities are countries having good leagues,
hubs are countries having good players.

<ul>
<li> <i>Hubs:</i> Ireland, France, Cameroon...
<li> <i>Hubs and authorities:</i> France, Denmark...
<li> <i>Authorities:</i> England, France, Italy...

Countries are written in descending order according to hubs/authorities weights.<br>




</ul>

<li>Comparing degree centrality to hubs and authorities the following question arises:<br>

 <i> Why is Ireland among hubs although it does not export to many countries
(it exports to only one country)? </i><br>

Ireland exports all its 22 players to England which is the most important authority.

</ul>
<A HREF="footpart.htm">SVG layout - hubs/authorities</A>
<hr>

<h3>Islands - line weights</h3>

<A HREF="island.htm">Islands - line weights</A>


</td></tr></table>
</center>

</BODY>
</HTML>


