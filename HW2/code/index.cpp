// C++ program for implementing B+ Tree
#include <fstream>
#include <iostream>
#include <stack>
#include <vector>
#include <math.h>
#include <queue>
#include "index.h"

using namespace std;
int LeafOrder = 310;
int InternalOrder = 1000;

// Initialise the BPTree Node
BPTree::BPTree()
{
	root = NULL;
}

Node* BPTree::binaryChildSearch(Node * cursor, int l, int r, int target){

    if (target >= cursor->key[cursor->size - 1]) {
        return cursor->child[cursor->size];
    }

    while (l != r) {
      int mid = (l + r) / 2;
      if (target >= cursor->key[mid]) {
        l = mid + 1;
      } 
      else {
        r = mid;
      }
    }
    
    return cursor->child[l];
}

int BPTree::binaryInSearch(Node * cursor, int l, int r, int target){

    if (target > cursor->key[cursor->size - 1]) {
        return cursor->size;
    }

    while (l != r) {
      int mid = (l + r) / 2;
      if (target > cursor->key[mid]) {
        l = mid + 1;
      } 
      else {
        r = mid;
      }
    }
    
    return l;
}

// Function to find any element
// in B+ Tree
int BPTree::key_query(int x)
{
    Node* cursor = root;

    // Till we reach leaf node
    while (cursor->IS_LEAF == false) {
        cursor = binaryChildSearch(cursor, 0, cursor->size - 1, x);     
    }

    int s = 0, e = cursor->size - 1;
    while (s != e) {
      int mid = (s + e) / 2;
     
      if (x > cursor->key[mid]) {
        s = mid + 1;
      } else {
        e = mid;
      }
    }

    if (cursor->key[s] == x){
        return cursor->value[s];
    }
    else{ 
        return -1;
    }
}

int BPTree::range_query(int start, int end)
{
    Node* cursor = root;

    // Till we reach leaf node
    while (cursor->IS_LEAF == false) {
        cursor = binaryChildSearch(cursor, 0, cursor->size - 1, start);
    }
	
    int s = 0, e = cursor->size - 1;
    while (s != e) {
      int mid = (s + e) / 2;
      if (start > cursor->key[mid]) {
        s = mid + 1;
      } else {
        e = mid;
      }
    }

    if (start > cursor->key[s]) {
      if (cursor->neighbor) {
        cursor = cursor->neighbor;
        s = 0;
      } 
      else {
        return -1;
      }
    }

    int max_value = -1;
    while(cursor->key[s] <= end){

        max_value = max(max_value, cursor->value[s++]);
        if(s == cursor->size){
            if(!cursor->neighbor) break;
            cursor = cursor->neighbor;
            s = 0;
        }
    }
    return max_value;
}

