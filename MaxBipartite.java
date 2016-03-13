// A Java program to find maximal Bipartite matching.
import java.util.*;
import java.lang.*;
import java.io.*;
 
class MaxBipartite
{
    // public MaxBipartite(){
        // M is number of applicants and N is number of jobs
        private static final int  M = 5;
        private static final int  N = 5;
        private static boolean[] useif = new boolean[M];
        private static int[] linkYtoX  = new int[M];
    // }
    // Returns maximum number of matching from M to N
    public static boolean maxBPM(boolean[][] rGraph, int input){
        for(int i=0; i<N; i++){
            if((useif[i]==false) && (rGraph[input][i])){
                useif[i] = true;

                if(linkYtoX[i] == -1 || maxBPM(rGraph, linkYtoX[i])){
                    linkYtoX[i] = input;
                    return true;
                }
            }
        }
        return false;
    }
 
    // Driver method
    public static void main (String[] args) throws java.lang.Exception
    {
        // Let us create a bpGraph shown in the above example
        boolean bpGraph[][] = new boolean[][]{
            {true, true, false, false, false},
            {false, true, true, false, false},
            {false, false, true, true, false},
            {false, false, false, true, true},
            {true, false, false, false, false}};

        boolean inGraph[][] = new boolean[][]{
            {true,  false, false, false, true},
            {true,  true,  false, false, false},
            {false, true,  true,  false, false},
            {false, false, true,  true,  false},
            {false, false, false, true,  false}};

        for(int i=0; i<useif.length; i++){
            useif[i] = false;
        }
        for(int i=0; i<linkYtoX.length; i++){
            linkYtoX[i] = -1;
        }
        
        int num = 0;
        for(int i=0; i<M; i++){
            if(maxBPM(bpGraph,i)) num++;
        }

        System.out.println("the result will be here -> " + num);
    }
}