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
  Node(Node[] readNodes, Node parent, float mutate){
    this.init(readNodes, parent, mutate);
  }
  
  //new random node
  void init(Node[] readNodes, float mutate){
    read = readNodes;
    weights = new float[read.length];
    for(int i=0; i<read.length; i++){
      weights[i] = random(-mutate,mutate);
    }
    bias = random(-mutate,mutate);
  }
  
  //mutate child node
  void init(Node[] readNodes, Node parent, float mutate){
    this.init(readNodes,mutate);
    for(int i=0; i<read.length; i++){
      weights[i] += parent.weights[i];
    }
    bias += parent.bias;
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
