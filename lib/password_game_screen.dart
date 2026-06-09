import 'package:flutter/material.dart';
import './database_helper.dart';

class PasswordGameScreen extends StatefulWidget {
  final String username;
  const PasswordGameScreen({super.key, required this.username});

  @override
  State<PasswordGameScreen> createState() => _PasswordGameScreenState();
}

class _PasswordGameScreenState extends State<PasswordGameScreen> {
  int _currentRound = 0;
  int _score = 0;
  bool _finished = false;
  bool _answered = false;
  int? _selectedIndex;

  final List<Map<String, dynamic>> _passwords = [
    {'password': '123456', 'strength': 0},
    {'password': 'BlueBananaJump7!', 'strength': 2},
    {'password': 'password123', 'strength': 1},
    {'password': 'qwerty', 'strength': 0},
    {'password': 'PurpleCloudDance7!', 'strength': 2},
  ];

  final List<String> _strengthLabels = ['Weak', 'Medium', 'Strong'];

  void _answer(int index) {
    if (_answered) return;
    setState(() {
      _selectedIndex = index;
      _answered = true;
      if (index == _passwords[_currentRound]['strength']) _score++;
    });
  }

  void _nextRound() {
    if (_currentRound < _passwords.length - 1) {
      setState(() {
        _currentRound++;
        _selectedIndex = null;
        _answered = false;
      });
    } else {
      setState(() => _finished = true);
      DatabaseHelper().addXP(widget.username, _score * 5);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_finished) return _buildResult();
    final pwd = _passwords[_currentRound];
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(
        title: const Text('🔐 Password Warrior'),
        backgroundColor: const Color.fromARGB(255, 26, 26, 224),
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: (_currentRound + 1) / _passwords.length,
            minHeight: 6,
            backgroundColor: Colors.grey.shade300,
            valueColor: const AlwaysStoppedAnimation<Color>(
              Color.fromARGB(255, 26, 26, 224),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              '${_currentRound + 1} / ${_passwords.length}',
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5E9),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.green.shade300,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.withValues(alpha: 0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      pwd['password'],
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4A6B8A),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 35),
                  if (_answered)
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: _selectedIndex == pwd['strength']
                                ? Colors.green.withValues(alpha: 0.15)
                                : Colors.red.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: _selectedIndex == pwd['strength']
                                  ? Colors.green
                                  : Colors.red,
                              width: 2,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                _selectedIndex == pwd['strength']
                                    ? Icons.check_circle
                                    : Icons.cancel,
                                color: _selectedIndex == pwd['strength']
                                    ? Colors.green
                                    : Colors.red,
                                size: 24,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                _selectedIndex == pwd['strength']
                                    ? 'Correct!'
                                    : 'Wrong!',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: _selectedIndex == pwd['strength']
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (_selectedIndex != pwd['strength'])
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFFDE7),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.amber.shade200,
                                ),
                              ),
                              child: Text(
                                'Correct answer: ${_strengthLabels[pwd['strength']]}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF6D5E00),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                      ],
                    ),
                  const SizedBox(height: 35),
                  if (!_answered)
                    Column(
                      children: List.generate(
                        3,
                        (i) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () => _answer(i),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: [
                                  Colors.red.shade100,
                                  Colors.orange.shade100,
                                  Colors.green.shade100,
                                ][i],
                                foregroundColor: [
                                  Colors.red.shade800,
                                  Colors.orange.shade800,
                                  Colors.green.shade800,
                                ][i],
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                _strengthLabels[i],
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (_answered)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _nextRound,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                            255,
                            26,
                            26,
                            224,
                          ),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          _currentRound < _passwords.length - 1
                              ? 'Next'
                              : 'See Results',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResult() {
    final pct = (_score / _passwords.length * 100).round();
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(
        title: const Text('Results'),
        backgroundColor: const Color.fromARGB(255, 26, 26, 224),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                pct >= 80
                    ? '🏆'
                    : pct >= 40
                    ? '👍'
                    : '📚',
                style: const TextStyle(fontSize: 80),
              ),
              const SizedBox(height: 20),
              Text(
                '$_score / ${_passwords.length}',
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 26, 26, 224),
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => setState(() {
                      _currentRound = 0;
                      _score = 0;
                      _finished = false;
                      _selectedIndex = null;
                      _answered = false;
                    }),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Play Again'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 26, 26, 224),
                      foregroundColor: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 16),
                  OutlinedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Back'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color.fromARGB(255, 26, 26, 224),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
