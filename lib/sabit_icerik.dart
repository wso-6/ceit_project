import './content_model.dart';
import 'dart:ui';

final List<MainTopic> allTopics = [
  // ==================== TOPIC 1: WHAT IS CRYPTOGRAPHY? ====================
  MainTopic(
    id: "crypto_intro",
    title: "What is Cryptography?",
    iconEmoji: "🔐",
    color: const Color.fromARGB(255, 15, 97, 99),
    modules: [
      Module(
        number: 1,
        title: "Secret Agents at Work",
        description: "What is Cryptography? The science of secret codes",
        detailedContent: """
What is Cryptography?

In our daily lives, when we chat with our friends, we want our messages to stay just between us, right? In the cyber world, the science used to stop bad guys from stealing our messages, photos, or passwords is called CRYPTOGRAPHY (The Science of Encryption).

How Does the Process Work?

1. PLAINTEXT: This is the normal, unencrypted message that anyone can easily read. (Example: "Hi, let's meet today!")

2. ENCRYPTION ALGORITHM: These are the mathematical rules used to turn a normal message into a secret code.

3. CIPHERTEXT: This is the secret, scrambled version made of confusing letters and numbers. Anyone looking from the outside cannot understand it.
""",
        videoUrl: "https://youtu.be/GQvu49c0ZZc",
        imageAsset: "assets/t1 m1.png",
        hasQuiz: false,
        quizId: null,
      ),
      Module(
        number: 2,
        title: "Caesar's Secret Code",
        description: "The first encryption method in history",
        detailedContent: """
History's First Secret Codes: The Caesar Cipher

Long time ago, the famous Roman Emperor Julius Caesar wanted to send secret orders to his generals. He was terrified that his enemies might intercept and read his messages. To solve this problem, he invented a brilliant method: SHIFTING LETTERS!

Caesar wrote his messages by replacing each letter with the letter that comes 3 places after it in the alphabet.

- For example, instead of the letter "A", he wrote "D"
- Instead of "B", he wrote "E"

The person receiving the message knew the secret key: "Go back 3 letters!" Thanks to this key, they could easily decode the secret message back into normal text.

Today, our computers use much more advanced versions of this exact idea to protect our data in the cyber world!
""",
        videoUrl: "https://youtu.be/sMOZf4GN3oc",
        imageAsset: null,
        hasQuiz: true, // ✅ Son modül - Quiz var
        quizId: "caesar_quiz",
      ),
    ],
  ),

  // ==================== TOPIC 2: SPOT FAKE TRAPS ====================
  MainTopic(
    id: "fake_traps",
    title: "Spot Fake Traps",
    iconEmoji: "🛡️",
    color: const Color.fromARGB(255, 90, 95, 201),
    modules: [
      Module(
        number: 1,
        title: "The Clash of HTTP vs HTTPS",
        description: "The secure shield - What does the 'S' mean?",
        detailedContent: """
HTTP vs. HTTPS: Which One is the Shield? 🛡️

When you visit a website to play games or watch videos, look closely at the address bar at the very top. You will see either http:// or https://. That tiny letter "S" stands for SECURE (Safe)!

What is the Difference?

- HTTP (Unsafe): Your data travels through the internet naked! If you type a password here, cyber criminals can easily see and steal it.

- HTTPS (Safe): This website uses CRYPTOGRAPHY! Before your data leaves your computer, it puts on a powerful invisibility cloak (encryption). Even if hackers catch your data, they only see scrambled codes!
""",
        videoUrl: "https://youtube.com/shorts/bJGNl0Sv1kw",
        imageAsset: "assets/t2 m1.png", // HTTPS vs HTTP görseli
        hasQuiz: false,
        quizId: null,
      ),
      Module(
        number: 2,
        title: "The Copycat Lock Game",
        description: "How to spot fake websites",
        detailedContent: """
Don't Be Fooled by Copycats! 🐱❌

Cyber criminals are very tricky. Sometimes, they create a fake website that looks exactly like your favorite game login page. They might even put a fake padlock (lock) icon on the website design itself to make you feel safe!

How to Spot the Copycat Trap?

1. Check the Real Address Bar: The real safety lock is ALWAYS inside the browser's address bar (next to the website link), not inside the website background image.

2. Look for Weird Letters: Hackers use fake names like vvv.roblox-free.com instead of the real website link. Always read the domain name carefully, letter by letter!
""",
        videoUrl: "",
        imageAsset: null,
        hasQuiz: false,
        quizId: null,
      ),
      Module(
        number: 3,
        title: "Digital Certificate Detective",
        description: "The cyber passport of websites",
        detailedContent: """
The Cyber Passport: Digital Certificates 🎫

Just like you need a passport to travel to another country, websites need a DIGITAL CERTIFICATE to prove they are safe and encrypted.

When you click on the padlock icon next to a website's name, your browser shows you this certificate. It tells you exactly who owns the website and proves that the cryptography system is working perfectly.

If a website's passport is expired or fake, your computer will show a big red warning page: "Your connection is not private!" If you see that warning, turn back immediately!
""",
        videoUrl: "https://youtu.be/c-O-uMxTaEw",
        imageAsset: null,
        hasQuiz: true, // ✅ Son modül - Quiz var
        quizId: "certificate_quiz",
      ),
    ],
  ),

  // ==================== TOPIC 3: SAFE COMMUNICATION ====================
  MainTopic(
    id: "safe_comms",
    title: "Safe Communication",
    iconEmoji: "💬",
    color: const Color.fromARGB(255, 202, 83, 129),
    modules: [
      Module(
        number: 1,
        title: "The Magic Keys",
        description: "Symmetric & Asymmetric Encryption",
        detailedContent: """
How Do We Share Secrets Online? 🔑

Imagine you want to send a secret treasure box to your friend. How can you lock it so no one on the road can open it? In the cyber world, computers use two different types of magical keys to do this:

1. SYMMETRIC ENCRYPTION (The Single Key):
You and your friend use the EXACT same key to both lock and unlock the box. It is super fast, but you must find a safe way to share the key with your friend first!

2. ASYMMETRIC ENCRYPTION (The Double Keys):
This is the real internet magic. Everyone has two keys: a PUBLIC KEY (which anyone can use to lock a box for you) and a PRIVATE KEY (which stays only with you to unlock it). It is the ultimate shield for modern internet banking and shopping!
""",
        videoUrl: "https://youtu.be/-9rK3EZop_M",
        imageAsset: null,
        hasQuiz: false,
        quizId: null,
      ),
      Module(
        number: 2,
        title: "The Invisible Tunnel",
        description: "End-to-End Encryption explained",
        detailedContent: """
What is End-to-End Encryption? 🚇

When you chat with your friends on apps like WhatsApp or Signal, you might see a small note saying: "Messages are end-to-end encrypted." What does this mean?

It means your message turns into a secret code the exact millisecond you press the "Send" button. It travels through the internet inside an INVISIBLE, UNBREAKABLE TUNNEL.

- Not even the chat app company, the internet provider, or a hacker can peer inside this tunnel.
- The message can ONLY be unlocked and read by the phone of the friend you sent it to.

Your secrets stay completely safe!
""",
        videoUrl: "https://youtu.be/TImdsUglGv4",
        imageAsset: null,
        hasQuiz: false,
        quizId: null,
      ),
    ],
  ),

  // ==================== TOPIC 4: CYBER AWARENESS ====================
  MainTopic(
    id: "cyber_awareness",
    title: "Cyber Awareness",
    iconEmoji: "🧠",
    color: const Color.fromARGB(255, 191, 108, 53),
    modules: [
      Module(
        number: 1,
        title: "Creating an Unbreakable Password",
        description: "Be a Password Alchemist!",
        detailedContent: """
Be a Password Alchemist! 🧪

Computers are incredibly fast at guessing simple passwords like 123456, password, or your birth year. To protect your games and accounts, you need to create a CRYPTOGRAPHICALLY STRONG PASSWORD - a password that would take computers millions of years to guess!

The Secret Formula:

- Length Wins: Make it at least 12 characters long.
- The Three-Word Trick: Pick 3 random, funny words and put them together (e.g., BlueBananaJump!). It is super easy for you to remember, but impossible for a hacker's computer to guess!
- Mix it Up: Throw in a few numbers and special symbols (like #, ?, *).

DANGER: "roblox123" can be cracked in 2 seconds!
SECURE: "PurpleCloudDance7!" takes 2 million years to crack.
""",
        videoUrl: "",
        imageAsset: "assets/t4 m1.png", // Şifre görseli
        hasQuiz: false,
        quizId: null,
      ),
      Module(
        number: 2,
        title: "The Future of Secrets",
        description: "Quantum Cryptography",
        detailedContent: """
The Next Generation: Quantum Cryptography 🚀

Technology never stops! In the near future, ultra-powerful supercomputers called QUANTUM COMPUTERS will arrive. These computers will be so fast that they could easily crack our normal, everyday codes.

But don't worry! Cyber scientists are already building a new superpower called QUANTUM CRYPTOGRAPHY. Instead of using math and numbers, this system uses LIGHT PARTICLES (PHOTONS) to send secret codes!

If a hacker tries to steal or look at a quantum message, the light particles instantly change their shape and self-destruct, alerting the system immediately. It is the ultimate sci-fi protection!
""",
        videoUrl: "https://youtu.be/UiJiXNEm-Go",
        imageAsset: null,
        hasQuiz: false,
        quizId: null,
      ),
      Module(
        number: 3,
        title: "The Ultimate Cyber Hero Test",
        description: "Your cyber journey is complete!",
        detailedContent: """
Your Cyber Journey is Complete! 🎓

Look how far you've come! You started as a beginner and now you are a true CYBER HERO. You know:
- How text turns into secret codes
- How Caesar shifted his letters
- Why the "S" in HTTPS keeps us safe
- How to spot copycat websites
- The magic of encryption keys
- How to create unbreakable passwords

Remember, the internet is a vast and beautiful world, but it requires smart protectors like you. Keep your keys safe, always double-check the address bar, and use your cryptography awareness to stay one step ahead of cyber traps!
""",
        videoUrl: "",
        imageAsset: null,
        hasQuiz: true, // ✅ Son modül - Final Quiz
        quizId: "final_hero_quiz",
      ),
    ],
  ),
];
