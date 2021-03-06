import 'package:path/path.dart';
import 'package:qelem/domain/profile/profile.dart';
import 'package:qelem/infrastructure/answer/answer_model_mapper.dart';
import 'package:qelem/infrastructure/auth/user_model_mapper.dart';
import 'package:qelem/infrastructure/profile/profile_dto.dart';
import 'package:qelem/infrastructure/profile/profile_entity.dart';
import 'package:qelem/infrastructure/question/local/question/question_entity_mapper.dart';
import 'package:qelem/infrastructure/question/question_dto.dart';
import 'package:qelem/infrastructure/question/question_mapper.dart';
import 'package:qelem/infrastructure/user/local/user_entity.dart';
import 'package:qelem/infrastructure/user/local/user_entity_mapper.dart';
import 'package:sqflite/sqflite.dart';

import '../../../domain/question/question.dart';
import '../../../infrastructure/answer/answer_dto.dart';
import '../../../infrastructure/answer/local/answer/answer_entity.dart';
import '../../../infrastructure/auth/user_dto.dart';
import '../../../infrastructure/question/local/question/question_entity.dart';
import '../../../infrastructure/tag/tag_dto.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'qelem.db');
    return await openDatabase(path, version: 3, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tags (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        questionId INTEGER NOT NULL,
        tagId INTEGER NOT NULL,
        name TEXT NOT NULL
      )''');

    await db.execute('''
      CREATE TABLE user (
        id INTEGER PRIMARY KEY,
        userName TEXT NOT NULL,
        firstName TEXT NOT NULL,
        lastName TEXT NOT NULL,
        profilePicture TEXT NOT NULL,
        role TEXT NOT NULL)
      ''');

    await db.execute('''
      CREATE TABLE question (
        id INTEGER PRIMARY KEY,
        topic TEXT NOT NULL,
        content TEXT NOT NULL,
        upVotes INTEGER NOT NULL,
        downVotes INTEGER NOT NULL,
        userVote INTEGER NOT NULL,
        createdAt TEXT NOT NULL,
        updatedAt TEXT NOT NULL,
        authorId INTEGER NOT NULL,
        FOREIGN KEY (authorId)
        REFERENCES user(id))
      ''');

    await db.execute('''
      CREATE TABLE answer (
        id INTEGER PRIMARY KEY,
        content TEXT NOT NULL,
        upVotes INTEGER NOT NULL,
        downVotes INTEGER NOT NULL,
        userVote INTEGER NOT NULL,
        createdAt TEXT NOT NULL,
        updatedAt TEXT NOT NULL,
        questionId INTEGER NOT NULL, 
        authorId INTEGER NOT NULL,
        FOREIGN KEY (questionId)
        REFERENCES question(id),
        FOREIGN KEY (authorId)
        REFERENCES user(id) )
      ''');

    await db.execute('''
      CREATE TABLE profile (
        id INTEGER PRIMARY KEY,
        userName TEXT NOT NULL,
        firstName TEXT NOT NULL,
        lastName TEXT NOT NULL,
        profilePicture TEXT NOT NULL,
        role TEXT NOT NULL)
      ''');
  }

  Future<List<Question>> getQuestions() async {
    final Database db = await database;
    final List<Map<String, dynamic>> questionsList = await db.query("question");
    List<QuestionEntity> questionEntityList = questionsList.isEmpty
        ? []
        : questionsList.map((e) => QuestionEntity.fromJson(e)).toList();
    List<Question> finalResult = [];
    for (QuestionEntity questionEntity in questionEntityList) {
      final user = await getUser(questionEntity.authorId);
      var tags = await db.query("tags",
          where: "questionId = ?", whereArgs: [questionEntity.id]);
      List<TagDto> tempTag = [];
      for (var t in tags) {
        tempTag.add(TagDto.fromJson(t));
      }
      finalResult.add(questionEntity.toQuestion(user.toUser(), tempTag));
    }
    return finalResult;
  }

  Future<List<Question>> getQuestionsByAuthorId(int authorId) async {
    final Database db = await database;
    final List<Map<String, dynamic>> questionsList = await db
        .query("question", where: "authorId = ?", whereArgs: [authorId]);
    List<QuestionEntity> questionEntityList = questionsList.isEmpty
        ? []
        : questionsList.map((e) => QuestionEntity.fromJson(e)).toList();
    List<Question> finalResult = [];
    for (QuestionEntity questionEntity in questionEntityList) {
      final user = await getUser(questionEntity.authorId);
      var tags = await db.query("tags",
          where: "questionId = ?", whereArgs: [questionEntity.id]);
      List<TagDto> tempTag = [];
      for (var t in tags) {
        tempTag.add(TagDto.fromJson(t));
      }
      finalResult.add(questionEntity.toQuestion(user.toUser(), tempTag));
    }
    return finalResult;
  }

  // get a single question
  Future<Question> getQuestion(int id) async {
    final Database db = await database;
    final List<Map<String, dynamic>> questionsList =
        await db.query("question", where: "id = ?", whereArgs: [id]);
    QuestionEntity questionEntity =
        QuestionEntity.fromJson(questionsList.first);
    final user = await getUser(questionEntity.authorId);
    var tags = await db
        .query("tags", where: "questionId = ?", whereArgs: [questionEntity.id]);
    List<TagDto> tempTag = [];
    for (var t in tags) {
      tempTag.add(TagDto.fromJson(t));
    }
    return questionEntity.toQuestion(user.toUser(), tempTag);
  }

  // get answers to a question
  Future<List<AnswerEntity>> getAnswers(int questionId) async {
    final Database db = await database;
    final List<Map<String, dynamic>> answersList = await db
        .query("answer", where: "questionId = ?", whereArgs: [questionId]);
    List<AnswerEntity> answerEntityList = answersList.isEmpty
        ? []
        : answersList.map((e) => AnswerEntity.fromJson(e)).toList();
    return answerEntityList;
  }

  // get a single answer
  Future<AnswerEntity> getAnswer(int answerId) async {
    final Database db = await database;
    final List<Map<String, dynamic>> answersList =
        await db.query("answer", where: "id = ?", whereArgs: [answerId]);
    AnswerEntity answerEntity = AnswerEntity.fromJson(answersList.first);
    return answerEntity;
  }

  // Profile
  Future<Profile> getProfile(int id) async {
    final Database db = await database;
    final List<Map<String, dynamic>> profileList =
        await db.query("profile", where: "id = ?", whereArgs: [id]);
    ProfileEntity profileEntity = ProfileEntity.fromJson(profileList.first);
    return profileEntity.toProfile();
  }

  // update a profile
  Future<void> putProfile(ProfileEntity profileDto) async {
    final Database db = await database;
    await db.insert("user", profileDto.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // get a single user
  Future<UserEntity> getUser(int id) async {
    final Database db = await database;
    final List<Map<String, dynamic>> usersList =
        await db.query("user", where: "id = ?", whereArgs: [id]);
    UserEntity userModel = UserEntity.fromJson(usersList.first);
    return userModel;
  }

  // remove a question
  Future<void> removeQuestion(int id) async {
    final Database db = await database;
    await db.delete("question", where: "id = ?", whereArgs: [id]);
  }

  // remove an answer
  Future<void> removeAnswer(int id) async {
    final Database db = await database;
    await db.delete("answer", where: "id = ?", whereArgs: [id]);
  }

  // remove a user
  Future<void> removeUser(int id) async {
    final Database db = await database;
    await db.delete("user", where: "id = ?", whereArgs: [id]);
  }

  // remove all questions, users, and answers in case we need this
  Future<void> removeAll() async {
    final Database db = await database;
    final batch = db.batch();
    batch.delete("question");
    batch.delete("user");
    batch.delete("answer");
    batch.delete("tags");
    await batch.commit(noResult: true);
  }

  // add multiple questions
  Future<void> addQuestions(List<QuestionDto> questionDtoList) async {
    final Database db = await database;
    await db.transaction((txn) async {
      final batch = txn.batch();

      for (var e in questionDtoList) {
        batch.insert("question", e.toQuestionEntity().toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace);
        batch.insert("user", e.author.toUserEntity().toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace);
        for (var t in e.tags) {
          Map<String, dynamic> tagMap = {
            "questionId": e.id,
            "tagId": t.id,
            "name": t.name,
          };
          batch.insert("tags", tagMap,
              conflictAlgorithm: ConflictAlgorithm.replace);
        }
      }
      await batch.commit(noResult: true);
    });
  }

  // add multiple answers
  Future<void> addAnswers(List<AnswerDto> answerDtoList) async {
    final Database db = await database;
    await db.transaction((txn) async {
      final batch = txn.batch();

      for (var e in answerDtoList) {
        batch.insert("answer", e.toAnswerEntity().toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace);
        batch.insert("user", e.author.toUserEntity().toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
      await batch.commit(noResult: true);
    });
  }

  // update a question
  Future<void> updateQuestion(QuestionEntity questionEntity) async {
    final Database db = await database;
    await db.insert("question", questionEntity.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // update an answer
  Future<void> updateAnswer(AnswerEntity answer) async {
    final Database db = await database;
    await db.insert("answer", answer.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // update a user
  Future<void> updateUser(UserDto userDto) async {
    final Database db = await database;
    await db.insert("user", userDto.toUserEntity().toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
