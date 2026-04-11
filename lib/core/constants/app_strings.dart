class AppStrings {
  final String language;

  AppStrings(this.language);

  // 🔷 Login
  String get login => language == "gu" ? "લોગિન" : "Login";
  String get welcomeBack =>
      language == "gu" ? "પાછા સ્વાગત છે" : "Welcome Back";
  String get signIn => language == "gu"
      ? "તમારા એકાઉન્ટમાં સાઇન ઇન કરો"
      : "Sign in to your account";

  // 🔷 Fields
  String get enterEmail =>
      language == "gu" ? "ઇમેઇલ દાખલ કરો" : "Enter your email";
  String get enterPassword =>
      language == "gu" ? "પાસવર્ડ દાખલ કરો" : "Enter your password";

  // 🔷 Actions
  String get forgotPassword =>
      language == "gu" ? "પાસવર્ડ ભૂલી ગયા?" : "Forgot Password?";
  String get signUp => language == "gu" ? "સાઇન અપ" : "Sign Up";

  // 🔷 Bottom text
  String get dontHaveAccount =>
      language == "gu" ? "એકાઉન્ટ નથી?" : "Don't have an account?";
}
