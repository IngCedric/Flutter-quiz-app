# quiz_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

Je vais te rédiger un README complet pour ton application de quiz en Flutter. Ce document te permettra de comprendre chaque étape du développement de ton application et de pouvoir la reproduire seul.

---

# Quiz App Flutter

## Description

Cette application Flutter est une simple application de quiz qui permet aux utilisateurs de répondre à des questions et de recevoir un score basé sur leurs réponses. L'application affiche une série de questions avec plusieurs choix de réponses, et à la fin, elle montre le score final avec une possibilité de recommencer le quiz.

## Prérequis

Avant de commencer, assure-toi d'avoir installé les éléments suivants :

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- Un éditeur de code comme [Visual Studio Code](https://code.visualstudio.com/) ou [Android Studio](https://developer.android.com/studio)
- Un simulateur ou un appareil physique pour exécuter l'application

## Structure du Projet

Voici une vue d'ensemble des fichiers et répertoires importants dans ton projet :

- `lib/`
    - `main.dart` : Le point d'entrée de l'application.
    - `question_model.dart` : Le modèle de données pour les questions et réponses.
    - `quiz_screen.dart` : L'écran principal où se déroule le quiz.

## Étapes de Développement

### 1. Créer le modèle de question (`question_model.dart`)

Dans ce fichier, tu vas définir les classes qui représentent une question et ses réponses.

```dart
class Answer {
  final String answerText;
  final bool isCorrect;

  Answer(this.answerText, this.isCorrect);
}

class Question {
  final String questionText;
  final List<Answer> answersList;

  Question(this.questionText, this.answersList);
}
```

### 2. Créer l'interface utilisateur principale (`quiz_screen.dart`)

Cet écran affiche les questions, les réponses, et gère les interactions de l'utilisateur.

#### Affichage de la question

```dart
_questionWidget(){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text("Question ${currentQuestionIndex + 1}/${questionList.length.toString()}",
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
        ),
      ),
      SizedBox(height: 20,),
      Container(
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
          ),
        ),
      ),
    ],
  );
}
```

#### Affichage des boutons de réponse

Les boutons de réponse sont affichés en grille avec deux boutons par ligne.

```dart
_answerList() {
  return GridView.count(
    crossAxisCount: 2,
    shrinkWrap: true,
    mainAxisSpacing: 10,
    crossAxisSpacing: 10,
    children: questionList[currentQuestionIndex]
        .answersList
        .map((e) => _answerButton(e))
        .toList(),
  );
}

Widget _answerButton(Answer answer) {
  bool isSelected = answer == selectedAnswer;

  return Container(
    child: ElevatedButton(
      onPressed: () {
        setState(() {
          selectedAnswer = answer;
          if (answer.isCorrect) {
            score++;
          }
        });
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(10),
        backgroundColor: isSelected ? Colors.orangeAccent : Colors.white,
        foregroundColor: isSelected ? Colors.white : Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        answer.answerText,
        style: TextStyle(fontSize: 18),
      ),
    ),
  );
}
```

#### Gestion du bouton "Next"

Le bouton "Next" permet de passer à la question suivante ou de soumettre le quiz si c'est la dernière question.

```dart
_nextButton() {
  bool isLastQuestion = currentQuestionIndex == questionList.length - 1;

  return Container(
    width: MediaQuery.of(context).size.width * 0.5,
    height: 48,
    child: ElevatedButton(
      onPressed: () {
        if (isLastQuestion) {
          showDialog(context: context, builder: (_) => _showScoreDialog());
        } else {
          setState(() {
            selectedAnswer = null;
            currentQuestionIndex++;
          });
        }
      },
      child: Text(isLastQuestion ? "Submit" : "Next"),
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
    ),
  );
}
```

### 3. Calcul du Score et Affichage du Résultat

À la fin du quiz, le score est calculé et affiché dans une boîte de dialogue.

```dart
_showScoreDialog() {
  bool isPassed = score >= questionList.length * 0.6;
  String title = isPassed ? "Réussi" : "Échec";

  return AlertDialog(
    title: Text("$title | Votre score est $score",
      style: TextStyle(
        color: isPassed ? Colors.green : Colors.redAccent,
      ),
    ),
    content: ElevatedButton(
      onPressed: () {
        Navigator.pop(context);
        setState(() {
          currentQuestionIndex = 0;
          score = 0;
          selectedAnswer = null;
        });
      },
      child: Text('Restart'),
    ),
  );
}
```

## Exécution de l'Application

Pour exécuter l'application, tu peux utiliser la commande suivante dans ton terminal :

```bash
flutter run
```

Assure-toi que ton simulateur est ouvert ou que ton appareil physique est connecté.

---
