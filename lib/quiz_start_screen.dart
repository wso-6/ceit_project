import 'package:flutter/material.dart';
import './quiz_model.dart';
import './database_helper.dart';
import './quiz_screen.dart';
import './progress_manager.dart';
import './sabit_icerik.dart';

class QuizStartScreen extends StatefulWidget {
  final QuizTopic quizTopic;
  final String username;

  const QuizStartScreen({
    super.key,
    required this.quizTopic,
    required this.username,
  });

  @override
  State<QuizStartScreen> createState() => _QuizStartScreenState();
}

class _QuizStartScreenState extends State<QuizStartScreen> {
  List<Map<String, dynamic>> _history = [];
  bool _loading = true;
  late ProgressManager _progressManager;

  @override
  void initState() {
    super.initState();
    _progressManager = ProgressManager(username: widget.username);
    _loadHistory();
  }

  void _loadHistory() async {
    final history = await DatabaseHelper().getQuizHistory(
      widget.username,
      widget.quizTopic.id,
    );
    setState(() {
      _history = history;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(
        title: Text(widget.quizTopic.title),
        backgroundColor: const Color.fromARGB(255, 26, 26, 224),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Üst bilgi kartı
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
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
              child: Column(
                children: [
                  Text(
                    widget.quizTopic.iconEmoji,
                    style: const TextStyle(fontSize: 60),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.quizTopic.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4A6B8A),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildInfoChip(Icons.timer, '5 min'),
                      const SizedBox(width: 20),
                      _buildInfoChip(
                        Icons.quiz,
                        '${widget.quizTopic.questions.length} questions',
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Konunun tüm modülleri tamamlandı mı?
                        final topic = allTopics.firstWhere(
                          (t) => t.id == widget.quizTopic.id,
                        );
                        bool allCompleted = topic.modules.every(
                          (m) => _progressManager.isModuleCompleted(
                            widget.quizTopic.id,
                            m.number,
                          ),
                        );

                        if (!allCompleted) {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              title: const Row(
                                children: [
                                  Icon(
                                    Icons.lock,
                                    color: Colors.orange,
                                    size: 28,
                                  ),
                                  SizedBox(width: 10),
                                  Text('Locked!'),
                                ],
                              ),
                              content: const Text(
                                'You must complete all lessons in this topic before taking the quiz!',
                                style: TextStyle(fontSize: 16),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(ctx),
                                  child: const Text(
                                    'OK',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          );
                          return;
                        }

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QuizScreen(
                              quizTopic: widget.quizTopic,
                              username: widget.username,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.play_arrow),
                      label: const Text(
                        'Start Quiz',
                        style: TextStyle(fontSize: 18),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 26, 26, 224),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Geçmiş tablosu
            Row(
              children: [
                const Icon(Icons.history, color: Color(0xFF4A6B8A)),
                const SizedBox(width: 8),
                const Text(
                  'Last Attempts',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4A6B8A),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (_loading)
              const Padding(
                padding: EdgeInsets.all(20),
                child: CircularProgressIndicator(),
              )
            else if (_history.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'No previous attempts',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              )
            else
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 183, 201, 245),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    // Başlık satırı
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD6E4F0),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                      ),
                      child: const Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Date',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          Text(
                            'Score',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          SizedBox(width: 16),
                          Text(
                            'C/W',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Veri satırları
                    ..._history.map(
                      (h) => Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey.shade200,
                              width: 0.5,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                h['date'] ?? '',
                                style: const TextStyle(fontSize: 13),
                              ),
                            ),
                            Text(
                              '${h['score'] * 10}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: Color.fromARGB(255, 16, 127, 44),
                              ),
                            ),
                            const SizedBox(width: 24),
                            Text(
                              '${h['correct']}/${h['wrong']}',
                              style: const TextStyle(fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 250, 241, 189),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: const Color(0xFF4A6B8A)),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              color: Color(0xFF4A6B8A),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
