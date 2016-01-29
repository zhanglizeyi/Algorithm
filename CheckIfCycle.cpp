#include <iostream>
#include <list>
#include <limits.h>

using namespace std;


//class for an undirected graph
class Graph{

	int V; //numbers of vertices
	list<int> *adj; //pointer to an array containing adjacency lists
	bool isCyclicUtil(int v, bool visited[], int parent);

public: 
	Graph(int v); //Constructor
	void addEdge(int v, int w); // add an edge to graph
	bool isCycl(); // return true if there is a cycle
};

Graph::Graph(int V){

	this->V = V;
	adj = new list<int>[V];
}

void Graph::addEdge(int v, int w){

	adj[v].push_back(w); // add w to v's list
	adj[w].push_back(v); // add v to w's list
}

bool Graph::isCyclicUtil(int v, bool visited[], int parent){
	//mark the current node as visited
	visited[v] = true;

	//recur for all the vertices adjacent to this vertex
	list<int>::iterator i;

	for( i= adj[v].begin(); i != adj[v].end(); i++){
		//if an adjacent is not visited, then recur for that adjacent
		if(!visited[*i]){
			if(isCyclicUtil(*i, visited, v)){
				return true;
			}
		}else if(*i != parent){
			return true;
		}
	}
	return false;
}

bool Graph::isCycl(){
	//mark all the vertices as not visited and not part of recursion
	//stack

	bool *visited = new bool[V];
	for(int i = 0; i < v; i++){
		visited[i] = false;
	}

	//call the recursive helper function to dectect cycle in different
	//Dfs

	for(int u = 0; u < V; u++){
		if(!visited[u]){
			if(isCyclicUtil(u,visited,-1))
				return true;
	return false;
		}
	}
}

