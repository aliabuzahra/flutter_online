import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../routes/app_routes.dart';
import '../providers/game_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gameState = Provider.of<GameState>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("خريطة المدينة"),
        backgroundColor: Colors.redAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              gameState.resetAreas();
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: gameState.mapSize,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
          ),
          itemBuilder: (context, index) {
            final owner = gameState.selectedAreaOwner(index);
            final color = owner == null
                ? Colors.grey[800]
                : (owner == "Gang A" ? Colors.red : Colors.blue);

            return GestureDetector(
              onTap: () {
                gameState.claimArea(index, "Gang A");
                Navigator.pushNamed(context, '/battle');
              },
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Text(
                    owner == null ? "📍 ${index + 1}" : "$owner",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
