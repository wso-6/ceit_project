import 'package:flutter/material.dart';
import './database_helper.dart';

class URLGameScreen extends StatefulWidget {
  final String username;
  const URLGameScreen({super.key, required this.username});

  @override
  State<URLGameScreen> createState() => _URLGameScreenState();
}

class _URLGameScreenState extends State<URLGameScreen> {
  int _currentRound = 0;
  int _score = 0;
  bool _finished = false;
  bool _answered = false;
  String? _tappedChar;

  final List<Map<String, dynamic>> _urls = [
    {
      'url': 'www.googIe.com',
      'suspicious': 'I',
      'tip': 'Big "I" instead of "l"',
    },
    {
      'url': 'netfliix-security.com',
      'suspicious': 'i',
      'tip': 'Double "i" - fake!',
    },
    {
      'url': 'amaz0n-deals.shop',
      'suspicious': '0',
      'tip': 'Zero instead of "o"',
    },
    {
      'url': 'faceb00k-login.net',
      'suspicious': '0',
      'tip': 'Zeros instead of "o"',
    },
    {
      'url': 'www.google.com',
      'suspicious': '',
      'tip': 'No tricks - this URL is safe!',
    },
  ];

  void _checkTap(String tapped) {
    if (_answered) return;
    final correct = _urls[_currentRound]['suspicious'] as String;
    final isCorrect = tapped == correct;
    setState(() {
      _tappedChar = tapped;
      _answered = true;
      if (isCorrect) _score++;
    });
  }

  void _nextRound() {
    if (_currentRound < _urls.length - 1) {
      setState(() {
        _currentRound++;
        _answered = false;
        _tappedChar = null;
      });
    } else {
      setState(() => _finished = true);
      DatabaseHelper().addXP(widget.username, _score * 5);
      DatabaseHelper().updateGameScore(widget.username, _score);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_finished) return _buildResult();
    final urlData = _urls[_currentRound];
    final url = urlData['url'] as String;
    final correct = urlData['suspicious'] as String;

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(
        title: const Text('🔗 URL Hunter'),
        backgroundColor: const Color.fromARGB(255, 26, 26, 224),
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: (_currentRound + 1) / _urls.length,
            minHeight: 6,
            backgroundColor: Colors.grey.shade300,
            valueColor: const AlwaysStoppedAnimation<Color>(
              Color.fromARGB(255, 26, 26, 224),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              '${_currentRound + 1} / ${_urls.length}',
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            ),
          ),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Tap the suspicious part:',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 4,
                      runSpacing: 8,
                      alignment: WrapAlignment.center,
                      children: url.split('').map((char) {
                        Color bgColor = Colors.white;
                        if (_answered && char == correct)
                          bgColor = Colors.green.shade100;
                        if (_answered && _tappedChar == char && char != correct)
                          bgColor = Colors.red.shade100;
                        return GestureDetector(
                          onTap: () => _checkTap(char),
                          child: Container(
                            margin: const EdgeInsets.all(3),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: bgColor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: _answered && char == correct
                                    ? Colors.green
                                    : Colors.grey.shade300,
                                width:
                                    _answered &&
                                        (char == correct || _tappedChar == char)
                                    ? 2.5
                                    : 1.5,
                              ),
                            ),
                            child: Text(
                              char,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: _answered && char == correct
                                    ? Colors.green.shade800
                                    : const Color(0xFF4A6B8A),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                    if (_answered)
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: _tappedChar == correct
                                  ? Colors.green.withValues(alpha: 0.15)
                                  : Colors.red.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: _tappedChar == correct
                                    ? Colors.green
                                    : Colors.red,
                                width: 2,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  _tappedChar == correct
                                      ? Icons.check_circle
                                      : Icons.cancel,
                                  color: _tappedChar == correct
                                      ? Colors.green
                                      : Colors.red,
                                  size: 24,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  _tappedChar == correct
                                      ? 'Correct!'
                                      : 'Wrong!',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: _tappedChar == correct
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFFDE7),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.amber.shade200),
                            ),
                            child: Text(
                              urlData['tip'],
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
                    if (!_answered)
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ElevatedButton.icon(
                          onPressed: () => _checkTap(''),
                          icon: const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          ),
                          label: const Text('This URL is Safe'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade100,
                            foregroundColor: Colors.green.shade800,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 14,
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(height: 20),
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
                            _currentRound < _urls.length - 1
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
          ),
        ],
      ),
    );
  }

  Widget _buildResult() {
    final pct = (_score / _urls.length * 100).round();
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
                '$_score / ${_urls.length}',
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
                      _answered = false;
                      _tappedChar = null;
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
