# -*- coding: UTF-8 -*-

# Nets
# renamed version of Graph
# Network analysis package
# by Batagelj, V.: 12. September 2010
# change: 12. January 2014
# change: 29. August 2016
# change: 12. August 2017 - Graph renamed to Nets
# change: 9. November 2018 - delLoops, TQtwo2oneNorm
# change: 14. April 2019 - some problems in loadPajek - see code
# change: 2. June 2020 - "standardization" in _info 'network' and 'title'
# change: 12. June 2020 - delLink, BFSpair, biBFSpair
# last change: 21. June 2020 - biconnected components BCC, shortCyWeight
# === To do =============================================================
# Check loops in stars - apply set to union  !?
# Remove intervals with value 0
# Replace (u,v) in products with index
# Remove n1 and n2 from link values
# =======================================================================
import re, sys, os, json, TQ, datetime, platform
import turtle as t
import webbrowser
from math import *
from random import random, randint, shuffle
from itertools import chain
from warnings import warn
from search import Search
from coloring import Coloring
from copy import copy, deepcopy
from collections import deque
from collections import defaultdict  

# http://www.w3schools.com/html/html_colornames.asp

class Network(Search,Coloring):
    class NetworkError(RuntimeError): pass

    Colors = ['White','Black','Red','Blue','Green','Magenta','Cyan',
        'Yellow', 'Brown', 'Orange', 'Lime', 'Pink', 'Purple', 'Orchid',
        'Salmon', 'SeaGreen']
    INFTY = float('inf')
    
    @staticmethod
    def location():
        return [platform.uname()[1], os.getcwd()]
    @staticmethod
    def turtleXY(T):
        return ((T[0]-0.5)*t.window_width(),(T[1]-0.5)*t.window_height())
    @staticmethod
    def extractTQ(s):
        l = s.find('['); r = s.rfind(']')
        S = s[l+1:r].split(','); tq = []
        for e in S:
            L = e.split('-'); t1 = eval(L[0])
            if len(L)>1: t2 = 999999999 if '*' in L[1] else eval(L[1])+1
            else: t2 = t1+1
            tq.append([t1,t2,1])
        return tq
    def initNode(self,e): return self._links[e][0]
    def termNode(self,e): return self._links[e][1]
    def twin(self,u,e):
        S={self.initNode(e),self.termNode(e)}
        if not (u in S):
            warn("Node {0} not on link {1}".format(u,e))
            return None
        elif len(S)==1: return u
        else: return (S-{u}).pop()
    def __init__(self,simple=False,mode=1,multirel=False,temporal=False,
        network="test",title="Test",):
        self._linkId = 0
        self._info = {'simple': simple,'mode': mode,'multirel':multirel,
            'temporal':temporal,'network':Network,'title':title,'meta':[],
            'legends':{}}
        self._info['required'] = {"nodes":['id','mode','lab'],
            'links':['n1', 'n2', 'type']}
        self._nodes = {}
        self._links = {}
    def __str__(self): return "Nets:\nNodes: "+ \
        str(list(self.nodes()))+"\nLinks: "+ \
        str([("A" if self._links[e][2] else "E")+str(e)+ \
        str((self.initNode(e),self.termNode(e))) for e in self.links()])
    __repr__ = __str__
    def __len__(self): return len(self._nodes)
    def nodes(self):
        for u in self._nodes.keys(): yield u
    def nodesMode(self,mode):
        for u in self._nodes.keys():
            if 'mode' in self._nodes[u][3].keys():
                if self._nodes[u][3]['mode'] == mode: yield u
            elif mode == 1: yield u
    def links(self):
        for e in self._links.keys(): yield e
    def edges(self):
        for e in self._links.keys():
            if not self._links[e][2]: yield e
    def arcs(self):
        for a in self._links.keys():
            if self._links[a][2]: yield a
    def link(self,e): return self._links[e]
    def Info(self):
        simple = self._info.get('simple',False)
        temporal = self._info.get('temporal',False)
        org = self._info.get('org',1)
        mode = self._info.get('mode',1)
        network = self._info.get('network',"test")
        title = self._info.get('title',"testSAVE")
        multirel = self._info.get('multirel',False)
        # meta =  self._info.get('meta',[])
        # trace = self._info.get('trace',[])
        # required = self._info.get('required',{})
        nNodes = len(self._nodes)
        nEdges = len(list(self.edges()))
        nArcs = len(list(self.arcs()))
        directed = nEdges==0
        print("\nnetwork: ",network,"\n",title,"\nsimple=",simple,
            " directed=",directed," org=",org," mode=",mode,
            " multirel=",multirel," temporal=",temporal,"\nnodes=",nNodes,
            " links=",nArcs+nEdges," arcs=",nArcs," edges=",nEdges)
        if mode==2:
            n1 = len(list(self.nodesMode(1)))
            n2 = nNodes - n1
            print("nodes1=",n1," nodes2=",n2)
        if temporal:
            minT = self._info['time'][0]
            maxT = self._info['time'][1]
            print("Tmin=",minT," Tmax=",maxT)

    def addNode(self,u,mode=1):
        if (not u in self._nodes):
            self._nodes[u] = [{},{},{},{}]
            if self._info['mode'] > 1:
                self._nodes[u][3]['mode'] = mode
        else: raise self.NetworkError(
            "Node {0} already defined".format(u))
    def addEdge(self,u,v,w={},rel=None,lid=None):
        p,q = (u,v) if u < v else (v,u)
        linked = q in self._nodes[p][0]
        if not linked:
            if lid == None:
                self._linkId += 1; lid = self._linkId
            self._nodes[p][0][q] = [lid]
            self._nodes[q][0][p] = [lid]
            self._links[lid] = [p,q,False,rel,w]
        elif not self._info['simple']:
            if lid == None:
                self._linkId += 1; lid = self._linkId
            self._nodes[p][0][q].append(lid)
            self._nodes[q][0][p].append(lid)
            self._links[lid] = [p,q,False,rel,w]
        else: raise self.NetworkError(
            "Link {0} already defined".format((u,v)))
        return lid
    def addArc(self,u,v,w={},rel=None,lid=None):
        try: linked = v in self._nodes[u][2]
        except: raise Network.NetworkError(    # *****
            "Problems in arc {} {} {}".format(u,v,w))
        # linked = v in self._nodes[u][2]
        if not linked:
            if lid == None:
                self._linkId += 1; lid = self._linkId
            self._nodes[u][2][v] = [lid]
            self._nodes[v][1][u] = [lid]
            self._links[lid] = [u,v,True,rel,w]
        elif not self._info['simple']:
            if lid == None:
                self._linkId += 1; lid = self._linkId
            self._nodes[u][2][v].append(lid)
            self._nodes[v][1][u].append(lid)
            self._links[lid] = [u,v,True,rel,w]
        else: raise self.NetworkError(
            "Link {0} already defined".format((u,v)))
        return lid
    def neighbors(self,u):
        return (set(self._nodes[u][0].keys()) |
                set(self._nodes[u][1].keys()) |
                set(self._nodes[u][2].keys()))
    def edgeNeighbors(self,u):
        return set(self._nodes[u][0].keys())
    def inArcNeighbors(self,u):
        return set(self._nodes[u][1].keys())
    def outArcNeighbors(self,u):
        return set(self._nodes[u][2].keys())
    def inNeighbors(self,u):
        return (set(self._nodes[u][0].keys()) |
                set(self._nodes[u][1].keys()))
    def outNeighbors(self,u):
        return (set(self._nodes[u][0].keys()) |
                set(self._nodes[u][2].keys()))
    def edgeStar(self,u):
        for L in self._nodes[u][0].values():
            for edge in L: yield edge
    def inArcStar(self,u):
        for L in self._nodes[u][1].values():
            for arc in L: yield arc
    def outArcStar(self,u):
        for L in self._nodes[u][2].values():
            for arc in L: yield arc
    def star(self,u):
        return chain(self.edgeStar(u),self.inArcStar(u),self.outArcStar(u))
    def inStar(self,u):
        return chain(self.edgeStar(u),self.inArcStar(u))
    def outStar(self,u):
        return chain(self.edgeStar(u),self.outArcStar(u))
    def __iter__(self):
        for v in self._nodes.keys(): yield v
    def delLink(self,e):	
        u,v,directed,*r = self._links[e]
        if directed:
            self._nodes[u][2][v].remove(e)
            if self._nodes[u][2][v]==[]: self._nodes[u][2].pop(v)
            self._nodes[v][1][u].remove(e)
            if self._nodes[v][1][u]==[]: self._nodes[v][1].pop(u)
        else:
            self._nodes[u][0][v].remove(e);
            if self._nodes[u][0][v]==[]: self._nodes[u][0].pop(v)
            self._nodes[v][0][u].remove(e)
            if self._nodes[v][0][u]==[]: self._nodes[v][0].pop(u)
        del(self._links[e])
    def delNode(self,u):
        for e in self.star(u): self.delLink(e)
        del(self._nodes[u])
    def setLoops(self,key='tq',val=TQ.TQ.sN):
        for e in self._links:
            if self._links[e][0]==self._links[e][1]:
                self._links[e][4][key] = val
    def delLoops(self):
        L = set([ e for e in self._links if self._links[e][0]==self._links[e][1] ])
        for e in L:
            u = self._links[e][0]
            ed, ia, oa, np = self._nodes[u]
            try: del ed[u]
            except KeyError: pass
            try: del ia[u]
            except KeyError: pass
            try: del oa[u]
            except KeyError: pass
            self._nodes[u] = [ed, ia, oa, np]
        for e in L: del self._links[e]
    def setInfo(self,key,val): self._info[key] = val
    def getInfo(self,key): return self._info[key]
    def setNode(self,u,key,val): self._nodes[u][3][key] = val
    def setNodes(self,key,val):
        for u in self._nodes: self._nodes[u][3][key] = val
    def getNode(self,u,key,null=None):
        return self._nodes[u][3].get(key,null)
    def delProp(self,key):
    	for u in self._nodes:
    	    if key in self._nodes[u][3]: del self._nodes[u][3][key]
    def indEdge(self,uv):
    	u, v = uv; return self._nodes[u][0][v][0]
    def indArc(self,uv):
    	u, v = uv; return self._nodes[u][1][v][0]
    def setLink(self,e,key,val): self._links[e][4][key] = val
    def getLink(self,e,key,null=None):
        return self._links[e][4].get(key,null)
    def delWeight(self,key):
    	for u in self._links:
    	    if key in self._links[u][4]: del self._links[u][4][key]
    def degree(self,u): return len(list(self.star(u)))
    def inDegree(self,u): return len(list(self.inStar(u)))
    def outDegree(self,u): return len(list(self.outNeighbors(u)))
    def pairs2edges(self):
        S = Network()
        S._info = deepcopy(self._info)
        for u in self._nodes:
            ed,ia,oa,pr = self._nodes[u]
            S._nodes[u] = [{},{},{},pr]
        for p in self._links:
            u,v,d,r,w = self._links[p]
            if u<=v: lid=S.addEdge(u,v,w=w)
        return S
    def topLinks(self,key='w',thresh=0,NA=0):
        def takeFifth(elem): return elem[4]
        JJ = list(self.links())
        JJE = [[u,v,self._nodes[u][3]['lab'],self._nodes[v][3]['lab'],
                self._links[(u,v)][4].get(key,NA)] for u,v in JJ]
        T = [ c for c in JJE if c[4] >= thresh]
        T.sort(key=takeFifth,reverse=True)
        return(T)
    def reverse(self):
        R = Network()
        R._info = copy(self._info)
        R._info['network'] = 'Tran('+self._info['network']+')'
        R._info['title'] = 'TRAN('+self._info['title']+')'
        for v in self._nodes.keys():
            R._nodes[v] = [ dict(self._nodes[v][0]),
                dict(self._nodes[v][2]),dict(self._nodes[v][1]),
                dict(self._nodes[v][3]) ]
        for e in self._links.keys(): R._links[e] = dict(self._links[e])
        return R
    def transpose(self):
        if self._info['mode'] == 1: return self.reverse()
        T = Network()
        nr, nc = self._info['dim']
        T._info = deepcopy(self._info)
        T._info['network'] = 'Tran('+self._info['network']+')'
        T._info['title'] = 'TRAN('+self._info['title']+')'
        for v in self._nodes.keys():
            if self._nodes[v][3]['mode']==1:
                t = v+nc; mode = 2
            else: t = v-nr; mode = 1
            T.addNode(t)
            T._nodes[t][3] = dict(self._nodes[v][3])
            T._nodes[t][3]['mode'] = mode
        for p in self._links.keys():
            u,v,directed,r,w = self._links[p]
            if directed: T.addArc(v-nr,u+nc,w,r,lid=p)
            else: T.addEdge(v-nr,u+nc,w,r,lid=p)
        T._info['dim'] = [nc,nr]
        return T
    def one2twoMode(self):
        T = Network(); n = len(self._nodes)
        T._info = copy(self._info); T._info['mode'] = 2
        T._info['dim'] = (n,n)
        T._info['network'] = '1to2('+self._info['network']+')'
        T._info['title'] = '1TO2('+self._info['title']+')'
        for v in self._nodes.keys():
            T.addNode(v,1); T.addNode(v+n,2)
            T._nodes[v][3] = copy(self._nodes[v][3])
            T._nodes[v+n][3] = copy(self._nodes[v][3])
            T._nodes[v][3]['mode'] = 1; T._nodes[v+n][3]['mode'] = 2
        for p in self._links.keys():
        	u,v,directed,r,w = self._links[p]
        	if directed: T.addArc(u,v+n,w,r)
        	else: T.addArc(u,v+n,w,r); T.addArc(v,u+n,w,r)
        return T
    def two2oneEq(self,noDup=True):
