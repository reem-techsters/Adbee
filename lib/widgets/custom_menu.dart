import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:newadbee/controller/menu_controller.dart';
import 'package:newadbee/controller/sharedprefs_prov.dart';
import 'package:newadbee/core/colors/colors.dart';
import 'package:newadbee/core/constants/constants.dart';
import 'package:newadbee/core/fonts/fonts.dart';
import 'package:newadbee/core/icons/icons.dart';
import 'package:newadbee/view/authentication/authentication_screen.dart';
import 'package:newadbee/view/bank/edit_bankdetails_screen.dart';
import 'package:newadbee/view/profile/edit_profile_screen.dart';
import 'package:newadbee/widgets/custom_alert_dialog.dart';
import 'package:provider/provider.dart';

class CustomPopupMenuButton extends StatefulWidget {
  const CustomPopupMenuButton({super.key});

  @override
  State<CustomPopupMenuButton> createState() => _CustomPopupMenuButtonState();
}

class _CustomPopupMenuButtonState extends State<CustomPopupMenuButton> {
  @override
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var provider = Provider.of<MenuProv>(context, listen: false);
      var sharedprovider = Provider.of<SharedPrefsProv>(context, listen: false);
      provider.isDND = await sharedprovider.getBool('isDND');
      provider.isSwitched = provider.isDND ?? false;
      log('isDND --> ${provider.isDND.toString()}');
    });
    EdgeInsets padding = EdgeInsets.only(left: 8.0, top: 2.0, bottom: 2.0);
    TextStyle textStyle = KFont().fieldNameStyle.copyWith(fontSize: 14);
    return Consumer<MenuProv>(builder: (context, value, child) {
      return PopupMenuButton<int>(
        onCanceled: () {
          value.toggleMenu(value.isMenu);
        },
        onOpened: () async {
          value.toggleMenu(value.isMenu);
        },
        padding: EdgeInsets.zero,
        elevation: 0,
        offset: Offset(00, 32),
        onSelected: (value) {
          var provider = Provider.of<MenuProv>(context, listen: false);
          provider.toggleMenu(provider.isMenu);
          switch (value) {
            case 0:
              provider.toggleSwitch(context);
              break;
            case 1:
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => EditBankDetailsScreen(),
              ));
              break;
            case 2:
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => EditProfileScreen(),
              ));
            case 3:
              showDialog(
                context: context,
                builder: (context) {
                  return LogoutAlertWidget(
                    title: 'Do you want to logout?',
                    btnTitle: 'Logout',
                    onPressed: () async {
                      // await Provider.of<DrawerProv>(context, listen: false)
                      //     .logoutButton(context);
                      var sharedprovider =
                          Provider.of<SharedPrefsProv>(context, listen: false);
                      sharedprovider.setBool('isLoggedIn', false);
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AuthenticationScreen(),
                          ),
                          (route) => false);
                    },
                  );
                },
              );
              break;
          }
        },
        itemBuilder: (BuildContext context) {
          return <PopupMenuEntry<int>>[
            PopupMenuItem<int>(
              value: 0,
              height: 0,
              padding: padding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'DND Mode',
                    style: textStyle,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Consumer<MenuProv>(builder: (context, vaal, child) {
                      return FlutterSwitch(
                        padding: 2,
                        width: 35,
                        height: 20,
                        toggleSize: 15,
                        value: vaal.isSwitched,
                        activeColor: kPrimaryColor,
                        onToggle: (val) {
                          value.toggleSwitch(context);
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),
            PopupMenuDivider(height: 10.0),
            PopupMenuItem<int>(
              value: 1,
              height: 0,
              padding: padding,
              child: Text(
                'Add Bank Details',
                style: textStyle,
              ),
            ),
            PopupMenuDivider(height: 10.0),
            PopupMenuItem<int>(
              value: 2,
              height: 0,
              padding: padding,
              child: Text(
                'Edit Profile',
                style: textStyle,
              ),
            ),
            PopupMenuDivider(height: 10.0),
            PopupMenuItem<int>(
              value: 3,
              height: 0,
              padding: padding,
              child: Row(
                children: [
                  Text(
                    'Logout',
                    style: textStyle,
                  ),
                  kWidth5,
                  Icon(
                    Icons.logout,
                    color: kFieldNameGreyBlackColor,
                    size: 15,
                  ),
                ],
              ),
            ),
          ];
        },
        child: Consumer<MenuProv>(builder: (context, value, child) {
          return value.isMenu == true
              ? Padding(
                  padding: const EdgeInsets.only(left: 14.0),
                  child: Transform.scale(scale: 1.4, child: KIcon.closemenu),
                )
              : Icon(
                  Icons.more_horiz,
                  size: 25,
                );
        }),
      );
    });
  }
}
