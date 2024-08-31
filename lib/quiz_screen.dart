import 'package:flutter/material.dart';
import 'package:quiz_app/question_model.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  // definir les donnees

  // questionList contient toutes nos questions
  List<Question> questionList = getQuestions();
  // cette variable garde la trace de l'index de la question sur laquelle nous sommes
  int currentQuestionIndex = 0;
  // garder le score
  int score = 0;
  // pour garder la reponse selectionner par le joueur il s'agit d'une variable de type answer
  Answer? selectedAnswer;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Color.fromARGB(255, 5, 50, 80) ,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('Simple quiz app', style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),),
            _questionWidget(),
            _answerList(),
            SizedBox(height: 12,),
            _nextButton(),
          ],
        ),
      ),
    );
  }

  _questionWidget(){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Question ${currentQuestionIndex+1}/${questionList.length.toString()}", style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w100,
          ),),
          SizedBox(height: 20,),
          Container(
            // ici le conteneur doit prendre toute la place disponible de son parent
            width: double.infinity,
            padding: EdgeInsets.all(32),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.orangeAccent,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              questionList[currentQuestionIndex].questionText,
              style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),),
          ),
        ],
      );
  }

  // _answerList(){
  //   return Column(
  //     children: questionList[currentQuestionIndex]
  //         .answersList
  //         .map(
  //       (e) => _answerButton(e),
  //     )
  //         .toList(),
  //   );
  // }
  //
  // Widget _answerButton(Answer answer){
  //   return Container(
  //     child: ElevatedButton(onPressed: (){}
  //         , child: Text(answer.answerText),),
  //   );
  // }

  _answerList() {
    return GridView.count(
      // nombre de colonne
      crossAxisCount: 2, // 2 boutons par ligne
      shrinkWrap: true,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      children: questionList[currentQuestionIndex]
          .answersList
          .map(
            (e) => _answerButton(e),
      )
          .toList(),
    );
  }

  Widget _answerButton(Answer answer) {

    bool isSelected = answer == selectedAnswer;
    // pour verifier si l'utilisateur a cliquer sur un bouton

    return Container(
      child: ElevatedButton(
        onPressed: () {
          // Action à exécuter lors de la sélection de la réponse
          setState(() {
            selectedAnswer = answer;

            // Incrémenter le score si la réponse est correcte
            if (answer.isCorrect) {
              score++;
            }
          });
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(10),
          backgroundColor: isSelected ? Colors.orangeAccent: Colors.white,
          // Couleur du bouton equivalent a primary
          foregroundColor: isSelected ? Colors.white: Colors.black,
          // Couleur du bouton equivalent a onPrimary
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Boutons arrondis
          ),
        ),
        child: Text(
          answer.answerText,
          // le texte herite directement de la couleur definie dans le foregroundcolor
          style: TextStyle(fontSize: 18,), // Texte du bouton
        ),
      ),
    );
  }

  _nextButton() {

    bool isLastQuestion = false;
    if(currentQuestionIndex == questionList.length -1){
      isLastQuestion = true;
    }

    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: 48,
      child: ElevatedButton(
        onPressed: () {
          // Action à exécuter lors du clic sur "Next"
          if(isLastQuestion){
          //   afficher le score

            showDialog(context: context, builder: (_) => _showScoreDialog());

          }else{
          //   question suivante
            setState(() {
              selectedAnswer = null;
              currentQuestionIndex++;
            });
          }
        },
        child: Text( isLastQuestion? "Submit" : "Next"),
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          backgroundColor: Colors.blueAccent,  // Utilisez backgroundColor au lieu de Primary
          foregroundColor: Colors.white,       // Utilisez foregroundColor au lieu de onPrimary
        ),
      ),
    );
  }

  _showScoreDialog(){

    bool isPassed = false;

    if(score >= questionList.length * 0.6){
    //   reussit si pourcentage = 60%
      isPassed = true;
    }
    String title = isPassed?"reussit": "echec";

    return AlertDialog(
      title: Text(title + "| votre score est $score", style: TextStyle(
        color: isPassed ? Colors.green : Colors.redAccent
      ),),
      content: ElevatedButton(onPressed: (){
        Navigator.pop(context);
        setState(() {
          currentQuestionIndex = 0;
          score = 0;
          selectedAnswer = null;
        });
    },
    child: Text('Restart')),
    ) ;
  }

}
