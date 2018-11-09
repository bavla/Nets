# Test files

![WA test network](https://raw.githubusercontent.com/bavla/Nets/master/test/WAtest.png "WAtest.net")

```
gdir = 'c:/users/batagelj/work/python/graph/Nets'
wdir = "C:/Users/batagelj/work/Python/WoS/SocNet/2018/Time/work"
ddir = 'C:/Users/batagelj/work/Python/WoS/SocNet/2018/Time/WAt'
cdir = "C:/Users/batagelj/work/Python/WoS/SocNet/2018/Time/work/chart"
import sys, os, re, datetime, json
sys.path = [gdir]+sys.path; os.chdir(wdir)
from TQ import *
from Nets import Network as N

tdir = "C:/Users/batagelj/work/Python/graph/JSON/test"
net = tdir+"/WAtestInst.json"
WAti = N.loadNetJSON(net)
CCt = WAti.TQtwo2oneNorm()
N1 = WAti.TQnormal()
N2 = N1.transpose()
CCm = N.TQmultiply(N2,N1,oneMode=True)
```

