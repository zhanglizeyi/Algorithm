import java.util.*;

/*
input: a directed graph with n vertices 
output: a topological ordering v1,v2...

S  is an empty stack 

for each vertex u in G do 
	incount(u) = indeg(u)
	if incount(u) = 0 then
		S.push(u)

i=1
while S is non-empty do
	u = S.pop()
	set u as the i-th vertex vi
	i++
	for each vertex w forming the directed edge(u,w) do
		incount(w)--
		if(incount(w) == 0 )then 
			S.push(w)

if i != n + 1  
	return G has a dicycle

*/


public class topo{

}