# check - probably needs rewriting
        n1 = len(list(self.nodesMode(1)))
        n2 = len(list(self.nodesMode(2)))
        if n1 != n2: raise Network.NetworkError(
            "Nonsquare two-mode Network {0} != {1}".format(n1,n2))
        G = Network()
        G._info = copy(self._info); G._info['mode'] = 1
        for v in self.nodesMode(1):
            G.addNode(v); G._nodes[v][3] = dict(self._nodes[v][3])
            del(G._nodes[v][3]['mode'])
        for p in self._links.keys():
            u,v,k = p
            q = (u,v-n1,k) if (k < 0) or (u < v-n1) else (v-n1,u,k)
            u,v,k = q; add = True
#            print('p =',p,' q =',q)
            if k < 0: G.addArc(u,v,-k)
            elif not((q in G._links) and noDup): G.addEdge(u,v,k)
            else: add = False
            if add:
                G._links[q] = dict(self._links[p])
#                print('p =',p,' q =',q,self._links[p])
        return G
    def two2oneRows(self,key='w'):
        nr,nc = self._info['dim']
        G = Network(); G._info['mode'] = 1; G._info['nNodes'] = nr
        G._info['simple'] = True
        G._info['network'] = 'ProR('+self._info['network']+')'
        G._info['title'] = 'PROR('+self._info['title']+')'
        for v in self.nodesMode(1):
            G.addNode(v,1); G._nodes[v][3] = dict(self._nodes[v][3])
