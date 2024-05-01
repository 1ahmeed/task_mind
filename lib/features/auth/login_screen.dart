import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ionicons/ionicons.dart';
import 'package:task_mindd/core/utils/app_strings.dart';
import 'package:task_mindd/features/Layout/Layout_screen.dart';
import 'package:task_mindd/features/auth/cubit/login_cubit.dart';
import 'package:task_mindd/features/auth/cubit/login_state.dart';

import '../../core/utils/app_assets.dart';
import '../../core/utils/my_validators.dart';
import '../../generated/l10n.dart';

class LoginScreen extends StatefulWidget {
  static const routName = '/LoginScreen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: BlocProvider(
  create: (context) => LoginCubit(),
  child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LayoutScreen(),
                ));
            Fluttertoast.showToast(
                msg: "Login Successfully",
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
          } else if (state is LoginFailedState) {
            Fluttertoast.showToast(
                msg: state.errorMessage,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        },
        builder: (context, state) {
          return const Scaffold(
            body: Padding(
              padding: EdgeInsets.only(left: 30.0, right: 30),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 68.0,
                    ),

                    ///headers
                    HeaderSection(),

                    SizedBox(
                      height: 50,
                    ),
                    InputSection(),
                    SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
),
    ));
  }
}

class HeaderSection extends StatelessWidget {
  const HeaderSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Center(
          child: CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage(AppAssets.imagesLogo),
            // child: ,
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
        Text(
          S.of(context).welcome,
          style: TextStyle(
              fontSize: 34,
              fontFamily: AppStrings.fontFamily,
              fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}

class InputSection extends StatefulWidget {
  const InputSection({Key? key}) : super(key: key);

  @override
  State<InputSection> createState() => _InputSectionState();
}
class _InputSectionState extends State<InputSection> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;
  late final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    // Focus Nodes
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    // Focus Nodes
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _loginFct() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      LoginCubit.get(context)!.login(
          email: _emailController.text, password: _passwordController.text);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: _formKey,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// email field
              SizedBox(
                height: MediaQuery.of(context).size.height*.09,
                child: TextFormField(
                  controller: _emailController,
                  focusNode: _emailFocusNode,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: S.of(context).email,
                    hintStyle: TextStyle(
                        fontSize: 18,
                        fontFamily: AppStrings.fontFamily,
                        fontWeight: FontWeight.w400),
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                      color: Color(0xffEBC00D),
                    ),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),

                  ),
                  validator: (value) {
                    return MyValidators.emailValidator(value);
                  },
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(_passwordFocusNode);
                  },
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),

              ///password field
              SizedBox(
                height: MediaQuery.of(context).size.height*.09,

                child: TextFormField(
                  controller: _passwordController,
                  focusNode: _passwordFocusNode,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.visiblePassword,obscureText: true,
                  decoration: InputDecoration(
                    hintText: S.of(context).password,
                    hintStyle: TextStyle(
                        fontSize: 18,
                        fontFamily: AppStrings.fontFamily,
                        fontWeight: FontWeight.w400),
                    prefixIcon: const Icon(
                      IconlyLight.lock,
                      color: Color(0xffEBC00D),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  validator: (value) {
                    return MyValidators.passwordValidator(value);
                  },
                  onFieldSubmitted: (value) {
                    _loginFct();
                  },
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),

              ///forget password
              const ForgetPasswordSection(),
              const SizedBox(
                height: 14.0,
              ),

              ///login button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(12),
                    backgroundColor: const Color(0xffFBD203),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                    ),
                  ),
                  onPressed: () async {
                    _loginFct();
                  },
                  child: Text(
                    S.of(context).logIn,
                    style: TextStyle(
                        fontFamily: AppStrings.fontFamily,
                        fontSize: 23,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              const IfNotHaveAccountSection(),
              const SizedBox(
                height: 68.0,
              ),
              const SocialSection()

            ],
          ),
        )
      ],
    );
  }
}

class IfNotHaveAccountSection extends StatelessWidget {
  const IfNotHaveAccountSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          S.of(context).donHaveAccount,
          style: TextStyle(
              fontFamily: AppStrings.fontFamily,
              fontSize: 16,
              color: const Color(0xff999999),
              fontWeight: FontWeight.w400),
        ),
        TextButton(
          style: const ButtonStyle(
              padding: MaterialStatePropertyAll(
                  EdgeInsets.zero)),
          onPressed: () {
            // Navigator.pushNamed(context, RegisterScreen.routName);
          },
          child: Text(
            S.of(context).registerNow,
            style: TextStyle(
                fontFamily: AppStrings.fontFamily,
                fontSize: 18,
                decoration: TextDecoration.underline,
                decorationColor: const Color(0xff38D39F),
                color: const Color(0xff38D39F),
                fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }
}

class ForgetPasswordSection extends StatelessWidget {
  const ForgetPasswordSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: InkWell(
        onTap: () {},
        child: Text(
          S.of(context).forgetPassword,
          style: TextStyle(
              wordSpacing: 3,
              fontWeight: FontWeight.w400,
              fontSize: 18,
              color: const Color(0xff999999),
              fontFamily: AppStrings.fontFamily),
        ),
      ),
    );
  }
}
class SocialSection extends StatelessWidget {
  const SocialSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Or Sign in With",
          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: const Color(0xff757575),
              fontFamily: AppStrings.fontFamily2),
        ),
        const SizedBox(
          height: 12.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () {},
              child: CircleAvatar(
                  backgroundColor: const Color(0xffF5F6F9),
                  radius: 30,
                  child:
                  SvgPicture.asset(AppAssets.imagesFace)),
            ),
            const SizedBox(
              width: 10,
            ),
            InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () {},
              child: const CircleAvatar(
                backgroundColor: Color(0xffF5F6F9),
                radius: 30,
                child: Icon(
                  Ionicons.logo_apple,
                  color: Colors.black,
                  size: 30,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () {},
              child: CircleAvatar(
                  backgroundColor: const Color(0xffF5F6F9),
                  radius: 30,
                  child: SvgPicture.asset(
                      AppAssets.imagesGoogle)),
            ),
          ],
        ),
      ],
    );
  }
}
