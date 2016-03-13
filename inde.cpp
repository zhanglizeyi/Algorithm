
#include <iostream>  
using namespace std;  
  
struct Node{  
        int value;  
        int is_LISS; // used in the dynamic programming version  
                     // the size of LIS when this is a member of the LIS  
        int not_LISS; // used in the dynamic programming version  
                     // the size of LIS when this is not a member of the LIS  
        Node* lchild;  
        Node* rchild;  
        Node(int val, int is_, int not_, Node* lch, Node* rch):  
                value(val), is_LISS(is_), not_LISS(not_),  
                lchild(lch), rchild(rch) {}       
};  
  
int is_LISS(Node* root); // return the size of LIS when root is a member of the LIS  
int not_LISS(Node* root); // return the size of LIS when root is not a member of the LIS  
  
int is_LISS(Node* root)  
{  
        if(root==NULL)  
                return 0;  
        else  
                cout<< "is liss -> " << 1 + not_LISS(root->lchild) + not_LISS(root->rchild)<<endl;                           
                return 1 + not_LISS(root->lchild) + not_LISS(root->rchild);  
}  
  
int not_LISS(Node* root)  
{  
        if(root==NULL)  
                return 0;  
        else  
            cout<< "not liss" << max(is_LISS(root->lchild), not_LISS(root->lchild)) <<endl;
                cout<< "not liss" << max(is_LISS(root->rchild), not_LISS(root->rchild)) <<endl;
                return max(is_LISS(root->lchild), not_LISS(root->lchild)) +  
                max(is_LISS(root->rchild), not_LISS(root->rchild));  
}  
  
// return the size of LIS of the tree rooted at root  
int LISS(Node* root)  
{  
        return max(is_LISS(root), not_LISS(root));  
}  
  
int main(int argc, char** argv)  
{  
        Node* n70 = new Node(70,-1,-1,NULL,NULL);  
        Node* n80 = new Node(80,-1,-1,NULL,NULL);  
        Node* n50 = new Node(50,-1,-1,n70,n80);  
        Node* n40 = new Node(40,-1,-1,NULL,NULL);  
        Node* n20 = new Node(20,-1,-1,n40,n50);  
        Node* n60 = new Node(60,-1,-1,NULL,NULL);  
        Node* n30 = new Node(30,-1,-1,NULL,n60);  
        Node* n10 = new Node(10,-1,-1,n20,n30);  
  
        cout<< LISS(n10) <<endl;  
} 