// Function to implement the Insert
// Operation in B+ Tree
void BPTree::insert(int x, int y)
{

	// If root is null then return
	// newly created node
	if (root == NULL) {
		root = new Node;
        root->key = new int[LeafOrder -1];
        root->value = new int[LeafOrder - 1];
        root->value[0] = y;
		root->key[0] = x;
		root->IS_LEAF = true;
        root->neighbor = NULL;
		root->size = 1;
	}

	// Traverse the B+ Tree
	else {
		Node* cursor = root;
		stack<Node*> parent;

		// Till cursor reaches the
		// leaf node
		while (cursor->IS_LEAF == false) {

			parent.push(cursor);
            cursor = binaryChildSearch(cursor, 0, cursor->size - 1, x);
		}

		if (cursor->size < LeafOrder - 1) {
		
            int in = binaryInSearch(cursor, 0, cursor->size - 1, x);

			for (int j = cursor->size; j > in; j--) {
				cursor->key[j] = cursor->key[j - 1];
                cursor->value[j] = cursor->value[j - 1];
			}

			cursor->key[in] = x;
            cursor->value[in] = y;
			cursor->size++;
		}

		else {
			// Create a newLeaf node
			Node* newLeaf = new Node;
            newLeaf->key = new int[LeafOrder - 1];
            newLeaf->value = new int[LeafOrder - 1];
            newLeaf->size = LeafOrder - ceil(((double)(LeafOrder-1))/2);
            newLeaf->IS_LEAF = true;
            newLeaf->neighbor = cursor->neighbor;

            
			// Traverse to find where the new
			// node is to be inserted
        
            int in = binaryInSearch(cursor, 0, LeafOrder - 2, x);

            cursor->neighbor = newLeaf;
            cursor->size = ceil(((double)(LeafOrder-1))/2);

            int cut = cursor->size;
            
            if(in >= cut){
                // filling the newLeaf node
                int i, j;
                for (i = 0, j = cut; j < in; i++, j++) {
				    newLeaf->key[i] = cursor->key[j];
                    newLeaf->value[i]= cursor->value[j];
                }
                newLeaf->key[i]= x;
                newLeaf->value[i]= y;
                i++;
                for (j = in; j < (LeafOrder - 1); i++, j++) {
				    newLeaf->key[i] = cursor->key[j];
                    newLeaf->value[i]= cursor->value[j];
                }

            }

            else{
                // filling the newLeaf node
                int i, j;
                for (i = 0, j = cut - 1; j < (LeafOrder - 1); i++, j++) {
				    newLeaf->key[i] = cursor->key[j];
                    newLeaf->value[i]= cursor->value[j];
                }

                // filling cursor node
                for (int j = LeafOrder - 2; j > in; j--) {
                    cursor->key[j] = cursor->key[j - 1];
                    cursor->value[j] = cursor->value[j - 1];
                }

                cursor->key[in]= x;
                cursor->value[in]= y;
            }

			// If cursor is the root node
			if (cursor == root) {

				// Create a new Node
				Node* newRoot = new Node;
                newRoot->key = new int[InternalOrder - 1];
                newRoot->child = new Node*[InternalOrder];

				// Update rest field of
				// B+ Tree Node
				newRoot->key[0] = newLeaf->key[0];
				newRoot->child[0] = cursor;
				newRoot->child[1] = newLeaf;
				newRoot->IS_LEAF = false;
                newRoot->neighbor = NULL;
				newRoot->size = 1;
				root = newRoot;
			}
			else {
				insertInternal(newLeaf->key[0], parent, newLeaf);
			}
		}
	}
}

