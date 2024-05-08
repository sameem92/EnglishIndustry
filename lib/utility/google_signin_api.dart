import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInApi {
  static final GoogleSignIn _googleSignIn = GoogleSignIn();
  static Future<GoogleSignInAccount> login() => _googleSignIn.signIn();
  // ignore: missing_return
  static Future<GoogleSignInAccount> logout() { _googleSignIn.disconnect();
  _googleSignIn.signOut();


  }
}
