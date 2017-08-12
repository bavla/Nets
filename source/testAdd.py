from Nets import Network
def TestAdd():
    N = Network()
    N.addNode('B'); N.addNode('A'); N.addNode('C'); N.addNode('D')
    N.addEdge('B','D',{'w':3}); N.addArc('B','A',{'w':5});
    N.addArc('A','C',{'w':4}); N.addArc('B','C',{'w':6})
    N.addNode('E'); N.addNode('F')
    i=N.addArc('E','C',{'w':5}); j=N.addEdge('B','D',{'w':7});
    N.addArc('A','F',{'w':8}); N.addArc('A','C',{'w':5})
    N.onCircle()
    print(N)
    N.draw(800,800,"Cornsilk")
    N.savePajek('test.net')
#    N.delLink(j); N.delLink(i)
#   print(N)
    return N
N = TestAdd()
