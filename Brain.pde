class Brain{
  Node[][] nodes;
  float mutate;

  //add memory
  //add structure change/evolve
  
  //new random brain | input, <layers>, outputs
  Brain(int[] layers, float Mutate){
    mutate = Mutate;
    nodes = new Node[layers.length][];  //input, 2*process, output
    for(int x=0; x<nodes.length; x++){
      nodes[x] = new Node[layers[x]];
      for(int y=0; y<nodes[x].length; y++){
        if(x==0){nodes[x][y] = new Node();}
        else{nodes[x][y] = new Node(nodes[x-1], mutate);}
      }
    }
  }
  

  //brain made slightly altered of parent
  Brain(Brain parent){
    mutate = parent.mutate/2 + random(parent.mutate);
    nodes = new Node[parent.nodes.length][];
    //nodes altered version of parents
    for(int x=0; x<nodes.length; x++){
      nodes[x] = new Node[parent.nodes[x].length];
      for(int y=0; y<nodes[x].length; y++){
        if(x==0){nodes[x][y] = new Node();}
        else{nodes[x][y] = new Node(nodes[x-1],parent.nodes[x][y], mutate);}
      }
    }
  }

  //float output[] = process(float input[])
  float[] process(float[] in){
    //sense
    for(int i=0; i<in.length && i<nodes[0].length; i++){
      nodes[0][i].value = in[i];
    }
    //think
    for(int x=1; x<nodes.length; x++){
      boolean out = x==nodes.length-1 ? true : false;
      for(int y=0; y<nodes[x].length; y++){
        nodes[x][y].process(out);
      }
    }
    //act
    int outSize = nodes[nodes.length-1].length;
    float[] out = new float[outSize];
    for(int i=0; i<outSize; i++){
      out[i] = nodes[nodes.length-1][i].value;
    }
    return out;
  }
}
