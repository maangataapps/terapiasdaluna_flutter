import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:terapiasdaluna/domain/model/profile/profile_model.dart';
import 'package:terapiasdaluna/presentation/base/bloc/test_actions.dart';
import 'package:terapiasdaluna/presentation/base/bloc/test_state.dart';

class TestBloc extends Bloc<TestActions, TestState> {
  TestBloc() : super(TestState(namesSelected: [])) {
    on<SelectOptionAction>((event, emit) {
      state.namesSelected.add(event.title);
      final profile = ProfileModel(
          userId: 'userId',
          name: 'Yara',
          userType: UserType.user.index,
          birthDate: DateTime.now().millisecondsSinceEpoch,
          height: 173,
          weight: 62,
        sex: SexType.female.index,
      );
      emit(TestState(namesSelected: state.namesSelected));
    });
  }

}