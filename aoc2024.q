
day1:{({sum abs(-). x};{sum x[0]*sum each x[0]=\: x 1})@\: asc each flip "J"$"   "vs/:read0 x}
/
day1 `:input1
2192892 22962826
\

day2:{
   f:{(all abs[v]within 1 3)&all 1_(=':) signum v:1_deltas x};
   /sum each (f each res;any each f@/:'{{x _y}[x] each til count x}each res:"J"$" "vs/:read0 x)
   sum each (f each res;any each f@/:'{x _/:til count x}each res:"J"$" "vs/:read0 x) / use /: instead of each
 }
/
day2 `:input2
524 569
\

day3:{
  r:raze read0 x;
  f:sum 0^(*)./: ("JJ";",")0:/: 1#'")"vs/:"mul(" vs;
  r1:(distinct 0,asc ss[r;"don't()"],ss[r;"do()"]) _r;
  raze (f r;f raze r1 where not r1 like "don't()*") 
 } 
/
day3 `:input3
174336360 88802350
\

day4:{[x]
  r:read0 x;
  i:count 1_s:"XMAS";
  m:(2*i)+n:count first r;
  /raze to one dimension and then use step p to match index in the order of s
  c:where each raze[w,/:r,\:w:i#"."]=/:s; /add 3 dummy margins to avoid looking across the first and last columns
  p:raze k,v,l:(k:-1 1)+/:\:v:-1 1*m;
  r1:sum 3=sum each(raze c[0]+\:p*\:1+til i ) in'\: 1_c;
  r2:sum sum 2=(sum'')(all'')(c[2]+\: k,reverse each k:(l;flip l))in'\:\: c[1 3]; /flip index to match all patterns
  (r1;r2)
 }
/
day4 `:input4
2397 1824
\

