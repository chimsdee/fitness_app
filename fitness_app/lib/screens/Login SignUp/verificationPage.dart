import 'package:fitness_app/constants/color.dart';
import 'package:flutter/material.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final List<TextEditingController> _otpControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              print("Back button pressed in verification screen");
              Navigator.pop(context);
            },
            color: Colors.white,
          ),
          backgroundColor: Colors.black,
        ),
        body: Container(
          width: size.width,
          height: size.height,
          padding: EdgeInsets.only(
            top: size.height * 0.06,
            left: size.width * 0.05,
            right: size.width * 0.05,
            bottom: size.height * 0.03,
          ),
          child: Column(
            children: [
              Text(
                'Verification Code'.toUpperCase(),
                style: TextStyle(
                  fontSize: size.width * 0.07,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Text(
                'Enter the 6-digit code sent to your\nemail address',
                style: TextStyle(
                  fontSize: size.width * 0.04,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: size.height * 0.05),

              // Verification code input
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    6,
                    (index) => Container(
                      width: size.width * 0.12,
                      height: size.width * 0.12,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: _otpControllers[index],
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: size.width * 0.06,
                        ),
                        decoration: const InputDecoration(
                          counterText: '',
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                          print("OTP digit ${index + 1} changed to: $value");
                        },
                      ),
                    ),
                  ),
                ),
              ),

              const Spacer(),
              Container(
                width: size.width * 0.9,
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    print("Resend Code button pressed");
                  },
                  child: Text(
                    'Resend Code',
                    style: TextStyle(
                      color: PrimaryColor,
                      fontSize: size.width * 0.04,
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    final otpCode = _otpControllers.map((c) => c.text).join();
                    print("Verify button pressed with OTP: $otpCode");

                    if (otpCode.length < 6) {
                      print("Incomplete OTP entered");
                    } else {
                      print("Full OTP submitted: $otpCode");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PrimaryColor,
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.3,
                      vertical: size.height * 0.02,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: Text(
                    'Verify',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: size.width * 0.04,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
