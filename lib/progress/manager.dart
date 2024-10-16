import 'package:nantap/progress/interfaces.dart';
import 'package:nantap/progress/state.dart';

class ProgressManager implements AbstractProgressManager { 
  AbstractWallet wallet; 
  GlobalState state; 
  AbstractStorage storage; 

  ProgressManager(this.wallet, this.state, this.storage);
}