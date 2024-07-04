import 'package:c_box/navigation_bar/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFF141517), // for black BG
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
        color: Color(0xFF141517), // Set dark black background color
        borderRadius: BorderRadius.circular(35),
      ),
      child: SingleChildScrollView(
        // padding: EdgeInsets.fromLTRB(16, 20, 16, 0),
        child: Column(
          children: [
            buildHeader(context, constraints),
            // SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Expanded(
                //   child: 
                  Container(
                    width: constraints.maxWidth * 0.3,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          'assets/images/wepik_export_202308081622374_se_3_removebg_preview_1.png',
                        ),
                      ),
                    ),
                    height: constraints.maxHeight * 0.7,
                  ),
                // ),
                SizedBox(width: constraints.maxWidth * 0.08),
                // Expanded(
                //   flex: 1,
                  // child: 
                  Container(
                    width: constraints.maxWidth * 0.4,
                    margin: EdgeInsets.only(right: 16),
                    child: SingleChildScrollView(
                      child: buildForm(context, constraints),
                    ),
                  ),
                // ),
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
        color: Color(0xFF141517), // Set dark black background color
        image: DecorationImage(
          image: AssetImage('assets/images/wepik_export_202308081622374_se_3_removebg_preview_1.png'),
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
            SizedBox(width: 10), // Space between logo and text
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'C-Box',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w900,
                    fontSize: constraints.maxWidth * 0.04,
                    color: Color(0xFFFFFFFF), // White text color
                  ),
                ),
                Text(
                  'Community',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                    fontSize: constraints.maxWidth * 0.02,
                    color: Color(0xFFFFFFFF), // White text color
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
                  SnackBar(content: Text('Sign Up button tapped!')),
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
            SizedBox(width: 10), // Space between buttons
            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Register button tapped!')),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: constraints.maxWidth * 0.02,
                  vertical: constraints.maxHeight * 0.01,
                ),
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Text(
                  'SignIn',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                    fontSize: constraints.maxWidth * 0.03,
                    color: Color(0xFF000000), // Black text color
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
            color: Color(0xFFFFFFFF), // White text color
          ),
        ),
        // SizedBox(height: constraints.maxHeight * 0.01),
        Text(
          'Welcome To Our Community',
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w500,
            fontSize: 25,
            color: Color(0xFFFFFFFF), // White text color
          ),
        ),
        SizedBox(height: constraints.maxHeight * 0.01),
        Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter Email',
                  hintStyle: GoogleFonts.roboto(
                    fontWeight: FontWeight.w300,
                    fontSize: 20,
                    color: Color(0xFF5E5E5E),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.03),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter Password',
                  hintStyle: GoogleFonts.roboto(
                    fontWeight: FontWeight.w300,
                    fontSize: 20,
                    color: Color(0xFF5E5E5E),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: constraints.maxHeight * 0.03),
        GestureDetector(
          onTap: () { // here you can add the button function
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Sign Up button tapped!')),
            );
            Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Navigation_Bar()),
                );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.symmetric(vertical: constraints.maxHeight * 0.02),
            child: Center(
              child: Text(
                'Sign Up',
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                  color: Color(0xFF010000),
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
                  color: Color(0xFFFFFFFF), // White text color
                ),
              ),
              SizedBox(width: 7),
              Text(
                'Sign In !',
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  color: Color(0xFFFFFFFF), // White text color
                ),
              ),
            ],
          ),
      ],
    );
  }
  Widget buildSocialButton(BuildContext context, String assetPath, BoxConstraints constraints) {
    return GestureDetector(
      onTap: () {
        // Define the action to be performed on button tap
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Button tapped!')),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
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
