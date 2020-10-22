import 'package:bilgi_yarismasi/screens/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:bilgi_yarismasi/data/qestions_data.dart';

class BuildQuestionScreen extends StatefulWidget {
  @override
  _BuildQuestionScreen createState() => _BuildQuestionScreen();
}

class _BuildQuestionScreen extends State {
  QuestionsData questionData = QuestionsData();
  Color renk1, renk2, renk3, renk4;

  @override
  void initState() {
    restartTheButtons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[700],
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
                child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  questionData.getQuestionString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25.0, color: Colors.white),
                ),
              ),
            )),
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.only(bottom: 70),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: RaisedButton(
                        color: renk1,
                        onPressed: () {
                          buildOptions(1, questionData.getOptionA(),
                              questionData.getTrueOption());
                        },
                        textColor: Colors.white,
                        child: Text(
                          questionData.getOptionA(),
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    )),
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: RaisedButton(
                        color: renk2,
                        onPressed: () {
                          buildOptions(2, questionData.getOptionB(),
                              questionData.getTrueOption());
                        },
                        textColor: Colors.white,
                        child: Text(
                          questionData.getOptionB(),
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    )),
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: RaisedButton(
                        color: renk3,
                        onPressed: () {
                          buildOptions(3, questionData.getOptionC(),
                              questionData.getTrueOption());
                        },
                        textColor: Colors.white,
                        child: Text(
                          questionData.getOptionC(),
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    )),
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: RaisedButton(
                        color: renk4,
                        onPressed: () {
                          buildOptions(4, questionData.getOptionD(),
                              questionData.getTrueOption());
                        },
                        textColor: Colors.white,
                        child: Text(
                          questionData.getOptionD(),
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    )),
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }

  void buildOptions(int id, String data, String trueOption) {
    setState(() {
      switch (id) {
        case 1:
          questionData.trueOrFalse(data, trueOption)
              ? renk1 = Colors.green
              : renk1 = Colors.red;
          break;
        case 2:
          questionData.trueOrFalse(data, trueOption)
              ? renk2 = Colors.green
              : renk2 = Colors.red;
          break;
        case 3:
          questionData.trueOrFalse(data, trueOption)
              ? renk3 = Colors.green
              : renk3 = Colors.red;
          break;
        case 4:
          questionData.trueOrFalse(data, trueOption)
              ? renk4 = Colors.green
              : renk4 = Colors.red;
          break;
      }
      nextQuestion();
    });
  }

  void restartTheButtons() {
    renk1 = Colors.amber;
    renk2 = Colors.amber;
    renk3 = Colors.amber;
    renk4 = Colors.amber;
  }

  void nextQuestion() {
    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        if (questionData.getNextQuestion())
          restartTheButtons();
        else {
          List<int> results = questionData.getResults();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BuildResultScreen(results)));
        }
      });
    });
  }
}
