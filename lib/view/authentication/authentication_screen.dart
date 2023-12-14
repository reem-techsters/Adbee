import 'package:flutter/material.dart';
import 'package:newadbee/controller/authentication_prov.dart';
import 'package:newadbee/core/colors/colors.dart';
import 'package:newadbee/core/constants/constants.dart';
import 'package:newadbee/widgets/login_tab_widget.dart';
import 'package:newadbee/widgets/signup_tab_widget.dart';
import 'package:provider/provider.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    var provider = Provider.of<AuthProv>(context, listen: false);
    provider.rememberMe(context);
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
            child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              kheight50,
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: kTabColor,
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      height: MediaQuery.of(context).size.height / 17,
                      child: TabBar(
                        controller: _tabController,
                        labelColor: kWhite,
                        unselectedLabelColor: kDeepGreenColor,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicator: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(50.0)),
                        tabs: const [
                          Tab(
                            child: Text(
                              "Login",
                              style: TextStyle(fontFamily: 'Roboto'),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Tab(
                            child: Text(
                              "Sign Up",
                              style: TextStyle(fontFamily: 'Roboto'),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    loginWidget(context: context),
                    signUpWidget(),
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
