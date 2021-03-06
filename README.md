# Nets
Python package for network analysis

See also https://github.com/bavla/Nets/wiki .

The Python library Nets supports basic operations with networks
based on graph representation. Each node/link has its id. If a link id
is not specified by a user it is determined by Nets.
The library Nets is based on an object containing three dictionaries:

  - `_info` - keys are general properties of a network. System
properties: `network`, `title`, `simple`, `directed`, `multirel`,
`mode`, `temporal`, `meta`, `nNodes`, `nArcs`, `nEdges`, `time`, etc.
User properties: `nWeak`, `planar`, etc.

  - `_nodes` - keys are ids of nodes. A value is a list of four
dictionaries:
`[ edgeStar, inArcStar, outArcStar, nodeProperties ]`
Each star is again a dictionary that has for keys ids of
neighboring nodes and for values lists of link ids.

  - `_links` - keys are ids of links. A value is a list
`[ nodeId1, nodeId2, directed, relId, linkProperties ]`
where linkProperties is a dictionary of weights.
## Structure of Network

```
>>> Co._info
{'simple': True, 'mode': 1, 'multirel': False, 'temporal': True, 
 'nNodes': 62106, 'time': (1900, 2016),
 'Network': 'testCOLS', 'title': 'COLS of instant', 
 'meta': [{'date': 'Fri Feb 22 20:33:03 2019', 'title': 'twoMode2netJSON'},
  {'date': 'Fri Feb 22 20:33:03 2019', 'title': 'saved from Graph to netJSON'}],
 'legends': {'Tlabs': {'1900': '1900', '1901': '1901', '1902': '1902', 
  ...
  '2013': '2013', '2014': '2014', '2015': '2015', '2016': '2016'}},
 'required': {'nodes': ['id', 'mode', 'lab', 'act'], 
  'links': ['n1', 'n2', 'type', 'tq']}
}
>>>  
```

```
>>> I = Co.Index()
>>> I['BORNMANN_L']
4654
>>> b = I['BORNMANN_L']
>>> Co._nodes[b]
[{4654: [(4654, 4654)], 7563: [(4654, 7563)], 21863: [(4654, 21863)], 6203: [(4654, 6203)], 
 21864: [(4654, 21864)], 29435: [(4654, 29435)], 16968: [(4654, 16968)], 23661: [(4654, 23661)],
 24416: [(4654, 24416)], 15646: [(4654, 15646)], 17614: [(4654, 17614)], 24896: [(4654, 24896)], 
 32173: [(4654, 32173)], 7495: [(4654, 7495)], 15652: [(4654, 15652)], 35816: [(4654, 35816)], 
 36073: [(4654, 36073)], 16984: [(4654, 16984)], 48315: [(4654, 48315)], 48316: [(4654, 48316)], 
 16966: [(4654, 16966)],  49841: [(4654, 49841)], 7588: [(4654, 7588)], 18205: [(4654, 18205)], 
 15149: [(4654, 15149)], 31092: [(4654, 31092)], 31684: [(4654, 31684)], 44045: [(4654, 44045)], 
 44047: [(4654, 44047)], 13328: [(4654, 13328)], 54082: [(4654, 54082)]}, {}, {},
 {'mode': 1, 'lab': 'BORNMANN_L', 'x': 0.0, 'y': 0.0, 'act': [(1900, 2017, 1)], 'id': 4654}]
>>> Co._links[(4654, 7563)]
[4654, 7563, False, None, {'tq': [(2005, 2006, 4), (2006, 2007, 3), (2007, 2008, 4), (2008, 2009, 7),
 (2009, 2010, 4), (2010, 2011, 11), (2011, 2013, 4), (2015, 2016, 1)],
 'type': 'edge', 'n1': 4654, 'n2': 7563}]
>>> 
```
To do:
  - remove repeated elements from links
  - replace (u,v) IDs with integer IDs
