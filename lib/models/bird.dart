// lib/models/bird.dart

import 'pet.dart';
import '../interfaces/friendly.dart';
import '../mixins/flyable.dart';

/// Bird class extending Pet, implementing Friendly, and using Flyable mixin
class Bird extends Pet with Flyable implements Friendly {
  String species;
  
  // Constructor using super
  Bird(String name, int age, String color, this.species) 
      : super(name, age, color);
  
  // Named constructor
  Bird.canary({
    required String name,
    int age = 1,
    String color = 'Yellow',
  }) : species = 'Canary',
       super(name, age, color);
  
  // Implementing abstract method from Pet
  @override
  String makeSound() {
    return 'Tweet! Tweet! 🐦';
  }
  
  // Override move method
  @override
  String move() {
    // Using both super and mixin method
    String parentMove = super.move();
    return '$parentMove by ${fly()}'; // Using Flyable mixin
  }
  
  // Implementing Friendly interface
  @override
  String showAffection() {
    return '${this.name} chirps happily and sits on your shoulder 🎵';
  }
  
  @override
  int getFriendlinessLevel() {
    return 8; // Birds are quite friendly
  }
  
  // Bird-specific method
  String sing() {
    return '${this.name} sings a beautiful melody';
  }
  
  @override
  String getInfo() {
    return '${super.getInfo()}, Species: $species, Flying Speed: $flyingSpeed km/h';
  }
}