// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/login_bloc/login_bloc.dart';
import '../../../configs/components/round_button.dart';
import '../../../configs/routes/routes_name.dart';
import '../../../data/response/status.dart';
import '../../../utils/extensions/flush_bar_extension.dart';

/// A widget representing the submit button for the login form.
class SubmitButton extends StatelessWidget {
  final formKey;
  const SubmitButton({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginStates>(
      listenWhen: (current, previous) =>
          current.loginApi.status != previous.loginApi.status,
      listener: (context, state) {
        if (state.loginApi.status == Status.error) {
          context.flushBarErrorMessage(
            message: state.loginApi.message.toString(),
          );
        }

        if (state.loginApi.status == Status.completed) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesName.home,
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        return SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          child: RoundButton(
            title: 'Login',
            loading: state.loginApi.status == Status.loading ? true : false,
            onPress: () {
              if (formKey.currentState.validate()) {
                context.read<LoginBloc>().add(const LoginApi());
              }
            },
          ),
        );
      },
    );
  }
}
