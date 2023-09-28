class Node{
  Node[] read; //list of nodes to read from if itself not input node
  float[] weights; //weights for nodes reading from
  float bias; //flat bias
  float value; //resultant output


  //input node
  Node(){
    read = null; weights = null; bias = 0;
    value = 0;
  }

  //process/output node
  Node(Node[] aboveLayer, float mutate){
    read = aboveLayer;
    weights = new float[read.length];
    for(int i=0; i<read.length; i++){
      weights[i] = random(-mutate,mutate);
    }
    bias = random(-mutate,mutate);
    value = 0;
  }
    
  //copy node
  Node(Node[] aboveLayer, Node parent, float mutate){
    read = aboveLayer;
    weights = new float[read.length];
    for(int i=0; i<read.length; i++){
      weights[i] += parent.weights[i] + random(-mutate,mutate);
    }
    bias = parent.bias + random(-mutate,mutate);
    value = 0;
  }
  
  
  void process(boolean out){
    value = bias;
    for(int i=0; i<read.length; i++){
      value+= read[i].value * weights[i];
    }
    //determine activation function
    //none, sigmoid, binary, etc?
    // externalise determination, all get sigmoid, then in brain RecU outputs
    if(out){value = 1 / (1 + exp(-value));}
    else{value = max(0,value);}
  }
}
