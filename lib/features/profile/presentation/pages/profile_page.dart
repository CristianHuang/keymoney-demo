import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keymoneydemo/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:keymoneydemo/features/authentication/presentation/bloc/auth_state.dart';
import 'package:keymoneydemo/features/profile/presentation/pages/profile_logged.dart';
import 'package:keymoneydemo/features/profile/presentation/pages/profile_no_logged.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthSuccess) {
          return const ProfileLogged();
        } else {
          return const ProfileNoLogged();
        }
      },
    );
  }
}
