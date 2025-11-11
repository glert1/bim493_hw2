// lib/main.dart

import 'package:flutter/material.dart';
import 'models/pet.dart';
import 'models/dog.dart';
import 'models/cat.dart';
import 'models/bird.dart';

void main() {
  runApp(const SmartPetManagerApp());
}

class SmartPetManagerApp extends StatelessWidget {
  const SmartPetManagerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Pet Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const PetListScreen(),
    );
  }
}

class PetListScreen extends StatefulWidget {
  const PetListScreen({Key? key}) : super(key: key);

  @override
  State<PetListScreen> createState() => _PetListScreenState();
}

class _PetListScreenState extends State<PetListScreen> {
  late List<Pet> pets;

  @override
  void initState() {
    super.initState();
    // Creating pet instances using different constructors
    pets = [
      Dog('Max', 3, 'Golden', 'Golden Retriever'),
      Cat.indoor(name: 'Whiskers', age: 2, color: 'White'),
      Bird.canary(name: 'Tweety', age: 1, color: 'Yellow'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Smart Pet Manager',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 2,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: pets.length,
              itemBuilder: (context, index) {
                return PetCard(pet: pets[index]);
              },
            ),
          ),
          // Bottom section showing total pets (static variable)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.blue,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Text(
              'Total Pets: ${Pet.getTotalPets()}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PetCard extends StatelessWidget {
  final Pet pet;

  const PetCard({Key? key, required this.pet}) : super(key: key);

  IconData _getPetIcon() {
    if (pet is Dog) return Icons.pets;
    if (pet is Cat) return Icons.pets;
    if (pet is Bird) return Icons.flutter_dash;
    return Icons.pets;
  }

  Color _getPetColor() {
    if (pet is Dog) return Colors.brown;
    if (pet is Cat) return Colors.orange;
    if (pet is Bird) return Colors.blue;
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              _getPetColor().withOpacity(0.1),
              Colors.white,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with icon and type
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _getPetColor(),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      _getPetIcon(),
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pet.runtimeType.toString(),
                          style: TextStyle(
                            fontSize: 14,
                            color: _getPetColor(),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          pet.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 8),
              
              // Pet Information
              _buildInfoRow(Icons.info_outline, pet.getInfo()),
              const SizedBox(height: 8),
              _buildInfoRow(Icons.volume_up, pet.makeSound()),
              const SizedBox(height: 8),
              _buildInfoRow(Icons.directions_run, pet.move()),
              const SizedBox(height: 8),
              
              // Friendly behavior (implements interface)
              if (pet is Dog || pet is Cat || pet is Bird) ...[
                _buildInfoRow(
                  Icons.favorite,
                  (pet as dynamic).showAffection(),
                ),
                const SizedBox(height: 8),
                _buildInfoRow(
                  Icons.star,
                  'Friendliness: ${(pet as dynamic).getFriendlinessLevel()}/10',
                ),
              ],
              
              const SizedBox(height: 12),
              
              // Special behaviors
              Row(
                children: [
                  if (pet is Dog) ...[
                    _buildActionButton(
                      context,
                      'Fetch',
                      Icons.sports_baseball,
                      () => _showAction(context, (pet as Dog).fetch()),
                    ),
                  ],
                  if (pet is Cat) ...[
                    _buildActionButton(
                      context,
                      'Scratch',
                      Icons.back_hand,
                      () => _showAction(context, (pet as Cat).scratch()),
                    ),
                  ],
                  if (pet is Bird) ...[
                    _buildActionButton(
                      context,
                      'Sing',
                      Icons.music_note,
                      () => _showAction(context, (pet as Bird).sing()),
                    ),
                    const SizedBox(width: 8),
                    _buildActionButton(
                      context,
                      'Land',
                      Icons.flight_land,
                      () => _showAction(context, (pet as Bird).land()),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[700]),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[800],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String label,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return Expanded(
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 18),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: _getPetColor(),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  void _showAction(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}