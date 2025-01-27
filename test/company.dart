import 'package:flutter_test/flutter_test.dart';
import 'package:progress/company.dart';

void main() {
  group('Company Tests', () {
    test('Company initializes correctly', () {
      final company = Company(name: 'Tech Inc', revenue: 1000);
      expect(company.name, equals('Tech Inc'));
      expect(company.revenue, equals(1000));
    });

    test('Revenue updates correctly', () {
      final company = Company(name: 'Tech Inc', revenue: 1000);
      company.updateRevenue(500);
      expect(company.revenue, equals(1500));
    });

    test('Company resets revenue correctly', () {
      final company = Company(name: 'Tech Inc', revenue: 1000);
      company.resetRevenue();
      expect(company.revenue, equals(0));
    });
  });
}
