import 'package:flutter/material.dart';
import 'package:job_link/core/router/router_strings.dart';
import 'package:job_link/core/theme/app_theme.dart';
import 'package:job_link/modules/auth/data/models/freelancer.dart';
import 'package:job_link/modules/auth/data/models/job_owner.dart';
import 'package:job_link/modules/auth/data/models/user.dart';
import 'package:job_link/modules/auth/data/services/firebase_auth_service.dart';
import 'package:job_link/modules/home/data/model/drawer_item_model.dart';
import 'package:job_link/modules/home/presentation/widgets/drawer_item.dart';
import 'package:job_link/modules/task/data/service/task_hive_service.dart';

class CustomDrawer extends StatelessWidget {
  final MyAppUser user;
  const CustomDrawer({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    bool isFreelancer = user is Freelancer;
    final AppTheme theme = Theme.of(context).extension<AppTheme>()!;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              isFreelancer
                  ? (user as Freelancer).name
                  : (user as JobOwner).companyName,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: null,
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                isFreelancer ? Icons.person : Icons.business,
                size: 50,
                color: Colors.blue,
              ),
            ),
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
          ),
          if (!isFreelancer)
            DrawerItem(
              item: DrawerItemModel(
                icon: Icons.add,
                title: 'Add Job',
                onTap: () {
                  Navigator.of(
                    context,
                  ).pushNamed(
                    RouterStrings.addJob,
                    arguments: user as JobOwner,
                  );
                },
              ),
            ),
          if (!isFreelancer)
            DrawerItem(
              item: DrawerItemModel(
                icon: Icons.chat_bubble_outline,
                title: 'Mention Task',
                onTap: () {
                  Navigator.of(context).pushNamed(RouterStrings.onlyAccepted);
                },
              ),
            ),
          DrawerItem(
            item: DrawerItemModel(
              icon: Icons.list_alt,
              title: 'Mentioned Tasks',
              onTap: () {
                Navigator.of(
                  context,
                ).pushNamed(RouterStrings.tasks, arguments: user);
              },
            ),
          ),
          Divider(
            color: theme.dividerColor,
            height: 40,
            indent: 16,
            endIndent: 16,
          ),
          DrawerItem(
            item: DrawerItemModel(
              icon: Icons.logout,
              title: 'logout',
              color: Colors.red,
              onTap: () {
                FirebaseAuthService().logout();
                TaskHiveService().clearCache();
                Navigator.of(context).pushReplacementNamed(RouterStrings.login);
              },
            ),
          ),
        ],
      ),
    );
  }
}
