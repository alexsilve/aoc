
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
