#!/usr/bin/python
#############################################################################
#
#   Amazon - Harvesting from Amazon.com
#
#   file: amazon.net
#   amazon.run('oldAmazon.net',nver0,narc,maxver)
#
#   import sys
#   sys.path.append(r'D:\Vlado\work\Python\Amazon')
#
#   import amazon
#   amazon.run('AmazonOld.net',14187,68860,100000)
#   amazon.run('AmazonOld.net',17017,82520,100000)
#   amazon.run('AmazonOld.net',39546,189930,500000)
#   amazon.run('AmazonOld.net',51229,245187,500000)
#   amazon.run('AmazonOld.net',65392,311572,500000)
#   amazon.run('AmazonOld.net',67389,320844,500000)
#   amazon.run('AmazonOld.net',84328,399474,500000)
#   amazon.run('AmazonOld.net',92547,437163,500000)
#   amazon.run('AmazonOld.net',100695,474562,500000)
#   amazon.run('AmazonOld.net',132680,618564,500000)
#   amazon.run('AmazonOld.net',144952,672480,500000)
#   amazon.run('AmazonOld.net',145682,675781,500000)
#   amazon.run('AmazonOld.net',160397,739653,500000)
#   amazon.run('AmazonOld.net',171164,787017,500000)
#   amazon.run('AmazonOld.net',196255,895208,500000)
#   amazon.run('AmazonOld.net',209144,949874,500000)
#
#   Vladimir Batagelj,  5/19. june 2004
#
###############################################################################

import urllib, urlparse, string, os

def new_vertex(bk,ti,au):
   global nver, vert, books, maxver, nodes, titles, trace, narc
   nver = nver + 1
   trace.write(str(nver) + ' ' + str(narc) + '\n')
   print 'New vertex(', nver, '): ' + bk
   vert[bk] = nver
   nodes.write(str(nver)+" '"+book+"'\n")
   titles.write(str(nver)+" '"+book+"' "+au+" --> "+ti+"\n")
   if nver < maxver: books.append(bk)

def new_arc(vini,vter):
   global arcs, trace, narc, nver
   narc = narc + 1
   print 'New arc ', narc, ': (', vini, ',', vter, ')'
   arcs.write(str(vini) + ' ' + str(vter) + '\n')
   trace.write(str(nver) + ' ' + str(narc) + '\n')

def inspect(bk):
   global lstr, rstr, lref, rtit, vert, nver, url1, book, titl, \
     auth, url2, books, maxver, b, narc
   vini = vert[bk]
   url  = url1 + bk + url2
   page = urllib.urlopen(url)
   a    = page.read()
   try:
      lind = string.index(a,lstr) + len(lstr)
   except ValueError:
      lind = len(a)
   try:
      rind = string.index(a,rstr,lind)
   except ValueError:
      rind = len(a)
   b    = a[lind:rind]
   while len(b) > 10:
      try:             # find   '<a href='
         linr = string.index(b,lref) + len(lref)
      except ValueError:
         print 'HREF not found'
         b = ''
      else:
         rinr = string.index(b,'>',linr)
         url  = b[linr:rinr]
         print 'URL : ', url
         b    = b[rinr+1:]
         rint = string.index(b,rtit)    # find '</a>'
         titl = b[:rint]
         b    = b[rint + len(rtit):]
         try:
            lina = string.index(b,'by')
         except ValueError:
            auth = 'by UNKNOWN AUTHOR'
         else:
            rina = string.index(b,'\n',lina)
            auth = b[lina:rina]
            b    = b[rina+1:]
         try:
            linu = string.index(url,'detail/-/') + 9
         except ValueError:
            print '*** nonstandard URL ***'
         else:
            try:
               rinu = string.index(url,'?',linu)
            except ValueError:
               rinu = string.index(url,'/',linu)
            book = url[linu:rinu]
            print 'book: ', book, ' ', auth
            if vert.has_key(book):
               vter = vert[book]
            else:
               new_vertex(book,titl,auth)
               vter = nver
            new_arc(vini,vter)

def harvest():
   global books
   while books:
      book= books[0]
      del books[0]
      inspect(book)
   print '\nHarvest finished\n'


def run(vtxfile,nver0,narc0,maxver0):
   global lstr, rstr, lref, rtit, vert, nver, url1, book, titl, auth, \
     url2, books, nodes, arcs, titles, b, trace, narc, maxver
   lstr = '<a name=same_store></a>'
   rstr = '<a name=cross_store></a>'
   lref = '<a href='
   rtit = '</a>'
   vert = {}
   nver = 0
   narc = narc0
   maxver = maxver0
   url1 = 'http://www.amazon.com/exec/obidos/tg/detail/-/'
   url2 = '?v=glance'
#
   workdir = 'd:\\vlado\\work\\python\\amazon\\'
   titles = open(workdir+'amazon.tit', 'w')
   trace  = open(workdir+'amazon.dat', 'w')
   nodes  = open(workdir+'amazon.net', 'w')
   nodes.write('*vertices \n')
   books = []
   try:
      vtx  = open(workdir+vtxfile, 'r')
   except:
      book = '0761956042'
      titl = 'Introducing Social Networks'
      auth = 'by Michel Forse (Author), Alain Degenne (Author)'
      new_vertex(book,titl,auth)
   else:
      LL = vtx.readline()
      for line in vtx.readlines() :
#        print line
         LL = line.split(' ');
         bk = LL[1].split("'")[1];  bi = int(LL[0])
         vert[bk] = bi
         if bi > nver0: books.append(bk)
      vtx.close()
      nver = bi
#
   arcs   = open(workdir+'amazon.lin', 'w')
   arcs.write('*arcs \n')
#
   try:
      harvest()
   except:
      print b
      print 'book = ', book, ' arc = ', narc
      print '\nInterrupted\n'
#
   nodes.close()
   arcs.close()
   titles.close()
   trace.close()
