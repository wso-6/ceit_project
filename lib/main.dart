import './database_helper.dart';
import 'package:flutter/material.dart';
import './sabit_icerik.dart';
import './ders_detay_screen.dart';
import './progress_manager.dart';
import './splash_screen.dart';
import './quiz_icerik.dart';
import './quiz_start_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cyber Detective',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 253, 253, 253),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF8DA9C4)),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 26, 26, 224),
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final DatabaseHelper _dbHelper = DatabaseHelper();
  String _message = '';

  void _login() async {
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      setState(() {
        _message = 'Please fill in all fields!';
      });
      return;
    }

    var user = await _dbHelper.loginUser(username, password);

    if (!mounted) return;

    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(username: username, userData: user),
        ),
      );
    } else {
      setState(() {
        _message = 'Incorrect username or password!';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 211, 224, 240),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            Image.asset('assets/logo.png', width: 350, height: 350),
            const SizedBox(height: 2),
            Text(
              'Cyber Detective',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF4A6B8A),
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                prefixIcon: const Icon(
                  Icons.person,
                  color: Color.fromARGB(255, 26, 26, 224),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(
                  Icons.lock,
                  color: Color.fromARGB(255, 26, 26, 224),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              _message,
              style: const TextStyle(color: Colors.red, fontSize: 14),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 26, 26, 224),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text('Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final String username;
  final Map<String, dynamic>? userData;
  final int initialIndex;
  const HomeScreen({
    super.key,
    required this.username,
    this.userData,
    this.initialIndex = 0,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int _currentIndex;
  late ProgressManager _progressManager;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _progressManager = ProgressManager();
  }

  Widget _buildLessonsScreen() {
    return ListenableBuilder(
      listenable: _progressManager,
      builder: (context, child) {
        return Column(
          children: [
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color.fromARGB(225, 11, 79, 135),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(
                      255,
                      167,
                      167,
                      167,
                    ).withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Level 3 Detective',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 202, 223, 243),
                              ),
                            ),
                            const SizedBox(height: 8),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: LinearProgressIndicator(
                                value: 0.72,
                                minHeight: 10,
                                backgroundColor: Colors.grey.shade200,
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                  Color.fromARGB(255, 26, 26, 224),
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '72% completed',
                              style: TextStyle(
                                fontSize: 17,
                                color: const Color.fromARGB(255, 241, 223, 223),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8EDF2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Column(
                          children: [
                            Icon(
                              Icons.shield,
                              size: 32,
                              color: Color(0xFF4A6B8A),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Rookie',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4A6B8A),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.play_arrow, size: 20),
                      label: const Text('Continue where you left off'),
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
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: allTopics.length,
                itemBuilder: (context, index) {
                  final topic = allTopics[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: topic.color.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: topic.color.withValues(alpha: 0.5),
                        width: 1.5,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                topic.iconEmoji,
                                style: const TextStyle(fontSize: 28),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  topic.title,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: topic.color,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: topic.modules.map((module) {
                              final isCompleted = _progressManager
                                  .isModuleCompleted(topic.id, module.number);
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DersDetayScreen(
                                        module: module,
                                        mainTitle: topic.title,
                                        topicId: topic.id,
                                        progressManager: _progressManager,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 55,
                                  height: 55,
                                  decoration: BoxDecoration(
                                    color: isCompleted
                                        ? Colors.green
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: isCompleted
                                          ? Colors.green
                                          : topic.color,
                                      width: 2,
                                    ),
                                  ),
                                  child: Center(
                                    child: isCompleted
                                        ? const Icon(
                                            Icons.check,
                                            color: Colors.white,
                                            size: 28,
                                          )
                                        : Text(
                                            "${module.number}",
                                            style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: topic.color,
                                            ),
                                          ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildQuizScreen() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 170, 210, 244),
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
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Quiz Progress',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF4A6B8A),
                          ),
                        ),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: 0.25,
                            minHeight: 10,
                            backgroundColor: Colors.grey.shade200,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              Color.fromARGB(255, 26, 26, 224),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '1/4 quizzes completed',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8EDF2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Column(
                      children: [
                        Icon(Icons.quiz, size: 32, color: Color(0xFF4A6B8A)),
                        SizedBox(height: 4),
                        Text(
                          'Quiz',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4A6B8A),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.play_arrow, size: 20),
                  label: const Text('Continue where you left off'),
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
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: allQuizzes.length,
            itemBuilder: (context, index) {
              final quiz = allQuizzes[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color.fromARGB(
                      255,
                      26,
                      26,
                      224,
                    ).withValues(alpha: 0.3),
                    width: 1.5,
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuizStartScreen(
                            quizTopic: quiz,
                            username: widget.username,
                          ),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Text(
                            quiz.iconEmoji,
                            style: const TextStyle(fontSize: 36),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  quiz.title,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF4A6B8A),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${quiz.questions.length} questions',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Color.fromARGB(255, 26, 26, 224),
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
    );
  }

  List<Widget> get _pages => [
    _buildLessonsScreen(),
    _buildQuizScreen(),
    const Center(
      child: Text('🎮 Game Section', style: TextStyle(fontSize: 24)),
    ),
    Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            SizedBox(height: 20),
            // Avatar - ayrı
            Stack(
              children: [
                CircleAvatar(
                  radius: 55,
                  backgroundColor: const Color.fromARGB(255, 26, 26, 224),
                  child: Icon(
                    _getAvatarIcon(widget.userData?['avatar'] ?? 'person'),
                    size: 50,
                    color: Colors.white,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () => _showAvatarPicker(),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color.fromARGB(255, 26, 26, 224),
                          width: 2,
                        ),
                      ),
                      child: const Icon(
                        Icons.edit,
                        size: 14,
                        color: Color.fromARGB(255, 26, 26, 224),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            // Hoşgeldin mesajı
            Text(
              'Welcome, ${widget.username}!',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4A6B8A),
              ),
            ),
            SizedBox(height: 20),
            // Level + Badge + XP kartı
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFD6E4F0),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Level 3 Detective',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(255, 26, 26, 224),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    widget.userData?['badge'] ?? 'Rookie Detective 🔍',
                    style: TextStyle(
                      fontSize: 15,
                      color: const Color.fromARGB(255, 10, 0, 0),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: 0.72,
                      minHeight: 8,
                      backgroundColor: Colors.grey.shade300,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Color.fromARGB(255, 26, 26, 224),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '720 XP',
                    style: TextStyle(
                      fontSize: 12,
                      color: const Color.fromARGB(255, 10, 0, 0),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Bilgi tablosu
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 208, 251, 255),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildInfoRow(
                    Icons.badge,
                    'Name',
                    widget.userData?['name'] ?? 'Ali Veli',
                  ),
                  Divider(),
                  _buildInfoRow(
                    Icons.school,
                    'Grade',
                    widget.userData?['grade'] ?? '5-B',
                  ),
                  Divider(),
                  _buildInfoRow(
                    Icons.face,
                    'Gender',
                    widget.userData?['gender'] ?? 'Male',
                  ),
                  Divider(),
                  _buildInfoRow(
                    Icons.star,
                    'Badge',
                    widget.userData?['badge'] ?? 'Rookie Detective 🔍',
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                icon: Icon(Icons.logout),
                label: Text('Logout'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade300,
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
    ),
  ];

  bool get _isLandscape {
    final orientation = MediaQuery.of(context).orientation;
    return orientation == Orientation.landscape;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 26, 26, 224),
              ),
              child: CustomPaint(
                painter: ShieldPainter(),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
            AppBar(
              toolbarHeight: 90,
              title: Text(
                'Cyber Detective',
                style: GoogleFonts.orbitron(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              foregroundColor: Colors.white,
              centerTitle: true,
            ),
          ],
        ),
      ),
      body: _isLandscape
          ? Row(
              children: [
                NavigationRail(
                  selectedIndex: _currentIndex,
                  onDestinationSelected: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  backgroundColor: const Color(0xFFF8FAFD),
                  selectedIconTheme: const IconThemeData(
                    color: Color.fromARGB(255, 26, 26, 224),
                  ),
                  unselectedIconTheme: IconThemeData(
                    color: const Color.fromARGB(122, 11, 2, 70),
                  ),
                  labelType: NavigationRailLabelType.all,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.menu_book),
                      label: Text('Lessons'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.quiz),
                      label: Text('Quiz'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.videogame_asset),
                      label: Text('Game'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.person),
                      label: Text('Profile'),
                    ),
                  ],
                ),
                Expanded(child: _pages[_currentIndex]),
              ],
            )
          : _pages[_currentIndex],
      bottomNavigationBar: _isLandscape
          ? null
          : BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              selectedItemColor: const Color.fromARGB(255, 26, 26, 224),
              unselectedItemColor: const Color.fromARGB(122, 11, 2, 70),
              backgroundColor: const Color(0xFFF8FAFD),
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu_book),
                  label: 'Lessons',
                ),
                BottomNavigationBarItem(icon: Icon(Icons.quiz), label: 'Quiz'),
                BottomNavigationBarItem(
                  icon: Icon(Icons.videogame_asset),
                  label: 'Game',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
    );
  }

  final List<Map<String, String>> _avatars = const [
    {'icon': 'person', 'label': 'Person'},
    {'icon': 'shield', 'label': 'Shield'},
    {'icon': 'rocket_launch', 'label': 'Rocket'},
    {'icon': 'emoji_events', 'label': 'Trophy'},
    {'icon': 'local_police', 'label': 'Badge'},
    {'icon': 'psychology', 'label': 'Brain'},
    {'icon': 'sports_esports', 'label': 'Gamer'},
    {'icon': 'favorite', 'label': 'Heart'},
  ];

  IconData _getAvatarIcon(String iconName) {
    switch (iconName) {
      case 'shield':
        return Icons.shield;
      case 'rocket_launch':
        return Icons.rocket_launch;
      case 'emoji_events':
        return Icons.emoji_events;
      case 'local_police':
        return Icons.local_police;
      case 'psychology':
        return Icons.psychology;
      case 'sports_esports':
        return Icons.sports_esports;
      case 'favorite':
        return Icons.favorite;
      default:
        return Icons.person;
    }
  }

  void _showAvatarPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Choose Your Avatar',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4A6B8A),
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: _avatars.map((avatar) {
                return GestureDetector(
                  onTap: () async {
                    await DatabaseHelper().updateAvatar(
                      widget.username,
                      avatar['icon']!,
                    );
                    final user = await DatabaseHelper().getUser(
                      widget.username,
                    );
                    if (!mounted) return;
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(
                          username: widget.username,
                          userData: user,
                          initialIndex: 3,
                        ),
                      ),
                      (route) => false,
                    );
                  },
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: const Color.fromARGB(255, 26, 26, 224),
                        child: Icon(
                          _getAvatarIcon(avatar['icon']!),
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        avatar['label']!,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, color: Color(0xFF8DA9C4), size: 22),
          SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: const Color.fromARGB(255, 30, 29, 29),
            ),
          ),
          Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(255, 38, 107, 60),
            ),
          ),
        ],
      ),
    );
  }
}

class ShieldPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.06)
      ..style = PaintingStyle.fill;
    for (double y = 0; y < size.height; y += 40) {
      for (double x = 0; x < size.width; x += 40) {
        _drawShield(canvas, Offset(x + 20, y + 10), 8, paint);
      }
    }
  }

  void _drawShield(Canvas canvas, Offset center, double size, Paint paint) {
    final path = Path();
    path.moveTo(center.dx, center.dy - size);
    path.lineTo(center.dx + size, center.dy - size * 0.5);
    path.lineTo(center.dx + size, center.dy + size * 0.3);
    path.lineTo(center.dx, center.dy + size);
    path.lineTo(center.dx - size, center.dy + size * 0.3);
    path.lineTo(center.dx - size, center.dy - size * 0.5);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
