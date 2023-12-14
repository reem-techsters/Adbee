import 'dart:async';
import 'package:flutter/material.dart';
import 'package:newadbee/controller/wallet_prov.dart';
import 'package:newadbee/model/campaign_model.dart';
import 'package:newadbee/services/campaign_services.dart';
import 'package:provider/provider.dart';

class AdvertisementProv extends ChangeNotifier {
  double progresss = 0.0;
  final double _duration = 15.0; // The duration of the ad in seconds
  late Timer _timer; // Declare _timer here

  double get progress => progresss;
  // AdvertisementProv(BuildContext context) {
  //   updateProgress(context);
  // }

  void updateProgress(BuildContext context) {
    // Update progress every 1 second
    const updateInterval = Duration(seconds: 1);

    _timer = Timer.periodic(updateInterval, (timer) async {
      if (progresss < 1.0) {
        progresss += updateInterval.inSeconds / _duration;
        if (progresss > 1.0) {
          progresss = 1.0; // Ensure progress doesn't exceed 1.0
        }
        notifyListeners();
      } else {
        // Ad playback completed, stop the timer
        _timer.cancel();
        await viewedCampaign(
            context: context, campaignID: listCampaign[0].campId.toString());
        final prov2 = Provider.of<WalletProv>(context, listen: false);
        prov2.getProfileDetails(context);
        return;
      }
    });
  }

  List<CampaignData> listCampaign = [];

  Future<void> getCampaignDetails(BuildContext context) async {
    if (context.mounted) {
      final response =
          await CampaignServices().getCampaignDetails(context: context);
      if (response != null && response.data != null) {
        listCampaign = response.data ?? [];
        notifyListeners();
      } else {
        debugPrint('null');
      }
    }
  }

  Future<void> viewedCampaign({
    required BuildContext context,
    required String campaignID,
  }) async {
    await CampaignServices().viewedCampaign(
      context: context,
      campaignID: campaignID,
    );
  }
}
