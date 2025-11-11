// lib/models/pet.dart

/// Abstract base class for all pets
abstract class Pet {
  // Static variable to track total number of pets
  static int totalPets = 0;
  
  // Instance variables
  String name;
  int age;
  String color;
  
  // Default constructor
  Pet(this.name, this.age, this.color) {
    totalPets++; // Increment total pets when a new pet is created
  }
  
  // Named constructor
  Pet.withDefaults({
    this.name = 'Unknown',
    this.age = 0,
    this.color = 'Unknown',
  }) {
    totalPets++;
  }
  
  // Abstract method - must be implemented by subclasses
  String makeSound();
  
  // Concrete method
  String getInfo() {
    return 'Name: $name, Age: $age, Color: $color';
  }
  
  // Method to demonstrate movement
  String move() {
    return '$name is moving';
  }
  
  // Static method to get total number of pets
  static int getTotalPets() {
    return totalPets;
  }
}