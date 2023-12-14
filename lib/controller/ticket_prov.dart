import 'package:flutter/material.dart';
import 'package:newadbee/controller/sharedprefs_prov.dart';
import 'package:newadbee/model/closed_ticket_model.dart';
import 'package:newadbee/model/open_ticket_model.dart';
import 'package:newadbee/model/profile_model.dart';
import 'package:newadbee/model/ticket_conversion_model.dart';
import 'package:newadbee/services/profile_services.dart';
import 'package:newadbee/services/ticket_services.dart';
import 'package:provider/provider.dart';

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
  TextEditingController replyTicketController = TextEditingController();

  Future<void> replyTicket({required BuildContext context}) async {
    if (myTicketformKey.currentState!.validate()) {
      notifyListeners();
      await TicketServices()
          .replyTicket(context: context, ticketID: '', query: '');
      clear();
      notifyListeners();
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
