
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
  r1:(distinct 0,asc ss[r;v:"don't()"],ss[r;"do()"]) _r;
  raze (f r;f raze r1 where not r1 like "don't()*") 
 } 
/
day3 `:input3
174336360 88802350
\
