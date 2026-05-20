import 'package:flutter/material.dart';
import './content_model.dart';
import './progress_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class DersDetayScreen extends StatefulWidget {
  final Module module;
  final String mainTitle;
  final String topicId;
  final ProgressManager progressManager;

  const DersDetayScreen({
    super.key,
    required this.module,
    required this.mainTitle,
    required this.topicId,
    required this.progressManager,
  });

  @override
  State<DersDetayScreen> createState() => _DersDetayScreenState();
}

class _DersDetayScreenState extends State<DersDetayScreen> {
  bool _isCompleted = false;

  @override
  void initState() {
    super.initState();
    _isCompleted = widget.progressManager.isModuleCompleted(
      widget.topicId,
      widget.module.number,
    );
  }

  void _markComplete() async {
    if (!_isCompleted) {
      await widget.progressManager.markModuleCompleted(
        widget.topicId,
        widget.module.number,
      );
      setState(() {
        _isCompleted = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("✅ Module completed! Great job!"),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _openVideo() async {
  final Uri url = Uri.parse(widget.module.videoUrl);
  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Could not open video!")),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    final totalModules = widget.progressManager.getTotalModulesForTopic(widget.topicId);
    final isLastModule = (widget.module.number == totalModules);

    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.mainTitle} - Module ${widget.module.number}"),
        backgroundColor: const Color(0xFF8DA9C4),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Başlık kartı
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _isCompleted
                    ? Colors.green.withValues(alpha: 0.1)
                    : const Color(0xFF8DA9C4).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: _isCompleted
                    ? Border.all(color: Colors.green, width: 2)
                    : null,
              ),
              child: Row(
                children: [
                  Icon(
                    _isCompleted ? Icons.check_circle : Icons.info_outline,
                    color: _isCompleted ? Colors.green : const Color(0xFF8DA9C4),
                    size: 28,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget.module.title,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: _isCompleted ? Colors.green : const Color(0xFF4A6B8A),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // GÖRSEL (eğer varsa)
            if (widget.module.imageAsset != null) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  widget.module.imageAsset!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
            ],

            // VIDEO (eğer varsa)
            if (widget.module.videoUrl.isNotEmpty) ...[
              const Text(
                "🎬 Watch the Video",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextButton.icon(
                  onPressed: _openVideo,
                  icon: const Icon(Icons.play_circle, color: Color(0xFF8DA9C4), size: 40),
                  label: const Text("Click to Watch", style: TextStyle(fontSize: 16)),
                ),
              ),
              const SizedBox(height: 20),
            ],

            // Yazı içeriği
            const Text(
              "📖 Read & Learn",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                widget.module.detailedContent,
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
            ),
            const SizedBox(height: 24),

            // TAMAMLA BUTONU
            if (!_isCompleted)
              Center(
                child: ElevatedButton.icon(
                  onPressed: _markComplete,
                  icon: const Icon(Icons.check_circle_outline),
                  label: const Text("Mark as Complete", style: TextStyle(fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              )
            else
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.check_circle, color: Colors.green),
                      SizedBox(width: 10),
                      Text("Completed!", style: TextStyle(fontSize: 18, color: Colors.green)),
                    ],
                  ),
                ),
              ),

            const SizedBox(height: 20),

            // QUIZ BUTONU (sadece son modül için ve hasQuiz true ise)
            if (isLastModule && widget.module.hasQuiz)
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("🎯 Quiz: ${widget.module.quizId} - Coming soon!"),
                        backgroundColor: Colors.orange,
                      ),
                    );
                  },
                  icon: const Icon(Icons.quiz),
                  label: const Text("🎯 Take the Quiz", style: TextStyle(fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}