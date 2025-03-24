import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elaros_gp4/Controller/questionnaire_controller.dart';

class QuestionnaireView extends StatefulWidget {
  const QuestionnaireView({super.key});

  @override
  QuestionnaireViewState createState() => QuestionnaireViewState();
}

class QuestionnaireViewState extends State<QuestionnaireView> {
  final QuestionnaireController _controller = QuestionnaireController();
  final Map<int, Map<int, String>> _answers = {};
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _handleSubmit() async {
    print('User answers: $_answers');

    Map<String, dynamic> answersToStore = {};
    _answers.forEach((questionIndex, answers) {
      final question = _controller.questions[questionIndex];
      answers.forEach((subQuestionIndex, answer) {
        final subQuestion = question.questionText[subQuestionIndex];
        answersToStore[
                'Q${questionIndex + 1}_S${subQuestionIndex + 1}_ ${subQuestion.substring(0, 22)}'] =
            answer;
      });
    });

    await FirebaseFirestore.instance
        .collection('questionnaire_answers')
        .add(answersToStore);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Answers Submitted Successfully!')),
    );
  }

  double _calculateProgress() {
    return (_currentPage + 1) / _controller.questions.length;
  }

  List<Widget> _buildQuestionCards() {
    return _controller.questions.asMap().entries.map((entry) {
      int index = entry.key;
      var question = entry.value;

      return SizedBox(
        height: 200,
        child: Card(
          margin: EdgeInsets.all(16.0),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  question.questionTitle,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                ...List.generate(question.questionText.length, (qIndex) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        question.questionText[qIndex],
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(height: 10),
                      ...question.answers[qIndex].map((answer) {
                        return RadioListTile<String>(
                          title: Text(answer, style: TextStyle(fontSize: 14)),
                          value: answer,
                          groupValue: _answers[index]?[qIndex],
                          onChanged: (value) {
                            setState(() {
                              _answers[index] ??= {};
                              _answers[index]![qIndex] = value!;
                            });
                          },
                        );
                      }),
                      SizedBox(height: 10),
                      if (qIndex < question.questionText.length - 1)
                        Divider(color: Colors.grey, indent: 25, endIndent: 25),
                      if (qIndex < question.questionText.length - 1)
                        SizedBox(height: 10),
                    ],
                  );
                }),
              ],
            ),
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 249, 232, 184),
      appBar: AppBar(
        elevation: 4,
        title: Row(
          children: [
            Image.asset('Assets/SleepyFoxLogo512.png', width: 45, height: 45),
            const SizedBox(width: 10),
            const Text('Questionnaire'),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: 8,
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: _calculateProgress()),
                duration: Duration(milliseconds: 750),
                builder: (context, value, _) => LinearProgressIndicator(
                  value: value,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                ),
              ),
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: _buildQuestionCards(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_currentPage < _controller.questions.length - 1) {
            _pageController.nextPage(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          } else {
            _handleSubmit();
          }
        },
        child: Icon(Icons.arrow_forward),
      ),
    );
  }

}
