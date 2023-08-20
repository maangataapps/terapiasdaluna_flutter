import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:terapiasdaluna/presentation/base/bloc/test_bloc.dart';
import 'package:terapiasdaluna/presentation/base/bloc/test_state.dart';
import 'package:terapiasdaluna/presentation/widgets/dashboard_wheel.dart';

class TestWidgetScreen extends StatelessWidget {
  const TestWidgetScreen({Key? key}) : super(key: key);
  static const routeName = '/test_screen';

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final nameController = TextEditingController();
    final bloc = BlocProvider.of<TestBloc>(context);

    return BlocProvider<TestBloc>.value(
      value: bloc,
      child: SafeArea(
        child: Scaffold(
          body: BlocConsumer<TestBloc, TestState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Column(
                children:  [
                  Container(
                    margin: const EdgeInsets.all(6.0),
                    child: Container()
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

}