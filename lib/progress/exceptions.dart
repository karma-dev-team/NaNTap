class FailedToReturnFromLocalData implements Exception { 
  String failedKey; 
  String msg; 

  FailedToReturnFromLocalData(this.failedKey, this.msg); 
}