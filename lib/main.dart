import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:newadbee/controller/advertisement_prov.dart';
import 'package:newadbee/controller/bank_prov.dart';
import 'package:newadbee/controller/menu_controller.dart';
import 'package:newadbee/controller/registration_prov.dart';
import 'package:newadbee/controller/onboard_prov.dart';
import 'package:newadbee/controller/authentication_prov.dart';
import 'package:newadbee/controller/password_prov.dart';
import 'package:newadbee/controller/profile_prov.dart';
import 'package:newadbee/controller/calls_prov.dart';
import 'package:newadbee/controller/sharedprefs_prov.dart';
import 'package:newadbee/controller/ticket_prov.dart';
import 'package:newadbee/controller/wallet_prov.dart';
import 'package:newadbee/view/authentication/authentication_screen.dart';
import 'package:newadbee/view/calls/call_screen.dart';
import 'package:newadbee/view/onboard/onboard_screen.dart';
import 'package:newadbee/view/registration/create_account_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isOnBoarded = prefs.getBool('isOnBoarded') ?? false;
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  bool isOtpVerified = prefs.getBool('isOtpVerified') ?? false;
  bool isRegistered = prefs.getBool('isRegistered') ?? false;
  log('isOnBoarded --> ${isOnBoarded.toString()}');
  log('isOtpVerified --> ${isOtpVerified.toString()}');
  log('isRegistered --> ${isRegistered.toString()}');
  log('isLoggedIn --> ${isLoggedIn.toString()}');
  await Firebase.initializeApp();
  runApp(MyApp(
    isLoggedIn: isLoggedIn,
    isOnBoarded: isOnBoarded,
    isOtpVerified: isOtpVerified,
    isRegistered: isRegistered,
  ));
}

class MyApp extends StatelessWidget {
  final bool? isLoggedIn;
  final bool? isOnBoarded;
  final bool? isOtpVerified;
  final bool? isRegistered;
  const MyApp(
      {super.key,
      this.isLoggedIn,
      this.isOnBoarded,
      this.isOtpVerified,
      this.isRegistered});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => OnBoardProv()),
        ChangeNotifierProvider(create: (context) => SharedPrefsProv()),
        ChangeNotifierProvider(create: (context) => AuthProv()),
        ChangeNotifierProvider(create: (context) => RegistrationProv()),
        ChangeNotifierProvider(create: (context) => BankProv()),
        ChangeNotifierProvider(create: (context) => PasswordProv()),
        ChangeNotifierProvider(create: (context) => CallsFetchProv()),
        ChangeNotifierProvider(create: (context) => ProfileProv()),
        ChangeNotifierProvider(create: (context) => AdvertisementProv()),
        ChangeNotifierProvider(create: (context) => MenuProv()),
        ChangeNotifierProvider(create: (context) => TicketProv()),
        ChangeNotifierProvider(create: (context) => WalletProv()),
      ],
      child: MaterialApp(
        theme: ThemeData(),
        // home: CallScreen(),
        home: (isLoggedIn == true)
            ? CallScreen()
            : (isOnBoarded == true)
                ? (isOtpVerified == true)
                    ? (isRegistered == true)
                        ? AuthenticationScreen()
                        : CreateAccountScreen()
                    : AuthenticationScreen()
                : OnBoardScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}









 //-----Google Auth
// // Check if the user's authentication provider is Google.
// bool isGoogleSignInUser(User? user) {
//   if (user == null) {
//     return false;
//   }
//   for (var userInfo in user.providerData) {
//     if (userInfo.providerId == 'google.com') {
//       return true;
//     }
//   }
//   return false;
// }
   //-----Google Auth
        // home: StreamBuilder<User?>(
        //   stream: FirebaseAuth.instance.authStateChanges(),
        //   builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        //     if (snapshot.connectionState == ConnectionState.active) {
        //       final user = snapshot.data;
        //       if (isLoggedIn!) {
        //         return CallScreen();
        //       } else if (isOnBoarded!) {
        //         if (isOtpVerified!) {
        //           if (isRegistered!) {
        //             if (user == null ||
        //                 (isLoggedIn! == false && !isGoogleSignInUser(user))) {
        //               return AuthenticationScreen();
        //             } else {
        //               return CallScreen();
        //             }
        //           } else {
        //             return CreateAccountScreen();
        //           }
        //         } else {
        //           return AuthenticationScreen();
        //         }
        //       } else {
        //         return OnBoardScreen();
        //       }
        //     }
        //     return CircularProgressIndicator();
        //   },
        // ),