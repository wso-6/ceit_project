
## Project file
# BTO3102 TEAM 4 CYBERDETECTIVE MOBILE APPLICATION DEVELOPMENT REPORT
[Team4_CompNets_OS_final_report](https://stdyildizedu-my.sharepoint.com/:w:/g/personal/aysegul_kaya1_std_yildiz_edu_tr/IQDufxLWlheUQ55USPRJsdssAY091ntHYmxJHRvOcIWGal0?e=UzkAdx)

### Team Information
* **Team Number:** TEAM-4
* **Developers:**
  * Ayşegül Kaya – 23091025
  * Zeynep Büşra Demir – 23091602
  * Zeynep Sena Yıldız – 23091021


## 1. Project Overview & Academic Background
This report encompasses the design, pedagogical, and software development processes of the CyberDetective mobile application, developed as a collaborative joint term project for the Computer Networks and Operating Systems courses within the Department of Computer Education and Instructional Technology (CEIT).

The theoretical and content foundation of the project is strictly built upon Chapter 8: Cryptography, which is positioned in Week 15 of the Computer Networks curriculum. Concurrently, the application's system architecture, background processes, and user session workflows are modeled using core technical competencies acquired from the Operating Systems course. The application stands as an interactive, comprehensive platform engineered to enhance cybersecurity, cryptography, and cyber awareness among middle school students.

**Application Demo Video:** [Watch the CyberDetective Walkthrough Video](#) *(A comprehensive demonstration of the UI/UX flow, modular course content, and educational game mechanics).*
 **GitHub Repository:** [Access CyberDetective Source Code](#) *(The complete, deployment-ready production source code repository, including all assets and Flutter configurations).*

---

## 2. Design Methodology: The ADDIE Model
The CyberDetective application was structured under the systematic guidance of the ADDIE (Analysis, Design, Development, Implementation, Evaluation) instructional design framework.

### 2.1. Analysis
* **Content Analysis:** Abstract and complex concepts within Chapter 8 of the Computer Networks course were analyzed and deconstructed into 4 fundamental, digestible instructional pillars tailored for the middle school level:
  * What is Cryptography?
  * Deceptive Traps (HTTPS)
  * Secure Communication
  * Cyber Awareness
* **Target Audience Analysis:** Middle school students, who are currently developing abstract reasoning skills and remain highly vulnerable to online risks, were chosen as the target demographic. This age group's digital tendencies, user experience (UX) expectations, and behavioral responses to gamified environments were thoroughly analyzed.

### 2.2. Design
* **Pedagogical Design (Skinner’s Programmed Instruction Theory):** The entire instructional delivery process is grounded in B.F. Skinner’s Programmed Instruction theory. To optimize cognitive load management, the 4 core topics were broken down into small steps (modules). This structural choice enables students to progress at their own pace (individualized pacing) while receiving immediate reinforcement (immediate feedback).
* **Visual Design:** A dark navy blue color palette was deliberately chosen to sustain learner focus and prevent the feeling of unregulated screen time. The typography and fonts were selected for their high readability and dynamic nature to natively appeal to middle school students.

### 2.3. Development (Technical & Software Infrastructure)
* **Architecture & Object-Oriented Programming:** The application was programmed using the Flutter SDK and Android Studio IDE, leveraging asynchronous execution patterns across platforms. It utilizes Object-Oriented Programming (OOP) principles to enforce a clean-code architecture.
* **User & Session Management:** A technical infrastructure for user registration and secure session handling was implemented to ensure safe intra-app data flows. Profile metrics and application states are processed securely directly on the device storage using a Local Storage / SharedPreferences architecture.
* **Embedded Media & Performance Optimization:** Lecture and topic videos are directly embedded into the software core using a Native Embedded Video Player. By completely eliminating external web browser redirects or heavy intents, the system dramatically optimizes memory (RAM) and processor (CPU) performance, preventing any disruptions to the user's attention.
* **State Management:** Module completion flags, instantaneous UI color transitions, earned experience points (XP), and dynamic level advancements are entirely handled by Flutter’s reactive State Management layer, ensuring seamless interface re-rendering.

### 2.4. Implementation
* **Deployment-Ready Scenario:** The CyberDetective application is engineered as a deployment-ready production prototype, fully prepared for either individual learning or collective classroom simulations. The underlying system architecture supports a technical user hierarchy where students log in as dedicated class members, successfully prototyping future peer-interaction models.

### 2.5. Evaluation
* **In-App Data Analytics:** To natively measure instructional effectiveness, data collection and measurement tools are integrated directly into the software architecture. The system tracks module completion logs, quiz data outputs (correct/incorrect counts, completion time metrics in milliseconds, and net scores), alongside XP/level advancements at the database level. This builds a self-contained technical evaluation layer that measures the application's impact on raising cybersecurity awareness.

---

## 3. System Architecture and User Experience (UX) Flow

### 3.1. Authentication and Account Management
* **Initial Registration:** Upon creating an account through a simplified interface, the student is automatically mapped to their respective classroom model as a distinct "member" within the backend data models, fostering peer learning and healthy classroom competition.
* **Subsequent Logins:** Users authenticate via the "Login" screen and are routed instantly to their personalized Dashboard.

### 3.2. Main Navigation and Core Modules
A persistent 4-button Bottom Navigation Bar acts as the functional backbone of the application's user experience:

#### A. Course Content (Modular Learning Area)
The cybersecurity and cryptography curriculum is organized into 4 primary sections, with each section divided into concise sub-modules.
* **Three-Tier Content Structure:** Every sub-module provides a uniform layout consisting of Visual Content, level-appropriate Educational Video Content, and Text Content.
* **"Completed" Trigger Mechanism:** When students finish a module at their own pace and tap the "Completed" button, a state change forces an instant UI re-render, changing the module card's color to green. This visual shift technically satisfies Skinner's pedagogical concept of "immediate reward" to enhance sustainable learner motivation.
* **Bridge to Assessment:** The final module of each section includes an integrated bridge button that routes the user directly to that section's specific quiz.

#### B. Quizzes (Assessment & Measurement)
Students can access quizzes seamlessly either upon completing a section's final module or directly through the bottom navigation bar.
* **Parametric Transparency:** Prior to starting a quiz, parameters such as the exact question count and time limits are displayed transparently to reduce test anxiety.
* **Performance Metrics:** Upon quiz completion, metrics including completion date, correct/incorrect counts, and final scores are calculated via dynamic algorithms and rendered immediately, providing vital pedagogical "immediate feedback."

#### C. Game Zone (Educational Games & Cyber Cryptography)
To reinforce cryptography concepts through gamification, 3 mini educational games are available:
1. **Message Detective** (Encryption/Decryption Mechanics)
2. **Password Warrior** (Secure Protocol Algorithms)
3. **URL Hunter** (HTTPS/Phishing Detection)
* **Game Panel & Data Tracking:** Tapping the Game icon on the navigation bar displays these three games. The user's cumulative gaming statistics (total score, games played, % completion rate) are centrally tracked via a unified state data model on the same screen.

#### D. Profile Page & Gamification
The profile page acts as a central hub displaying the student's personal metrics and classroom assignments.
* **Level & XP Algorithm:** A global gamification loop runs across the application ecosystem. Course progression and mini-game accomplishments are continuously committed to the database as XP (Experience Points). Students can monitor their calculated "Detective Level" title from both the profile dashboard and the course interface, boosting social learning motivation when utilized in a classroom setting.
## How to Run

```bash
flutter pub get
flutter run
```
