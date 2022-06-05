import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:qelem/application/question/question_construction/question_construction_bloc.dart';
import 'package:qelem/application/question/question_construction/question_construction_event.dart';
import 'package:qelem/application/question/question_construction/question_construction_state.dart';
import 'package:qelem/application/question/question_detail/question_detail_bloc.dart';
import 'package:qelem/application/question/question_detail/question_detail_event.dart';
import 'package:qelem/application/question/question_detail/question_detail_state.dart';
import 'package:qelem/application/question/questions_list/questions_list_bloc.dart';
import 'package:qelem/application/question/questions_list/questions_list_event.dart';
import 'package:qelem/application/question/questions_list/questions_list_state.dart';
import 'package:qelem/domain/auth/user.dart';
import 'package:qelem/domain/common/vote.dart';
import 'package:qelem/domain/question/question.dart';
import 'package:qelem/domain/question/question_form.dart';
import 'package:qelem/infrastructure/question/question_repository.dart';
import 'package:qelem/util/either.dart';
import 'package:qelem/util/error.dart';

import 'questions_blocs_test.mocks.dart';

@GenerateMocks([QuestionRepository, User, Question, QuestionForm])
void main() {
  late MockQuestionRepository mockQuestionRepository;
  late MockQuestion mockQuestion;
  late MockQuestionForm mockQuestionForm;

  setUp(() {
    mockQuestionRepository = MockQuestionRepository();
    mockQuestion = MockQuestion();
    mockQuestionForm = MockQuestionForm();
  });

  group("QuestionsListsBloc", () {
    test(
        "should emit [QuestionListStateLoading, QuestionListStateSuccess] when event QuestionsListEventLoad is called and no error occur",
        () async {
      final mockQuestions = List.generate(3, (index) => mockQuestion);

      when(mockQuestionRepository.getMyQuestions())
          .thenAnswer((_) async => Either(val: mockQuestions));

      final questionsListBloc =
          QuestionsListBloc(questionRepository: mockQuestionRepository);

      questionsListBloc.add(const QuestionsListEventLoad());

      final expected = [
        const QuestionsListStateLoading(),
        QuestionsListStateSuccess(mockQuestions),
      ];

      expectLater(questionsListBloc.stream, emitsInOrder(expected));
    });

    test(
        "should emit [QuestionListStateLoading, QuestionListStateError] when event QuestionsListEventLoad is called and an error occurs",
        () async {
      when(mockQuestionRepository.getMyQuestions())
          .thenAnswer((_) async => Either(error: Error('error')));

      final questionsListBloc =
          QuestionsListBloc(questionRepository: mockQuestionRepository);

      questionsListBloc.add(const QuestionsListEventLoad());

      final expected = [
        const QuestionsListStateLoading(),
        QuestionsListStateError(Error('error')),
      ];
      expectLater(questionsListBloc.stream, emitsInOrder(expected));
    });
  });

  group("QuestionDetailBloc", () {
    test(
        "should emit [QuestionDetailStateLoading, QuestionDetailStateLoadedQuestion] when event QuestionDetailLoadEvent is called and no error occur",
        () async {
      when(mockQuestionRepository.getQuestionById(0))
          .thenAnswer((_) async => Either(val: mockQuestion));

      final questionDetailBloc =
          QuestionDetailBloc(questionRepository: mockQuestionRepository);

      questionDetailBloc.add(const QuestionDetailLoadEvent(0));

      final expected = [
        const QuestionDetailStateLoading(),
        QuestionDetailStateLoadedQuestion(mockQuestion),
      ];

      expectLater(questionDetailBloc.stream, emitsInOrder(expected));
    });

    test(
        "should emit [QuestionDetailStateLoading, QuestionDetailStateError] when event QuestionDetailLoadEvent is called and an error occurs",
        () async {
      when(mockQuestionRepository.getQuestionById(0))
          .thenAnswer((_) async => Either(error: Error('error')));

      final questionDetailBloc =
          QuestionDetailBloc(questionRepository: mockQuestionRepository);

      questionDetailBloc.add(const QuestionDetailLoadEvent(0));

      final expected = [
        const QuestionDetailStateLoading(),
        QuestionDetailStateError(Error('error')),
      ];
      expectLater(questionDetailBloc.stream, emitsInOrder(expected));
    });

    test(
        "should emit [QuestionDetailStateLoading, QuestionDetailStateDeleteSuccess] when event QuestionDetailDeleteEvent is called and no error occur",
        () async {
      when(mockQuestionRepository.deleteQuestion(0))
          .thenAnswer((_) async => Either(val: true));

      final questionDetailBloc =
          QuestionDetailBloc(questionRepository: mockQuestionRepository);

      questionDetailBloc.add(const QuestionDetailDeleteEvent(0));

      final expected = [
        const QuestionDetailStateLoading(),
        const QuestionDetailStateDeleteSuccess(),
      ];

      expectLater(questionDetailBloc.stream, emitsInOrder(expected));
    });

    test(
        "should emit [QuestionDetailStateLoading, QuestionDetailStateError] when event QuestionDetailDeleteEvent is called and an error occurs",
        () async {
      when(mockQuestionRepository.deleteQuestion(0))
          .thenAnswer((_) async => Either(error: Error('error')));

      final questionDetailBloc =
          QuestionDetailBloc(questionRepository: mockQuestionRepository);

      questionDetailBloc.add(const QuestionDetailDeleteEvent(0));

      final expected = [
        const QuestionDetailStateLoading(),
        QuestionDetailStateError(Error('error')),
      ];

      expectLater(questionDetailBloc.stream, emitsInOrder(expected));
    });

    test(
        "should emit [QuestionDetailStateLoadedQuestion] when event VoteQuestionEvent is called and no error occurs",
        () async {
      when(mockQuestionRepository.getQuestionById(0))
          .thenAnswer((_) async => Either(val: mockQuestion));
      when(mockQuestionRepository.voteQuestion(0, Vote.upVote))
          .thenAnswer((_) async => Either(val: mockQuestion));
      when(mockQuestion.id).thenReturn(0);

      final questionDetailBloc =
          QuestionDetailBloc(questionRepository: mockQuestionRepository);

      questionDetailBloc.add(VoteQuestionEvent(mockQuestion, Vote.upVote));

      final expected = [
        QuestionDetailStateLoadedQuestion(mockQuestion),
      ];

      expectLater(questionDetailBloc.stream, emitsInOrder(expected));
    });

    test(
        "should emit [QuestionDetailStateLoadedQuestion] when event VoteQuestionEvent is called and an error occurs",
        () async {
      when(mockQuestionRepository.getQuestionById(0))
          .thenAnswer((_) async => Either(val: mockQuestion));
      when(mockQuestionRepository.voteQuestion(0, Vote.upVote))
          .thenAnswer((_) async => Either(error: Error('error')));
      when(mockQuestion.id).thenReturn(0);

      final questionDetailBloc =
          QuestionDetailBloc(questionRepository: mockQuestionRepository);

      questionDetailBloc.add(VoteQuestionEvent(mockQuestion, Vote.upVote));

      final expected = [
        QuestionDetailStateError(Error('error')),
      ];

      expectLater(questionDetailBloc.stream, emitsInOrder(expected));
    });
  });

  group("QuestionConstructionBloc", () {
    test(
        "should emit [QuestionPostStateLoading, QuestionPostStateSuccess] when event QuestionEventPost is called and no error occur",
        () async {
      when(mockQuestionRepository.createQuestion(mockQuestionForm))
          .thenAnswer((_) async => Either(val: mockQuestion));
      when(mockQuestion.id).thenReturn(0);

      final questionContructionBloc =
          QuestionContructionBloc(questionRepository: mockQuestionRepository);

      questionContructionBloc.add(QuestionEventPost(mockQuestionForm));

      final expected = [
        const QuestionPostStateLoading(),
        QuestionPostStateSuccess(mockQuestion),
      ];

      expectLater(questionContructionBloc.stream, emitsInOrder(expected));
    });

    test(
        "should emit [QuestionPostStateLoading, QuestionPostStateError] when event QuestionEventPost is called and an error occurs",
        () async {
      when(mockQuestionRepository.createQuestion(mockQuestionForm))
          .thenAnswer((_) async => Either(error: Error('error')));

      final questionContructionBloc =
          QuestionContructionBloc(questionRepository: mockQuestionRepository);

      questionContructionBloc.add(QuestionEventPost(mockQuestionForm));

      final expected = [
        const QuestionPostStateLoading(),
        QuestionPostStateError(Error('error')),
      ];
      expectLater(questionContructionBloc.stream, emitsInOrder(expected));
    });
  });
}
