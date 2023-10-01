class Brain{
  Node[] input;
  Node[] output;
  Node[] process; // process is a single array so it can be more dynamically altered, no strict layer structure
  Node[] memory;
  int px, py;
  
  
  //new random brain | input, process-x, process-y, output, memory, mutate
  Brain(int in, int Px, int Py, int out, int mem, float mutate){
    px = Px; py = Py;
    
    //memory
    memory = new Node[mem];
    for(int i=0; i<memory.length; i++){
      memory[i] = new Node();
    }
    
    //input
    input = new Node[in];
    for(int i=0; i<input.length; i++){
      input[i] = new Node();
    }
    
    // although process is dynamic single array, initial brains are set up like simple layered NN and evolve from there
    process = new Node[px*py];
    //first
    for(int y=0; y<py; y++){
      process[y] = new Node(merge(input,memory), mutate);
    }
    //rest
    for(int x=1; x<px; x++){
      for(int y=0; y<py; y++){
        process[x*py+y] = new Node(slice(process,(x-1)*py,py), mutate);
      }
    }
    
    //output
    output = new Node[out];
    for(int i=0; i<output.length; i++){
      output[i] = new Node(slice(process,(px-1)*py,py), mutate);
    }
    
    //memory reads final process layer
    for(int i=0; i<memory.length; i++){
      memory[i].init(slice(process,(px-1)*py,py), mutate);
    }
  }
  
  
  //inherit and mutate | parent
  Brain(Brain parent, float mutate){
    px = parent.px; py = parent.py;
    
    //memory
    memory = new Node[parent.memory.length];
    for(int i=0; i<memory.length; i++){
      memory[i] = new Node();
    }
    
    //input
    input = new Node[parent.input.length];
    for(int i=0; i<input.length; i++){
      input[i] = new Node();
    }
    
    //process
    process = new Node[parent.process.length];
    //first
    for(int y=0; y<py; y++){
      process[y] = new Node(merge(input,memory), parent.process[y], mutate);
    }
    //rest
    for(int x=1; x<px; x++){
      for(int y=0; y<py; y++){
        process[x*py+y] = new Node(slice(process,(x-1)*py,py), parent.process[y], mutate);
      }
    }
    
    //output
    output = new Node[parent.output.length];
    for(int i=0; i<output.length; i++){
      output[i] = new Node(slice(process,(px-1)*py,py), parent.process[i], mutate);
    }
    
    //memory reads final process layer
    for(int i=0; i<memory.length; i++){
      memory[i].init(slice(process,(px-1)*py,py), parent.process[i], mutate);
    }
  }


  //float output[] = process(float input[])
  float[] process(float[] in){
    // feed inputs in
    for(int i=0; i<in.length; i++){
      input[i].value = in[i];
    }
    
    // process all inner nodes
    for(Node P : process){
      P.process(false);
    }
    // process memory
    for(Node M : memory){
      M.process(false);
    }
    
    // sigmoid and return output
    float[] out = new float[output.length];
    for(int i=0; i<out.length; i++){
      output[i].process(true);
      out[i] = output[i].value;
    }
    return out;
  }
}


// return section of array from point x of size y
Node[] slice(Node[] array, int x, int y){
  Node[] slice = new Node[y];
  for(int i=0; i<y; i++){
    slice[i] = array[x+i];    
  }
  return slice;
}


// join two arrays together, concat a+b
Node[] merge(Node[] a, Node[] b){
  Node[] c = new Node[a.length+b.length];
  for(int i=0; i<a.length; i++){
    c[i] = a[i];
  }
  for(int i=0; i<b.length; i++){
    c[a.length+i] = b[i];
  }
  return c;
}



// ARCHIVE
// unused and broken code that i plan to fix later

////inherit and mutate | parent
//Brain(Brain parent, float mutate){  //ERROR here i think
//  //memory
//  memory = new Node[parent.memory.length];
//  for(int i=0; i<memory.length; i++){
//    memory[i] = new Node();
//  }    

//  //input
//  input = new Node[parent.input.length];
//  for(int i=0; i<input.length; i++){
//    input[i] = new Node();
//  }
  
//  //I input
//  //P process
//  //O output
//  //M memory
  
//  //up = IMP
//  //dn = POM
  
