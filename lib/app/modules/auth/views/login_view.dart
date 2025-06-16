import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class LoginView extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();

  LoginView({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RxString selectedRole = 'student'.obs;

  final List<String> roles = ['student', 'faculty', 'admin'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3F51B5),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // IMS Logo/Icon
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: .2),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    'IMS',
                    style: TextStyle(
                      color: Color(0xFF3F51B5), // Blue color for text
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Sign In Title
              const Text(
                'Sign In',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              // Access your account subtitle
              Text(
                'Access your account',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: .8),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 32),

              // Email/Username Input
              _buildInputField(
                controller: emailController,
                hintText: 'you@example.com',
                labelText: 'Email/Username',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),

              // Password Input
              _buildInputField(
                controller: passwordController,
                hintText: '********',
                labelText: 'Password',
                obscureText: true,
              ),
              const SizedBox(height: 16),

              // Login as Dropdown
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                    child: Text(
                      'Login as',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: .8),
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Obx(
                    () => Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: .15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 0,
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedRole.value,
                          dropdownColor: const Color(
                            0xFF3F51B5,
                          ), // Match background
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white.withValues(alpha: .8),
                          ),
                          isExpanded: true,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: .9),
                            fontSize: 16,
                          ),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              selectedRole.value = newValue;
                            }
                          },
                          items: roles.map<DropdownMenuItem<String>>((
                            String role,
                          ) {
                            return DropdownMenuItem<String>(
                              value: role,
                              child: Text(
                                role.capitalizeFirst!,
                              ), // Capitalize first letter
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Forgot Password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Navigate to forgot password page
                  },
                  child: Text(
                    'Forgot password?',
                    style: TextStyle(
                      color: Colors.blue[200], // Lighter blue for link
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Sign In Button
              Obx(
                () => SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: authController.isLoading.value
                        ? null
                        : () {
                            authController.login(
                              emailController.text,
                              passwordController.text,
                              // selectedRole.value,
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, // White background
                      foregroundColor: const Color(0xFF3F51B5), // Blue text
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 5,
                    ),
                    child: authController.isLoading.value
                        ? const CircularProgressIndicator(
                            color: Color(0xFF3F51B5),
                          )
                        : const Text(
                            'Sign in',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
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

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    required String labelText,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
          child: Text(
            labelText,
            style: TextStyle(
              color: Colors.white.withValues(alpha: .8),
              fontSize: 14,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(
              alpha: .15,
            ), // Semi-transparent white
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            style: TextStyle(
              color: Colors.white.withValues(alpha: .9),
            ), // White text
            cursorColor: Colors.white,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.white.withValues(alpha: .5)),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              border: InputBorder.none, // No border
              filled: false,
            ),
          ),
        ),
      ],
    );
  }
}
