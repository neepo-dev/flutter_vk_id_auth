import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vkid_flutter_sdk/library_vkid.dart';

import 'package:flutter_vk_id_auth_demo/services/auth/cubit/auth_cubit.dart';
import 'package:flutter_vk_id_auth_demo/services/auth/extensions/auth_context_x.dart';
import 'package:flutter_vk_id_auth_demo/ui/auth/login_bottom_sheet.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.currentUser;

    return SafeArea(
      child: Drawer(
        child: user != null
            ? _AuthorizedContent(user: user)
            : const _UnauthorizedContent(),
      ),
    );
  }
}

/// Контент для авторизованного пользователя
class _AuthorizedContent extends StatelessWidget {
  final User user;

  const _AuthorizedContent({required this.user});

  @override
  Widget build(BuildContext context) {
    final fullName = '${user.firstName} ${user.lastName}'.trim();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UserAccountsDrawerHeader(
          accountName: Text(
            fullName.isEmpty ? 'Пользователь VK' : fullName,
          ),
          accountEmail:
          Text(user.email.isNotEmpty ? user.email : user.phone),
          currentAccountPicture: CircleAvatar(
            backgroundImage: user.avatarUrl.isNotEmpty
                ? NetworkImage(user.avatarUrl)
                : null,
            child: user.avatarUrl.isEmpty ? const Icon(Icons.person) : null,
          ),
        ),

        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Выйти'),
          onTap: () {
            Navigator.pop(context);
            context.read<AuthCubit>().logout();
          },
        ),
      ],
    );
  }
}

/// Контент для НЕавторизованного пользователя
class _UnauthorizedContent extends StatelessWidget {
  const _UnauthorizedContent();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: FilledButton.icon(
          icon: const Icon(Icons.login),
          label: const Text('Login'),
          onPressed: () {
            Navigator.pop(context);
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              useSafeArea: true,
              builder: (_) => const LoginBottomSheet(),
            );
          },
        ),
      ),
    );
  }
}
