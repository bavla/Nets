# -*- coding: UTF-8 -*-

from IndexMinPQ import *
class Search(object):

    INFTY = 1e10

# poti iz dane točke  s  v globino
    def DFSpaths(self,s):
        self.setInfo('source',s)
        self.setNodes('mark',False)
        self.setNodes('back',0)
        self.DFS(s)
    def DFS(self,v):
        self.setNode(v,'mark',True)
        for w in self.outNeighbors(v):
            if not self.getNode(w,'mark'):
                self.setNode(w,'back',v)
                self.DFS(w)
    def existsPathTo(self,t): return self.getNode(t,'mark')
    def pathTo(self,t):
        if not self.existsPathTo(t): return None
        u = t; path = []; s = self.getInfo('source')
        while u != s:
            path.append(u); u = self.getNode(u,'back')
        path.append(s); path.reverse()
        return path

# poti iz dane točke  s  v širino - najkrajše poti
    def BFSpaths(self,s):
        self.setInfo('source',s)
        self.setNodes('mark',False)
        self.setNodes('back',0)
        self.BFS(s)
    def BFS(self,v):
        self.setNode(v,'mark',True); s = self.getInfo('source')
        q = [s]
        while len(q) > 0:
            v = q.pop(0)
            for w in self.outNeighbors(v):
                if not self.getNode(w,'mark'):
                    self.setNode(w,'back',v); self.setNode(w,'mark',True)
                    q.append(w)

# šibko povezane komponente
    def connectedComponents(self):
        self.setNodes('weak',0); nc = 0
        for w in self.nodes():
            if self.getNode(w,'weak') == 0:
                nc += 1; self.setInfo('weak',nc); self.DFScc(w)
    def DFScc(self,v):
        self.setNode(v,'weak',self.getInfo('weak'))
        for w in self.neighbors(v):
            if self.getNode(w,'weak') == 0: self.DFScc(w)
    def weaklyConnected(self,u,v):
        return self.getNode(u,'weak') == self.getNode(v,'weak')
    def weakCompNum(self): return self.getInfo('weak')

# ali je dvodelen
    def searchBipart(self):
        self.setInfo('bipart',True); self.setNodes('mark',False)
        self.setNodes('col','White')
        for w in self.nodes():
            if not self.getNode(w,'mark'):
                self.setNode(w,'col','Red'); self.DFSbi(w)
    def DFSbi(self,v):
        self.setNode(v,'mark',True)
        for w in self.neighbors(v):
            if not self.getNode(w,'mark'):
                col = 'Blue' if self.getNode(v,'col')=='Red' else 'Red'
                self.setNode(w,'col',col); self.DFSbi(w)
            elif self.getNode(w,'col') == self.getNode(v,'col'):
                self.setInfo('bipart',False)
    def isBipartite(self): return self.getInfo('bipart')

# ali vsebuje pol-cikel
    def searchCycle(self):
        self.setInfo('cyclic',False); self.setNodes('mark',False)
        for w in self.nodes():
            if not self.getNode(w,'mark'): self.DFScyc(w,w)
    def DFScyc(self,v,u):
        self.setNode(v,'mark',True)
        for w in self.neighbors(v):
            if not self.getNode(w,'mark'): self.DFScyc(w,v)
            elif w != u: self.setInfo('cyclic',True)
    def isCyclic(self): return self.getInfo('cyclic')

# ali vsebuje usmerjeni cikel
    def searchDirCycle(self):
        self.setNodes('mark',False); self.setNodes('back',0)
        self.setNodes('stack',False); self._cycle = []
        for w in self.nodes():
            if not self.getNode(w,'mark'): self.DFSdir(w)
    def DFSdir(self,v):
        self.setNode(v,'stack',True); self.setNode(v,'mark',True)
        for w in self.outNeighbors(v):
            if len(self._cycle) > 0: return
            if not self.getNode(w,'mark'):
                self.setNode(w,'back',v); self.DFSdir(w)
            elif self.getNode(w,'stack'):
                u = v
                while u != w:
                    self._cycle.append(u)
                    u = self.getNode(u,'back')
                self._cycle.append(w); self._cycle.append(v)
        self.setNode(v,'stack',False)
    def hasCycle(self): return len(self._cycle) > 0
    def cycle(self): return iter(self._cycle)

    def DFSorders(self):
        self._pre = []; self._post = []
        self.setNodes('mark',False)
        for w in self.nodes():
            if not self.getNode(w,'mark'): self.DFSord(w)
    def DFSord(self,v):
        self.setNode(v,'mark',True)
        self._pre.append(v)
        for w in self.outNeighbors(v):
            if not self.getNode(w,'mark'): self.DFSord(w)
        self._post.append(v)
    def preOrder(self): return self._pre
    def postOrder(self): return self._post
    def topologicalOrder(self):
        self.searchDirCycle()
        if self.hasCycle(): return None
        self.DFSorders()
        order = list(self._post); order.reverse()
        return order
    def depth(self):
        self.setNodes('depth',1)
        for v in self.topologicalOrder():
            dv = self.getNode(v,'depth')
            for u in self.outArcNeighbors(v):
                if self.getNode(u,'depth')<=dv: self.setNode(u,'depth',dv+1)

# krepke komponente - Kosaraju
    def KosarajuSCC(self):
        self.setNodes('strong',0); nc = 0
        R=self.reverse(); R.DFSorders()
        order = list(R._post); order.reverse()
        for w in order:
            if self.getNode(w,'strong') == 0:
                nc += 1; self.setInfo('strong',nc); self.DFSscc(w)
    def DFSscc(self,v):
        self.setNode(v,'strong',self.getInfo('strong'))
        for w in self.outNeighbors(v):
            if self.getNode(w,'strong') == 0: self.DFSscc(w)
    def stronglyConnected(self,u,v):
        return self.getNode(u,'strong') == self.getNode(v,'strong')
    def strongCompNum(self): return self.getInfo('strong')


#  Dijkstra's algorithm. Computes the shortest path tree.
#  Assumes all weights are nonnegative.

    def DijkstraSP(self, s):
        self.setInfo('source',s)   # source node
        self.setNodes('dis',Search.INFTY)  # dis[v] = distance of shortest s->v path
        self.setNodes('back',None)  # back[v] = last edge on shortest s->v path
        self.setNode(s,'dis',0.0)
        n = len(self._nodes)

        # relax vertices in order of distance from s
        pq = IndexMinPQ(n)
        pq.insert(s, self.getNode(s,'dis'))
        while not pq.isEmpty():
            v = pq.delMin()
            for e in self.outStar(v): self.relax(pq,v,e)

    # relax edge e and update pq if changed
    def relax(self,pq,v,e):
        w = self.twin(v,e)
        if self.getNode(w,'dis') > self.getNode(v,'dis') + self._links[e]['w']:
            self.setNode(w,'dis', self.getNode(v,'dis') + self._links[e]['w'])
            self.setNode(w,'back',e)
            if pq.contains(w): pq.change(w, self.getNode(w,'dis'))
            else: pq.insert(w, self.getNode(w,'dis'))

    # length of shortest path from s to v
    def dist(self, v): return self.getNode(v,'dis')

    # is there a path from s to v?
    def hasPathTo(self, v): return self.getNode(v,'dis') < Search.INFTY

    # shortest path from s to v, None if no such path
    def pathLinksTo(self, v):
        if not self.hasPathTo(v): return None
        s = []; u = v
        while True:
            e = self.getNode(u,'back')
            if e == None: break
            s.append(e)
            u = self.twin(u,e)
        s.reverse()
        return s

# if __name__ == '__main__':
#    from Nets import Nets