day5:{
  r:(0,where r like "")_r:read0 x;
  r1:group (!). reverse ("JJ";"|")0: r 0; /for each number, get all the numbers should be after it.
  r2:1_"J"$","vs/:r 1;
  n:count'[r2]div 2;
  r3:{x idesc sum each x in/: y x}[;r1] each r2; /for a given a list, get the count of numbers should be after each number and then sort the list
  (sum each group (./:[r3;(til count r3),'n])!r3~'r2) 10b
 }
/
day5 `:input5
6034 6305
\

day6:{
  m:2+n:count first res:read0 x;
  res1:raze "X",/:(r,res,r:enlist n#"X"),\:"X"; /add terminators and raze to 1 dimension;
  / get indexes of start, obstacles, and terminators
  s:where res1="^"; 
  o:where res1="#";  
  t:where res1="X";
  d:neg[m],1,m,-1; / step increments in the order of up, right, down, left
  / f create a list of index at each path til hit obstacles or terminators; 
  / return a three item list z:(i;t;p) where
  / i is the number of iteration, used determine direction "^>V<"
  / t is the list of constraints, o and t
  / p is the obstacles hits
  f:{i:x z[0]mod 4;c:{not x in raze y}[;y] (i+)/ last z 1;(1+z 0;z[1],c:$[c in y 0;neg[i]+c;c];z[2],c)};
  v:{not any x[1] in y}[;t] f[d;(o;t);]/ (0;s); /stop building path when hit terminators;
  p:v 1; / turning points
  a1:count p2:-1_distinct raze p1:{x,x+z*1+til (y-x) div z} .' (1_(prev p),'p),'-1_d (count v[1])#til 4; / only need to compare aginst the previous one to build the path
  g1:{[x;y;z;n]
     c:2_b:last a:(n+1)#z; /all possible new obstacle
     g:{[f;lst;num;ind;pa]
         a:pa ind+1;
         c:pa ind+2;
         {(not last[x[2]] in -1_x[2]) & (not last[x[2]] in -1_x[2]) & not any x[1] in y}[;c,(lst . 1 1)] f[lst 0;(c,lst . 1 0;lst . 1 1);]/ ((num+1) mod 4;(),a;(),c)
      }[x;y;n;;b];
     path:g each til count c;
     first'[path[;2]] where (last'[path[;1]] in' -1_'path[;1]) & (last'[path[;2]] in' -2_'path[;1]) & not last'[path[;2]] in y . 1 1
    }[f;(d;(o;t));p1;];
   a2:count distinct raze g1 each 1_til count p1; / add obstacles starting path 1
   (a1;a2)
 }
/
day6 `:input6
5305 2143
\

day7:{ 
   res:": " vs/:read0 x;
   a1:sum {("J"$x)*any value each x,/:"=",/:@[s;where s=" ";:;]each (cross/)(sum " "=s:" " sv reverse " " vs y)#enlist"+*"}./: res;
   s:{v:@[y;where y=" ";:;]each (cross/)(sum" "=y)#enlist"+*|";enlist[x],v @/: where v like\: "*|*"}./: res;
   f:{({(string[value[x]],y) except "|"}/) {v:asc 0,raze ss[x;] each "*|+";v _x} x}; /break strings at "|+*"; value and then join strings while ignore |
   a1+ 0,sum {("J"$x[0])* any value each x[0],/:"=",/:y each 1_x}[;f] each s
 }
/
running slow, to be optimized
day7 `:input7
5030892084481 91377448644679j
\

day8:{
  res:read0 x;
  a:distinct (res1:raze res) except ".";
  b:(c:count first res) vs til count res1;
  f1:{(x+d;y-d:x-y)};f2:{(x+/:reverse d),y-/:d:z*\:x-y}[;;til count res1];
  a1:count distinct raze {[x;y;z;f]j:flip h:distinct 0N 2#(raze/)e f/:\:e:flip x[;y];(h where all j within z)except e}[b;;(0;-1+c);f1]each where each res1=/:a;
  a2:count distinct raze {[x;y;z;f]j:flip h:distinct 0N 2#(raze/)e f/:\:e:flip x[;y];h where all j within z}[b;;(0;-1+c);f2]each where each res1=/:a;
  (a1;a2)
 }
/
day8 `:input8
400 1280
\

day9:{
  res:raze read0 x;
  idl:"J"$id:1#'0N 2#res; /files length
  idn:idl#'n:til count id; /files id
  fs:0^"J"$1_'0N 2#res; / free space length
  /replace with tokens so double digits could fit in one place holder
  ids:idl#'"#";
  fss:fs#'"*";
  fs1:raze ids,'fss;
  fsb:count[raze idn]#fs1;
  fsbn:sum fsb="*";
  d1:fsbn#reverse raze idn;
  m1:where fsb="*";
  m2:where fsb="#";
  a1:sum raze (d1*m1),(count[m2]#raze idn)*m2;
  / part2, iteration
  / move rightmost "#" to fill in leftmost "*" in whole til no more "*" with size larger than any "#" on its right
  f:{b:x[0]=a:"*";g:sum each e:(d:where differ b)_ b;h:first where z<=g;
      j:x[2] i:where x[1]=y;
      k:(d h)+til z;
      $[(any k>j)| null h;x; 
        ("#*"@[b;k,j;:;raze z#/:01b];raze idn;@[x 2;i;:;k])
       ]
     };
   a2:sum prd 1_f/[(fs1;raze idn;where fs1="#");reverse 1_n;reverse 1_idl];
   (a1;a2)
 }
/
day9 `:input9
6399153661894 6421724645083
\

/day 10
day10:{
   n:count res:read0 x;
   res1:raze ".",/:(r,res,r:enlist n#"."),\:".";
   l:ss[res1;] each string til 10;
   s:neg[n+2],1,-1,n+2;
   f:{b:(a:last'[x 2])+\:x[0];j:distinct raze (x[2],/:'b @' where each c)where any each c:b in x . 1,y+1;(-1_x),enlist j };
   a:(f/ [(s;l;l 0);-1_til 10]) 2;
   count each distinct each ((last;first)@\:/:;::)@\:a
 }
/
day10 `:input10
550 1255
\

day11:{ 
  r:"J"$" "vs raze read0 x;
  / f:{v:count each group x;n:(2024*;{"J"$2 0N#string x};{1})./: flip (2^mod [floor {10 xlog x}key v;2];key[v]);raze raze value[v]#'enlist each n};
  / g:{count raze x y/ z}[;f;r];
  / rewrote based on https://github.com/sean185/aoc/blob/main/2024/d11.q, original function is running slow
  f1:{raze (2024*;{"J"$2 0N#string x};{1}). (2^mod [floor {10 xlog x}x;2];x)};
  g1:{select sum c by v from ungroup update x each v from y}[f1;];
  sum y g1/ ([]v:r;c:1)
 }

/
 exec c from day11[`:input11] each 25 75
203609 240954878211138
\
