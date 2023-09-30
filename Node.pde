class Node{
  Node[] read; //list of nodes to read from if itself not input node
  float[] weights; //weights for nodes reading from
  float bias; //flat bias
  float value; //resultant output
  
  //input/memory
  Node(){}

  //process/output node
  Node(Node[] readNodes, float mutate){
    this.init(readNodes, mutate);
  }
  
  //set up node. separated from obj creation because of memory nodes. also allows ressetting without creating new
  void init(Node[] readNodes, float mutate){
    read = readNodes;
    weights = new float[read.length];
    for(int i=0; i<read.length; i++){
      weights[i] = random(-mutate,mutate);
    }
    bias = random(-mutate,mutate);
  }

  //copy node
  Node(Node[] readNodes, Node parent, float mutate){
    read = readNodes;
    weights = new float[read.length];
    for(int i=0; i<read.length; i++){
      weights[i] = parent.weights[i] + random(-mutate,mutate);
    }
    bias = parent.bias + random(-mutate,mutate);
  }
  
  void process(boolean sigmoid){
    value = bias;
    for(int i=0; i<read.length; i++){
      value+= read[i].value * weights[i];
    }
    if(sigmoid){value = 1 / (1 + exp(-value));}
    else{value = max(0,value);}
  }
}
