import 'package:elaros_gp4/Model/questionnaire_model.dart';

class QuestionnaireController {
  final List<Question> _questions = [
    Question(
      questionTitle: 'Question 1. Age Identification:',
      questionText: ['How Old is Your Child?'],
      answers: [
        ['1-2', '3-5', '6-13']
      ],
    ),
    Question(
      questionTitle: 'Question 2. Sleep Duration:',
      questionText: ['How Many Hours Does Your Child Sleep Per Night?'],
      answers: [
        ['11-14', '9-11', '8-10']
      ],
    ),
    Question(
      questionTitle: 'Question 3. Sleep Drive Factors:',
      questionText: [
        'Does Your Child Engage in Regular Physical Activity?',
        'Does Your Child Have a Set Wake-up Time Each Morning?',
        'For Young Children: Are Nap Times Appropriatetly Times and Not Too Close to Bedtime?',
        'For Older Children (5-6 Years and Above): Does Your Child Avoid Daytime Naps?'
      ],
      answers: [
        ['Yes', 'Sometimes', 'No'],
        ['Yes', 'Sometimes', 'No'],
        ['Yes', 'Sometimes', 'No'],
        ['Yes', 'Sometimes', 'No']
      ],
    ),
    Question(
      questionTitle: 'Question 4. Circadian Rhythm Alignment:',
      questionText: [
        'Do You Keep Consistant Sleep and Wake Times for Your Child Everyday Including Weekends?',
        'Is Your Child Exposed to Natural Daylight Shortly After Waking Up?',
        'Do You Limit Exposure to Bright Light a Few Hours Before Bed?',
      ],
      answers: [
        ['Yes', 'Sometimes', 'No'],
        ['Yes', 'Sometimes', 'No'],
        ['Yes', 'Sometimes', 'No']
      ],
    ),
    Question(
      questionTitle: 'Question 5. Diet and Nutrition:',
      questionText: [
        'Does Your Child Eat a Large Meal Before Bedtime?',
        'Does Your Child Consume Food and/or Drink Containing Caffiene in the evening?',
        'Do You Offer Sleep-Friendly Snacks Before Bed (e.g. Cheese, Banana, Oats, Yoghurt, Milk)?',
      ],
      answers: [
        ['Yes', 'Sometimes', 'No'],
        ['Yes', 'Sometimes', 'No'],
        ['Yes', 'Sometimes', 'No']
      ],
    ),
  ];

  List<Question> get questions => _questions;
}
