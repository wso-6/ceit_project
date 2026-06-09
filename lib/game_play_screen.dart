import 'package:flutter/material.dart';
import './database_helper.dart';

class GamePlayScreen extends StatefulWidget {
  final String username;
  const GamePlayScreen({super.key, required this.username});

  @override
  State<GamePlayScreen> createState() => _GamePlayScreenState();
}

class _GamePlayScreenState extends State<GamePlayScreen> {
  int _currentRound = 0;
  int _score = 0;
  bool _finished = false;
  int? _selectedIndex;
  bool _answered = false;

  final List<Map<String, dynamic>> _scenarios = [
    {
      'message':
          '"Your Netflix account is suspended. Click: netfliix-security.com"',
      'isSuspicious': true,
      'tip': 'The link has double "i" - a trick!',
    },
    {
      'message':
          '"Welcome to Google Classroom. Login at: classroom.google.com"',
      'isSuspicious': false,
      'tip': 'This is the real Google Classroom link!',
    },
    {
      'message': '"URGENT! Your password expired. Renew: secure-bank.xyz"',
      'isSuspicious': true,
      'tip': 'Banks never use .xyz domains!',
    },
    {
      'message': '"Your friend sent a message. Read: whatsapp.com"',
      'isSuspicious': false,
      'tip': 'Official WhatsApp link - safe!',
    },
    {
      'message': '"Congratulations! You WON! Claim: free-prize2025.co"',
      'isSuspicious': true,
      'tip': 'Fake prize - .co domain, too good to be true!',
    },
  ];

  void _answer(bool userSaysSuspicious) {
    if (_answered) return;
    final correct =
        _scenarios[_currentRound]['isSuspicious'] == userSaysSuspicious;
    setState(() {
      _selectedIndex = userSaysSuspicious ? 0 : 1;
      _answered = true;
      if (correct) _score++;
    });
  }

  void _nextRound() {
    if (_currentRound < _scenarios.length - 1) {
      setState(() {
        _currentRound++;
        _selectedIndex = null;
        _answered = false;
      });
    } else {
      setState(() => _finished = true);
      DatabaseHelper().addXP(widget.username, _score * 5);
      DatabaseHelper().updateGameScore(widget.username, _score);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_finished) return _buildResultScreen();
    return _buildGameScreen();
  }

  Widget _buildGameScreen() {
    final scenario = _scenarios[_currentRound];
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(
        title: const Text('📩 Message Detective'),
        backgroundColor: const Color.fromARGB(255, 26, 26, 224),
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: (_currentRound + 1) / _scenarios.length,
            minHeight: 6,
            backgroundColor: Colors.grey.shade300,
            valueColor: const AlwaysStoppedAnimation<Color>(
              Color.fromARGB(255, 26, 26, 224),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              'Round ${_currentRound + 1} / ${_scenarios.length}',
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
                      color: const Color(0xFFFFF8E1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.orange.shade200,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange.withValues(alpha: 0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      scenario['message'],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF4A6B8A),
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (_answered)
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color:
                                (_selectedIndex == 0) ==
                                    scenario['isSuspicious']
                                ? Colors.green.withValues(alpha: 0.15)
                                : Colors.red.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color:
                                  (_selectedIndex == 0) ==
                                      scenario['isSuspicious']
                                  ? Colors.green
                                  : Colors.red,
                              width: 2,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                (_selectedIndex == 0) ==
                                        scenario['isSuspicious']
                                    ? Icons.check_circle
                                    : Icons.cancel,
                                color:
                                    (_selectedIndex == 0) ==
                                        scenario['isSuspicious']
                                    ? Colors.green
                                    : Colors.red,
                                size: 24,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                (_selectedIndex == 0) ==
                                        scenario['isSuspicious']
                                    ? 'Correct!'
                                    : 'Wrong!',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      (_selectedIndex == 0) ==
                                          scenario['isSuspicious']
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFFDE7),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.amber.shade200),
                          ),
                          child: Text(
                            scenario['tip'],
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF6D5E00),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 20),
                  if (!_answered)
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => _answer(true),
                            icon: const Icon(
                              Icons.warning,
                              color: Colors.orange,
                            ),
                            label: const Text('Suspicious'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange.shade100,
                              foregroundColor: Colors.orange.shade800,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => _answer(false),
                            icon: const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            ),
                            label: const Text('Safe'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green.shade100,
                              foregroundColor: Colors.green.shade800,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ],
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
                          _currentRound < _scenarios.length - 1
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

  Widget _buildResultScreen() {
    final percentage = (_score / _scenarios.length * 100).round();
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
                percentage >= 80
                    ? '🏆'
                    : percentage >= 40
                    ? '👍'
                    : '📚',
                style: const TextStyle(fontSize: 80),
              ),
              const SizedBox(height: 20),
              Text(
                '$_score / ${_scenarios.length}',
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 26, 26, 224),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '$percentage%',
                style: const TextStyle(fontSize: 24, color: Color(0xFF4A6B8A)),
              ),
              const SizedBox(height: 16),
              Text(
                percentage >= 80 ? 'Excellent detective!' : 'Keep training!',
                style: const TextStyle(fontSize: 18, color: Color(0xFF4A6B8A)),
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
