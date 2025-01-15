import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reel/core/extension/widget_extension.dart';
import 'package:reel/core/services/service_locator.dart';
import 'package:reel/feature/auth/domain/model/user_model.dart';
import 'package:reel/feature/profile/presentation/cubit/profile_cubit.dart';
import 'package:reel/feature/profile/data/logout_mixin.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with LogoutMixin {
  final String profilePicUrl = 'https://www.example.com/profile-pic.jpg';
  // Replace with actual URL
  final String name = 'Name';

  final String email = 'name.@example.com';

  @override
  void initState() {
    getIt<ProfileCubit>().getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: BlocBuilder<ProfileCubit, UserModel>(
        builder: (context, state) {
          return Center(
            child: Column(
              children: [
                // Profile Picture
                CircleAvatar(
                  radius: 80.r,
                  backgroundImage:
                      NetworkImage(state.photoUrl ?? profilePicUrl),
                ).padBottom(bottom: 20.h),

                // Name
                Text(
                  state.displayName ?? name,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ).padBottom(bottom: 20.h),

                // Email
                Text(
                  state.email ?? email,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ).padBottom(bottom: 20.h),
                Spacer(),

                // Logout Button
                ElevatedButton(
                  onPressed: logout,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text('Logout'),
                ).padBottom(bottom: 40.h),
              ],
            ),
          );
        },
      ).padHorizontal(horizontal: 20.w).padVertical(vertical: 20.h),
    );
  }
}
