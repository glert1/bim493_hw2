// lib/mixins/flyable.dart

/// Mixin for pets that can fly
mixin Flyable {
  double flyingSpeed = 25.0; // km/h
  
  String fly() {
    return 'Flying at $flyingSpeed km/h';
  }
  
  String land() {
    return 'Landing safely on the ground';
  }
}