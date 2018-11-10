# Test files

## WAtest

![WA test network](https://raw.githubusercontent.com/bavla/Nets/master/test/WAtest.png "WAtest.net")
![Cite test network](https://raw.githubusercontent.com/bavla/Nets/master/test/CiteTest.png "CiteTest.net")

```
gdir = 'c:/users/batagelj/work/python/graph/Nets'
wdir = "C:/Users/batagelj/work/Python/WoS/SocNet/2018/Time/work"
ddir = 'C:/Users/batagelj/work/Python/WoS/SocNet/2018/Time/WAt'
cdir = "C:/Users/batagelj/work/Python/WoS/SocNet/2018/Time/work/chart"
import sys, os, re, datetime, json
sys.path = [gdir]+sys.path; os.chdir(wdir)
from TQ import *
from Nets import Network as N
```

### Creating temporal networks

```
net = tdir+"/WAtest.net"
clu = tdir+"/yearsTest.clu"
t1 = datetime.datetime.now(); print("started: ",t1.ctime(),"\n")
WAtc = N.twoMode2netJSON(clu,net,'WAtCum.json',instant=False)
t2 = datetime.datetime.now(); print("\nconverted to cumulative TN: ",t2.ctime(),"\ntime used: ", t2-t1)
WAi = N.twoMode2netJSON(clu,net,'WAins.json',instant=True)
t3 = datetime.datetime.now(); print("\nconverted to instantaneous TN: ",t3.ctime(),"\ntime used: ", t3-t2)


```

### Derived networks

```
tdir = "C:/Users/batagelj/work/Python/graph/JSON/test"
net = tdir+"/WAtestInst.json"
WAti = N.loadNetJSON(net)
CCt = WAti.TQtwo2oneNorm()
N1 = WAti.TQnormal()
N2 = N1.transpose()
CCm = N.TQmultiply(N2,N1,oneMode=True)
```

