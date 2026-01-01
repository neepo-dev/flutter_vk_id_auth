import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vkid_flutter_sdk/library_vkid.dart';

import 'package:flutter_vk_id_auth_demo/services/auth/cubit/auth_cubit.dart';

class LoginBottomSheet extends StatelessWidget {
  const LoginBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 26),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Login',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 24),

            OneTap(
              key: GlobalKey(),
              signInToAnotherAccountButtonEnabled: true,
              authParams: UIAuthParamsBuilder()
                  .withScopes({'phone', 'email'})
                  .build(),
              onAuth: (oAuth, data) {
                context.read<AuthCubit>().login(data);
                Navigator.of(context).pop();
              },
              onError: (oAuth, error) {
                // TODO: обработка ошибок
                switch (error) {
                  case AuthCancelledError():
                    break;
                  case AuthOtherError(description: var description):
                    break;
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
