import 'package:education_media/constants/app_constants.dart';
import 'package:education_media/ui/catogory/catogory_view.dart';
import 'package:education_media/ui/home/home_view.dart';
import 'package:education_media/ui/login/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
        viewModelBuilder: () => LoginViewModel(),
        onViewModelReady: (viewmodel) {
          viewmodel.addListener(() {
            if (viewmodel.isLoggedIn) {
                  Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>CategoryView()
        ),
      );
            }
          });
        },
        builder: (context, viewModel, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: const Text("Sign In"),
            ),
            body: SafeArea(
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        InkWell(
                          onTap: () =>  Navigator.push(context,MaterialPageRoute(builder: (context) => HomeView(),)),
                          child: const Text(
                            "Welcome Back",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Sign in with your email and password  \nor continue with social media",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Color(0xFF757575)),
                        ),
                        // const SizedBox(height: 16),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05),
                        Form(
                          child: Column(
                            children: [
                              TextFormField(
                                controller: viewModel.emailController,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                    hintText: "Enter your email",
                                    labelText: "Email",
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    hintStyle: const TextStyle(
                                        color: Color(0xFF757575)),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 24,
                                      vertical: 16,
                                    ),
                                    suffix: SvgPicture.string(mailIcon),
                                    border: authOutlineInputBorder,
                                    enabledBorder: authOutlineInputBorder,
                                    focusedBorder:
                                        authOutlineInputBorder.copyWith(
                                            borderSide: const BorderSide(
                                                color: Color(0xFFFF7643)))),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 24),
                                child: TextFormField(
                                  controller: viewModel.passwordController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      hintText: "Enter your password",
                                      labelText: "Password",
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      hintStyle: const TextStyle(
                                          color: Color(0xFF757575)),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 24,
                                        vertical: 16,
                                      ),
                                      suffix: SvgPicture.string(lockIcon),
                                      border: authOutlineInputBorder,
                                      enabledBorder: authOutlineInputBorder,
                                      focusedBorder:
                                          authOutlineInputBorder.copyWith(
                                              borderSide: const BorderSide(
                                                  color: Color(0xFFFF7643)))),
                                ),
                              ),
                              const SizedBox(height: 8),
                              if (viewModel.errorMessage != null)
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Text(
                                    viewModel.errorMessage!,
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                ),
                              ElevatedButton(
                                onPressed: viewModel.isLoading
                                    ? null
                                    : viewModel.login,
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: const Color(0xFFFF7643),
                                  foregroundColor: Colors.white,
                                  minimumSize: const Size(double.infinity, 48),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16)),
                                  ),
                                ),
                                child: viewModel.isLoading
                                    ? const CircularProgressIndicator()
                                    : const Text("Continue"),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.2),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [],
                        ),
                        const SizedBox(height: 16),
                        const NoAccountText(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}

const authOutlineInputBorder = OutlineInputBorder(
  borderSide: BorderSide(color: Color(0xFF757575)),
  borderRadius: BorderRadius.all(Radius.circular(100)),
);

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don’t have an account? ",
          style: TextStyle(color: Color(0xFF757575)),
        ),
        GestureDetector(
          onTap: () {
            // Handle navigation to Sign Up\
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => const HomeView(),
            //     ));
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(
              color: Color(0xFFFF7643),
            ),
          ),
        ),
      ],
    );
  }
}
