import 'package:flutter/material.dart';
import './quiz_model.dart';
import './database_helper.dart';

class QuizScreen extends StatefulWidget {
  final QuizTopic quizTopic;
  final String username;

  const QuizScreen({
    super.key,
    required this.quizTopic,
    required this.username,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentIndex = 0;
  int _score = 0;
  int? _selectedIndex;
  bool _answered = false;
  bool _finished = false;

  void _checkAnswer(int selected) {
    if (_answered) return;
    setState(() {
      _selectedIndex = selected;
      _answered = true;
      if (selected ==
          widget.quizTopic.questions[_currentIndex].correctAnswerIndex) {
        _score++;
      }
    });
  }

  void _nextQuestion() {
    if (_currentIndex < widget.quizTopic.questions.length - 1) {
      setState(() {
        _currentIndex++;
        _selectedIndex = null;
        _answered = false;
      });
    } else {
      setState(() {
        _finished = true;
        if (_finished) {
          DatabaseHelper().updateQuizScore(widget.username, _score);
        }
      });
    }
  }

  void _previousQuestion() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
        _selectedIndex = null;
        _answered = false;
        // Önceki soruya dönünce skoru koru, ama cevap seçimini sıfırla
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_finished) {
      return _buildResultScreen();
    }
    return _buildQuizScreen();
  }

  Widget _buildQuizScreen() {
    final question = widget.quizTopic.questions[_currentIndex];
    final totalQuestions = widget.quizTopic.questions.length;

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(
        title: Text(widget.quizTopic.title),
        backgroundColor: const Color.fromARGB(255, 26, 26, 224),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // İlerleme çubuğu
          LinearProgressIndicator(
            value: (_currentIndex + 1) / totalQuestions,
            minHeight: 6,
            backgroundColor: Colors.grey.shade300,
            valueColor: const AlwaysStoppedAnimation<Color>(
              Color.fromARGB(255, 26, 26, 224),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${_currentIndex + 1} / $totalQuestions',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Soru kartı
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      question.question,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4A6B8A),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Cevap seçenekleri
                  ...List.generate(question.options.length, (index) {
                    final isSelected = _selectedIndex == index;
                    final isCorrect = index == question.correctAnswerIndex;

                    Color? bgColor;
                    Color? borderColor;
                    IconData? icon;

                    if (_answered) {
                      if (isCorrect) {
                        bgColor = Colors.green.withValues(alpha: 0.1);
                        borderColor = Colors.green;
                        icon = Icons.check_circle;
                      } else if (isSelected && !isCorrect) {
                        bgColor = Colors.red.withValues(alpha: 0.1);
                        borderColor = Colors.red;
                        icon = Icons.cancel;
                      } else {
                        bgColor = Colors.white;
                        borderColor = Colors.grey.shade300;
                      }
                    } else if (isSelected) {
                      bgColor = const Color.fromARGB(
                        255,
                        26,
                        26,
                        224,
                      ).withValues(alpha: 0.1);
                      borderColor = const Color.fromARGB(255, 26, 26, 224);
                    } else {
                      bgColor = Colors.white;
                      borderColor = Colors.grey.shade300;
                    }

                    return GestureDetector(
                      onTap: () => _checkAnswer(index),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: bgColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: borderColor, width: 2),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                question.options[index],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: const Color(0xFF4A6B8A),
                                ),
                              ),
                            ),
                            if (icon != null)
                              Icon(icon, color: borderColor, size: 24),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
          // Alt navigasyon
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Row(
              children: [
                if (_currentIndex > 0)
                  OutlinedButton.icon(
                    onPressed: _previousQuestion,
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Previous'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color.fromARGB(255, 26, 26, 224),
                      side: const BorderSide(
                        color: Color.fromARGB(255, 26, 26, 224),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  )
                else
                  const SizedBox(width: 100),
                const Spacer(),
                if (_answered)
                  ElevatedButton.icon(
                    onPressed: _nextQuestion,
                    icon: Icon(
                      _currentIndex < widget.quizTopic.questions.length - 1
                          ? Icons.arrow_forward
                          : Icons.flag,
                    ),
                    label: Text(
                      _currentIndex < widget.quizTopic.questions.length - 1
                          ? 'Next'
                          : 'Finish',
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 26, 26, 224),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultScreen() {
    final total = widget.quizTopic.questions.length;
    final percentage = (_score / total * 100).round();

    String message;
    String emoji;
    if (percentage == 100) {
      message = 'Perfect! You are a Cyber Genius!';
      emoji = '🏆';
    } else if (percentage >= 80) {
      message = 'Great job! Almost perfect!';
      emoji = '🌟';
    } else if (percentage >= 50) {
      message = 'Good effort! Keep learning!';
      emoji = '👍';
    } else {
      message = 'Keep studying! You will improve!';
      emoji = '📚';
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(
        title: Text(widget.quizTopic.title),
        backgroundColor: const Color.fromARGB(255, 26, 26, 224),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(emoji, style: const TextStyle(fontSize: 80)),
              const SizedBox(height: 20),
              Text(
                '$_score / $total',
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
                message,
                style: const TextStyle(fontSize: 18, color: Color(0xFF4A6B8A)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _currentIndex = 0;
                        _score = 0;
                        _selectedIndex = null;
                        _answered = false;
                        _finished = false;
                      });
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Try Again'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 26, 26, 224),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Back'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color.fromARGB(255, 26, 26, 224),
                      side: const BorderSide(
                        color: Color.fromARGB(255, 26, 26, 224),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
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
