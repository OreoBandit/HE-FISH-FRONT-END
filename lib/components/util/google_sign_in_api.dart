import 'package:flutter/src/widgets/framework.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInApi {
  static final _googleSignIn = GoogleSignIn();

  static Future<GoogleSignInAccount?> login(BuildContext context) =>
      _googleSignIn.signIn();

  static Future logout() => _googleSignIn.disconnect();
}
