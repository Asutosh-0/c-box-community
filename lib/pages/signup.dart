import 'package:c_box/navigation_bar/navigation_bar.dart';
import 'package:c_box/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUp extends StatelessWidget {
  final auth = Auth_Services();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String? passwordError;

  SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color(0xFF141517), // for black BG
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 600) {
              return largeScreenLayout(context, constraints);
            } else {
              return smallScreenLayout(context, constraints);
            }
          },
        ),
      ),
    );
  }

  Widget largeScreenLayout(BuildContext context, BoxConstraints constraints) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF141517), // Set dark black background color
        borderRadius: BorderRadius.circular(35),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildHeader(context, constraints),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: constraints.maxWidth * 0.3,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/images/wepik_export_202308081622374_se_3_removebg_preview_1.png',
                      ),
                    ),
                  ),
                  height: constraints.maxHeight * 0.7,
                ),
                SizedBox(width: constraints.maxWidth * 0.08),
                Container(
                  width: constraints.maxWidth * 0.4,
                  margin: const EdgeInsets.only(right: 16),
                  child: SingleChildScrollView(
                    child: buildForm(context, constraints),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget smallScreenLayout(BuildContext context, BoxConstraints constraints) {
    return Container(
      height: constraints.maxHeight,
      width: constraints.maxWidth,
      decoration: BoxDecoration(
        color: const Color(0xFF141517), // Set dark black background color
        image: DecorationImage(
          image: const AssetImage('assets/images/wepik_export_202308081622374_se_3_removebg_preview_1.png'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5),
              BlendMode.dstATop
          ),
        ),
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: constraints.maxHeight * 0.058
        ),
        child: Column(
          children: [
            buildHeader(context, constraints),
            SizedBox(height: constraints.maxHeight * 0.01),
            Container(
              margin: EdgeInsets.only(right: 16),
              child: SingleChildScrollView(
                child: buildForm(context, constraints),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context, BoxConstraints constraints) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                'assets/c_box.png',
                width: constraints.maxWidth * 0.10, // Adjust logo size based on maxWidth
                height: constraints.maxWidth * 0.10,
              ),
              const SizedBox(width: 10), // Space between logo and text
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'C-Box',
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w900,
                      fontSize: constraints.maxWidth * 0.04,
                      color: const Color(0xFFFFFFFF), // White text color
                    ),
                  ),
                  Text(
                    'Community',
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      fontSize: constraints.maxWidth * 0.02,
                      color: const Color(0xFFFFFFFF), // White text color
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Sign Up button tapped!')),
                  );
                },
                child: Text(
                  'Sign Up',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w600,
                    fontSize: constraints.maxWidth * 0.04,
                    color: Color(0xFFFFFFFF), // White text color
                  ),
                ),
              ),
              const SizedBox(width: 10), // Space between buttons
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Register button tapped!')),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: constraints.maxWidth * 0.02,
                    vertical: constraints.maxHeight * 0.01,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Text(
                    'SignIn',
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      fontSize: constraints.maxWidth * 0.03,
                      color: const Color(0xFF000000), // Black text color
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildForm(BuildContext context, BoxConstraints constraints) {
    return Column(
      children: [
        Text(
          'Hello !',
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w600,
            fontSize: 40,
            color: const Color(0xFFFFFFFF), // White text color
          ),
        ),
        Text(
          'Welcome To Our Community',
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w500,
            fontSize: 25,
            color: const Color(0xFFFFFFFF), // White text color
          ),
        ),
        SizedBox(height: constraints.maxHeight * 0.01),
        Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Enter Email',
                  hintStyle: GoogleFonts.roboto(
                    fontWeight: FontWeight.w300,
                    fontSize: 20,
                    color: const Color(0xFF5E5E5E),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            if (passwordError != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  passwordError!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                  ),
                ),
              ),
            SizedBox(height: constraints.maxHeight * 0.03),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Enter Password',
                  hintStyle: GoogleFonts.roboto(
                    fontWeight: FontWeight.w300,
                    fontSize: 20,
                    color: const Color(0xFF5E5E5E),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: constraints.maxHeight * 0.03),
        GestureDetector(
          onTap: () async {
            final email = emailController.text;
            final password = passwordController.text;

            if(email.isEmpty){
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Enter Email.')),
                );
            }else if(password.isEmpty){
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Enter password.')),
                );
            }else{
              final user = await auth.createUserWithEmailAndPassword(email, password);
              if (user != null) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Navigation_Bar()),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Failed to register user.')),
                );
              }
            }
              
            // } else {
            //   passwordError = 'Password must be at least 8 characters long, containing digits, letters, and special characters.';
            // }

            scaffoldKey.currentState?.setState(() {});
          },
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.symmetric(vertical: constraints.maxHeight * 0.02),
            child: Center(
              child: Text(
                'Sign Up',
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                  color: const Color(0xFF010000),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: constraints.maxHeight * 0.05),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildSocialButton(context, 'assets/vectors/flat_color_iconsgoogle_x2.svg', constraints),
            buildSocialButton(context, 'assets/vectors/logosfacebook_x2.svg', constraints),
            buildSocialButton(context, 'assets/vectors/ionlogo_apple_x2.svg', constraints),
          ],
        ),
        SizedBox(height: constraints.maxHeight * 0.03),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Have An Account ?',
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w300,
                fontSize: 16,
                color: const Color(0xFFFFFFFF), // White text color
              ),
            ),
            const SizedBox(width: 7),
            Text(
              'Sign In !',
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w900,
                fontSize: 16,
                color: const Color(0xFFFFFFFF), // White text color
              ),
            ),
          ],
        ),
      ],
    );
  }

  bool isValidPassword(String password) {
    final regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    return regex.hasMatch(password);
  }

  Widget buildSocialButton(BuildContext context, String assetPath, BoxConstraints constraints) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Button tapped!')),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(10),
        ),
        width: 60,
        height: constraints.maxHeight * 0.07,
        child: Center(
          child: SvgPicture.asset(
            assetPath,
            width: constraints.maxWidth * 0.08,
            height: constraints.maxHeight * 0.05,
          ),
        ),
      ),
    );
  }
}