void BPTree::insertInternal(int x,  stack<Node*> &parent, Node* child_node)
{
    Node *cursor = parent.top();
    parent.pop();

    // If we doesn't have overflow
    if (cursor->size < InternalOrder - 1) {
        int in = binaryInSearch(cursor, 0, cursor->size - 1, x);

        for (int j = cursor->size; j > in; j--) {
            cursor->key[j] = cursor->key[j - 1];
            cursor->child[j + 1] = cursor->child[j];
        }

        cursor->key[in] = x;
        cursor->child[in + 1] = child_node;
        cursor->size++;
    }
  
    // For overflow, break the node
    else {
        // For new Interval
        Node* newInternal = new Node;
        newInternal->key = new int[InternalOrder - 1];
        newInternal->child = new Node*[InternalOrder];
        newInternal->IS_LEAF = false;
        newInternal->neighbor = NULL;
        newInternal->size = InternalOrder - ceil(((float)InternalOrder / 2));

        // Traverse to find where the new
        // node is to be inserted
        int in = binaryInSearch(cursor, 0, InternalOrder - 2, x);
        cursor->size = ceil(((float)InternalOrder / 2)) - 1;

        // start to fill internal node
        int return_key;
        int cut = cursor->size;
    
        if(in == cut){
            return_key = x;

            // fill newInternal node
            newInternal->child[0] = child_node;
            int i, j;
            for(i = 0, j = cut; j < (InternalOrder - 1); i++, j++){
                newInternal->key[i] = cursor->key[j];
                newInternal->child[i + 1] = cursor->child[j + 1];
            }
        }

        else if(in > cut){
            return_key = cursor->key[cut];
            
            // fill newInternal node
            newInternal->child[0] = cursor->child[cut + 1];
            int i, j;
            for(i = 0, j = cut + 1; j < in; i++, j++){
                newInternal->key[i] = cursor->key[j];
                newInternal->child[i + 1] = cursor->child[j + 1];
            }

            newInternal->key[i] = x;
            newInternal->child[i + 1] = child_node;
            i++;

            for(j = in; j < (InternalOrder - 1); i++, j++){
                newInternal->key[i] = cursor->key[j];
                newInternal->child[i + 1] = cursor->child[j + 1];
            }
        }

        else{
            return_key = cursor->key[cut - 1];
            
            // fill intetnal node
            int i, j;
            for(i = 0, j = cut; j < (InternalOrder - 1); i++, j++){
                newInternal->key[i] = cursor->key[j];
                newInternal->child[i] = cursor->child[j];
            }
            newInternal->child[i] = cursor->child[InternalOrder - 1];

            // filling cursor node
            for (int j = InternalOrder - 2; j > in; j--) {
                cursor->key[j] = cursor->key[j - 1];
                cursor->child[j + 1] = cursor->child[j];
            }

            cursor->key[in] = x;
            cursor->child[in + 1] = child_node;
        }
  
        // If cursor is the root node
        if (cursor == root) {
            // Create a new root node
            Node* newRoot = new Node;
            newRoot->key = new int[InternalOrder - 1];
            newRoot->child = new Node*[InternalOrder];
  
            // Update key value
            newRoot->key[0] = return_key;

            // Update rest field of
            // B+ Tree Node
            newRoot->child[0] = cursor;
            newRoot->child[1] = newInternal;
            newRoot->IS_LEAF = false;
            newRoot->neighbor = NULL;
            newRoot->size = 1;
            root = newRoot;
        }
        else {
            insertInternal(return_key, parent, newInternal);
        }
    }
}

void BPTree::display(){
    Node* cursor = root;
    queue<Node*> q;
    q.push(cursor);
    while(!q.empty()){
        cursor = q.front();
    
        for (int i = 0; i < cursor->size; i++) {
            cout<<cursor->key[i]<< " ";
        }
        cout<<endl;
        if(!cursor->IS_LEAF){
            for(int j = 0; j <= cursor->size; j++){
                q.push(cursor->child[j]);
            }
        }
        q.pop();
    }
}

void BPTree::clear_index(){
    Node* cursor = root;
    queue<Node*> q;
    q.push(cursor);
    while(!q.empty()){
        cursor = q.front();

        if(!cursor->IS_LEAF){
            for(int j = 0; j <= cursor->size; j++){
                q.push(cursor->child[j]);
            }
            delete []  cursor->key;
            delete []  cursor->child;
        }
        else{
            delete []  cursor->key;
            delete []  cursor->value;
        }
        
        delete cursor;
        q.pop();
    }
}

Index::Index(int num_rows, vector<int> &key, vector<int> &value){
    for(int i=0; i < num_rows; i++){
        tree.insert(key[i], value[i]);
    }
}

void Index::key_query(vector<int> &query_keys){
    fstream out;
    out.open("key_query_out.txt", ios::out | ios::trunc);
    for(int i = 0; i < query_keys.size(); i++){
        out<<tree.key_query(query_keys[i])<<'\n';
    }
    out.close();
}

void Index::range_query(vector<pair<int, int>> &query_pairs){
    fstream out;
    out.open("range_query_out.txt", ios::out | ios::trunc);
    for(int i = 0; i < query_pairs.size(); i++){
        out<<tree.range_query(query_pairs[i].first, query_pairs[i].second)<<'\n';
    }
    out.close();
}

void Index::clear_index(){
    tree.clear_index();
}