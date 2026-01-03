import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vkid_flutter_sdk/library_vkid.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:flutter_vk_id_auth_demo/services/auth/cubit/auth_cubit.dart';
import 'package:flutter_vk_id_auth_demo/services/auth/storage/auth_storage.dart';
import 'package:flutter_vk_id_auth_demo/services/auth/extensions/auth_context_x.dart';
import 'package:flutter_vk_id_auth_demo/services/auth/repository/auth_repository.dart';
import 'package:flutter_vk_id_auth_demo/ui/drawer/app_drawer.dart';
import 'package:flutter_vk_id_auth_demo/ui/auth/login_bottom_sheet.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storage = AuthStorage(const FlutterSecureStorage());
  final repository = AuthRepository(storage);

  runApp(
    BlocProvider(
      create: (_) => AuthCubit(repository)..init(),
      lazy: false, // enable force fast read the auth session for rid the UI lag
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter VK ID Auth Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Flutter VK ID Auth Demo'),
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {

              if (context.userIsLoggedIn) {
                final User user = context.currentUser!;
                return Column(
                  spacing: 8,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(user.firstName),
                    Text(user.lastName),
                    Text(user.email),
                  ],
                );
              }

              return Column(
                spacing: 10,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('User not logged in'),
                  FilledButton.icon(
                    icon: const Icon(Icons.login),
                    label: const Text('Login'),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        useSafeArea: true,
                        builder: (_) => const LoginBottomSheet(),
                      );
                    },
                  )
                ],
              );

            },
          ),
        ),
      ),
    );
  }
}
