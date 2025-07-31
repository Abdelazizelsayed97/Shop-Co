import 'package:e_commerce_web_app/core/utils/app_colors.dart';
import 'package:e_commerce_web_app/core/utils/local_hive_storage.dart';
import 'package:e_commerce_web_app/core/widgets/app_buttons.dart';
import 'package:e_commerce_web_app/features/home/ui/widgets/app_bar_widget.dart';
import 'package:e_commerce_web_app/features/profile/ui/managers/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

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

  var _userData;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state.fetchUserData.isSuccess) {
          _userData = state.fetchUserData.data;
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
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(child: Icon(Iconsax.profile_circle)),

                    AppPrimaryButton(
                      onTap: () async {
                        print('pressed  ');
                        context.read<ProfileCubit>().logOut();
                        setState(() {
                          HiveStorageService.service.clearBox("CurrentUser");
                          HiveStorageService.service.deleteModel(
                            boxName: "CurrentUser",
                            key: "CurrentUser",
                          );
                        });
                      },
                      colors: AppColors.orangeRedGradientList,
                      child: Text("Log out"),
                    ),
                    // Column(
                    //   children: [
                    //     Row(children: [CircleAvatar()]),
                    //   ],
                    // ),
                    // Column(children: []),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
