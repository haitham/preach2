#include <vector>
#include <bitset>
#include <iostream>

#include <lemon/list_graph.h>
#include <lemon/bfs.h>

#include <fstream>
#include <map>
#include <ctime>
#include <sys/time.h>

#include <sys/time.h> // for gettimeofday
#include <stdlib.h> // drand48

#include "Stl.h"

#define MAX_NODES 512
#define MAX_EDGES 2048

using namespace std;

typedef bitset<MAX_NODES> Nodes_T;
typedef bitset<MAX_EDGES> Edges_T;
typedef vector<Edges_T> EdgesSet;

// macro to smoth up the use of bitsets
#define FOREACH_BS(v, vSet)	  \
	for (size_t v=vSet._Find_first(); v!=vSet.size(); v=vSet._Find_next(v))

/*A class modeling a vertex cut*/
class Cut{
    Nodes_T middle; // The nodes in the
    Nodes_T left; // Set of nodes on the left
    Nodes_T right; // Set of nodes on the right

public:
    // consturctor for a specified cut
	Cut(Nodes_T& _left, Nodes_T& _middle, Nodes_T& _right):
		left(_left), middle(_middle), right(_right){}

    Nodes_T& getMiddle(){return middle;}
    Nodes_T& getRight(){return right;}
    Nodes_T& getLeft(){return left;}
};

