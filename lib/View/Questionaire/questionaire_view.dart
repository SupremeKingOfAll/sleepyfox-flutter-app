import 'package:flutter/material.dart';
import 'package:elaros_gp4/Controller/questionnaire_controller.dart';

class QuestionnaireView extends StatefulWidget {
  const QuestionnaireView({super.key});

  @override
  QuestionnaireViewState createState() => QuestionnaireViewState();
}

class QuestionnaireViewState extends State<QuestionnaireView> {
  final QuestionnaireController _controller = QuestionnaireController();
  final Map<int, Map<int, String>> _answers = {};

  void _handleSubmit() {
    // Handle form submission
    print('User answers: $_answers');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 249, 217, 130),
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('Assets/SleepyFoxLogo512.png', width: 45, height: 45),
            const SizedBox(width: 10),
            const Text('Questionnaire'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: _controller.questions.length,
          itemBuilder: (context, index) {
            final question = _controller.questions[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        question.questionTitle,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 15),
                      ...List.generate(question.questionText.length, (qIndex) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              question.questionText[qIndex],
                              style: TextStyle(fontSize: 15),
                            ),
                            SizedBox(height: 20),
                            ...question.answers[qIndex].map((answer) {
                              return RadioListTile<String>(
                                title: Text(answer,
                                    style: TextStyle(fontSize: 14)),
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
                            SizedBox(height: 20),
                            if (qIndex < question.questionText.length - 1)
                              Divider(
                                  color: Colors.grey,
                                  indent: 25,
                                  endIndent: 25),
                            if (qIndex < question.questionText.length - 1)
                              SizedBox(height: 20),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _handleSubmit,
        child: Icon(Icons.check),
      ),
    );
  }
}