#            del(G._nodes[v][3]['mode'])
        for t in self.nodesMode(2):
            for p in self.inStar(t):
                u = self.twin(t,p); pw = self._links[p][4][key]
                for q in self.inStar(t):
                    v = self.twin(t,q); r = (u,v)
                    if not r in G._links: G._links[r] = [ u,v,True,None,{key:0} ]
                    G._links[r][4][key] += pw*self._links[q][4][key]
        return G
    def two2oneCols(self, key='w'):
        nr,nc = self._info['dim']
        G = Network(); G._info['mode'] = 1; G._info['nNodes'] = nc
        G._info['simple'] = True
        G._info['network'] = 'ProC('+self._info['network']+')'
        G._info['title'] = 'PROC('+self._info['title']+')'
        for v in range(nc):
            C.addNode(v+1,1); C._nodes[v+1][3] = dict(self._nodes[nr+v+1][3])
#            del(G._nodes[v-nr][3]['mode'])
        for t in self.nodesMode(1):
            for p in self.outStar(t):
                u = self.twin(t,p)-nr; pw = self._links[p][4][key]
                for q in self.outStar(t):
                    v = self.twin(t,q)-nr; r = (u,v)
                    if not r in G._links: G._links[r] = [ u,v,True,None,{key:0} ]
                    G._links[r][4][key] += pw*self._links[q][4][key]
        return G
    def multiply(A,B,key='w',oneMode=False):
        nar,nac = A._info['dim']; nbr,nbc = B._info['dim']
        if nac != nbr: raise Network.NetworkError(
            "Noncompatible Networks {0} != {1}".format(nac,nbr))
        if oneMode and (nar != nbc): raise Network.NetworkError(
            "Product is not a one-mode Network {0} != {1}".format(nar,nbc))
        C = Network(); C._info['simple'] = True
        C._info['network'] = '('+A._info['network']+') X ('+B._info['network']+')'
        C._info['title'] = 'PROD('+A._info['title']+', '+B._info['title']+')'
        C._info['mode'] = 1 if oneMode else 2; C._info['dim'] = [nar,nbc]
        C._info['nNodes'] = nar if oneMode else nar+nbc
        for v in range(nar):
            C.addNode(v+1,1); C._nodes[v+1][3] = dict(A._nodes[v+1][3])
        if not oneMode:
            for v in range(nar,nar+nbc):
                C.addNode(v+1,2)
                C._nodes[v+1][3] = dict(B._nodes[v+1+nbr-nar][3])
        for t in A.nodesMode(2):
            for p in A.inStar(t):
                u = A.twin(t,p); Apw = A._links[p][4][key]
                for q in B.outStar(t-nar):
                    v = B.twin(t-nar,q)-nbr
                    if not oneMode: v = v+nar
                    r = (u,v)
                    if not r in C._links: C._links[r] = \
                       [ u, v, True, None, {key: 0} ]
                    C._links[r][4][key] += Apw*B._links[q][4][key]
        return C
    def TQnormal(self,key='tq',act='act'):
        N = deepcopy(self)
        N._info['network'] = 'Norm('+self._info['network']+')'
        N._info['title'] = 'NORM('+self._info['title']+')'
        for u in N.nodesMode(1):
            qu = TQ.TQ.invert(N.TQnetOutDeg(u,act=act),vZero=1)
            for p in N.outStar(u):
                N._links[p][4][key] = TQ.TQ.prod(qu,N._links[p][4][key])
        return N
    def TQnodeCut(self,cut,key='act'):
        T = Network(); T._info = copy(self._info)
        for v in self._nodes.keys():
            tq = self._nodes[v][3][key]; tex = TQ.TQ.extract(cut,tq)
            vt = TQ.TQ.prod(tex,TQ.TQ.setConst(TQ.TQ.cutGE(TQ.TQ.sum(tex,TQ.TQ.prodConst(cut,-1)),0),1))
            if vt != []:
                T.addNode(v); T._nodes[v][3] = self._nodes[v][3]
                self._nodes[v][3][key] = vt
        for p in self._links.keys():
            u,v,directed,r,w = self._links[p]
            if (u in T._nodes) and (v in T._nodes):
                if directed: T.addArc(u,v,w,r)
                else: T.addEdge(u,v,w,r)
        return T
    def TQlinkCut(self,cut,key='tq'):
        T = Network(); T._info = copy(self._info)
        for p in self._links.keys():
            u,v,directed,r,w = self._links[p]
            tq = w[key]; tex = TQ.TQ.extract(cut,tq)
            vt = TQ.TQ.prod(tex,TQ.TQ.setConst(TQ.TQ.cutGE(TQ.TQ.sum(tex,TQ.TQ.prodConst(cut,-1)),0),1))
            if vt != []:
                if not(u in T._nodes): T.addNode(u)
                if not(v in T._nodes): T.addNode(v)
                w[key] = vt
                if directed: T.addArc(u,v,w,r)
                else: T.addEdge(u,v,w,r)
        return T
    def TQtopLoops(self,key='tq',thresh=0):
        def takeThird(elem): return elem[2]
        JJ = list(self.nodes())
        JJL = [[j,self._nodes[j][3]['lab'],self._links[(j,j)][4].get(key,[])
                if (j,j) in self._links.keys() else [] ] for j in JJ]
        L = [[a,b,TQ.TQ.total(c),c] for a,b,c in JJL if TQ.TQ.total(c) >= thresh]
        L.sort(key=takeThird,reverse=True)
        return(L)
    def TQtopLinks(self,key='tq',thresh=0):
        def takeFifth(elem): return elem[4]
        JJ = list(self.links())
        JJE = [[u,v,self._nodes[u][3]['lab'],self._nodes[v][3]['lab'],
                self._links[(u,v)][4].get(key,[])] for u,v in JJ]
        T = [[u,v,ul,vl,TQ.TQ.total(c),c] for u,v,ul,vl,c in JJE
              if TQ.TQ.total(c) >= thresh]
        T.sort(key=takeFifth,reverse=True)
        return(T)
    def TQtwo2oneRows(self,lType='edge',key='tq'):
        nr,nc = self._info['dim']
        C = Network(); C._info['mode'] = 1; C._info['nNodes'] = nr
        C._info['temporal'] = True; C._info['simple'] = True
        C._info['network'] = 'ProR('+self._info['network']+')'
        C._info['title'] = 'PROR('+self._info['title']+')'
        C._info['time'] = self._info['time']
        if 'legends' in self._info: C._info['legends']['Tlabs'] = \
            self._info['legends']['Tlabs']
        C._info['meta'] = self._info['meta']
        C._info['required'] = self._info['required']
        C._info['multirel'] = self._info['multirel']
        for v in range(nr):
            C.addNode(v+1,1); C._nodes[v+1][3] = dict(self._nodes[v+1][3])
            C._nodes[v+1][3]['mode'] = 1
        for t in self.nodesMode(2):
            for p in self.inStar(t):
                u = self.twin(t,p); Apw = self._links[p][4][key]
                for q in self.inStar(t):
                    v = self.twin(t,q)
                    if u<=v:
                        s = TQ.TQ.prod(Apw,self._links[q][4][key])
                        if s==[]: continue
                        r = (u,v)
                        if (lType=='edge') or (lType=='double'):
                            if not r in C._links:
                                C.addEdge(u,v,lid=r,w={key: []})
                            if (u!=v) and (lType=='double'): s = TQ.TQ.sum(s,s)
                            C._links[r][4][key] = TQ.TQ.sum(C._links[r][4][key],s)
                        else:
                            if not r in C._links:
                                C.addArc(u,v,lid=r,w={key: []})
                            C._links[r][4][key] = TQ.TQ.sum(C._links[r][4][key],s)
                            if u!=v:
                                rr = (v,u)
                                if not rr in C._links:
                                    C.addArc(v,u,lid=rr,w={key: []})
                                C._links[rr][4][key] = C._links[r][4][key]
        return C
    def TQtwo2oneCols(self,lType='edge',key='tq'):
        nr,nc = self._info['dim']
        C = Network(); C._info['mode'] = 1; C._info['nNodes'] = nc
        C._info['temporal'] = True; C._info['simple'] = True
        C._info['network'] = 'ProC('+self._info['network']+')'
        C._info['title'] = 'PROC('+self._info['title']+')'
        C._info['time'] = self._info['time']
        if 'legends' in self._info: C._info['legends']['Tlabs'] = \
            self._info['legends']['Tlabs']
        C._info['meta'] = self._info['meta']
        C._info['required'] = self._info['required']
        C._info['multirel'] = self._info['multirel']
        for v in range(nc):
            C.addNode(v+1,1); C._nodes[v+1][3] = dict(self._nodes[nr+v+1][3])
            C._nodes[v+1][3]['mode'] = 1
        for t in self.nodesMode(1):
            for p in self.outStar(t):
                u = self.twin(t,p)-nr; Apw = self._links[p][4][key]
                for q in self.outStar(t):
                    v = self.twin(t,q)-nr
                    if u<=v:
                        s = TQ.TQ.prod(Apw,self._links[q][4][key])
                        if s==[]: continue
                        r = (u,v)
                        if (lType=='edge') or (lType=='double'):
                            if not r in C._links:
                                C.addEdge(u,v,lid=r,w={key: []})
                            if (u!=v) and (lType=='double'): s = TQ.TQ.sum(s,s)
                            C._links[r][4][key] = TQ.TQ.sum(C._links[r][4][key],s)
                        else:
                            if not r in C._links:
                                C.addArc(u,v,lid=r,w={key: []})
                            C._links[r][4][key] = TQ.TQ.sum(C._links[r][4][key],s)
                            if u!=v:
                                rr = (v,u)
                                if not rr in C._links:
                                    C.addArc(v,u,lid=rr,w={key: []})
                                C._links[rr][4][key] = C._links[r][4][key]
        return C
    def TQtwo2oneNorm(self,nType='normal',key='tq'):
    # nType in { 'normal', 'Newman' }
        nr,nc = self._info['dim']
        C = Network(); C._info['mode'] = 1; C._info['nNodes'] = nc
        C._info['temporal'] = True; C._info['simple'] = True
        C._info['network'] = nType+'('+self._info['network']+')'
        C._info['title'] = nType+'('+self._info['title']+')'
        C._info['time'] = self._info['time']
        if 'legends' in self._info: C._info['legends']['Tlabs'] = \
            self._info['legends']['Tlabs']
        C._info['meta'] = self._info['meta']
        C._info['required'] = self._info['required']
        C._info['multirel'] = self._info['multirel']
        for v in range(nc):
            C.addNode(v+1,1); C._nodes[v+1][3] = dict(self._nodes[nr+v+1][3])
            C._nodes[v+1][3]['mode'] = 1
        d = [ self.outDegree(v) for v in self.nodesMode(1) ]
        for t in self.nodesMode(1):
            d1 = max(1,d[t-1])
            d2 = d1 if nType=='normal' else max(1,d[t-1]-1)
            for p in self.outStar(t):
                u = self.twin(t,p)-nr; Apw = self._links[p][4][key]
                for q in self.outStar(t):
                    v = self.twin(t,q)-nr
                    if u<=v:
                        s = TQ.TQ.prod(Apw,self._links[q][4][key])
                        if s==[]: continue
                        s = TQ.TQ.prodConst(s,1/d1/d2)
                        r = (u,v)
                        if (u!=v): s = TQ.TQ.sum(s,s)
                        if (u<v) or (nType=='normal'):
                            if not r in C._links: C.addEdge(u,v,lid=r,w={key: []})
                            C._links[r][4][key] = TQ.TQ.sum(C._links[r][4][key],s)
        return C
    def TQmultiply(A,B,oneMode=False,keyA='tq',keyB='tq'):
        nar,nac = A._info['dim']; nbr,nbc = B._info['dim']
        if nac != nbr: raise Network.NetworkError(
            "Noncompatible Networks {0} != {1}".format(nac,nbr))
        if oneMode and (nar != nbc): raise Network.NetworkError(
            "Product is not a one-mode Network {0} != {1}".format(nar,nbc))
        C = Network(); C._info['mode'] = 2; C._info['dim'] = [nar,nbc]
        C._info['temporal'] = True; C._info['simple'] = True
        C._info['network'] = '('+A._info['network']+') X ('+B._info['network']+')'
        C._info['title'] = 'PROD('+A._info['title']+', '+B._info['title']+')'
        C._info['time'] = A._info['time']
        if 'legends' in A._info: C._info['legends']['Tlabs'] = \
            A._info['legends']['Tlabs']
        C._info['meta'] = A._info['meta']
        C._info['required'] = A._info['required']
        C._info['multirel'] = A._info['multirel']
        C._info['mode'] = 1 if oneMode else 2
        C._info['nNodes'] = nar if oneMode else nar+nbc
        for v in range(nar):
            C.addNode(v+1,1); C._nodes[v+1][3] = dict(A._nodes[v+1][3])
        if not oneMode:
            for v in range(nar,nar+nbc):
                C.addNode(v+1,2)
                C._nodes[v+1][3] = dict(B._nodes[v+1+nbr-nar][3])
        for t in A.nodesMode(2):
            for p in A.inStar(t):
                u = A.twin(t,p); Apw = A._links[p][4][keyA]
                for q in B.outStar(t-nar):
                    s = TQ.TQ.prod(Apw,B._links[q][4][keyB])
                    if s==[]: continue
                    v = B.twin(t-nar,q)-nbr
                    if not oneMode: v = v+nar
                    r = (u,v)
                    if not r in C._links: C.addArc(u,v,lid=r,w={'tq':[]})
                    C._links[r][4]['tq'] = TQ.TQ.sum(C._links[r][4]['tq'],s)
        return C
    def TQactivity(self,Rows,Cols):
        s = []
        for u in Rows:
            for p in self.outStar(u):
                v = self.twin(u,p)
                if v in Cols: s = TQ.TQ.sum(s,self.getLink(p,'tq'))
        return(s)
    def TQnetDeg(self,u,key='tq',act='act'):
        deg = TQ.TQ.setConst(self._nodes[u][3][act],0)
        for p in self.star(u):
            deg = TQ.TQ.sum(deg,TQ.TQ.binary(self._links[p][4][key]))
        return deg
    def TQnetInDeg(self,u,key='tq',act='act'):
        deg = TQ.TQ.setConst(self._nodes[u][3][act],0)
        for p in self.inStar(u):
            deg = TQ.TQ.sum(deg,TQ.TQ.binary(self._links[p][4][key]))
        return deg
    def TQnetOutDeg(self,u,key='tq',act='act'):
        deg = TQ.TQ.setConst(self._nodes[u][3][act],0)
        for p in self.outStar(u):
            deg = TQ.TQ.sum(deg,TQ.TQ.binary(self._links[p][4][key]))
        return deg
    def TQnetSum(self,u,key='tq',act='act'):
        s = TQ.TQ.setConst(self._nodes[u][3][act],0)
        for p in self.star(u):
            s = TQ.TQ.sum(s,self._links[p][4][key])
        return s
    def TQnetInSum(self,u,key='tq',act='act'):
        s = TQ.TQ.setConst(self._nodes[u][3][act],0)
        for p in self.inStar(u):
            s = TQ.TQ.sum(s,self._links[p][4][key])
        return s
    def TQnetOutSum(self,u,key='tq',act='act'):
        s = TQ.TQ.setConst(self._nodes[u][3][act],0)
        for p in self.outStar(u):
            s = TQ.TQ.sum(s,self._links[p][4][key])
        return s
    def TQnetBin(self,key='tq'):
        B = deepcopy(self)
        for p in B._links:
            B._links[p][4][key] = TQ.TQ.binary(B._links[p][4][key])
        return B
    def TQgraph2mat(self):
        onemode = self._info['mode'] == 1
        if onemode:
            rows = self._nodes.keys(); cols = self._nodes.keys()
        else:
            rows = self.nodesMode(1); cols = self.nodesMode(2)
        nr = len(list(rows)); nc = len(list(cols))
        B = [[[] for v in range(nr)] for u in range(nc)]
        for p in self._links.keys():
            u = self._links[p][0]-1; v = self._links[p][1]-1
            if not onemode: v = v - nr
            B[u][v] = TQ.TQ.sum(B[u][v],self._links[p][4]['tq'])
            if onemode and not self._links[p][2]: B[v][u] = B[u][v]
        return B
    def Index(self): return { v[3]['lab']: k for k,v in self._nodes.items() }
    def TQgetLinkValue(self,i,lu,lv): return self._links[(i[lu],i[lv])][4]['tq']
    def loadPajek(file):
