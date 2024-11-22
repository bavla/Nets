<html>
<head>
  <title>Pajek data: The Edinburgh Associative Thesaurus</title>
  <meta HTTP-EQUIV="Content-Type" CONTENT="text/html;charset=UTF-8">
  <link rel=StyleSheet href="../../esna/esna.css" type="text/css" title="ESNA Style" media="screen, print">
</head>
<body bgcolor=darkgreen>
<center>
<table width=650 bgcolor=lightyellow cellpadding=10 border=0 bordercolor=brown><tr><td>
<h1><img src=../../pajek.gif width=100>Pajek datasets</h1>
<hr>
<h2> EAT<br>The Edinburgh Associative Thesaurus</h2>

<p><b>Dataset</b> &nbsp; <code>eat</code>
<p><b>Description</b>
<p>
 <tt>eatRS.net</tt> directed network with 23219 vertices and 325624 arcs (564 loops);
     stimulus X is associated with response Y N times.<br>
 <tt>eatSR.net</tt> directed network with 23219 vertices and 325589 arcs (564 loops);
     response X is associated with stimulus Y N times.<p>
 <b><font color=darkred>
 It seems that the SR network is incomplete and that it should be the inverse
 of RS network.</font></b> <p>
 <tt>EATnew.net</tt> directed network with 23219 vertices and 325593 arcs (564 loops);
     stimulus X is associated with response Y N times. Combined eatRS and eatSR,
     duplicated arcs (32) removed.
 </p>

<p><b>Download</b>
<p><a HREF="./eatRS.zip">EAT response-stimulus</a> (ZIP, 1321K)<br>
<a HREF="./eatSR.zip">EAT stimulus-response</a> (ZIP, 1306K)<br>
<a HREF="./EATnew.zip">EAT stimulus-response NEW</a> (ZIP, 1043K)

<h3>Background</h3>
<p>The Edinburgh Associative Thesaurus (EAT) is a set
of word association norms showing the counts of word
association as collected from subjects. This is not a
developed semantic network such as <b>WordNet</b> (3),
but empirical association data.</p>
<p>The traditional way to collect word association norms
is to show or say a word to several people and ask them
to say the word which first comes to their minds upon
receiving the stimulus. The link established between
the stimulus and the response is not semantically
labelled (e.g. as synonym, antonym or by a case relation)
and can only be regarded as an association.</p>
<p>The Edinburgh association norms were collected by growing
the network from a nucleus set of words. Responses were
collected to words in this nucleus set, then these responses
were used to obtain further responses, and so on. In fact
the cycle was repeated about three times since by then the
number of different responses was so large that they could
not be re-used as stimuli. Data collection stopped when 8400
stimulus words had been used. Each stimulus word was
presented to 100 different subjects, each of whom received
100 words. This gave rise to a total of 55732 nodes in the
Thesaurus network.</p>
<p>The subjects were mostly undergraduates from a wide variety
of British universities. The age range of the subjects was
from 17 to 22 with a mode of 19. The sex distribution was 64
per cent male and 36 per cent female. The data was collected
between June 1968 and May 1971.</p>
<p>The database consists of two files. The SR (stimulus-response)
file, and the RS (response-stimulus) file.
Where words have been truncated to 19 characters to save
space the per cent character (%) has been placed as the 20th.</p>
<p>The EAT here is that included in the
<b>MRC Psycholinguistic Database</b> (4),
for use with the other measures available there.</p>

