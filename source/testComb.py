wdir = "C:/Users/batagelj/work/R/pajek/twitter"
ddir = "C:/Users/batagelj/work/R/pajek/twitter"
import os
os.chdir(wdir)
from combine import *

combine(ddir,"comment.net","react.net","combine.net")

