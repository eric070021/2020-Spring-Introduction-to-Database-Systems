#ifndef INDEX_H_
#define INDEX_H_

#include <stack>
#include <vector>

using namespace std;

// BP node
struct Node {
	bool IS_LEAF;
    int size;
	int *key;
     union{
        int *value;
        Node **child;
    };
    Node *neighbor;
};

// BP tree
class BPTree {
	Node* root;
    void insertInternal(int,  stack<Node*>&, Node*);
    static Node* binaryChildSearch(Node*, int, int, int);
    static int binaryInSearch(Node*, int, int, int);
public:
	BPTree();
	int key_query(int);
    int range_query(int, int);
	void insert(int, int);
	void display();
    void clear_index();
};

class Index {
public:
    BPTree tree;
	Index(int, vector<int>&, vector<int>&);
	void key_query(vector<int> &);
    void range_query(vector<pair<int, int>>&);
    void clear_index();
};

#endif