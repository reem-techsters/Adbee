import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:newadbee/controller/sharedprefs_prov.dart';
import 'package:newadbee/model/closed_ticket_model.dart';
import 'package:newadbee/model/open_ticket_model.dart';
import 'package:newadbee/model/profile_model.dart';
import 'package:newadbee/model/ticket_conversion_model.dart';
import 'package:newadbee/services/profile_services.dart';
import 'package:newadbee/services/ticket_services.dart';
import 'package:newadbee/widgets/custom_snackbar.dart';
import 'package:provider/provider.dart';

// class FormData {
//   String text = '';
//   TextEditingController controller = TextEditingController();
// }

class TicketProv extends ChangeNotifier {
  final GlobalKey<FormState> createTicketformKey = GlobalKey<FormState>();
  TextEditingController subjectController = TextEditingController();
  TextEditingController queryController = TextEditingController();
  bool showloader = false;

  List<PDatum> listProfile = [];
  //----
  late List<bool> selectedOpenTicket = [false];
  late List<bool> selectedClosedTicket = [false];

  void toggleOpenTicket(int index) {
    selectedOpenTicket![index] = !selectedOpenTicket![index];
    notifyListeners();
  }

  void toggleClosedTicket(int index) {
    selectedClosedTicket![index] = !selectedClosedTicket![index];
    notifyListeners();
  }

//------
  int? savedIndex;
  Future<void> saveTicketIndex(int index) async {
    savedIndex = index;

    notifyListeners();
  }

//----
  clear() {
    subjectController.clear();
    queryController.clear();
  }

  Future<void> createTicket({required BuildContext context}) async {
    if (createTicketformKey.currentState!.validate()) {
      notifyListeners();
      await TicketServices().createticket(
          context: context,
          subject: subjectController.text,
          query: queryController.text);
      if (context.mounted) {
        getOpenTicket(context);
        getClosedTicket(context);
      }

      clear();
      notifyListeners();
    }
  }

  List<OpenTDatum> listOpenTicket = [];
  Future<void> getOpenTicket(BuildContext context) async {
    showloader = true;
    if (context.mounted) {
      final response = await TicketServices().getOpenTicket(context: context);
      if (response != null) {
        listOpenTicket = response.data ?? [];
        selectedOpenTicket =
            List.generate(listOpenTicket.length, (index) => false);

        showloader = false;
        notifyListeners();
      } else {
        debugPrint('nully');
      }
    }
  }

  List<ClosedTDatum> listClosedTicket = [];
  Future<void> getClosedTicket(BuildContext context) async {
    showloader = true;
    if (context.mounted) {
      final response = await TicketServices().getClosedTicket(context: context);
      if (response != null) {
        listClosedTicket = response.data ?? [];

        selectedClosedTicket =
            List.generate(listClosedTicket.length, (index) => false);
        showloader = false;
        notifyListeners();
      } else {
        debugPrint('nully');
      }
    }
  }

  List<Thread> listTicketConversion = [];
  Future<void> getTicketDetails(BuildContext context,
      {required String ticketID}) async {
    showloader = true;
    if (context.mounted) {
      final response = await TicketServices()
          .getTicketDetails(context: context, ticketID: ticketID);
      if (response != null && response.data != null) {
        listTicketConversion = response.data!.first.threads ?? [];
        showloader = false;
        notifyListeners();
      } else {
        debugPrint('nully');
      }
    }
  }

  String? savedMobile;
  Future<void> getProfileDetails(BuildContext context) async {
    showloader = true;
    final provider = Provider.of<SharedPrefsProv>(context, listen: false);
    savedMobile = await provider.getString('saved_mobile');
    notifyListeners();
    if (context.mounted) {
      final response =
          await ProfileServices().getProfileDetails(context: context);
      if (response != null) {
        listProfile = response.data ?? [];
        showloader = false;
        notifyListeners();
      } else {
        debugPrint('nully');
      }
    }
  }

  final GlobalKey<FormState> myTicketformKey = GlobalKey<FormState>();
  late List<TextEditingController> replyTicketOPENController;
  late List<TextEditingController> replyTicketCLOSEDController;

  void updateText(int index, String newText) {
    replyTicketOPENController[index].text = newText;
    notifyListeners();
  }

  // TextEditingController replyTicketController = TextEditingController();
  Future<void> replyTicketOpen({
    required BuildContext context,
    required String ticketID,
    required txtfieldIndex,
  }) async {
    log(txtfieldIndex.toString());
    if (replyTicketOPENController[txtfieldIndex].text.isNotEmpty) {
      notifyListeners();
      log(ticketID.toString());
      await TicketServices().replyTicket(
          context: context,
          ticketID: ticketID,
          query: replyTicketOPENController[txtfieldIndex].text);
      replyTicketOPENController[txtfieldIndex].clear();
      listTicketConversion.clear();
      if (context.mounted) {
        getTicketDetails(context,
            ticketID: listOpenTicket[savedIndex!].ticketId.toString());
        getOpenTicket(context);
      }

      notifyListeners();
    } else {
      showCustomSnackbar(context, 'Add reply to submit', false);
    }
  }

  Future<void> replyTicketClosed({
    required BuildContext context,
    required String ticketID,
    required txtfieldIndex,
  }) async {
    log(txtfieldIndex.toString());
    if (replyTicketOPENController[txtfieldIndex].text.isNotEmpty) {
      notifyListeners();
      log(ticketID.toString());
      await TicketServices().replyTicket(
          context: context,
          ticketID: ticketID,
          query: replyTicketCLOSEDController[txtfieldIndex].text);
      replyTicketOPENController[txtfieldIndex].clear();
      listTicketConversion.clear();
      if (context.mounted) {
        getTicketDetails(context,
            ticketID: listClosedTicket[savedIndex!].ticketId.toString());
        getOpenTicket(context);
      }

      notifyListeners();
    } else {
      showCustomSnackbar(context, 'Add reply to submit', false);
    }
  }

  //-------------------------------------------* Validator
  textFormValidation(String? value) {
    if (value!.isEmpty) {
      notifyListeners();
      return 'This is required';
    }
    return null;
  }
}
