// lib/models/dog.dart

import 'pet.dart';
import '../interfaces/friendly.dart';

/// Dog class extending Pet and implementing Friendly
class Dog extends Pet implements Friendly {
  String breed;
  
  // Constructor using super to call parent constructor
  Dog(String name, int age, String color, this.breed) 
      : super(name, age, color);
  
  // Named constructor
  Dog.withBreed({
    required String name,
    required this.breed,
    int age = 1,
    String color = 'Brown',
  }) : super(name, age, color);
  
  // Implementing abstract method from Pet
  @override
  String makeSound() {
    return 'Woof! Woof! 🐕';
  }
  
  // Override move method
  @override
  String move() {
    // Using super to call parent method
    String parentMove = super.move();
    return '$parentMove by running fast';
  }
  
  // Implementing Friendly interface
  @override
  String showAffection() {
    // Using this keyword
    return '${this.name} wags tail and licks your face! 💕';
  }
  
  @override
  int getFriendlinessLevel() {
    return 10; // Dogs are very friendly!
  }
  
  // Dog-specific method
  String fetch() {
    return '${this.name} fetches the ball!';
  }
  
  @override
  String getInfo() {
    return '${super.getInfo()}, Breed: $breed';
  }
}