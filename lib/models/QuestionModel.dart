import "dart:collection";
import 'dart:convert';
import "dart:math";

import "package:flutter/foundation.dart";

class QuestionModel extends ChangeNotifier {
  List<Question> _questions = [
    new Question(
        "Qual o melhor conceito de define o termo Internet das coisas ou IoT (Internet of things)?",
        "é um conceito que define a conexão entre objetos físicos com o usuário e a internet.",
        [
          "é um conceito que define a conexão do usuário com a internet.",
          "é um conceito que define a conexão entre objetos virtuais com o usuário e a internet.",
          "é um conceito que define a conexão entre objetos físicos com o usuário."
        ]),
    new Question(
        "Quando surgiu e quem criou a Internet das Coisas?",
        "Foi criado em setembro de 1999 e seu inventor se chama Kevin Ashton, um pesquisador britânico do Massachusetts Institute of Technology (MIT).",
        [
          "Foi criado em setembro de 1999 e seu inventor se chama Kevin Ashyton, um pesquisador britânico do Massachusetts Institute of Technology (MIT).",
          "Foi criado em setembro de 1998 e seu inventor se chama Kevin Ashton, um pesquisador britânico do Massachusetts Institute of Technology (MIT).",
          "Foi criado em dezembro de 1999 e seu inventor se chama Kevin Ashton, um pesquisador britânico do Massachusetts Institute of Technology (MIT)."
        ]),
    new Question(
        "Qual o objetivo da Internet das Coisas?",
        "É o de permitir a comunicação direta entre diversos equipamentos de uso pessoal, bem como entre estes e seus usuários, através de sensores e conexão sem fio.",
        [
          "Facilitar a vida das pessoas, trazer informações, entretenimento e comunicação.",
          "Criar um canal de comunicação direta dentro de uma Organização em seus departamentos, buscando melhorias em seus processos e redução de custos."
        ]),
    new Question(
        "Qual a função de um sensor na Internet das Coisas?",
        "Responsável por capturar valores de grandezas físicas como temperatura, umidade, pressão, presença etc.",
        [
          "Responsável por capturar valores de grandezas escalares como Tempo, Temperatura, Volume, Massa, Trabalho de uma Força, etc.",
          "Responsável por capturar valores de grandezas vetoriais: Velocidade, Aceleração, Força, Deslocamento, Empuxo, Campo elétrico, Campo magnético, Força peso, etc."
        ]),
    new Question(
        "Qual a função de um atuador na Internet das Coisas?",
        "São dispositivos que produzem alguma ação, atendendo a comandos que podem ser manuais, elétricos ou mecânicos",
        [
          "São dispositivos que produzem alguma ação, atendendo a comandos que podem ser somente elétricos.",
          "São dispositivos que produzem alguma ação, atendendo a comandos que podem ser somente mecânicos.",
          "São dispositivos que produzem alguma ação, atendendo a comandos que podem ser somente manuais."
        ]),
  ];

  UnmodifiableListView<Question> get questions =>
      UnmodifiableListView(this._questions);

  List<Question> get4Questions() {
    Random random = new Random();
    List<Question> randomizedQuestions = [];

    if (this._questions.length < 4)
      throw new ErrorDescription(
          "Dont there is questions sufficient to randomize");
    for (var inx = 0; inx < 4;) {
      var randomInt = random.nextInt(this._questions.length);
      if (!randomizedQuestions.contains(this._questions.elementAt(randomInt))) {
        randomizedQuestions.add(this._questions.elementAt(randomInt));
        inx++;
      }
    }
    return randomizedQuestions;
  }
}

class Question {
  String title;
  bool isTrueOrFalse = false;
  List<String> wrongAnswers;
  String correctAnswer;

  Question(this.title, this.correctAnswer, this.wrongAnswers,
      [this.isTrueOrFalse]);

  String _map() {
    Map<String, String> mapDoubleQuote = {};
    for (var index = 0; index < this.wrongAnswers.length; index++) {
      mapDoubleQuote.putIfAbsent(
          '\$$index\$', () => '\$${this.wrongAnswers.elementAt(index)}\$');
    }
    return mapDoubleQuote.toString();
  }

  static List<String> _mapDecode(String str) {
    var jsonDoubleQuote = json.decode(str.replaceAll('\$', '"'));
    List<String> wrongs = [];
    for (var key in jsonDoubleQuote.keys) {
      wrongs.add(jsonDoubleQuote[key]);
    }
    return wrongs;
  }

  @override
  String toString() {
    Map<String, String> arr = {
      '"title"': '"${this.title}"',
      '"correctAnswer"': '"${this.correctAnswer}"',
      '"wrongAnswers"': '"${_map()}"',
    };
    return arr.toString();
  }

  static Question parse(String str) {
    var map = json.decode(str);
    var question = new Question(
        map['title'],
        map['correctAnswer'],
        _mapDecode(
          map['wrongAnswers'],
        ));
    return question;
  }
}