//  //for P/O/M n in child & mirror p of parent:
//  //  loop all I/M/P m of child and q of parent:
//  //    if q in p.read:
//  //      n.read add m
  
//  //refactor following into function, repeated code
  
//  //process
//  process = new Node[parent.process.length];
//  for(int n=0; n<process.length; n++){
//    Node[] read = new Node[parent.process[n].read.length];
//    int j = 0;
    
//    //check input layer
//    for(int m=0; m<input.length && j!=read.length; m++){
//      for(int k=0; k<parent.process[n].read.length; k++){
//        if(parent.input[m] == parent.process[n].read[k]){
//          read[j] = input[m];
//          j++;
//          break; //once match found, stop looking
//        }
//      }
//    }

//    //check memory layer
//    for(int m=0; m<memory.length && j!=read.length; m++){
//      for(int k=0; k<parent.process[n].read.length; k++){
//        if(parent.memory[m] == parent.process[n].read[k]){
//          read[j] = memory[m];
//          j++;
//          break; //once match found, stop looking
//        }
//      }
//    }

//    //check process layer
//    for(int m=0; m<process.length && j!=read.length; m++){
//      for(int k=0; k<parent.process[n].read.length; k++){
//        if(parent.process[m] == parent.process[n].read[k]){
//          read[j] = process[m];
//          j++;
//          break; //once match found, stop looking
//        }
//      }
//    }
    
//    //create new process node with all mirrored connections
//    process[n] = new Node(read,parent.process[n],mutate);
//  }
//  //end process
  
//  //output
//  output = new Node[parent.output.length];
//  for(int n=0; n<output.length; n++){
//    Node[] read = new Node[parent.output[n].read.length];
//    int j = 0;
    
//    //check input layer
//    for(int m=0; m<input.length && j!=read.length; m++){
//      for(int k=0; k<parent.output[n].read.length; k++){
//        if(parent.input[m] == parent.output[n].read[k]){
//          read[j] = input[m];
//          j++;
//          break;
//        }
//      }
//    }

//    //check memory layer
//    for(int m=0; m<memory.length && j!=read.length; m++){
//      for(int k=0; k<parent.output[n].read.length; k++){
//        if(parent.memory[m] == parent.output[n].read[k]){
//          read[j] = memory[m];
//          j++;
//          break;
//        }
//      }
//    }

//    //check process layer
//    for(int m=0; m<process.length && j!=read.length; m++){
//      for(int k=0; k<parent.output[n].read.length; k++){
//        if(parent.process[m] == parent.output[n].read[k]){
//          read[j] = process[m];
//          j++;
//          break;
//        }
//      }
//    }
    
//    //create new output node with all mirrored connections
//    output[n] = new Node(read,parent.output[n],mutate);
//  }
//  //end output
  
//  //memory
//  //already init above
//  for(int n=0; n<memory.length; n++){
//    Node[] read = new Node[parent.memory[n].read.length];
//    int j = 0;
    
//    //check input layer
//    for(int m=0; m<input.length && j!=read.length; m++){
//      for(int k=0; k<parent.memory[n].read.length; k++){
//        if(parent.input[m] == parent.memory[n].read[k]){
//          read[j] = input[m];
//          j++;
//          break;
//        }
//      }
//    }

//    //check memory layer
//    for(int m=0; m<memory.length && j!=read.length; m++){
//      for(int k=0; k<parent.memory[n].read.length; k++){
//        if(parent.memory[m] == parent.memory[n].read[k]){
//          read[j] = memory[m];
//          j++;
//          break;
//        }
//      }
//    }

//    //check process layer
//    for(int m=0; m<process.length && j!=read.length; m++){
//      for(int k=0; k<parent.memory[n].read.length; k++){
//        if(parent.process[m] == parent.memory[n].read[k]){
//          read[j] = process[m];
//          j++;
//          break;
//        }
//      }
//    }
    
//    //initialize memory node with all mirrored connections
//    memory[n].init(read,parent.memory[n],mutate);
//  }
//  //end memory

//  //this.prune();
//}

// prune dead connections and nodes
void prune(){
  // loop all nodes
    // any connections < m get removed
    // any connections to nodes flagged for death get removed
    // if no connections left, flag for death
  // remove dead nodes
  // loop all nodes in reverse
    // kill node if not marked
    // mark nodes they point to    
}
