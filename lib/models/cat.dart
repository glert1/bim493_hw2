// lib/models/cat.dart

import 'pet.dart';
import '../interfaces/friendly.dart';

/// Cat class extending Pet and implementing Friendly
class Cat extends Pet implements Friendly {
  bool isIndoor;
  
  // Constructor using super
  Cat(String name, int age, String color, this.isIndoor) 
      : super(name, age, color);
  
  // Named constructor
  Cat.indoor({
    required String name,
    int age = 2,
    String color = 'White',
  }) : isIndoor = true,
       super(name, age, color);
  
  // Implementing abstract method from Pet
  @override
  String makeSound() {
    return 'Meow! Meow! 🐱';
  }
  
  // Override move method
  @override
  String move() {
    String parentMove = super.move();
    return '$parentMove by gracefully walking';
  }
  
  // Implementing Friendly interface
  @override
  String showAffection() {
    return '${this.name} purrs softly and rubs against you 😺';
  }
  
  @override
  int getFriendlinessLevel() {
    return 7; // Cats are selectively friendly
  }
  
  // Cat-specific method
  String scratch() {
    return '${this.name} scratches the scratching post';
  }
  
  @override
  String getInfo() {
    String location = isIndoor ? 'Indoor' : 'Outdoor';
    return '${super.getInfo()}, Location: $location';
  }
}