import 'package:e_commerce_web_app/core/utils/app_colors.dart';
import 'package:e_commerce_web_app/core/utils/local_hive_storage.dart';
import 'package:e_commerce_web_app/core/widgets/app_buttons.dart';
import 'package:e_commerce_web_app/features/home/ui/widgets/app_bar_widget.dart';
import 'package:e_commerce_web_app/features/profile/ui/managers/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/text_styles.dart';
import '../../../authentication/domain/entity/user_entity.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..fetchUserData(""),
      child: _ProfilePageBody(),
    );
  }
}

class _ProfilePageBody extends StatefulWidget {
  @override
  State<_ProfilePageBody> createState() => _ProfilePageBodyState();
}

class _ProfilePageBodyState extends State<_ProfilePageBody> {
  final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  UserInfoEntity? _userData;

  @override
  void initState() {
    HiveStorageService.service
        .getModel(
          boxName: "CurrentUser",
          key: "CurrentUser",
          fromJson: (p0) => UserInfoEntity.fromJson(p0),
        )
        .then((value) async {
          if (value != null) {
            setState(() {
              _userData = value;
            });
          }
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state.fetchUserData.isSuccess) {
          // _userData = state.fetchUserData.data;
        } else if (state.fetchUserData.isFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.fetchUserData.failureMessage ?? "")),
          );
        }
      },
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state.fetchUserData.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return LayoutBuilder(
            builder: (context, constrains) {
              return Scaffold(
                appBar: AppBarWidget(
                  constraints: constrains,
                  globalKey: globalKey,
                ),
                body: Row(
                  children: [
                    // Sidebar
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 48.h,
                          horizontal: 32.w,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Manage My Account",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 16.h),
                            _sidebarItem("My Profile", selected: true),
                            _sidebarItem("Address Book"),
                            _sidebarItem("My Payment Options"),
                            SizedBox(height: 24.h),
                            Text(
                              "My Orders",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 16.h),
                            _sidebarItem("My Returns"),
                            _sidebarItem("My Cancellations"),
                            SizedBox(height: 24.h),
                            Text(
                              "My WishList",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Form
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.all(32.0.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Edit Your Profile",
                              style: TextStyles.boldFont(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 24.h),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildField(
                                    "First Name",
                                    _userData?.firstName ?? "",
                                  ),
                                ),
                                SizedBox(width: 16.w),
                                Expanded(
                                  child: _buildField(
                                    "Last Name",
                                    _userData?.lastName ?? "",
                                    outlined: true,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16.h),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildField(
                                    "Email",
                                    _userData?.verifiedEmail ?? "",
                                  ),
                                ),
                                SizedBox(width: 16.w),
                                Expanded(
                                  child: _buildField(
                                    "Address",
                                    "Kingston, 5236, United State",
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 32.h),
                            Text(
                              "Password Changes",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 16.h),
                            _buildField(
                              "Current Password",
                              "",
                              isPassword: true,
                            ),
                            SizedBox(height: 8.h),
                            _buildField("New Password", "", isPassword: true),
                            SizedBox(height: 8.h),
                            _buildField(
                              "Confirm New Password",
                              "",
                              isPassword: true,
                            ),
                            SizedBox(height: 24.h),
                            Row(
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                SizedBox(width: 16.w),
                                AppPrimaryButton(
                                  width: 200.w,
                                  height: 48.h,
                                  onTap: () {},
                                  colors: AppColors.unFollowListColors,
                                  child: Text(
                                    "Save changes",
                                    style: TextStyles.boldFont(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildField(
    String label,
    String value, {
    bool outlined = false,
    bool isPassword = false,
    String? hintText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyles.regularFont(fontSize: 12, color: Colors.black),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          initialValue: value,
          obscureText: isPassword,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: Colors.grey.shade100,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 12.h,
            ),
            enabledBorder:
                outlined
                    ? OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple, width: 1),
                    )
                    : OutlineInputBorder(borderSide: BorderSide.none),
          ),
        ),
      ],
    );
  }

  Widget _sidebarItem(String title, {bool selected = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Text(
        title,
        style: TextStyle(
          color: selected ? Colors.red : Colors.grey.shade700,
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