<h4>EAT Data Collection Procedure (1)</h4>
<h5>Stimulus words</h5>
<p>Since the objective was to obtain a reasonably large
complete mapping of the associative network for a large set
of words, a systematic procedure of 'growing' the network
from a small nucleus was followed. At first responses were
obtained from this nucleus set, then these responses were
used as stimuli to obtain further responses, and so on.
In fact, this cycle was repeated about three times, since
by then the number of different responses was so large that
they could not all be re-used as stimuli.</p>
<p>The nucleus set was derived from (a) the 200 stimuli used
in the Palermo and Jenkins (1964) normq (b) the 1,000 most
frequent words of the Thorndike and Lorge (1944) word
frequency count and (c) the basic English vocabulary of
Ogden (1954).</p>
<p>Data collection was stopped when 8,400 stimulus words had
been used. Only a minimal amount of selection of stimuli was
applied in each cycle of the data collection. Effectively all
responses which were English words or meaningful verbal units
were included, including some phrasal forms and numerals. The
data cover a wide range of grammatical form classes and
inflexional forms.</p>

<h5>Procedure</h5>
<p>Each stimulus word was presented to 100 different subjects.
Each subject recieved a computer-printed sheet with 100
stimuli in randomised arrangement (to minimize priming effects).
The total contribution of each subject was thus 100 responses.
The verbal environment of each word for each subject was
different. The instructions asked the subject to write down
against each stimulus the first word it made him think of,
working as quickly as possible. the total time spent on this
task was measured, and most subjects completed the sheet in
five to ten minutes.</p>
<p>Most of the data was collected in a classroom setting under
supervision. Sheets which had more than 25 percent blank
responses were rejected and fresh data was collected.</p>

<h4>New version</h4> The network SR should be equal to
the transposed (mirror) version t(RS) of RS. This is
not true. There are some differences:
<pre>
   SR - t(RS):
     999.BELLOW       1

   t(RS) - SR:
     30.=*=          17
     ULCER.=*=        1
     THIRTY.=*=       1
     PERIOD.=*=       1
</pre>
There were also 32 multiple lines. Since the weights on the parallel
arcs were the same we treated them as duplicates and preserved only
a single arc. The 'corrected' version is saved in EATnew.net.

<h3>History</h3>
<p>
<ol>
<li> Original EAT: George Kiss, Christine Armstrong,
  Robert Milroy and J.R.I. Piper (collected between
  June 1968 and May 1971).</li>
<li> MRC Psycholinguistic Database Version modified by:
  Max Coltheart, S. James, J. Ramshaw, B.M. Philip,
  B. Reid, J. Benyon-Tinker and E. Doctor;
  made available by: Philip Quinlan.</li>
<li> The present version was re-structured and documented
  by Michael Wilson at the Rutherford Appleton Laboratory
  in 1988 (2).</li>
<li> transformed in Pajek format: V. Batagelj, 31. July 2003.</li>
<li> combined RS and SR versions, removed duplicates: V. Batagelj, 12. August 2013.</li>
</ol>
</p>

<h3>References</h3>
<ol>
<li> Kiss, G.R., Armstrong, C., Milroy, R., and Piper, J. (1973)
An associative thesaurus of English and its computer analysis.
In Aitken, A.J., Bailey, R.W. and Hamilton-Smith, N. (Eds.),
<i>The Computer and Literary Studies</i>. Edinburgh:
University Press.</li>
<li> The present version of
  <a href="http://monkey.cis.rl.ac.uk/Eat/htdocs/eat.zip">
  The Edinburgh Associative Thesaurus</a> (ZIP, 2.7M) </li>
<li> <a href="http://www.cogsci.princeton.edu/%7Ewn/">WordNet</a></li>
<li><a href="http://www.psych.rl.ac.uk/">
  MRC Psycholinguistic Database</a></li>
<li> Coltheart, M. (1981) MRC Psycholinguistic Database.
  Quarterly Journal of Experimental Psychology, 3A, 497-505.</li>
<li>Download <a href="http://ota.ahds.ac.uk/texts/1054.html">
  MRC Psycholinguistic Database 2</a></li>
</ol>
<hr><a href="../../default.htm">Pajek Data</a>;<a href="http://vlado.fmf.uni-lj.si/pub/networks/pajek/default.htm">Pajek Home</a><hr>31. July 2003
</td></tr></table></center></body></html>