# problems with names containing [ or ]
# in case of problem with an UTF-8 file add a comment as the first line
# see: https://github.com/bavla/SocNet/wiki/NumAuthors
        try: net = open(file,'r',encoding="utf-8")
        except: raise Network.NetworkError(
            "Problems with Pajek file {0}".format(file))
        G = Network(); mode = 1; status = 0; meta = ''; rels = {}
        simple = False; temporal = False; multirel = False
        org = 1; directed = True
        Tmax = 0; Tmin = 999999999; rn = -1
        while True:
            line = net.readline()
            if not line: break
            if line[0] == '%':
                meta += line[1:]; continue
            if line[0] == '*':
                L = re.split('\s+',line.strip())
                control = L[0].lower()
                if control=='*vertices':
                    num = eval(L[1])
                    twoMode = len(L)>2
                    if twoMode:
                       G._info['mode'] = 2
                       num1 = eval(L[2]); mode = 1
                       for v in range(num):
                           if v==num1: mode = 2
                           G.addNode(v+1,mode)
                       nr = num1; nc = num - num1
                    else:
                       for v in range(num): G.addNode(v+1)
                    status = 1;
                    print("NODES:  n =",num," mode =",mode)
                    if twoMode: print(nr,'+',nc)
                    continue
                elif control=='*arcs':
                    status = 2
                    i = line.find(':')
                    if i>0:
                        S = line[i+1:].split(' ',1)
                        rel = eval(S[0]); rlab = eval(S[1])
                        rels[rel] = rlab; multirel = True
                    print('ARCS:  multirel =',multirel)
                    continue
                elif control=='*edges':
                    status = 3
                    i = line.find(':')
                    if i>0:
                        S = line[i+1:].split(' ',1)
                        rel = eval(S[0]); rlab = eval(S[1])
                        rels[rel] = rlab; multirel = True
                    print('EDGES:  multirel =',multirel)
                    continue
                else: continue
            elif status == 1:
                L = re.split('\"',line.strip())
                if len(L) > 1:
                    K = re.split('\s+',L[2].strip())
                    L = L[:2]; L.extend(K)
                else:
                    L = re.split('\s+',line.strip())
                node = eval(L[0]); name = L[1]
                G.setNode(node,'lab',name)
                if len(L) > 3:
                    G.setNode(node,'x',eval(L[2]))
                    G.setNode(node,'y',eval(L[3]))
                if '[' in line:
                    temporal = True; tq = Network.extractTQ(line)
                    G.setNode(node,'act',tq); tu = tq[-1][1]
                    Tmin = min(Tmin,tq[0][0])
                    Tmax = tq[-1][0] if tu >= 999999999 else max(Tmax,tu)
            elif status == 2:
                i = line.find(':')
                if i > 0:
                    multirel = True; rn = rel if i < 0 else eval(line[:i])
                    print(i, rn, line)
                L = re.split('\s+',line[i+1:].strip())
                u = eval(L[0]); v = eval(L[1])
                if len(L)>2:
                    w = {'w': eval(L[2])}
                    if '[' in line:
                        temporal = True; w = {'tq': Network.extractTQ(line)}
                else: w = {'w': 1}
                if multirel: G.addArc(u,v,w=w,rel=rn)  # *****
                else: G.addArc(u,v,w=w)
            elif status == 3:
                i = line.find(':')
                if i > 0:
                    multirel = True; rn = rel if i < 0 else eval(line[:i])
                    print(i, rn, line)
                L = re.split('\s+',line[i+1:].strip())
                u = eval(L[0]); v = eval(L[1])
                if len(L)>2:
                    w = {'w': eval(L[2])}
                    if '[' in line:
                        temporal = True; w = {'tq': Network.extractTQ(line)}
                else: w = {'w': 1}
                if u > v : v,u = u,v
                if multirel : G.addEdge(u,v,w=w,rel=rn)
                else: G.addEdge(u,v,w=w)
        net.close()
        G._info['simple'] = simple
        G._info['mode'] = mode
        if mode==2:
            G._info['dim'] = ( nr, nc )
        G._info['temporal'] = temporal
        if temporal:
            if Tmax < Tmin: Tmin = 0; Tmax = 999999999
            G._info['time'] = {"Tmin": Tmin, "Tmax": Tmax}
            if Tmax+1 < 999999999:
                G._info['legends']['Tlabs'] = {str(y):str(y) for y in range(Tmin,Tmax+1)}
        if len(rels)>0:
            G._info['multirel'] = True
            G._info['legends'] = {}
            G._info['legends']['rels'] = rels
        if len(meta)>0:
            G._info['meta'] = [ { "info": meta } ]
        return G
    def loadNetsJSON(file, encoding='utf-8'):
        try: js = open(file,'r',encoding=encoding)
        except: raise Network.NetworkError(
            "Problems with Pajek file {0}".format(file))
        net = json.loads(js.read())
        mode = net['info'].get('mode',1)
        n = net['info'].get('nNodes',0)
        G = Network()
        G._info['mode'] = mode
        if mode==2:
            nr, nc = G._info['dim'] = net['info'].get('dim',[0,0])
            if nr==0: raise Network.NetworkError("Missing mode1 size")
        G._info['title'] = net['info'].get('title',"INPUT Network")
        G._info['network'] = net['info'].get('network',"Network")
        G._info['simple'] = net['info'].get('simple',False)
        G._info['meta'] = net['info'].get('meta',[])
        G._info['multirel'] = net['info'].get('multirel',False)
        G._info['directed'] = net['info'].get('directed',False)
        G._info['legends'] = net['info'].get('legends',{})
        G._info['required'] = net['info'].get('required',{"nodes":[],"links":[]})
        G._info['trace'] = net['info'].get('trace',["loadNetsJSON"])
        temporal = net['info'].get('temporal',False)
        G._info['temporal'] = temporal
        if temporal:
            if 'time' in net['info']:
                Tmin = net['info']['time'].get('Tmin',1)
                Tmax = net['info']['time'].get('Tmax',999999999)
                G._info['time'] = (Tmin,Tmax)
                G._info['legends']['Tlabs'] = net['info']['time'].get('Tlabs',{})
            else: raise Network.NetworkError("Missing Time info")
        for K in net['nodes']:
            L = K.copy(); vid = L.pop('id',None); G.addNode(vid,mode)
            G._nodes[vid][3] = L
        for K in net['links']:
            L = K.copy(); lid = L.pop('id',None);
            u = L.pop('n1',None); v = L.pop('n2',None)
            r = L.pop('id',None); t = L.pop('type','edge')
            if t=='arc': l = G.addArc(u,v,w=L,rel=r,lid=lid)
            else: l = G.addEdge(u,v,w=L,rel=r,lid=lid)
        return G
    def saveNetsJSON(self,file=None,indent=None):
        n = len(self._nodes)
        info = {}; nodes = {}; links = {};
        info['simple'] = self._info.get('simple',False)
        info['directed'] = len(list(self.edges()))==0
        temporal = self._info.get('temporal',False)
        info['temporal'] = temporal
        info['org'] = 1
        info['mode'] = self._info.get('mode',1)
        if info['mode']>1:
            info['dim'] = \
               [len(list(self.nodesMode(i+1))) for i in range(info['mode'])]
        info['network'] = self._info.get('network',"test")
        info['title'] = self._info.get('title',"testSAVE")
        info['multirel'] = self._info.get('multirel',False)
        info['meta'] =  self._info.get('meta',[])
        info['meta'].append({"date": datetime.datetime.now().ctime(),\
             "title": "saved from Nets to netsJSON" })
        info['trace'] = self._info.get('trace',[])
        info['required'] = self._info.get('required',{})
        info['nNodes'] = n
        if temporal:
            minT = self._info['time']['Tmin']
            maxT = self._info['time']['Tmax']
            leg = self._info.get('legends',None)
            if leg != None: Tlabs = leg.get('Tlabs',
               { str(y):str(y) for y in range(minT,maxT+1)})
            info['time'] = { "Tmin": minT, "Tmax": maxT, "Tlabs": Tlabs }
        nodes = []
        for node in self._nodes:
            Node = self._nodes[node][3]; Node['id'] = node
            nodes.append(Node)
        links = []
        for link in self._links:
            u,v,d,r,w = self._links[link]; Link = w
            Link["type"] = "arc" if d else "edge"
            Link["n1"] = u; Link["n2"] = v
            if r!=None: Link["rel"] = r
            links.append(Link)
        info['nArcs'] = len(list(self.arcs()))
        info['nEdges'] = len(list(self.edges()))
        if file==None: file = info['network']+'.json'
        net = {"netsJSON": "basic", "info": info, "nodes": nodes, "links": links}
        js = open(file,'w')
