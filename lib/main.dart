import 'package:flutter/material.dart';
import './sabit_icerik.dart';
import './ders_detay_screen.dart';
import './progress_manager.dart';
import './splash_screen.dart';

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
  String _message = '';

  void _login() {
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      setState(() {
        _message = 'Please fill in all fields!';
      });
    } else if (username == 'admin' && password == '1234') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen(username: username)),
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
            // Logo
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
            // Kullanıcı adı
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
            // Şifre
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
  const HomeScreen({super.key, required this.username});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  late ProgressManager _progressManager;

  @override
  void initState() {
    super.initState();
    _progressManager = ProgressManager();
  }

  Widget _buildLessonsScreen() {
    return ListenableBuilder(
      listenable: _progressManager,
      builder: (context, child) {
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: allTopics.length,
          itemBuilder: (context, index) {
            final topic = allTopics[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
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
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 87, 124, 160),
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
                        final isCompleted = _progressManager.isModuleCompleted(
                          topic.id,
                          module.number,
                        );
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
                                  : const Color(
                                      0xFF8DA9C4,
                                    ).withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isCompleted
                                    ? Colors.green
                                    : const Color(0xFF8DA9C4),
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "${module.number}",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: isCompleted
                                      ? Colors.white
                                      : const Color(0xFF4A6B8A),
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
        );
      },
    );
  }

  List<Widget> get _pages => [
    _buildLessonsScreen(),
    const Center(child: Text('❓ Quiz Section', style: TextStyle(fontSize: 24))),
    const Center(
      child: Text('🎮 Game Section', style: TextStyle(fontSize: 24)),
    ),
    Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundColor: Color(0xFF8DA9C4),
              child: Icon(Icons.person, size: 60, color: Colors.white),
            ),
            SizedBox(height: 15),
            Text(
              widget.username,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4A6B8A),
              ),
            ),
            SizedBox(height: 30),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
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
                  _buildInfoRow(Icons.badge, 'Name', 'Ali Veli'),
                  Divider(),
                  _buildInfoRow(Icons.school, 'Grade', '5-B'),
                  Divider(),
                  _buildInfoRow(Icons.face, 'Gender', 'Male'),
                  Divider(),
                  _buildInfoRow(Icons.star, 'Badge', 'Rookie Detective 🔍'),
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
      appBar: AppBar(title: const Text('Cyber Detective')),
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

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, color: Color(0xFF8DA9C4), size: 22),
          SizedBox(width: 12),
          Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
          Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF4A6B8A),
            ),
          ),
        ],
      ),
    );
  }
}
