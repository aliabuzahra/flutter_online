import 'package:flutter/material.dart';

class BattleScreen extends StatefulWidget {
  const BattleScreen({super.key});

  @override
  State<BattleScreen> createState() => _BattleScreenState();
}

class _BattleScreenState extends State<BattleScreen> {
  int secondsLeft = 60;
  late final countdown;

  @override
  void initState() {
    super.initState();
    countdown = startCountdown();
  }

  Future<void> startCountdown() async {
    while (secondsLeft > 0) {
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        secondsLeft--;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("المعركة - المنطقة 7"),
        backgroundColor: Colors.redAccent,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            "⏱️ الوقت المتبقي: $secondsLeft ثانية",
            style: const TextStyle(fontSize: 22, color: Colors.white),
          ),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            icon: const Icon(Icons.flash_on),
            label: const Text("الهجوم الآن"),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("تم تنفيذ الهجوم!")),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              minimumSize: const Size(200, 50),
            ),
          ),
          const SizedBox(height: 40),
          const Text(
            "👥 المشاركون:",
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              children: const [
                ListTile(
                  title: Text("🔥 اللاعب A"),
                  trailing: Text("3 هجمات"),
                ),
                ListTile(
                  title: Text("💣 اللاعب B"),
                  trailing: Text("1 هجوم"),
                ),
                ListTile(
                  title: Text("🧨 اللاعب C"),
                  trailing: Text("0 هجمات"),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
