import 'dart:developer' as developer;
import 'dart:io';

import 'package:qelem/data/local/entity/question/question_entity_mapper.dart';
import 'package:qelem/data/local/entity/user/user_entity_mapper.dart';
import 'package:qelem/domain/common/vote.dart';
import 'package:qelem/domain/question/question_form.dart';
import 'package:qelem/infrastructure/question/question_api.dart';
import 'package:qelem/infrastructure/question/question_dto.dart';
import 'package:qelem/infrastructure/question/question_form_mapper.dart';
import 'package:qelem/infrastructure/question/question_mapper.dart';

import '../../data/local/local_database/qelem_local_storage.dart';
import '../../domain/question/question.dart';
import '../../util/either.dart';
import '../../util/error.dart';
import '../common/qelem_http_exception.dart';

class QuestionRepository {
  final QuestionApi questionApi;
  final DatabaseHelper databaseHelper = DatabaseHelper.instance;

  QuestionRepository(this.questionApi);

  Future<Either<List<Question>>> getAllQuestions() async {
    try {
      List<Question> finalResult = [];

      var result = await databaseHelper.getQuestions();
      if (result.isEmpty) {
        List<QuestionDto> questionsDto = await questionApi.getAllQuestions();
        await databaseHelper.addQuestions(questionsDto);
        result = await databaseHelper.getQuestions();
      }

      result.map((questionEntity) async {
        var user = await databaseHelper.getUser(questionEntity.authorId);
        finalResult.add(questionEntity.toQuestion(user!.toUser()));
      }).toList();

      return Either(val: finalResult);
    } on QHttpException catch (e) {
      return Either(error: Error(e.message));
    } on SocketException catch (_) {
      return Either(error: Error("Check your internet connection"));
    } on Exception catch (e) {
      developer.log(
          "Unexpected error while up voting while fetching all questions in Question Repo",
          error: e);
      return Either(error: Error("Unknown error"));
    }
  }

  Future<Either<Question>> getQuestionById(int id) async {
    try {
      Question finalResult;

      var result = await databaseHelper.getQuestion(id);
      if (result == null) {
        List<QuestionDto> questionsDto = await questionApi.getAllQuestions();
        await databaseHelper.addQuestions(questionsDto);
        result = await databaseHelper.getQuestion(id);
      }
      var user = await databaseHelper.getUser(result!.authorId);
      finalResult = result.toQuestion(user!.toUser());

      return Either(val: finalResult);
    } on QHttpException catch (e) {
      return Either(error: Error(e.message));
    } on SocketException catch (_) {
      return Either(error: Error("Check your internet connection"));
    } on Exception catch (e) {
      developer.log("Unexpected error while fetching a question with Id $id in Question Repo",
          error: e);
      return Either(error: Error("Unknown error"));
    }
  }

  Future<Either<Question>> createQuestion(QuestionForm questionForm) async {
    try {
      final questionDto = await questionApi.createQuestion(questionForm.toDto());
      return Either(val: questionDto.toQuestion());
    } on QHttpException catch (e) {
      return Either(error: Error(e.message));
    } on SocketException catch (_) {
      return Either(error: Error("Check your internet connection"));
    } on Exception catch (e) {
      developer.log("Unexpected error while fetching creating a question in Question Repo",
          error: e);
      return Either(error: Error("Unknown error"));
    }
  }

  Future<Either<void>> deleteQuestion(int id) async {
    try {
      await databaseHelper.removeQuestion(id);
      await questionApi.deleteQuestion(id);
      return Either();
    } on QHttpException catch (e) {
      return Either(error: Error(e.message));
    } on SocketException catch (_) {
      return Either(error: Error("Check your internet connection"));
    } on Exception catch (e) {
      developer.log("Unexpected error while deleting a question with Id $id in Question Repo",
          error: e);
      return Either(error: Error("Unknown error"));
    }
  }

  Future<Either<Question>> updateQuestion(QuestionForm questionForm, int questionId) async {
    try {
      final questionDto = await questionApi.updateQuestion(questionForm.toDto(), questionId);
      await databaseHelper.updateQuestion(questionDto.toQuestionEntity());
      return Either(val: questionDto.toQuestion());
    } on QHttpException catch (e) {
      return Either(error: Error(e.message));
    } on SocketException catch (_) {
      return Either(error: Error("Check your internet connection"));
    } on Exception catch (e) {
      developer.log(
          "Unexpected error while updating a question with Id $questionId in Question Repo",
          error: e);
      return Either(error: Error("Unknown error"));
    }
  }

  Future<Either<Question>> upvoteQuestion(Question question) async {
    if (question.userVote == Vote.upVote) {
      // Should never happen, UI should prevent this
      throw Exception('You already upvoted this question');
    }

    try {
      await questionApi.upVoteQuestion(question.id);
      final newQuestion = question.copyWith(
        userVote: Vote.upVote,
        upVotes: question.upVotes + 1,
        downVotes: question.userVote == Vote.downVote ? question.downVotes - 1 : question.downVotes,
      );
      await databaseHelper.updateQuestion(newQuestion.toQuestionEntity());
      return Either(val: question);
    } on QHttpException catch (e) {
      return Either(error: Error(e.message));
    } on SocketException catch (_) {
      return Either(error: Error("Check your internet connection"));
    } on Exception catch (e) {
      developer.log(
          "Unexpected error while up voting a question with Id ${question.id} in Question Repo",
          error: e);
      return Either(error: Error("Unknown error"));
    }
  }

  Future<Either<Question>> downVoteQuestion(Question question) async {
    if (question.userVote == Vote.downVote) {
      // Should never happen, UI should prevent this
      throw Exception('You already downVoted this question');
    }

    try {
      await questionApi.downvoteQuestion(question.id);

      final newQuestion = question.copyWith(
        userVote: Vote.downVote,
        downVotes: question.downVotes + 1,
        upVotes: question.userVote == Vote.upVote ? question.upVotes - 1 : question.upVotes,
      );

      await databaseHelper.updateQuestion(newQuestion.toQuestionEntity());
      return Either(val: newQuestion);
    } on QHttpException catch (e) {
      return Either(error: Error(e.message));
    } on SocketException catch (_) {
      return Either(error: Error("Check your internet connection"));
    } on Exception catch (e) {
      developer.log(
          "Unexpected error while down voting a question with Id ${question.id} in Question Repo",
          error: e);
      return Either(error: Error("Unknown error"));
    }
  }

  Future<Either<Question>> unvoteQuestion(Question question) async {
    if (question.userVote == Vote.none) {
      // Should never happen, UI should prevent this
      throw Exception('You already unVoted this question');
    }

    try {
      await questionApi.unvoteQuestion(question.id);

      final newQuestion = question.copyWith(
        userVote: Vote.none,
        upVotes: question.userVote == Vote.upVote ? question.upVotes - 1 : question.upVotes,
        downVotes: question.userVote == Vote.downVote ? question.downVotes - 1 : question.downVotes,
      );

      await databaseHelper.updateQuestion(newQuestion.toQuestionEntity());
      return Either(val: newQuestion);
    } on QHttpException catch (e) {
      return Either(error: Error(e.message));
    } on SocketException catch (_) {
      return Either(error: Error("Check your internet connection"));
    } on Exception catch (e) {
      developer.log(
          "Unexpected error while unvoting a question with Id ${question.id} in Question Repo",
          error: e);
      return Either(error: Error("Unknown error"));
    }
  }
}
