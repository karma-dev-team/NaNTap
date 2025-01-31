import 'package:nantap/progress/interfaces.dart';
import 'package:nantap/progress/upgrade.dart';

void setupUpgradesRegistry(AbstractUpgradesRegistry upgradesRegistry) {
  upgradesRegistry.addUpgrade(
    Upgrade(
      'baker',
      'Пекарь',
      'Нанимает пекаря, который увеличивает ваш доход.',
      150.0,
      10, // Базовый доход
      'assets/image/upg1.png',
    ),
  );

  upgradesRegistry.addUpgrade(
    Upgrade(
      'pastry_chef',
      'Пекарь-кондитер',
      'Улучшенный пекарь, который делает торты и булочки.',
      1000.0,
      50, // Базовый доход
      'assets/image/upg2.png',
    ),
  );

  upgradesRegistry.addUpgrade(
    Upgrade(
      'bakery_machine',
      'Пекарный аппарат',
      'Автоматизированная машина, производящая хлеб.',
      5000.0,
      150, // Базовый доход
      'assets/image/upg3.png',
    ),
  );

  upgradesRegistry.addUpgrade(
    Upgrade(
      'super_baker',
      'Супер пекарь',
      'Нанимает супер пекаря, который работает без остановки.',
      20000.0,
      500, // Базовый доход
      'assets/image/upg4.png',
    ),
  );

  upgradesRegistry.addUpgrade(
    Upgrade(
      'bread_factory',
      'Хлебозавод',
      'Полный завод для производства хлеба.',
      100000.0,
      2500, // Базовый доход
      'assets/image/upg5.png',
    ),
  );

  upgradesRegistry.addUpgrade(
    Upgrade(
      'corporate_bakery',
      'Корпоративная пекарня',
      'Франшиза пекарен по всему миру.',
      500000.0,
      10000, // Базовый доход
      'assets/image/upg6.png',
    ),
  );
}