#        json.dump(net, js, ensure_ascii=False, indent=indent)
        json.dump(net, js, indent=indent)
        js.close()
    def savePajek(self,file,key='w',coord=True):
# sprogramiraj še za dvodelna omrežja
        net = open(file,'w'); n=len(self._nodes)
        net.write('% '+str(self._info['network'])+'\n')
        net.write('% '+str(self._info['meta'])+'\n')
        net.write('% savePajek:'+datetime.datetime.now().ctime()+'\n')
        net.write('*vertices '+str(n)+'\n')
        ind = {}
        for (i,v) in enumerate(self._nodes):
            xy = self.getXY(v); ind[v] = i+1
            lab = self.getNode(v,'lab')
            if lab == None: lab = "v"+str(v)
            net.write(str(i+1)+' "'+lab+'"')
            if coord: net.write(' '+str(xy[0])+' '+str(xy[1])+' 0.5')
            net.write('\n')
        net.write('*arcs\n')
        for a in self.arcs():
            u,v,*r = self._links[a]
#            print(a,u,v,r)
            w = self.getLink(a,key)
            if w == None: w = 1
            net.write(str(ind[u])+' '+str(ind[v])+' '+str(w)+'\n')
        net.write('*edges\n')
        for e in self.edges():
            u,v,*r = self._links[e]
