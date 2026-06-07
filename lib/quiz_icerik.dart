import './quiz_model.dart';

final List<QuizTopic> allQuizzes = [
  // ==================== QUIZ 1: CRYPTOGRAPHY ====================
  QuizTopic(
    id: "crypto_intro",
    title: "Cryptography Quiz",
    iconEmoji: "🔐",
    questions: [
      QuizQuestion(
        question: "What is cryptography?",
        options: [
          "The science of secret codes",
          "A type of computer virus",
          "A social media platform",
          "A video game",
        ],
        correctAnswerIndex: 0,
      ),
      QuizQuestion(
        question: "What is PLAINTEXT?",
        options: [
          "Encrypted secret message",
          "Normal, readable message",
          "A mathematical formula",
          "A type of password",
        ],
        correctAnswerIndex: 1,
      ),
      QuizQuestion(
        question: "What is CIPHERTEXT?",
        options: [
          "The original message",
          "The secret, scrambled message",
          "The encryption key",
          "The computer program",
        ],
        correctAnswerIndex: 1,
      ),
      QuizQuestion(
        question: "Who invented the Caesar Cipher?",
        options: ["Bill Gates", "Isaac Newton", "Julius Caesar", "Steve Jobs"],
        correctAnswerIndex: 2,
      ),
      QuizQuestion(
        question: "How many letters did Caesar shift in his cipher?",
        options: ["1 letter", "2 letters", "3 letters", "5 letters"],
        correctAnswerIndex: 2,
      ),
      QuizQuestion(
        question: "In Caesar Cipher, 'A' becomes which letter?",
        options: ["B", "C", "D", "E"],
        correctAnswerIndex: 2,
      ),
      QuizQuestion(
        question: "What does an ENCRYPTION ALGORITHM do?",
        options: [
          "Deletes messages",
          "Turns normal text into secret code",
          "Sends emails",
          "Plays music",
        ],
        correctAnswerIndex: 1,
      ),
      QuizQuestion(
        question: "Why do we use cryptography today?",
        options: [
          "To play games faster",
          "To protect our data and privacy",
          "To make websites colorful",
          "To download movies",
        ],
        correctAnswerIndex: 1,
      ),
      QuizQuestion(
        question: "What does the person receiving a secret message need?",
        options: [
          "A new phone",
          "The secret key to decode",
          "A faster internet",
          "A bigger screen",
        ],
        correctAnswerIndex: 1,
      ),
      QuizQuestion(
        question: "Cryptography is mostly about...",
        options: [
          "Making websites pretty",
          "Keeping information secret and safe",
          "Playing online games",
          "Watching videos",
        ],
        correctAnswerIndex: 1,
      ),
    ],
  ),

  // ==================== QUIZ 2: SPOT FAKE TRAPS ====================
  QuizTopic(
    id: "fake_traps",
    title: "Spot Fake Traps Quiz",
    iconEmoji: "🛡️",
    questions: [
      QuizQuestion(
        question: "What does the 'S' in HTTPS stand for?",
        options: ["Speed", "Secure", "Simple", "Social"],
        correctAnswerIndex: 1,
      ),
      QuizQuestion(
        question: "Which one is safer?",
        options: [
          "http://site.com",
          "ftp://site.com",
          "https://site.com",
          "site.com",
        ],
        correctAnswerIndex: 2,
      ),
      QuizQuestion(
        question: "Where should the real padlock icon appear?",
        options: [
          "Inside the website image",
          "In the browser's address bar",
          "On the keyboard",
          "On the desktop wallpaper",
        ],
        correctAnswerIndex: 1,
      ),
      QuizQuestion(
        question: "What is a fake website called?",
        options: [
          "A real website",
          "A copycat or phishing site",
          "A search engine",
          "A blog",
        ],
        correctAnswerIndex: 1,
      ),
      QuizQuestion(
        question: "Which URL looks suspicious?",
        options: [
          "www.google.com",
          "www.youtube.com",
          "vvv.roblox-free.com",
          "www.wikipedia.org",
        ],
        correctAnswerIndex: 2,
      ),
      QuizQuestion(
        question: "What is a DIGITAL CERTIFICATE?",
        options: [
          "A paper document",
          "A website's cyber passport proving it's safe",
          "A type of video game",
          "An email attachment",
        ],
        correctAnswerIndex: 1,
      ),
      QuizQuestion(
        question: "What happens if a website's certificate is expired?",
        options: [
          "The website loads faster",
          "Your browser shows a warning",
          "Nothing happens",
          "The website becomes free",
        ],
        correctAnswerIndex: 1,
      ),
      QuizQuestion(
        question: "In HTTP, your data travels...",
        options: [
          "In a locked safe",
          "Naked, unprotected",
          "Through a secret tunnel",
          "Only at night",
        ],
        correctAnswerIndex: 1,
      ),
      QuizQuestion(
        question: "Cyber criminals create fake websites to...",
        options: [
          "Help you learn",
          "Steal your passwords and information",
          "Make you laugh",
          "Send you gifts",
        ],
        correctAnswerIndex: 1,
      ),
      QuizQuestion(
        question: "What should you always check on a website?",
        options: [
          "The color of the background",
          "The address bar for HTTPS and correct domain",
          "The font size",
          "How many images it has",
        ],
        correctAnswerIndex: 1,
      ),
    ],
  ),

  // ==================== QUIZ 3: SAFE COMMUNICATION ====================
  QuizTopic(
    id: "safe_comms",
    title: "Safe Communication Quiz",
    iconEmoji: "💬",
    questions: [
      QuizQuestion(
        question: "In SYMMETRIC encryption, how many keys are used?",
        options: [
          "Two different keys",
          "The same key for lock and unlock",
          "No keys at all",
          "Ten keys",
        ],
        correctAnswerIndex: 1,
      ),
      QuizQuestion(
        question: "In ASYMMETRIC encryption, how many keys do you have?",
        options: [
          "One key (private only)",
          "Two keys (public and private)",
          "Three keys",
          "No keys",
        ],
        correctAnswerIndex: 1,
      ),
      QuizQuestion(
        question: "Your PUBLIC key can be...",
        options: [
          "Kept secret forever",
          "Shared with anyone",
          "Thrown away",
          "Used only once",
        ],
        correctAnswerIndex: 1,
      ),
      QuizQuestion(
        question: "Your PRIVATE key must be...",
        options: [
          "Posted on social media",
          "Kept secret, only for you",
          "Given to everyone",
          "Deleted immediately",
        ],
        correctAnswerIndex: 1,
      ),
      QuizQuestion(
        question: "What is End-to-End Encryption?",
        options: [
          "Only the sender's message is encrypted",
          "Message stays encrypted from sender to receiver",
          "The message is never encrypted",
          "Only the receiver can encrypt",
        ],
        correctAnswerIndex: 1,
      ),
      QuizQuestion(
        question: "Which app uses End-to-End Encryption?",
        options: [
          "WhatsApp (Signal protocol)",
          "A calculator app",
          "A weather app",
          "A flashlight app",
        ],
        correctAnswerIndex: 0,
      ),
      QuizQuestion(
        question:
            "Can the app company read your end-to-end encrypted messages?",
        options: [
          "Yes, always",
          "No, they cannot",
          "Only on weekends",
          "Only if you pay",
        ],
        correctAnswerIndex: 1,
      ),
      QuizQuestion(
        question: "Symmetric encryption is...",
        options: [
          "Very slow",
          "Super fast but key sharing is tricky",
          "Impossible to use",
          "Only for pictures",
        ],
        correctAnswerIndex: 1,
      ),
      QuizQuestion(
        question: "Asymmetric encryption is great for...",
        options: [
          "Playing games",
          "Internet banking and shopping safely",
          "Watching movies",
          "Taking photos",
        ],
        correctAnswerIndex: 1,
      ),
      QuizQuestion(
        question: "What happens if a hacker intercepts an encrypted message?",
        options: [
          "They can read it easily",
          "They see only scrambled, unreadable code",
          "The message disappears",
          "Their computer crashes",
        ],
        correctAnswerIndex: 1,
      ),
    ],
  ),

  // ==================== QUIZ 4: CYBER AWARENESS ====================
  QuizTopic(
    id: "cyber_awareness",
    title: "Cyber Awareness Quiz",
    iconEmoji: "🧠",
    questions: [
      QuizQuestion(
        question: "How long should a strong password be?",
        options: [
          "At least 3 characters",
          "At least 6 characters",
          "At least 12 characters",
          "Only 1 character",
        ],
        correctAnswerIndex: 2,
      ),
      QuizQuestion(
        question: "Which password is the STRONGEST?",
        options: ["123456", "password", "BlueBananaJump7!", "roblox123"],
        correctAnswerIndex: 2,
      ),
      QuizQuestion(
        question: "How fast can 'roblox123' be cracked?",
        options: ["2 million years", "2 seconds", "Never", "1000 years"],
        correctAnswerIndex: 1,
      ),
      QuizQuestion(
        question: "What is Quantum Cryptography?",
        options: [
          "Using math for encryption",
          "Using light particles for ultra-secure codes",
          "Using sound waves",
          "Using pen and paper",
        ],
        correctAnswerIndex: 1,
      ),
      QuizQuestion(
        question: "What happens if a hacker tries to steal a quantum message?",
        options: [
          "They succeed easily",
          "The light particles self-destruct and alert the system",
          "The message becomes longer",
          "Nothing happens",
        ],
        correctAnswerIndex: 1,
      ),
      QuizQuestion(
        question: "The three-word trick helps you create...",
        options: [
          "A short password",
          "A strong, memorable password",
          "A username",
          "An email address",
        ],
        correctAnswerIndex: 1,
      ),
      QuizQuestion(
        question: "Why are simple passwords dangerous?",
        options: [
          "They are too colorful",
          "Computers can guess them very quickly",
          "They take too long to type",
          "They have too many letters",
        ],
        correctAnswerIndex: 1,
      ),
      QuizQuestion(
        question: "What is your most important cyber protection?",
        options: [
          "A fast computer",
          "Your awareness and strong passwords",
          "A big monitor",
          "Lots of RAM",
        ],
        correctAnswerIndex: 1,
      ),
      QuizQuestion(
        question: "Quantum computers will be...",
        options: [
          "Slower than normal computers",
          "Ultra-powerful, can crack normal codes",
          "The same as normal computers",
          "Only for gaming",
        ],
        correctAnswerIndex: 1,
      ),
      QuizQuestion(
        question: "What makes you a 'Cyber Hero'?",
        options: [
          "Playing lots of games",
          "Knowing how to protect yourself online",
          "Having many followers",
          "Using social media all day",
        ],
        correctAnswerIndex: 1,
      ),
    ],
  ),
];
