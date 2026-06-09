import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import './sabit_icerik.dart';

class ProgressManager extends ChangeNotifier {
  Set<String> completedModules = {};
  String _username = '';

  ProgressManager({String username = ''}) {
    _username = username;
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    final String? saved = prefs.getString('completed_modules_$_username');
    if (saved != null) {
      final List<String> list = List<String>.from(jsonDecode(saved));
      completedModules = Set<String>.from(list);
      notifyListeners();
    }
  }

  Future<void> markModuleCompleted(String topicId, int moduleNumber) async {
    final key = "${topicId}_$moduleNumber";
    if (!completedModules.contains(key)) {
      completedModules.add(key);
      await _saveProgress();
      notifyListeners();
    }
  }

  bool isModuleCompleted(String topicId, int moduleNumber) {
    return completedModules.contains("${topicId}_$moduleNumber");
  }

  int getTotalModulesForTopic(String topicId) {
    final topic = allTopics.firstWhere((t) => t.id == topicId);
    return topic.modules.length;
  }

  Future<void> _saveProgress() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> list = completedModules.toList();
    await prefs.setString('completed_modules_$_username', jsonEncode(list));
  }

  Future<void> resetProgress() async {
    completedModules.clear();
    await _saveProgress();
    notifyListeners();
  }
}
