
class IndexMinPQ(object):

  class pqError(RuntimeError): pass

  def __init__(self,NMAX):
    self.N    = 0                    # number of elements on PQ
    self.pris = [ None ]*(NMAX + 1)  # pris[i] = priority of i
    self.pq   = [ 0 ]*(NMAX + 1)     # binary heap using 1-based indexing
    self.qp   = [ -1 ]*(NMAX + 1)    # inverse of pq - qp[pq[i]] = pq[qp[i]] = i

  # is the priority queue empty?
  def isEmpty(self): return self.N == 0

  # is k an index on the priority queue?
  def contains(self, k): return self.qp[k] != -1

  # number of pris in the priority queue
  def size(self): return self.N

  # associate pri with index k
  def insert(self, k, pri):
    if self.contains(k):
      raise self.pqError("item is already in pq")
    self.N += 1
    self.qp[k] = self.N
    self.pq[self.N] = k
    self.pris[k] = pri;
    self.swim(self.N)

  # return the index associated with a minimal pri
  def minIndex(self):
    if self.N == 0:
      raise self.pqError("Priority queue underflow")
    return self.pq[1]

  # return a minimal pri
  def minpri(self):
    if self.N == 0:
      raise self.pqError("Priority queue underflow")
    return self.pris[self.pq[1]]

  # delete a minimal pri and returns its associated index
  def delMin(self):
    if self.N == 0:
      raise self.pqError("Priority queue underflow")
    mini = self.pq[1]
    self.exch(1, self.N); self.N -= 1
    self.sink(1); self.qp[mini] = -1;
    self.pris[self.pq[self.N+1]] = None
    self.pq[self.N+1] = -1;            # not needed
    return mini

  # change the pri associated with index k
  def change(self, k, pri):
    if not self.contains(k):
      raise self.pqError("item is not in pq")
    self.pris[k] = pri;
    self.swim(self.qp[k]);
    self.sink(self.qp[k]);

  # decrease the pri associated with index k
  def decrease(self, k, pri):
    if not self.contains(k):
      raise self.pqError("item is not in pq")
    if self.pris[k] <= pri:
      raise self.pqError("illegal decrease")
    self.pris[k] = pri
    self.swim(self.qp[k])

  # increase the pri associated with index k
  def increase(self, k, pri):
    if not self.contains(k):
      raise self.pqError("item is not in pq")
    if self.pris[k] >= pri:
      raise self.pqError("illegal decrease")
    self.pris[k] = pri
    self.sink(self.qp[k])

  def greater(self, i, j):
    return self.pris[self.pq[i]] > self.pris[self.pq[j]]

  def exch(self, i, j):
    self.pq[i], self.pq[j] = self.pq[j], self.pq[i]
    self.qp[self.pq[i]] = i; self.qp[self.pq[j]] = j

  def swim(self, k):
    while (k > 1) and self.greater(k//2, k):
      self.exch(k, k//2); k = k//2

  def sink(self, k):
    while 2*k <= self.N:
      j = 2*k
      if (j < self.N) and self.greater(j, j+1): j += 1
      if not self.greater(k, j): break
      self.exch(k, j); k = j
