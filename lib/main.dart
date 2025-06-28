import 'package:amazon_clone/layout/screen_layout.dart';
import 'package:amazon_clone/providers/user_details_provider.dart';
import 'package:amazon_clone/screens/sell_screen.dart';
import 'package:amazon_clone/screens/sign_in_screen.dart';
import 'package:amazon_clone/utils/color_themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyA05G4xzXWivvFb9eyEHfJ0MPdntLUcDpU",
            authDomain: "flutter--clone-413b4.firebaseapp.com",
            projectId: "flutter--clone-413b4",
            storageBucket: "flutter--clone-413b4.appspot.com",
            messagingSenderId: "40614922755",
            appId: "1:40614922755:web:bd1af197fa618816dfdc36"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const AmazonClone());
}

class AmazonClone extends StatelessWidget {
  const AmazonClone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserDetailsProvider())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Amazon Clone",
          theme: ThemeData.light()
              .copyWith(scaffoldBackgroundColor: backgroundColor),
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (snapshot.hasData) {
                  return ScreenLayout();
                } else {
                  return SignInScreen();
                }
              }
            },
          ),
        ));
  }
}
