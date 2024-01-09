
(\ (z)
{
	z |> print ();
	##        a     b      c     d
	##    <int> <int> <char> <int>
	## 1:     1     5     aa     6
	## 2:     2     6     bb     7
	## 3:     3     7     cc     8
	## 4:     4     8     dd     9
	
	z[, mget(c('a','b','d'))] |> print ();
	##        a     b     d
	##    <int> <int> <int>
	## 1:     1     5     6
	## 2:     2     6     7
	## 3:     3     7     8
	## 4:     4     8     9
	
	z[, mget(c('a','b','d','c'))] |> print ();
	##        a     b     d      c
	##    <int> <int> <int> <char>
	## 1:     1     5     6     aa
	## 2:     2     6     7     bb
	## 3:     3     7     8     cc
	## 4:     4     8     9     dd
	
	z[, list(a,c,d,c)] |> print ();
	##        a      c     d      c
	##    <int> <char> <int> <char>
	## 1:     1     aa     6     aa
	## 2:     2     bb     7     bb
	## 3:     3     cc     8     cc
	## 4:     4     dd     9     dd
	
	z[, c(mget(c('a','c')), list(d,c))] |> print ();
	##        a      c    V3     V4
	##    <int> <char> <int> <char>
	## 1:     1     aa     6     aa
	## 2:     2     bb     7     bb
	## 3:     3     cc     8     cc
	## 4:     4     dd     9     dd
	
	z[, c(mget(c('a','c')), x = list(d,c))] |> print ();
	##        a      c    x1     x2
	##    <int> <char> <int> <char>
	## 1:     1     aa     6     aa
	## 2:     2     bb     7     bb
	## 3:     3     cc     8     cc
	## 4:     4     dd     9     dd
	
	z[, c(mget(c('a','c')), d,c)] |> print ();
	##        a      c    V3    V4    V5    V6     V7     V8     V9    V10
	##    <int> <char> <int> <int> <int> <int> <char> <char> <char> <char>
	## 1:     1     aa     6     7     8     9     aa     bb     cc     dd
	## 2:     2     bb     6     7     8     9     aa     bb     cc     dd
	## 3:     3     cc     6     7     8     9     aa     bb     cc     dd
	## 4:     4     dd     6     7     8     9     aa     bb     cc     dd
	
	z[, c(mget(c('a','c')), list(d),list(c))] |> print ();
	##        a      c    V3     V4
	##    <int> <char> <int> <char>
	## 1:     1     aa     6     aa
	## 2:     2     bb     7     bb
	## 3:     3     cc     8     cc
	## 4:     4     dd     9     dd
	
	z[, c(mget(c('a','c')), d = list(d), c = list(c))] |> print ();
	##        a      c     d      c
	##    <int> <char> <int> <char>
	## 1:     1     aa     6     aa
	## 2:     2     bb     7     bb
	## 3:     3     cc     8     cc
	## 4:     4     dd     9     dd
	
	z[, list(mget(c('a','c')), d, c)] |> print ();
	##             V1     d      c
	##         <list> <int> <char>
	## 1:     1,2,3,4     6     aa
	## 2: aa,bb,cc,dd     7     bb
	## 3:     1,2,3,4     8     cc
	## 4: aa,bb,cc,dd     9     dd
	
}) (z = 
data.table::data.table(
	a = 1:4
	, b = 5:8
	, c = c('aa','bb','cc','dd')
	, d = 6:9))



