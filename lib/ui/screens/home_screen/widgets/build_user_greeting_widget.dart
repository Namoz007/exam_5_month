import 'package:flutter/widgets.dart';

import '../../../../data/model/user_model.dart';
class BuildUserGreetingWidget extends StatelessWidget {
  UserModel? user;
  BuildUserGreetingWidget({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello ${user?.name ?? 'Guest'}',
              style: const TextStyle(
                color: Color(0xFF1E1E1E),
                fontWeight: FontWeight.w600,
                fontSize: 19,
              ),
            ),
            const Text(
              'What are you cooking today?',
              style: TextStyle(
                color: Color(0xFFA9A9A9),
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ],
        ),
        Container(
          height: 47,
          width: 47,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: (user?.imageUrl == null || user!.imageUrl.isEmpty)
                  ? const AssetImage('assets/images/malfoy.png')
                      as ImageProvider
                  : NetworkImage(user!.imageUrl) as ImageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
