import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vkid_flutter_sdk/library_vkid.dart';

import '../cubit/auth_cubit.dart';

extension AuthContextX on BuildContext {
  User? get currentUser {
    final state = read<AuthCubit>().state;
    return state is AuthLoggedIn ? state.user : null;
  }

  bool get userIsLoggedIn {
    return read<AuthCubit>().state is AuthLoggedIn;
  }
}