#            print(e,u,v,r)
            w = self.getLink(e,key)
            if w == None: w = 1
            net.write(str(ind[u])+' '+str(ind[v])+' '+str(w)+'\n')
        net.close()
    def oneMode2netsJSON(yFile,netFile,jsonFile,instant=True,key='w',
                        replace=True,indent=None):
        def timer(): return datetime.datetime.now().ctime()
        G = Network.loadPajek(netFile); F = Network()
        for v in G.nodes(): F.addNode(v)
        F.loadPajekClu('year',yFile)
        minT = min(F.getNode(v,'year') for v in F.nodes())
        maxT = max(F.getNode(v,'year') for v in F.nodes())
        n = len(list(G.nodes()))
        for v in G.nodes(): G.setNode(v,'act', [(F.getNode(v,'year'),maxT+1,1)])
        for e in G.links():
            u,v,*r = G._links[e]; t = F.getNode(u,'year')
            G._links[e][4]['tq'] = [(t,t+1,G._links[e][4][key])] if instant \
                else [(t,maxT+1,G._links[e][4][key])]
            if replace: del G._links[e][4][key]
        G.setInfo('title',"instant" if instant else "cumulative")
        G.setInfo('temporal',True); G.setInfo('mode',1)  #; G.setInfo('dim',(nr,nc))
        G.setInfo('meta',[{"date":timer(),"title":"oneMode2netsJSON"}])
        G.setInfo('time',(minT,maxT)); G.setInfo('temporal',True)
        G._info['legends']['Tlabs'] = {str(y):str(y) for y in range(minT,maxT+1)}
#        G.setInfo('Tlabs',{str(y):str(y) for y in range(minT,maxT+1)});
        G.setInfo('trace',[timer(),Network.location(),"Nets","twoMode2netsJSON",
            [yFile,netFile],['input','input']])
        G.setInfo('required',{"nodes": ["id","mode","lab","act"],
            "links": ["n1","n2","type","tq"]}) # for JSON
        G.saveNetsJSON(jsonFile,indent=indent)
        return G
    def twoMode2netsJSON(yFile,netFile,jsonFile,instant=True,key='w',
                        replace=True,indent=None):
        def timer(): return datetime.datetime.now().ctime()
        G = Network.loadPajek(netFile); F = Network()
        for v in G.nodesMode(1): F.addNode(v)
        F.loadPajekClu('year',yFile)
        minT = min(F.getNode(v,'year') for v in F.nodes())
        maxT = max(F.getNode(v,'year') for v in F.nodes())
        nr = len(list(G.nodesMode(1))); nc = len(list(G.nodesMode(2)))
        for v in G.nodesMode(1): G.setNode(v,'act', [(F.getNode(v,'year'),maxT+1,1)])
        for v in G.nodesMode(2): G.setNode(v,'act', [(minT,maxT+1,1)])
        for e in G.links():
            u,v,*r = G._links[e]; t = F.getNode(u,'year')
            G._links[e][4]['tq'] = [(t,t+1,G._links[e][4][key])] if instant \
                else [(t,maxT+1,G._links[e][4][key])]
            if replace: del G._links[e][4][key]
        G.setInfo('title',"instant" if instant else "cumulative")
        G.setInfo('temporal',True); G.setInfo('mode',2); G.setInfo('dim',(nr,nc))
        G.setInfo('meta',[{"date":timer(),"title":"twoMode2netsJSON"}])
        G.setInfo('time',(minT,maxT)); G.setInfo('temporal',True)
        G._info['legends']['Tlabs'] = {str(y):str(y) for y in range(minT,maxT+1)}
