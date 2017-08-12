
import datetime

class Coloring(object):

    def expand(self,key):
#   21. nov 2011/ 3. dec 2011 by Vladimir Batagelj
#   extends a given coloring (partition key) by replacing
#   undefined colors 0 with the most frequent color among
#   colored neighbors
        tresh = 5
        t1 = datetime.datetime.now()
        print("\nNets: Expand\nstarted: "+t1.ctime()+"\n")              
        print("# nodes", len(self))
        U = { v for v in self.nodes() if self.getNode(v,key)==0 }
        print("# uncolored nodes", len(U))
        S = {}
        for u in U:
            s = 0; T = {}
            for e in self.edgeStar(u):
                w = self._links[e]['w']; s += w
                v = self.twin(u,e); cv = self.getNode(v,key)
                if not cv in T: T[cv] = 0
                T[cv] += w
            T[-1] = s; S[u] = T
        step = 0; small = 0; forced = False
        while len(U) > 0:
            step += 1
            print("step",step,len(U))
            if step > 200: break
            M = {}; r = -1
            for u in U:
                T = S[u]; s = T[-1]; q = -1
                if s > 0:
                    for f in T.keys():
                        if f > 0:
                            p = T[f]/s
                            if p > q:
                                t = u; q = p; b = f
                if q > r:
                    z = t; r = q; c = b
                if forced:
                    if q > 0: M[t] = b
                elif q >= 0.5: M[t] = b
            if r <= 0: break
            if len(M) == 0: M[z] = c
            if len(M) == 1:
                small += 1; forced = small >= tresh
            else:
                small = 0; forced = False
            for u in M.keys():
                cu = M[u]; self.setNode(u,key,cu)
                for e in self.edgeStar(u):
                    w = self._links[e]['w']
                    v = self.twin(u,e); cv = self.getNode(v,key)
                    if cv == 0:
                        S[v][-1] -= w
                        if not cu in S[v].keys(): S[v][cu] = 0
                        S[v][cu] += w
            U -= M.keys()
        t2 = datetime.datetime.now()
        print("\nfinished: "+t2.ctime(),"\ntime used: ", t2-t1,"\n")

