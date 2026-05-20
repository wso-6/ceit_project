class MainTopic {
  final String id;
  final String title;
  final String iconEmoji;
  final List<Module> modules;

  MainTopic({
    required this.id,
    required this.title,
    required this.iconEmoji,
    required this.modules,
  });
}

class Module {
  final int number;
  final String title;
  final String description;
  final String detailedContent;
  final String videoUrl;
  final String? imageAsset;  // 🟢 YENİ: Görsel dosya yolu
  final bool hasQuiz;
  final String? quizId;

  Module({
    required this.number,
    required this.title,
    required this.description,
    required this.detailedContent,
    required this.videoUrl,
    this.imageAsset,
    this.hasQuiz = false,
    this.quizId,
  });
}