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
  bool _finished = false;
  late List<int?> _userAnswers;

  @override
  void initState() {
    super.initState();
    _userAnswers = List.filled(widget.quizTopic.questions.length, null);
  }

  void _selectAnswer(int selected) {
    setState(() {
      _userAnswers[_currentIndex] = selected;
    });
  }

  void _nextQuestion() {
    if (_currentIndex < widget.quizTopic.questions.length - 1) {
      setState(() {
        _currentIndex++;
      });
    } else {
      _finishQuiz();
    }
  }

  void _finishQuiz() {
    int score = 0;
    for (int i = 0; i < widget.quizTopic.questions.length; i++) {
      if (_userAnswers[i] == widget.quizTopic.questions[i].correctAnswerIndex) {
        score++;
      }
    }
    _score = score;
    DatabaseHelper().updateQuizScore(widget.username, _score);
    setState(() {
      _finished = true;
    });
    final correct = score;
    final wrong = widget.quizTopic.questions.length - score;
    DatabaseHelper().saveQuizHistory(
      username: widget.username,
      quizId: widget.quizTopic.id,
      score: score,
      total: widget.quizTopic.questions.length,
      correct: correct,
      wrong: wrong,
    );
  }

  void _previousQuestion() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
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
                  ...List.generate(question.options.length, (index) {
                    final isSelected = _userAnswers[_currentIndex] == index;
                    Color bgColor;
                    Color borderColor;
                    if (isSelected) {
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
                      onTap: () => _selectAnswer(index),
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
                            if (isSelected)
                              const Icon(
                                Icons.check_circle,
                                color: Color.fromARGB(255, 26, 26, 224),
                                size: 24,
                              ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
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
                if (_userAnswers[_currentIndex] != null)
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
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => _buildReviewScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.checklist),
                  label: const Text('Show My Answers'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color.fromARGB(255, 26, 26, 224),
                    side: const BorderSide(
                      color: Color.fromARGB(255, 26, 26, 224),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _currentIndex = 0;
                        _score = 0;
                        _finished = false;
                        _userAnswers = List.filled(
                          widget.quizTopic.questions.length,
                          null,
                        );
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

  Widget _buildReviewScreen() {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(
        title: const Text('Review Answers'),
        backgroundColor: const Color.fromARGB(255, 26, 26, 224),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: widget.quizTopic.questions.length,
        itemBuilder: (context, index) {
          final question = widget.quizTopic.questions[index];
          final userAnswer = _userAnswers[index];
          final isCorrect = userAnswer == question.correctAnswerIndex;

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isCorrect ? Colors.green : Colors.red,
                width: 2,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      isCorrect ? Icons.check_circle : Icons.cancel,
                      color: isCorrect ? Colors.green : Colors.red,
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Question ${index + 1}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4A6B8A),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  question.question,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Color(0xFF4A6B8A),
                  ),
                ),
                const SizedBox(height: 10),
                if (userAnswer != null) ...[
                  Text(
                    'Your answer: ${question.options[userAnswer]}',
                    style: TextStyle(
                      fontSize: 14,
                      color: isCorrect ? Colors.green : Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
                if (!isCorrect) ...[
                  const SizedBox(height: 4),
                  Text(
                    'Correct answer: ${question.options[question.correctAnswerIndex]}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
                if (userAnswer == null) ...[
                  Text(
                    'Not answered',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade500,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Correct answer: ${question.options[question.correctAnswerIndex]}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
