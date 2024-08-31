
class Question{
  final String questionText;
  // Il s'agit d'une liste de type answer
  final List<Answer> answersList;

  Question(this.questionText, this.answersList);
}

class Answer{
  final String answerText;
  final bool isCorrect;

  // pour creer une nouvelle instance d'une reponse
  Answer(this.answerText, this.isCorrect);
}

// retourne une liste vide dans laquelle on va ajouter des quations avant de retourner
List<Question> getQuestions(){
  List<Question> list = [];
  // ajouter des questions

  list.add(Question(
    "Quelle est la complexité temporelle du tri rapide (QuickSort) dans le pire des cas ?",
    [
      Answer("O(n log n)", false),
      Answer("O(n^2)", true),
      Answer("O(n)", false),
      Answer("O(log n)", false),
    ],
  ));

  list.add(Question(
    "Lequel est principalement utilisé pour le développement des systèmes d'exploitation ?",
    [
      Answer("Python", false),
      Answer("C", true),
      Answer("JavaScript", false),
      Answer("Ruby", false),
    ],
  ));

  list.add(Question(
    "Qu'est-ce qu'un algorithme de recherche binaire ?",
    [
      Answer("Un algorithme qui divise continuellement la liste en deux moitiés pour trouver un élément.", true),
      Answer("Un algorithme qui recherche un élément en vérifiant chaque élément de la liste séquentiellement.", false),
      Answer("Un algorithme qui trie les éléments en ordre croissant.", false),
      Answer("Un algorithme qui trouve la plus petite valeur dans une liste.", false),
    ],
  ));

  list.add(Question(
    "Quel est le rôle principal d'un DNS (Domain Name System) ?",
    [
      Answer("Convertir des noms de domaine en adresses IP.", true),
      Answer("Fournir un service de messagerie électronique.", false),
      Answer("Protéger les sites web contre les cyberattaques.", false),
      Answer("Chiffrer les données transmises sur Internet.", false),
    ],
  ));

  list.add(Question(
    "Quel type de base de données est MongoDB ?",
    [
      Answer("Base de données relationnelle", false),
      Answer("Base de données NoSQL", true),
      Answer("Base de données graphique", false),
      Answer("Base de données en mémoire", false),
    ],
  ));

  return list;
}