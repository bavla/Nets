program scor2paj;
{$APPTYPE CONSOLE}
uses
  SysUtils;

const leng = 200;
label 1, 2, 3, 4, 5;
var
  dat, net: TextFile;
  n, m, i, j, np, d : integer;
  s, datname, netname : string;
  a : real;
  b : array [1..leng] of real;

begin
  write('SCOR file = '); readln(datname);
  write('PAJ  file = '); readln(netname);
  write('decimals  = '); readln(d);
  AssignFile(dat,datname);
  Reset(dat);
  AssignFile(net,netname);
  Rewrite(net);
  readln(dat,s);
  readln(dat,n,m);
  writeln(s);
  writeln('n = ',n:3,'  m = ', m:3);
  np := n + 3;
  writeln(net,'%',s);
  writeln(net,'% transformed from SCOR format by Scor2net ', DateToStr(Date));
  writeln(net,'*partition ECO types / ', datname);
  writeln(net,'*vertices ',np);
  for i := 1 to m do writeln(net,1);
  for i := m+1 to n do writeln(net,2);
  writeln(net,3); writeln(net,4); writeln(net,5);
  writeln(net);

  writeln(net,'*network ', datname);
  writeln(net,'*vertices ',np);
  for i := 1 to n do begin
    readln(dat,s); writeln(net,i:4, ' "',s,'"');
  end;
  writeln(net,n+1:4, ' "Input"');
  writeln(net,n+2:4, ' "Output"');
  writeln(net,n+3:4, ' "Respiration"');
  writeln(net,'*arcs'); flush(net);
  writeln('reading bio mass');
  for i := 1 to np do b[i] := 0;
  while true do begin
    readln(dat,j,a);
    if j < 0 then goto 1;
    b[j] := a;
  end;
1: writeln('reading inputs');
  while true do begin
    readln(dat,i,a);
    if i < 0 then goto 2;
    if d < 0 then writeln(net, n+1:4, i:4,' ', a)
      else writeln(net, n+1:4, i:4,' ', a:d+7:d);
  end;
2: writeln('reading outputs');
  while true do begin
    readln(dat,i,a);
    if i < 0 then goto 3;
    if d < 0 then writeln(net, i:4, n+2:4,' ', a)
      else writeln(net, i:4, n+2:4,' ', a:d+7:d);
  end;
3: writeln('reading dissipation');
  while true do begin
    readln(dat,i,a);
    if i < 0 then goto 4;
    if d < 0 then writeln(net, i:4, n+3:4, ' ', a)
      else writeln(net, i:4, n+3:4, ' ', a:d+7:d);
  end;
4: writeln('reading arcs');
  while true do begin
    readln(dat,i,j,a);
    if i < 0 then goto 5;
    if d < 0 then writeln(net, i:4, j:4, ' ', a)
      else writeln(net, i:4, j:4, ' ', a:d+7:d);
  end;
5:
  writeln(net);

  writeln(net,'*vector bio-masses / ', datname);
  writeln(net,'*vertices ',np);
  for i := 1 to np do
    if d < 0 then writeln(net,b[i]) else writeln(net,b[i]:d+7:d);
  writeln(net);

  CloseFile(dat); CloseFile(net);
  writeln('Scor2net finished');
  readln;
end.
