import 'package:flutter/material.dart';
import 'package:newadbee/controller/advertisement_prov.dart';
import 'package:newadbee/controller/calls_prov.dart';
import 'package:newadbee/core/colors/colors.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:phone_state/phone_state.dart';
import 'package:provider/provider.dart';

class ImageAdvertisement extends StatefulWidget {
  const ImageAdvertisement({Key? key}) : super(key: key);

  @override
  State<ImageAdvertisement> createState() => _ImageAdvertisementState();
}

class _ImageAdvertisementState extends State<ImageAdvertisement> {
  @override
  void initState() {
    super.initState();
    Provider.of<AdvertisementProv>(context, listen: false).progresss = 0.0;
    Provider.of<AdvertisementProv>(context, listen: false).updateProgress(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBlack,
        body: Center(
          child: Consumer<AdvertisementProv>(
            builder: (context, val, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  LinearPercentIndicator(
                    padding: EdgeInsets.zero,
                    animation: true,
                    animateFromLastPercent: true,
                    lineHeight: 3.0,
                    percent: val.progress,
                    backgroundColor: kWhite,
                    progressColor: kPrimaryColor,
                    barRadius: const Radius.circular(10),
                  ),
                  Expanded(
                    child: SizedBox(
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Transform.rotate(
                            // angle: 90 * 3.1415927 / 180,
                            angle: 0,
                            child: Image.network(
                              val.listCampaign[0].campFile.toString(),
                              // "https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                              fit: BoxFit.cover,
                            ),
                          ),
                          val.progress == 1.0
                              ? Positioned(
                                  top: 5,
                                  right: 5,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          final provider =
                                              Provider.of<CallsFetchProv>(
                                                  context,
                                                  listen: false);
                                          provider.status =
                                              PhoneState.nothing();
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(
                                          Icons.close_outlined,
                                          color: kWhite,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : SizedBox(),
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class LandscapeImageAdvertisement extends StatefulWidget {
  const LandscapeImageAdvertisement({Key? key}) : super(key: key);

  @override
  State<LandscapeImageAdvertisement> createState() =>
      _LandscapeImageAdvertisementState();
}

class _LandscapeImageAdvertisementState
    extends State<LandscapeImageAdvertisement> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBlack,
        body: Center(
          child: Consumer<AdvertisementProv>(
            builder: (context, val, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Transform.rotate(
                    angle: 90 *
                        3.1415927 /
                        180, // Specify the rotation angle in radians (45 degrees in this example)
                    child: Image.asset(
                      "https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                    ), // Replace with your image widget
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
