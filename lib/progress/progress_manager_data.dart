import 'package:nantap/progress/company.dart';
import 'package:nantap/progress/interfaces.dart';

void setupCompaniesData(AbstractProgressManager progressManager ) { 
  progressManager.getState().companies.addAll([Company("Филиал в японии", [], []), Company("Филиал в казахстане", [], [])]); 
}