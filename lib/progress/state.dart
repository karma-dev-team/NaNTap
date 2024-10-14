import 'dart:ffi';

class GlobalState { 
  int level; 
  Long breadCount;
  
  GlobalState(this.level, this.breadCount); 
}