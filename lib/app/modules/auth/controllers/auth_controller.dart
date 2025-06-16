import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants/api_endpoints.dart';
import '../../../constants/app_constrants.dart';
import '../../../data/models/user_model.dart';
import '../../../routes/app_routes.dart';
import '../../../services/api_service.dart';

class AuthController extends GetxController {
  final ApiService _apiService = ApiService();
  final SharedPreferences _prefs;

  final Rxn<UserModels> currentUser = Rxn<UserModels>();
  final RxBool isLoading = false.obs;

  AuthController(this._prefs);

  @override
  void onInit() {
    super.onInit();
    _loadUserFromStorage();
  }

  Future<void> _loadUserFromStorage() async {
    final String? userDataString = _prefs.getString(AppConstants.USER_DATA_KEY);
    if (userDataString != null) {
      try {
        final Map<String, dynamic> userDataJson = json.decode(userDataString);
        currentUser.value = UserModels.fromJson(userDataJson);
      } catch (e) {
        print("Error loading user data from storage: $e");
        await _clearUserData();
      }
    }
  }

  Future<void> handleInitialScreen() async {
    final bool hasSeenGetStarted =
        _prefs.getBool(AppConstants.HAS_SEEN_GET_STARTED_KEY) ?? false;
    final String? accessToken = _prefs.getString(AppConstants.ACCESS_TOKEN_KEY);

    if (!hasSeenGetStarted) {
      Get.offAllNamed(Routes.GET_STARTED);
      await _prefs.setBool(AppConstants.HAS_SEEN_GET_STARTED_KEY, true);
    } else if (accessToken == null || accessToken.isEmpty) {
      Get.offAllNamed(Routes.LOGIN);
    } else {
      await _loadUserFromStorage();
      if (currentUser.value != null) {
        _redirectToRoleBasedRoute(currentUser.value!.role);
      } else {
        await _clearUserData();
        Get.offAllNamed(Routes.LOGIN);
      }
    }
  }

  Future<void> login(String username, String password) async {
    isLoading.value = true;
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    try {
      final response = await _apiService.post(
        ApiEndpoints.LOGIN,
        data: {'username': username, 'password': password},
      );
      print(response.data);

      if (response.statusCode == 200 && response.data['user'] != null) {
        final user = response.data['user'];
        final accessToken = user['token']; // ✅ FIX: Get token from user
        final role = user['role'] as String;

        await _prefs.setString(AppConstants.ACCESS_TOKEN_KEY, accessToken);
        await _prefs.setString(AppConstants.USER_ROLE_KEY, role);
        await _prefs.setString(AppConstants.USER_DATA_KEY, json.encode(user));

        currentUser.value = UserModels.fromJson(user);

        Get.back();
        Get.snackbar(
          "Success",
          "Logged in successfully!",
          backgroundColor: Colors.green,
        );

        _redirectToRoleBasedRoute(role);
      } else {
        Get.back();
        Get.snackbar(
          "Login Failed",
          response.data['message'] ?? "Unknown error",
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      print("Login Error ${e.toString()}");
      Get.back();
      Get.snackbar("Login Error", e.toString(), backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  // User Login (Email/Password) - Now uses dummy data
  // Future<void> login(String email, String password, String role) async {
  //   isLoading.value = true;
  //   Get.dialog(
  //     const Center(child: CircularProgressIndicator()),
  //     barrierDismissible: false,
  //   );

  //   // --- Dummy Login Logic ---
  //   // Simulate a network delay
  //   await Future.delayed(const Duration(seconds: 1));

  //   // For dummy purposes, any non-empty email/password combination will "succeed"
  //   if (email.isNotEmpty && password.isNotEmpty) {
  //     // Create a dummy user model based on the selected role
  //     final dummyUser = UserModels(
  //       id: 'user_${DateTime.now().millisecondsSinceEpoch}', // Unique ID
  //       name: '${role.capitalizeFirst} User',
  //       email: email,
  //       role: role,
  //       photoUrl: null, // No photo for dummy
  //     );

  //     // Simulate a dummy access token
  //     const dummyAccessToken = 'dummy_access_token_12345';

  //     try {
  //       // Save dummy tokens and user data
  //       await _prefs.setString(AppConstants.ACCESS_TOKEN_KEY, dummyAccessToken);
  //       await _prefs.setString(AppConstants.USER_ROLE_KEY, role);
  //       await _prefs.setString(
  //         AppConstants.USER_DATA_KEY,
  //         json.encode(dummyUser.toJson()),
  //       );

  //       // Update current user observable
  //       currentUser.value = dummyUser;

  //       Get.back(); // Dismiss dialog
  //       Get.snackbar(
  //         "Success",
  //         "Logged in as ${role.capitalizeFirst}!",
  //         backgroundColor: Colors.green,
  //       );

  //       // Redirect based on role
  //       _redirectToRoleBasedRoute(role);
  //     } catch (e) {
  //       Get.back(); // Dismiss dialog
  //       Get.snackbar(
  //         "Login Error (Dummy)",
  //         "Failed to save user data: $e",
  //         backgroundColor: Colors.red,
  //       );
  //     }
  //   } else {
  //     Get.back(); // Dismiss dialog
  //     Get.snackbar(
  //       "Login Failed",
  //       "Please enter email and password.",
  //       backgroundColor: Colors.red,
  //     );
  //   }

  //   isLoading.value = false;
  // }

  void _redirectToRoleBasedRoute(String role) {
    switch (role) {
      case 'student':
        Get.offAllNamed(Routes.HOME);
        break;
      case 'faculty':
        Get.offAllNamed(Routes.FACULTY_ATTENDANCE);
        break;
      case 'admin':
        Get.offAllNamed(Routes.ADMIN_ATTENDANCE);
        break;
      default:
        Get.snackbar(
          "Role Error",
          "Unknown user role. Please contact support.",
          backgroundColor: Colors.orange,
        );
        signOut();
    }
  }

  Future<void> signOut() async {
    isLoading.value = true;
    try {
      await _clearUserData();
      Get.offAllNamed(Routes.LOGIN);
      Get.snackbar(
        "Logged Out",
        "You have been logged out.",
        backgroundColor: Colors.green,
      );
    } catch (e) {
      Get.snackbar("Logout Error", e.toString(), backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _clearUserData() async {
    await _prefs.remove(AppConstants.ACCESS_TOKEN_KEY);
    await _prefs.remove(AppConstants.USER_ROLE_KEY);
    await _prefs.remove(AppConstants.USER_DATA_KEY);
    await _prefs.setBool(AppConstants.HAS_SEEN_GET_STARTED_KEY, false);
    currentUser.value = null;
  }
}
