import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qelem/application/question/edit_question/edit_question_event.dart';
import 'package:qelem/application/question/edit_question/edit_question_state.dart';
import 'package:qelem/domain/question/question_repository_interface.dart';

class EditQuestionBloc extends Bloc<EditQuestionEvent, EditQuestionState> {
  final QuestionRepositoryInterface _questionRepository;

  EditQuestionBloc(this._questionRepository)
      : super(const EditQuestionState.initial()) {
    on<EditQuestionEvent>(((event, emit) async {
      emit(const EditQuestionState.loading());

      var result = await _questionRepository.updateQuestion(
          event.questionForm, event.questionId);

      if (result.hasError) {
        emit(EditQuestionStateFailure(result.error!));
      } else {
        emit(const EditQuestionStateSuccess());
      }
    }));
  }
}
