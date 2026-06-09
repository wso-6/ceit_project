import 'package:flutter/material.dart';
import './game_play_screen.dart';
import './password_game_screen.dart';
import './url_game_screen.dart';

class GameScreen extends StatefulWidget {
  final String username;
  const GameScreen({super.key, required this.username});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final List<Map<String, String>> _games = [
    {
      'title': 'Message Detective',
      'icon': '📩',
      'desc': 'Spot fake messages & phishing',
      'color': '#FF6B6B',
    },
    {
      'title': 'Password Warrior',
      'icon': '🔐',
      'desc': 'Rate password strength',
      'color': '#4ECDC4',
    },
    {
      'title': 'URL Hunter',
      'icon': '🔗',
      'desc': 'Find suspicious characters in URLs',
      'color': '#DEC133',
    },
  ];

  void _openGame(int index) {
    Widget screen;
    if (index == 0) {
      screen = GamePlayScreen(username: widget.username);
    } else if (index == 1) {
      screen = PasswordGameScreen(username: widget.username);
    } else {
      screen = URLGameScreen(username: widget.username);
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color.fromARGB(255, 63, 63, 79),
              width: 2,
            ),
          ),
          child: const Text(
            '🎮 Cyber Games',
            style: TextStyle(
              color: Color.fromARGB(255, 26, 26, 224),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 224, 224, 246),
        centerTitle: true,
        toolbarHeight: 70,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color.fromARGB(
                  255,
                  26,
                  26,
                  224,
                ).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color.fromARGB(
                    255,
                    26,
                    26,
                    224,
                  ).withValues(alpha: 0.3),
                ),
              ),
              child: const Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.emoji_events,
                        color: Color.fromARGB(255, 26, 26, 224),
                        size: 24,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Total Game Score',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 26, 26, 224),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    '0 / 15  |  0%',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4A6B8A),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Complete all games to become a Cyber Legend! 🚀',
              style: TextStyle(
                fontSize: 15,
                color: Color.fromARGB(255, 45, 65, 83),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _games.length,
              itemBuilder: (context, index) {
                final game = _games[index];
                final colorHex = game['color']!;
                final color = Color(
                  int.parse(colorHex.replaceAll('#', '0xFF')),
                );

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: color.withValues(alpha: 0.4),
                      width: 1.5,
                    ),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                    child: InkWell(
                      onTap: () => _openGame(index),
                      borderRadius: BorderRadius.circular(16),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: color.withValues(alpha: 0.3),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Center(
                                child: Text(
                                  game['icon']!,
                                  style: const TextStyle(fontSize: 30),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    game['title']!,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: color,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    game['desc']!,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: color,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
