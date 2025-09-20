import 'package:flutter/material.dart';
import 'dart:math';
import 'package:confetti/confetti.dart';

class QuizPage extends StatefulWidget {
  final String courseTitle;

  const QuizPage({
    super.key,
    required this.courseTitle,
  });

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> with TickerProviderStateMixin {
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _quizCompleted = false;
  late AnimationController _animationController;
  late Animation<double> _animation;
  List<int> _selectedAnswers = [];
  bool _answerSelected = false;
  bool _showCorrectAnswer = false;
  ConfettiController? _confettiController;

  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'Which of the following is not a valid C data type?',
      'options': [
        'int',
        'float',
        'string',
        'char'
      ],
      'correctIndex': 2,
      'explanation': 'In C, "string" is not a built-in data type. Strings are represented as arrays of characters.'
    },
    {
      'question': 'What is the correct way to declare a pointer to an integer in C?',
      'options': [
        'int ptr;',
        'pointer int ptr;',
        'int *ptr;',
        'int &ptr;'
      ],
      'correctIndex': 2,
      'explanation': 'A pointer to an integer is declared using the asterisk (*) symbol before the variable name.'
    },
    {
      'question': 'Which function is used to read a character from the standard input in C?',
      'options': [
        'scanf()',
        'getchar()',
        'gets()',
        'read()'
      ],
      'correctIndex': 1,
      'explanation': 'getchar() is used to read a single character from the standard input.'
    },
    {
      'question': 'What is the value of x after the following code is executed? int x = 5; x += 3; x *= 2;',
      'options': [
        '13',
        '16',
        '10',
        '8'
      ],
      'correctIndex': 1,
      'explanation': 'First, x becomes 5+3=8, then x becomes 8*2=16.'
    },
    {
      'question': 'Which of the following is not a loop structure in C?',
      'options': [
        'while',
        'for',
        'do-while',
        'foreach'
      ],
      'correctIndex': 3,
      'explanation': 'C doesn\'t have a foreach loop. It only has while, for, and do-while loops.'
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 30),
      vsync: this,
    );
    _animation = Tween(begin: 1.0, end: 0.0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _nextQuestion();
        }
      });
    _animationController.forward();

    _selectedAnswers = List.filled(_questions.length, -1);
    
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 3),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _confettiController?.dispose();
    super.dispose();
  }

  void _checkAnswer(int selectedIndex) {
    if (_answerSelected) return;
    
    setState(() {
      _answerSelected = true;
      _showCorrectAnswer = true;
      _selectedAnswers[_currentQuestionIndex] = selectedIndex;
      
      if (selectedIndex == _questions[_currentQuestionIndex]['correctIndex']) {
        _score++;
      }
    });
    
    _animationController.stop();
    
    // Delay before moving to next question
    Future.delayed(const Duration(seconds: 2), () {
      _nextQuestion();
    });
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _answerSelected = false;
        _showCorrectAnswer = false;
      });
      _animationController.reset();
      _animationController.forward();
    } else {
      setState(() {
        _quizCompleted = true;
      });
      if (_score >= (_questions.length * 0.7).round()) {
        _confettiController?.play();
      }
    }
  }

  void _restartQuiz() {
    setState(() {
      _currentQuestionIndex = 0;
      _score = 0;
      _quizCompleted = false;
      _selectedAnswers = List.filled(_questions.length, -1);
      _answerSelected = false;
      _showCorrectAnswer = false;
    });
    _animationController.reset();
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.courseTitle} Quiz'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: _quizCompleted ? _buildResultScreen() : _buildQuizScreen(),
    );
  }

  Widget _buildQuizScreen() {
    return Column(
      children: [
        // Timer Bar
        LinearProgressIndicator(
          value: _animation.value,
          backgroundColor: Colors.grey.shade200,
          color: _animation.value > 0.3
              ? Theme.of(context).colorScheme.primary
              : Colors.red,
          minHeight: 8,
        ),
        
        // Progress Indicator
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Question ${_currentQuestionIndex + 1}/${_questions.length}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Score: $_score',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ],
          ),
        ),
        
        // Question
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Question Text
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    _questions[_currentQuestionIndex]['question'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                
                // Options
                ..._buildOptions(),
                
                // Explanation
                if (_showCorrectAnswer) ...[
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.blue.shade200,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.info,
                              color: Colors.blue.shade700,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Explanation',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _questions[_currentQuestionIndex]['explanation'],
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        
        // Next Question Button (Only shown after answering)
        if (_answerSelected)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _nextQuestion,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                _currentQuestionIndex < _questions.length - 1
                    ? 'Next Question'
                    : 'Finish Quiz',
              ),
            ),
          ),
      ],
    );
  }

  List<Widget> _buildOptions() {
    final List<Widget> options = [];
    final currentQuestion = _questions[_currentQuestionIndex];
    
    for (int i = 0; i < currentQuestion['options'].length; i++) {
      final bool isCorrect = i == currentQuestion['correctIndex'];
      final bool isSelected = _selectedAnswers[_currentQuestionIndex] == i;
      
      Color cardColor = Colors.white;
      Color borderColor = Colors.grey.shade300;
      
      if (_showCorrectAnswer) {
        if (isCorrect) {
          cardColor = Colors.green.shade50;
          borderColor = Colors.green;
        } else if (isSelected) {
          cardColor = Colors.red.shade50;
          borderColor = Colors.red;
        }
      } else if (isSelected) {
        // ignore: deprecated_member_use
        cardColor = Theme.of(context).colorScheme.primary.withOpacity(0.1);
        borderColor = Theme.of(context).colorScheme.primary;
      }
      
      options.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: InkWell(
            onTap: _answerSelected ? null : () => _checkAnswer(i),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: borderColor,
                  width: 2,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: _showCorrectAnswer
                          ? isCorrect
                              ? Colors.green
                              : isSelected
                                  ? Colors.red
                                  : Colors.grey.shade200
                          : isSelected
                              ? Theme.of(context).colorScheme.primary
                              : Colors.grey.shade200,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      String.fromCharCode(65 + i), // A, B, C, D
                      style: TextStyle(
                        color: _showCorrectAnswer
                            ? isCorrect || isSelected
                                ? Colors.white
                                : Colors.black
                            : isSelected
                                ? Colors.white
                                : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      currentQuestion['options'][i],
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  if (_showCorrectAnswer && isCorrect)
                    const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    )
                  else if (_showCorrectAnswer && isSelected && !isCorrect)
                    const Icon(
                      Icons.close,
                      color: Colors.red,
                    ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    
    return options;
  }

  Widget _buildResultScreen() {
    final int totalQuestions = _questions.length;
    final double percentage = (_score / totalQuestions) * 100;
    final bool passed = percentage >= 70;
    
    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 24),
              
              // Trophy icon
              Icon(
                passed ? Icons.emoji_events : Icons.school,
                size: 100,
                color: passed
                    ? Colors.amber
                    : Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 24),
              
              // Result title
              Text(
                passed ? 'Congratulations!' : 'Quiz Completed',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: passed
                      ? Colors.amber.shade800
                      : Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              
              // Result message
              Text(
                passed
                    ? 'You successfully passed the quiz!'
                    : 'Keep practicing to improve your score.',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              
              // Score card
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'Your Score',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 150,
                          height: 150,
                          child: CircularProgressIndicator(
                            value: _score / totalQuestions,
                            strokeWidth: 12,
                            backgroundColor: Colors.grey.shade200,
                            color: passed
                                ? Colors.green
                                : Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              '$percentage%',
                              style: const TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '$_score/$totalQuestions correct',
                              style: TextStyle(
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Correct Answers: $_score',
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Icon(
                          Icons.cancel,
                          color: Colors.red.shade400,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Wrong Answers: ${totalQuestions - _score}',
                          style: TextStyle(
                            color: Colors.red.shade400,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              
              // Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _restartQuiz,
                      icon: const Icon(Icons.replay),
                      label: const Text('Retry Quiz'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Theme.of(context).colorScheme.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.home),
                      label: const Text('Back to Course'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 24),
              
              // View answers button
              TextButton.icon(
                onPressed: () {
                  // Show review dialog
                  showDialog(
                    context: context,
                    builder: (context) => _buildReviewDialog(),
                  );
                },
                icon: const Icon(Icons.visibility),
                label: const Text('View Correct Answers'),
              ),
              
              if (passed) ...[
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.green.shade200),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.workspace_premium,
                        color: Colors.green.shade700,
                        size: 32,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Certificate of Completion',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green.shade700,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'You\'ve earned a certificate for ${widget.courseTitle}!',
                              style: TextStyle(
                                color: Colors.green.shade900,
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('View'),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
        
        // Confetti animation for passed quiz
        if (passed)
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController!,
              blastDirection: pi / 2,
              maxBlastForce: 5,
              minBlastForce: 1,
              emissionFrequency: 0.05,
              numberOfParticles: 20,
              gravity: 0.2,
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple,
                Colors.red,
                Colors.yellow,
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildReviewDialog() {
    return AlertDialog(
      title: Text(
        'Quiz Review',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: _questions.length,
          itemBuilder: (context, index) {
            final question = _questions[index];
            final int selectedAnswer = _selectedAnswers[index];
            final int correctAnswer = question['correctIndex'];
            final bool isCorrect = selectedAnswer == correctAnswer;
            
            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              color: isCorrect ? Colors.green.shade50 : Colors.red.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: isCorrect ? Colors.green : Colors.red,
                          foregroundColor: Colors.white,
                          child: Icon(
                            isCorrect ? Icons.check : Icons.close,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Question ${index + 1}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      question['question'],
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 12),
                    if (selectedAnswer >= 0) ...[
                      Text(
                        'Your answer: ${question['options'][selectedAnswer]}',
                        style: TextStyle(
                          color: isCorrect ? Colors.green.shade700 : Colors.red.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                    ],
                    if (!isCorrect)
                      Text(
                        'Correct answer: ${question['options'][correctAnswer]}',
                        style: TextStyle(
                          color: Colors.green.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
      ],
    );
  }
}

class ConfettiWidget extends StatelessWidget {
  final ConfettiController confettiController;
  final double blastDirection;
  final double maxBlastForce;
  final double minBlastForce;
  final double emissionFrequency;
  final int numberOfParticles;
  final double gravity;
  final List<Color> colors;

  const ConfettiWidget({
    super.key,
    required this.confettiController,
    required this.blastDirection,
    required this.maxBlastForce,
    required this.minBlastForce,
    required this.emissionFrequency,
    required this.numberOfParticles,
    required this.gravity,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      color: Colors.transparent,
    );
  }
}