#        G.setInfo('Tlabs',{str(y):str(y) for y in range(minT,maxT+1)});
        G.setInfo('trace',[timer(),Network.location(),"Nets","twoMode2netsJSON",
            [yFile,netFile],['input','input']])
        G.setInfo('required',{"nodes": ["id","mode","lab","act"],
            "links": ["n1","n2","type","tq"]}) # for JSON
        G.saveNetsJSON(jsonFile,indent=indent)
        return G
    def loadPajekClu(self,key,file):
        try:
            clu = open(file,'r')
        except:
            raise Network.NetworkError(
                "Problems with Pajek file {0}".format(file))
        k = -1; n=len(self._nodes)
        while True:
            line = clu.readline()
            if not line: break
            if line[0] == '%': continue
            if line[0] == '*':
                L = re.split('\s+',line.strip())
                control = L[0].lower()
                if control=='*vertices':
                    num = eval(L[1])
                    if num != n: raise Network.NetworkError(
                      "Partition size {0} != Graph size{1}".format(num,n))
                    k = 0; continue
            elif k >= 0:
                k += 1
                if k > num: break
                self.setNode(k,key,eval(line.strip()))
                continue
            else:
                raise Network.NetworkError(
                    "Problems on Pajek file {0}".format(file))
        clu.close()
    def savePajekClu(self,key,file):
        clu = open(file,'w');  n=len(self._nodes)
        clu.write('*vertices '+str(n)+'\n')
        for i in range(n): clu.write(str(self.getNode(i+1,key))+'\n')
        clu.close()
    def loadPajekVec(self,key,file):
        try:
            vec = open(file,'r')
        except:
            raise Network.NetworkError(
                "Problems with Pajek file {0}".format(file))
        k = -1; n=len(self._nodes)
        while True:
            line = vec.readline()
            if not line: break
            if line[0] == '%': continue
            if line[0] == '*':
                L = re.split('\s+',line.strip())
                control = L[0].lower()
                if control=='*vertices':
                    num = eval(L[1])
                    if num != n: raise Network.NetworkError(
                      "Vector size {0} != Graph size{1}".format(num,n))
                    k = 0; continue
            elif k >= 0:
                k += 1
                if k > num: break
                self.setNode(k,key,eval(line.strip()))
                continue
            else:
                raise Network.NetworkError(
                    "Problems on Pajek file {0}".format(file))
        vec.close()
    def savePajekVec(self,key,file):
        vec = open(file,'w');  n=len(self._nodes)
        vec.write('*vertices '+str(n)+'\n')
        for i in range(n): vec.write(str(self.getNode(i+1,key))+'\n')
        vec.close()
    def TQshow(tq,cdir,TQmax,Tmin,Tmax,w,h,tit,
        fill='steelblue',xLab=70,yLab=40):
        TQ = [ list(q) for q in tq ]
        js = open(cdir+'/barData.js','w')
        js.write('var barData = '+str(TQ)+';\n')
        js.write('var TQmax = '+str(TQmax)+';\n')
        js.write('var Tmin = '+str(Tmin)+';\n')
        js.write('var Tmax = '+str(Tmax)+';\n')
        js.write('var Width = '+str(w)+';\n')
        js.write('var Height = '+str(h)+';\n')
        js.write('var Title = "'+tit+'";\n')
        js.write('var Rfill = "'+fill+'";\n')
        js.write('var xLab = "'+str(xLab)+'";\n')
        js.write('var yLab = "'+str(yLab)+'";\n')
        js.close()
    # https://pymotw.com/3/webbrowser/
    # import webbrowser
    # b = webbrowser.get('google-chrome')
    # b = webbrowser.get('mozilla')
        b = webbrowser.get('windows-default')
    #   b.open('c:/users/batagelj/work/python/graph/chart/barChart.html')
        b.open(cdir+'/TQchart.html')
    def getXY(self,u):
        if not('x' in self._nodes[u][3]): self._nodes[u][3]['x'] = random()
        if not('y' in self._nodes[u][3]): self._nodes[u][3]['y'] = random()
        return (self._nodes[u][3]['x'],self._nodes[u][3]['y'])
    def drawNode(self,u,rr=10,cols=('white','black')):
        xy = Network.turtleXY(self.getXY(u))
        t.pu(); t.setpos(xy); t.pd()
        t.dot(rr,cols[1]); t.dot(rr-2,cols[0])
        t.pu(); t.setpos(xy[0]+rr/1.3,xy[1]-rr/2)
        t.pencolor('black')
        t.write(self._nodes[u][3].get('lab',str(u)))
    def drawLink(self,u,v,w=1,col='blue',arc=False):
        xy1 = Network.turtleXY(self.getXY(u))
        xy2 = Network.turtleXY(self.getXY(v))
        t.pu(); t.setpos(xy2); t.pd()
        t.pencolor(col); t.pensize(w); t.setpos(xy1)
        if arc:
            t.seth(t.towards(xy2)); d = 5+4*w; t.pu()
            xy = ((xy1[0]+xy2[0])/2,(xy1[1]+xy2[1])/2)
            t.setpos(xy); t.pd(); t.rt(20); t.bk(d);
            t.pu(); t.setpos(xy); t.pd()
            t.lt(40); t.bk(d)
    def draw(self,W,H,bg,col='col',d=15,colors=Colors):
        t.screensize(W,H,bg); t.title("Draw graf"); t.colormode(255)
        t.speed(0); t.clear(); t.ht()
        for e in self.links():
            u,v,directed,*r = self._links[e]
            if directed: self.drawLink(u,v,col='red',arc=True)
            else: self.drawLink(u,v)
        colored = col in self._nodes[u][3].keys()
        for v in self.nodes():
            fcol = colors[self.getNode(v,col)] if colored else 'yellow'
            self.drawNode(v,d,(fcol,'black'))
#       t.done()
        t.exitonclick()
    def onCircle(self,p=None):
        if p == None: p = self.nodes()
        n = len(self._nodes); a = 2*pi/n
        for (i,v) in enumerate(p):
            self.setNode(v,'x',0.5+0.45*sin(i*a))
            self.setNode(v,'y',0.5+0.45*cos(i*a))
    def ErdosRenyiGraph(n,m):
        G = Network()
        for v in range(n): G.addNode(v+1)
        for i in range(m):
            while True:
                u = randint(1,n); v = randint(1,n)
                edge = (u,v,1) if u < v else (v,u,1)
                if not edge in G._links: break
            G.addEdge(u,v)
        return G
    def seqColoring(self,key='col'):
        fresh = 0; pal = set(range(1,20))
        for v in self.nodes(): self.setNode(v,key,fresh)
        p=list(self._nodes.keys()); shuffle(p)
        used = set()
        for v in p:
            free = used - \
                {self.getNode(u,key) for u in self.neighbors(v)}
            if len(free)==0:
                col = pal.pop()
                if len(pal) == 0: pal.add(col+1)
                free.add(col); used.add(col)
            self.setNode(v,key,free.pop())
        return len(used)

    def acyImportance(self,alpha,key='aImp'):
#   CDG, Paris, 21.10.2012
        for v in self.nodes():
            self.setNode(v,'outD',self.outDegree(v))
        for v in self.topologicalOrder():
            s = 1
            for u in self.inNeighbors(v):
                s = s + alpha*self.getNode(u,key)/self.getNode(u,'outD')
            self.setNode(v,key,s)

    def acyProbFlow(self,key='aPflow'):
#   Jena-Frankfurt, 5.7.2013
#   ~ acyImportance; alpha=1, standardized wo feed-back
        nInit = 0
        for v in self.nodes():
            self.setNode(v,'outD',self.outDegree(v))
            if self.inDegree(v)==0: nInit += 1
        for v in self.topologicalOrder():
            s = 0
            for u in self.inNeighbors(v):
                s = s + self.getNode(u,key)/self.getNode(u,'outD')
            if s==0: s = 1/nInit
            self.setNode(v,key,s)

