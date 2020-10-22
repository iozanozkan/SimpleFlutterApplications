import 'package:bilgi_yarismasi/models/question.dart';

class QuestionsData {
  int _index = 0, _trueAnswer = 0, _falseAnswer = 0;

  List<Question> _questions = [
    Question(
        "Bir işin uygun ve kolay olduğunu belirtmek için hangisi söylenir?",
        "Burnuma göre",
        "Kaşıma Göre",
        "Bıyığıma göre",
        "Dişime göre",
        "Dişime göre"),
    Question("Doğalgaz hangi birimle ölçülür ve ücretlendirilir?", "Ons",
        "Galon", "Mililitre", "Metreküp", "Metreküp"),
    Question("Hangisi doğru yazılmıştır?", "Kopora", "Kapora", "Kaparo",
        "Kaporo", "Kapora"),
    Question(
        "Boksörlerin kullandığı eldivenlerde, parmakları saran kaç bölüm olduğu görülür?",
        "1",
        "2",
        "3",
        "4",
        "2"),
    Question(
        "Karşınızdakine 'Alemsin' ya da 'İlahi' diyorsanız onun nasıl bir kişiliğe sahip olduğunu ifade ediyorsunuzdur?",
        "Esprili",
        "Gizemli",
        "Bilgili",
        "Cesur",
        "Esprili"),
  ];

  String getQuestionString() {
    return _questions[_index].questionString;
  }

  String getTrueOption() {
    return _questions[_index].trueOption;
  }

  String getOptionA() {
    return _questions[_index].optionA;
  }

  String getOptionB() {
    return _questions[_index].optionB;
  }

  String getOptionC() {
    return _questions[_index].optionC;
  }

  String getOptionD() {
    return _questions[_index].optionD;
  }

  bool getNextQuestion() {
    if (_index < _questions.length - 1) {
      _index++;
      return true;
    } else
      return false;
  }

  bool trueOrFalse(String question, String trueOption) {
    if (question == trueOption) {
      _trueAnswer++;
      return true;
    } else {
      _falseAnswer++;
      return false;
    }
  }

  List<int> getResults() {
    List<int> results = [_trueAnswer, _falseAnswer];
    return results;
  }
}
