import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:newadbee/controller/advertisement_prov.dart';
import 'package:newadbee/controller/calls_prov.dart';
import 'package:newadbee/controller/wallet_prov.dart';
import 'package:newadbee/core/colors/colors.dart';
import 'package:newadbee/view/calls/call_screen.dart';
import 'package:phone_state/phone_state.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class AdvertisementScreen extends StatefulWidget {
  const AdvertisementScreen({Key? key}) : super(key: key);

  @override
  State<AdvertisementScreen> createState() => _AdvertisementScreenState();
}

class _AdvertisementScreenState extends State<AdvertisementScreen> {
  late VideoPlayerController _controller;
  bool showButton = false;
  dynamic videoHeight;
  dynamic videoWidth;
  @override
  void initState() {
    final advprovider = Provider.of<AdvertisementProv>(context, listen: false);
    final String linnk = advprovider.listCampaign[0].campFile.toString();
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(linnk))
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      })
      ..setLooping(false).then((_) {
        setState(() {
          // Ensure the first frame is shown before playing

          showButton = true;
        });

        // Start playing the video
        _controller.play();

        // Listen for video playback completion
        _controller.addListener(() {
          if (_controller.value.position >= _controller.value.duration) {
            _onVideoComplete();
          }
        });
      });

    // log(_controller.value.size.width.toString());
  }

  void _onVideoComplete() {
    setState(() {
      showButton = true;
      final prov = Provider.of<AdvertisementProv>(context, listen: false);
      final prov2 = Provider.of<WalletProv>(context, listen: false);
      prov.viewedCampaign(
          context: context, campaignID: prov.listCampaign[0].campId.toString());
      prov2.getProfileDetails(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      videoHeight = _controller.value.size.height;
      videoWidth = _controller.value.size.width;
    });

    log(videoHeight.toString());
    log(videoWidth.toString());
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //    _controller = VideoPlayerController.networkUrl(Uri.parse(
    //     'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'))
    //   ..initialize().then((_) {
    //     setState(() {});
    //     _controller.play();
    //   })
    //   ..setLooping(false).then((_) {
    //     setState(() {
    //       // Ensure the first frame is shown before playing
    //       showButton = true;
    //     });

    //     // Start playing the video
    //     _controller.play();

    //     // Listen for video playback completion
    //     _controller.addListener(() {
    //       if (_controller.value.position >= _controller.value.duration) {
    //         _onVideoComplete();
    //       }
    //     });
    //   });
    // });
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBlack,
        body: Center(
          child: Stack(
            children: [
              Text('Video Height: $videoHeight'),
              Text('Video Width: $videoWidth'),
              if (_controller.value.isInitialized)
                AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              else
                Center(child: CircularProgressIndicator()),
              if (_controller.value.position >= _controller.value.duration &&
                  !_controller.value.isPlaying &&
                  showButton)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        final provider =
                            Provider.of<CallsFetchProv>(context, listen: false);
                        provider.status = PhoneState.nothing();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CallScreen(),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.close,
                        color: kWhite,
                        size: 20.0,
                      ),
                    ),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}


// import 'package:flutter/material.dart';
// import 'package:newadbee/controller/recent_call_prov.dart';
// import 'package:newadbee/core/colors/colors.dart';
// import 'package:newadbee/view/calls/call_screen.dart';
// import 'package:phone_state/phone_state.dart';
// import 'package:provider/provider.dart';

// class AdvertisementScreen extends StatefulWidget {
//   const AdvertisementScreen({Key? key}) : super(key: key);

//   @override
//   _AdvertisementScreenState createState() => _AdvertisementScreenState();
// }

// class _AdvertisementScreenState extends State<AdvertisementScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Center(
//           child: _buildCallStatusWidget(),
//         ),
//       ),
//     );
//   }

//   Widget _buildCallStatusWidget() {
//     return StreamBuilder<PhoneState>(
//       stream: PhoneState.stream,
//       initialData: PhoneState.nothing(),
//       builder: (context, snapshot) {
//         final callStatus = snapshot.data;
        
//         if (callStatus!.status == PhoneStateStatus.CALL_ENDED) {
//           // The call has ended, navigate to CallEndedScreen
//           Future.delayed(Duration.zero, () {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (context) => CallScreen()),
//             );
//           });
//         }

//         return Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               "Advertisement Screen",
//               style: TextStyle(fontSize: 20),
//             ),
//             if (callStatus!.status != PhoneStateStatus.CALL_ENDED)
//               CircularProgressIndicator(),
//           ],
//         );
//       },
//     );
//   }
// }
