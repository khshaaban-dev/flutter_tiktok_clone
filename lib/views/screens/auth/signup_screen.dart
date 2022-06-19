import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../../constants/constants.dart';
import '../../../logic/blocs/auth/auth_bloc.dart';
import '../../../logic/utils/pick_profile_image.dart';
import '../../widgets/widgets.dart';

class SignUpScreen extends StatefulWidget {
  static const String route = '/SignUpScreen';
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController nameController = TextEditingController();

  late String? imagePath;
  bool imageLoaded = false;
  bool imageBorder = false;
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  ImageProvider _getImage() {
    if (imageLoaded) {
      return FileImage(File(imagePath!));
    } else {
      return const AssetImage('assets/images/person.png');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Form(
                key: globalKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Tiktok clone',
                      style: TextStyle(
                        fontSize: 25.sp,
                        color: buttonColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'SingUp',
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: buttonColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    InkWell(
                      onTap: () async {
                        final image = await pickImage(
                          source: ImageSource.gallery,
                        );
                        if (image != null) {
                          imagePath = image;
                          setState(() {
                            imageLoaded = true;
                            imageBorder = false;
                          });
                        }
                      },
                      child: Stack(
                        children: [
                          Container(
                            height: 80.h,
                            width: 80.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40.h),
                              border: Border.all(
                                color: imageBorder
                                    ? Colors.red
                                    : Colors.transparent,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 80.h,
                              backgroundColor: Colors.grey,
                              backgroundImage: _getImage(),
                            ),
                          ),
                          Positioned(
                            bottom: -2.h,
                            right: 2.h,
                            child: Icon(
                              Icons.add_a_photo,
                              size: 22.sp,
                              color: imageBorder ? Colors.red : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(
                        horizontal: 20.w,
                      ),
                      child: CustomTextInputFormFeild(
                        validate: (value) {
                          if (value!.isEmpty) return 'Filed Is Empty';
                          return null;
                        },
                        labelText: 'User Name',
                        icon: Icons.email,
                        controller: nameController,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(
                        horizontal: 20.w,
                      ),
                      child: CustomTextInputFormFeild(
                        validate: (value) {
                          if (value!.isEmpty) return 'Filed Is Empty';
                          return null;
                        },
                        labelText: 'Email',
                        icon: Icons.email,
                        controller: emailController,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(
                        horizontal: 20.w,
                      ),
                      child: CustomTextInputFormFeild(
                        validate: (value) {
                          if (value!.isEmpty) return 'Filed Is Empty';
                          return null;
                        },
                        labelText: 'Password',
                        icon: Icons.lock,
                        controller: passwordController,
                        isObscure: true,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    InkWell(
                      onTap: () async {
                        //globalKey.currentState!.validate();
                        final state = globalKey.currentState!.validate();

                        if (state && imagePath != null) {
                          final email = emailController.text;
                          final password = passwordController.text;
                          final name = nameController.text;

                          context.read<AuthBloc>().add(
                                SignUpEvent(
                                  name: name,
                                  email: email,
                                  password: password,
                                  imageUrl: imagePath!,
                                ),
                              );
                        } else {
                          setState(() {
                            imageBorder = true;
                          });
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(
                          horizontal: 20.w,
                        ),
                        alignment: Alignment.center,
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: buttonColor,
                          borderRadius: BorderRadius.circular(
                            12.h,
                          ),
                        ),
                        child: Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 22.sp,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    const GoogleSignInButton(),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(
                        horizontal: 20.w,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account ?',
                            style: TextStyle(fontSize: 18.sp),
                          ),
                          GestureDetector(
                            onTap: () {
                              context.read<AuthBloc>().add(
                                    GoToSignInScreenEvent(),
                                  );
                            },
                            child: Text(
                              ' Login',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: buttonColor,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )));
  }
}
