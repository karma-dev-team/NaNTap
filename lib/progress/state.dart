import 'package:nantap/progress/company.dart';
import 'package:nantap/progress/interfaces.dart';
import 'package:nantap/progress/upgrade.dart';

class GlobalState implements AbstractWallet {
  int level;
  String userId; // User ID for Firestore integration
  double breadCount;
  double tapStrength = 0;
  int lvlPrice = 100;
  double bufferBread = 0; // Used as a buffer for jumping between levels on the home page, nothing more.
  List<Upgrade> upgrades;
  List<Company> companies;
  List<String> achievements;

  GlobalState(
    this.level,
    this.breadCount,
    this.upgrades,
    this.companies,
    this.achievements,
    this.userId, // Include userId in the constructor
  );

  double getAmount() {
    return breadCount;
  }

  String getAmountShortened() {
    return humanize(breadCount);
  }

  String getBufferAmountShortened() {
    return humanize(bufferBread);
  }

  String humanize(double breadCount) {
    if (breadCount > 1000 && breadCount < 1000000) {
      return "$breadCount тыс.";
    }
    if (breadCount > 1000000) {
      return "$breadCount млн.";
    } else {
      return "$breadCount";
    }
  }

  bool increase(double amount) {
    breadCount += amount;
    return true;
  }

  bool decrease(double amount) {
    if (breadCount < amount) {
      return false;
    }

    breadCount -= amount;
    return true;
  }

  // Factory constructor to create an instance from JSON
  factory GlobalState.fromJson(Map<String, dynamic> json) {
    // Parsing upgrades from JSON
    var upgradesFromJson = json['upgrades'] as List<dynamic>;
    List<Upgrade> upgrades =
        upgradesFromJson.map((upgradeJson) => Upgrade.fromJson(upgradeJson)).toList();

    // Parsing companies from JSON
    var companiesFromJson = json['companies'] as List<dynamic>;
    List<Company> companies =
        companiesFromJson.map((companyJson) => Company.fromJson(companyJson)).toList();

    // Parsing achievements from JSON
    List<String> achievements = List<String>.from(json['achievements'] ?? []);

    return GlobalState(
      json['level'] as int,
      (json['breadCount'] as num).toDouble(),
      upgrades,
      companies,
      achievements,
      json['userId'] as String, // Parse the userId from JSON
    );
  }

  // Convert GlobalState to JSON for saving to Firestore
  Map<String, dynamic> toJson() {
    return {
      'level': level,
      'userId': userId,
      'breadCount': breadCount,
      'tapStrength': tapStrength,
      'lvlPrice': lvlPrice,
      'bufferBread': bufferBread,
      'upgrades': upgrades.map((e) => e.toJson()).toList(),
      'companies': companies.map((e) => e.toJson()).toList(),
      'achievements': achievements,
    };
  }

  double nextLevelPrice() => level * lvlPrice * 1.0;

  void addLevel(int levelToAdd) {
    level += levelToAdd;
  }

  void levelUpUpgrade(String upgradeId, int levels) {
    for (var upg in upgrades) {
      if (upg.upgradeId == upgradeId) {
        upg.level += levels;
      }
    }
  }

  void addBread(double bread) {
    breadCount += bread;
  }

  double calcBread() {
    double result = 0;

    for (var upgrade in upgrades) {
      result += upgrade.earn();
    }

    for (var company in companies) {
      result += company.breadEarned();
    }

    return result;
  }

  double calcTapStrengthBoost() {
    double result = 0;

    for (var upgrade in upgrades) {
      result += upgrade.earnTapStrength();
    }

    for (var company in companies) {
      result += company.tapBooster();
    }

    return result + tapStrength;
  }
}
