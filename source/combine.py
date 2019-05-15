# combining two Pajek files first and second into a combined
# multirelational network on the file combined
# by Vladimir Batagelj, Moscow, May 15, 2019
# https://github.com/bavla/Nets/wiki/Combine

import sys, datetime 
gdir = "c:/users/batagelj/work/python/graph/Nets"
sys.path = [gdir]+sys.path
from Nets import Network as N

def combine(ddir,first,second,combined):
    C = N.loadPajek(ddir+'/'+first)
    R = N.loadPajek(ddir+'/'+second)
    nC = len(C._nodes); mC = len(C._links)
    nR = len(R._nodes); mR = len(R._links)
    Rlist = { R._nodes[i][3]['lab'] : ( i, 0) for i in range(1,nR+1) }
    for i in range(1,nC+1):
        name = C._nodes[i][3]['lab']
        if name in Rlist:
            (a,b) = Rlist[name]
            Rlist[name] = (a,i)
        else: Rlist[name] = (len(Rlist)+1,i)   # !!! ??? 
    nL = len(Rlist)
    I = [0]*(nC+1)
    for (a,b) in Rlist.values():
        if b>0: I[b] = a

    net = open(combined,"w",encoding='utf-8')
    s = net.write('\ufeff% Combine: '+first+' + '+second+' / '
        +str(datetime.datetime.now())+'\n*vertices '+str(nL)+'\n')
    for i,v in enumerate(Rlist): s = net.write(str(i+1)+' "'+v+'"\n')
    s = net.write('*arcs :1 "relation 1"\n')
    for e in C._links:
        u = C._links[e][0]; v = C._links[e][1]; w = C._links[e][4]['w']
        s = net.write(str(I[u])+" "+str(I[v])+" "+str(w)+"\n")
    s = net.write('*arcs :2 "relation 2"\n')
    for e in R._links:
        u = R._links[e][0]; v = R._links[e][1]; w = R._links[e][4]['w']
        s = net.write(str(u)+" "+str(v)+" "+str(w)+"\n")
    net.close()
