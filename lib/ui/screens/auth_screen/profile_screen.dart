import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../data/model/user_model.dart';
import '../../../data/services/user/firebase_user_service.dart';
import '../../../data/utils/app_constants.dart';
import '../../../logic/bloc/auth/auth_bloc.dart';
import '../../../logic/bloc/auth/auth_event.dart';
import '../../../logic/bloc/auth/auth_state.dart';
import '../profiles_screen/edit_screen.dart';
import '../splash_screens/welcome_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel? user;
  String? uId;

  @override
  void initState() {
    super.initState();
    print(AppConstants.uId);
    getCurrentUserInfo();
  }

  Future<void> getCurrentUserInfo() async {
    try {
      uId = await FirebaseUserService.getId();
      if (uId != null) {
        user = await FirebaseUserService().getUser(uId!);
      }
      setState(() {});
    } catch (e) {
      print('Error fetching user info: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.person,
          ),
        ),
        title: const Text('Profile Screen'),
        actions: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthUnauthenticated) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => WelcomeScreen()),
                  (route) => false,
                );
              }
            },
            child: IconButton(
              onPressed: () async {
                context.read<AuthBloc>().add(LogoutEvent());
              },
              icon: const Icon(
                Icons.logout,
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Center(
                  child: Column(
                    children: [
                      const Text(
                        'My Profile',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: user?.imageUrl != null
                                ? NetworkImage(user!.imageUrl)
                                : const AssetImage('assets/images/malfoy.png')
                                    as ImageProvider,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        user?.name ?? 'Malfoy',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _buildMenuItem(
                  icon: CupertinoIcons.settings,
                  title: "Settings",
                  onTap: () {},
                ),
                _buildMenuItem(
                  icon: Icons.logout,
                  title: "Logout",
                  onTap: () {
                    context.read<AuthBloc>().add(LogoutEvent());
                  },
                ),
                _buildMenuItem(
                  icon: Icons.person,
                  title: "Edit Profile",
                  onTap: () async {
                    final response = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfilePage(),
                      ),
                    );
                    if (response != null) {
                      setState(() {
                        user!.imageUrl = response['image'];
                        user!.name = response['name'];
                      });
                      print(user!.name);
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ZoomTapAnimation(
      onTap: onTap,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Icon(icon),
        title: Text(
          title,
          style: const TextStyle(fontSize: 20),
        ),
        trailing: const Icon(Icons.arrow_forward_ios_outlined),
      ),
    );
  }
}
