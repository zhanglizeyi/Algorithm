import java.util.PriorityQueue;
import java.util.List;
import java.util.ArrayList;
import java.util.Collections;


class Vertex implements Comparable<Vertex>{
	public final String name;
	public Edge[] adj;
	public double minDistance = Double.POSITIVE_INFINITY;
	public Vertex previous;
	public Vertex(String argName){ name = argName;}
	public String toString(){return name;}
	public int compareTo(Vertex other){
		return Double.compare(minDistance, other.minDistance);
	}
}


public class Dijkstra implements Comparable<Vertex>{
	public static void computePaths(Vertex source){
		
	}
}