# Transitive skeleton
# Piran, 26.12.2013
    def existsPath(self,K,u,h):
        F = set()
        for t in K:
            N = self.outArcNeighbors(t)
            if u in N: return True
            F = F | set({z for z in N if h[z-1] < h[u-1]})
        if len(F)==0: return False
        return self.existsPath(F,u,h)

    def tSkelet(self):
        print('Transitive skeleton')
        self.depth(); h = [0]*len(self)
        for i in range(len(self)): h[i] = self.getNode(i+1,'depth')
        p = [v+1 for (v,h) in sorted(list(enumerate(h)), key=lambda q: q[1])]
        p.reverse(); S = deepcopy(self)
        for v in p:
            for u in S.outArcNeighbors(v):
                if (h[u-1]-h[v-1])==1:
                    # print("accept",v,u)
                    continue
                T = set(S.outArcNeighbors(v)) - {u}
                K = {t for t in T if h[t-1]<h[u-1]}
                if len(K)==0: continue
                if S.existsPath(K,u,h):
                    S.delArc(v,u) #; print('delete',v,u)
        return S

    def cSkelet(self):
        print('Transitive skeleton count')
        self.depth(); hMax = 0
        for i in range(len(self)): hMax = max(hMax,self.getNode(i+1,'depth'))
        print('max depth = ',hMax)
        h = [0]*(hMax+1)
        for (u,v,k) in self.links():
           d = self.getNode(v,'depth') - self.getNode(u,'depth')
           h[d] += 1
        return h

# adapted from Rodion Efremov's
# Breadth-first search: traditional and bidirectional in Python
# https://codereview.stackexchange.com/questions/111208/breadth-first-search-traditional-and-bidirectional-in-python
# by Vladimir Batagelj, June 12, 2020

    def traceback_path(target, parents):
        path = []; current = target
        while current:
            path.append(current)
            current = parents[current]
        return list(reversed(path))
    def bi_traceback_path(touch_node, parents_a, parents_b):
        path = []; current = touch_node
        while current:
            path.append(current)
            current = parents_a[current]
        path = list(reversed(path))
        current = parents_b[touch_node]
        while current:
            path.append(current)
            current = parents_b[current]
        return path
    def BFSpair(self, source, target):
        queue = deque([source])
        parents = {source: None}
        while len(queue) > 0:
            current = queue.popleft()
            if current is target:
                return Network.traceback_path(target, parents)
            for child in self.outNeighbors(current):
                if child not in parents.keys():
                    parents[child] = current
                    queue.append(child)
        return []
    def biBFSpair(self, source, target):
        queue_a = deque([source]); queue_b = deque([target])
        parents_a = {source: None}; parents_b = {target: None}
        distance_a = {source: 0}; distance_b = {target: 0}
        best_cost = Network.INFTY; touch_node = None
        while len(queue_a) > 0 and len(queue_b) > 0:
            dist_a = distance_a[queue_a[0]]
            dist_b = distance_b[queue_b[0]]
            if touch_node and best_cost < dist_a + dist_b:
                return Network.bi_traceback_path(touch_node, parents_a, parents_b)
            # Trivial load balancing
            if dist_a < dist_b:
                current = queue_a.popleft()
                if current in distance_b.keys() and best_cost > dist_a + dist_b:
                    best_cost = dist_a + dist_b
                    touch_node = current
                for child in self.outNeighbors(current):
                    if child not in distance_a.keys():
                        distance_a[child] = distance_a[current] + 1
                        parents_a[child] = current
                        queue_a.append(child)
            else:
                current = queue_b.popleft()
                if current in distance_a.keys() and best_cost > dist_a + dist_b:
                    best_cost = dist_a + dist_b
                    touch_node = current
                for parent in self.inNeighbors(current):
                    if parent not in distance_b.keys():
                        distance_b[parent] = distance_b[current] + 1
                        parents_b[parent] = current
                        queue_b.append(parent)
        return []

# Python program to find biconnected components in a given undirected graph
# using algorithm by John Hopcroft and Robert Tarjan.
# https://www.geeksforgeeks.org/biconnected-components/
# Complexity : O(V+E)
# adapted for Nets by Vladimir Batagelj, June 21, 2020

# A recursive function that finds biconnected
# components using DFS traversal
# u - The vertex to be visited next
# disc[] - Stores discovery times of visited vertices
# low[] - Earliest visited vertex (the vertex with minimum
# discovery time) that can be reached from subtree
# rooted with current vertex
# st - Stack to store visited edges'''
    def BCCUtil(self, u, key): 
        global parent, low, disc, st, Time, count 
        children =0;
        Time += 1; disc[u] = Time; low[u] = Time 
        for v in self.edgeNeighbors(u):
            if disc[v] == -1 :
                parent[v] = u; children += 1
                e = (min(u,v),max(u,v)); st.append(e) 
                self.BCCUtil(v,key)
                low[u] = min(low[u], low[v]) 
                if (disc[u] == 1 and children > 1) or \
                   (disc[u] > 1 and low[v] >= disc[u]):
                    count +=1; w = -1
                    while w != e:
                        w = st.pop() # ; print(w,)
                        self.setLink(self.indEdge(w),key,count)
                    # print("")
            elif v != parent[u]:
                low[u] = min(low[u],disc[v])
                if disc[v] < disc[u]: st.append((min(u,v),max(u,v)))
 
#The function to do DFS traversal. It uses recursive BCCUtil()
    def BCC(self,key='BiCo'):
        global parent, low, disc, st, Time, count
        n = len(self._nodes); Time = 0; count = 0 
        disc = [-1] * (n+1); low = [-1] * (n+1)
        parent = [-1] * (n+1); st = []
        for i in self.nodes():
            if disc[i] == -1: self.BCCUtil(i,key) 
            if st:
                count +=1 
                while st:
                    w = st.pop()  # ; print(w,)
                    self.setLink(self.indEdge(w),key,count)
                # print("")
        self._info[key] = count
# shortest cycle weights
    def shortCyWeight(self,key='scy'):
    # biconnected components decomposition
        n = len(self._nodes); infinity = float('inf')
        self.BCC()
        count = self.getInfo('BiCo')
        for e in self._links: self.setLink(e,key,infinity)
        BiCo = [ self.getLink(e,'BiCo') for e in self.links()]
        size = [0] * (count+1)
        for c in BiCo: size[c] += 1
        for e in self.links():
            if size[self.getLink(e,'BiCo')] == 1: self.setLink(e,key,n+1)
    # triangles
        for e in self._links:
            if self.getLink(e,key) == infinity:
                u = self._links[e][0]; v = self._links[e][1]
                if len(self._nodes[u][0]) > len(self._nodes[v][0]): u,v = v,u
                found = False
                for t in self._nodes[u][0]:
                    if t in self._nodes[v][0]:
                        found = True
                        self.setLink(self.indEdge((u,t)),key,3)
                        self.setLink(self.indEdge((v,t)),key,3)
                    if found: self.setLink(self.indEdge((u,v)),key,3)
    # shortest cycles for remaining edges
        L = self._links.keys()
        for e in L:
            c = self.getLink(e,key)
            if c==infinity or (3 < c and c < (n+1)):
                u,v,d,r,w = self.link(e)
                self.delLink(e)
                S = self.biBFSpair(u,v)
                w[key] = n+1 if len(S) == 0 else len(S)
                self.addEdge(u,v,w)

# if __name__ == '__main__':

