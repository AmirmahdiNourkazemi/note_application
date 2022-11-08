import 'package:hive/hive.dart';
part 'car.g.dart';

@HiveType(typeId: 1)
class Car {
  @HiveField(0)
  String name;
  @HiveField(1)
  int topSpeed;
  @HiveField(2)
  int price;
  Car(this.name, this.price, this.topSpeed);
}
