graph [

  description " \
   <!-- ****************** CONTENTS ************************** -->   			\
											\
     This document contains one of two graphs provided for				\
     the 2003 Graph Drawing Contest.							\
											\
     It is a small social network, in which nodes represent organizations		\
     involved in drug policy making, and edges represent (undirected) informal		\
     communication between members of different organizations.  Due to the		\
     nature of the data, there is uncertainty about the existence of a relation.	\
     Confirmed relations, i.e. those that exist for sure, are regarded more		\
     important than others.								\
											\
     The state of an edge is marked by a boolean attribute.				\
											\
     A visualization of this network should clearly depict the structure		\
     of the overall network, of the subnetwork consisting only of confirmed		\
     relations, and the way in which the latter is embedded in the former.		\
											\
     Data courtesy of Patrick Kenis, Tilburg University, The Netherlands.		\
											\
   <!-- *************** ADDITIONAL ATTRIBUTES ********************** -->		\
											\
    node:										\
	none										\
											\
    egde:										\
	name:										\
		important								\
	values: 									\
		0 = false								\
		1 = true								\
  "

  node [ id 1 ]
  node [ id 2 ]
  node [ id 3 ]
  node [ id 4 ]
  node [ id 5 ]
  node [ id 6 ]
  node [ id 7 ]
  node [ id 8 ]
  node [ id 9 ]
  node [ id 10 ]
  node [ id 11 ]
  node [ id 12 ]
  node [ id 13 ]
  node [ id 14 ]
  node [ id 15 ]
  node [ id 16 ]
  node [ id 17 ]
  node [ id 18 ]
  node [ id 19 ]
  node [ id 20 ]
  node [ id 21 ]
  node [ id 22 ]
  node [ id 23 ]
  node [ id 24 ]
  node [ id 25 ]
  node [ id 26 ]
  edge [ source 9 target 24 important 0 ]
  edge [ source 10 target 20 important 1 ]
  edge [ source 11 target 25 important 1 ]
  edge [ source 12 target 21 important 1 ]
  edge [ source 13 target 26 important 0 ]
  edge [ source 13 target 22 important 0 ]
  edge [ source 13 target 18 important 0 ]
  edge [ source 13 target 12 important 0 ]
  edge [ source 13 target 24 important 0 ]
  edge [ source 16 target 21 important 0 ]
  edge [ source 16 target 22 important 1 ]
  edge [ source 17 target 10 important 0 ]
  edge [ source 17 target 4 important 0 ]
  edge [ source 17 target 9 important 0 ]
  edge [ source 17 target 8 important 0 ]
  edge [ source 18 target 12 important 0 ]
  edge [ source 18 target 10 important 0 ]
  edge [ source 18 target 21 important 0 ]
  edge [ source 18 target 5 important 0 ]
  edge [ source 18 target 26 important 1 ]
  edge [ source 19 target 16 important 0 ]
  edge [ source 19 target 15 important 0 ]
  edge [ source 19 target 23 important 1 ]
  edge [ source 20 target 21 important 0 ]
  edge [ source 20 target 18 important 0 ]
  edge [ source 20 target 7 important 0 ]
  edge [ source 20 target 14 important 0 ]
  edge [ source 20 target 15 important 0 ]
  edge [ source 21 target 11 important 0 ]
  edge [ source 21 target 14 important 0 ]
  edge [ source 22 target 21 important 0 ]
  edge [ source 22 target 14 important 0 ]
  edge [ source 22 target 15 important 0 ]
  edge [ source 22 target 19 important 1 ]
  edge [ source 23 target 10 important 0 ]
  edge [ source 23 target 6 important 0 ]
  edge [ source 23 target 3 important 0 ]
  edge [ source 23 target 7 important 0 ]
  edge [ source 23 target 5 important 0 ]
  edge [ source 23 target 14 important 0 ]
  edge [ source 23 target 15 important 0 ]
  edge [ source 24 target 26 important 0 ]
  edge [ source 24 target 23 important 1 ]
  edge [ source 24 target 19 important 1 ]
  edge [ source 24 target 22 important 1 ]
  edge [ source 24 target 16 important 1 ]
  edge [ source 25 target 2 important 0 ]
  edge [ source 25 target 21 important 0 ]
  edge [ source 25 target 20 important 0 ]
  edge [ source 25 target 9 important 0 ]
  edge [ source 25 target 6 important 0 ]
  edge [ source 25 target 8 important 0 ]
  edge [ source 25 target 15 important 0 ]
  edge [ source 25 target 17 important 1 ]
  edge [ source 26 target 12 important 0 ]
  edge [ source 26 target 21 important 0 ]
  edge [ source 26 target 15 important 0 ]
  edge [ source 26 target 14 important 0 ]
  edge [ source 26 target 8 important 0 ]
  edge [ source 26 target 9 important 0 ]
  edge [ source 26 target 17 important 0 ]
  edge [ source 26 target 25 important 0 ]
  edge [ source 26 target 20 important 1 ]
  edge [ source 26 target 11 important 1 ]
]
