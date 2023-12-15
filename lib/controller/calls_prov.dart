import 'dart:async';
import 'dart:developer';
import 'package:call_log/call_log.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phone_state/phone_state.dart';

class CallsFetchProv extends ChangeNotifier {
  bool isAnswered = false;
  Future<void> toggleAnswered(BuildContext context) async {
    isAnswered = !isAnswered;

    log('isAnswered is --> ${isAnswered.toString()}');
    notifyListeners();
  }

  Future<void> openContactForm() async {
    try {
      await ContactsService.openContactForm();
    } on FormOperationException catch (e) {
      switch (e.errorCode) {
        case FormOperationErrorCode.FORM_OPERATION_CANCELED:
          debugPrint('Form operation was canceled.');
          break;
        case FormOperationErrorCode.FORM_COULD_NOT_BE_OPEN:
          debugPrint('The contact form could not be opened.');
          break;
        case FormOperationErrorCode.FORM_OPERATION_UNKNOWN_ERROR:
          debugPrint('An unknown error occurred during form operation.');
          break;
        default:
          debugPrint('An error occurred: ${e.toString()}');
      }
    }
  }

  //--------------------------------------* PHONE STATE
  PhoneState status = PhoneState.nothing();
  bool granted = false;

  Future<void> init(BuildContext context) async {
    await phoneState(context);
    // await fetchRecentCalls(update: true);
    await fetchContacts(update: true);
  }

  Future<void> phoneState(BuildContext context) async {
    final temp = await requestPermission();
    granted = temp;
    if (granted) {
      if (context.mounted) setStream(context);
      PhoneState.stream.listen((event) {
        status = event;
        notifyListeners();
      });
    }
  }

  Future<bool> requestPermission() async {
    final status = await Permission.phone.request();
    notifyListeners();
    return status.isGranted;
  }

  void setStream(BuildContext context) {
    PhoneState.stream.listen((event) {
      status = event;
      notifyListeners();
    });
  }

  //--------------------------------------* SEARCHING
  TextEditingController searchController = TextEditingController();
  List<dynamic> searchData = [];
  getSearchResult(String value, {required String listname}) {
    List<dynamic> searchlist = listname == 'Recents'
        ? recentCalls
        : listname == 'Contacts'
            ? contacts
            : [];
    searchData.clear();
    for (var i in searchlist) {
      if (listname == 'Recents') {
        if (i.name.toString().toLowerCase().contains(value.toLowerCase())) {
          searchData.add(i);
          notifyListeners();
        }
      } else if (listname == 'Contacts') {
        if (i.displayName
            .toString()
            .toLowerCase()
            .contains(value.toLowerCase())) {
          searchData.add(i);
          notifyListeners();
        }
      }
    }
  }

  //--------------------------------------* FETCH RECENT CALLS
  List<CallLogEntry> recentCalls = [];
  List<CallLogEntry> filteredRecentCalls = [];

  Future<void> fetchRecentCalls({bool? update}) async {
    if (update == true) {
      Iterable<CallLogEntry> calls = await CallLog.get();
      recentCalls = calls.toList();
      filteredRecentCalls = recentCalls;
      notifyListeners();
    }

    if (await Permission.phone.request().isGranted) {
      Iterable<CallLogEntry> calls = await CallLog.get();
      recentCalls = calls.toList();
      filteredRecentCalls = recentCalls;

      notifyListeners();
    } else {
      // _showCustomToast(
      //     context, "Please Give Permission to access Recents logs");
    }
  }

  //--------------------------------------* FETCH CONTACTS
  List<Contact> contacts = [];
  List<Contact> cachedContacts = [];
  List<Contact> filteredContacts = [];

  Future<void> fetchContacts({bool? update}) async {
    if (update == true) {
      var contacts = await ContactsService.getContacts(
          photoHighResolution: false, withThumbnails: false);
      // Cache the fetched contacts data.
      cachedContacts = contacts.toList();
      contacts = cachedContacts;
      filteredContacts = contacts;
      notifyListeners();
    }
    if (cachedContacts.isEmpty) {
      if (await Permission.contacts.request().isGranted) {
        var contacts = await ContactsService.getContacts(
            photoHighResolution: false, withThumbnails: false);
        // Cache the fetched contacts data.
        cachedContacts = contacts.toList();
        contacts = cachedContacts;
        filteredContacts = contacts;
        notifyListeners();
      } else {
        // _showCustomToast(
        //     context, "Please Give Permission to access Contacts logs");
      }
    } else {
      // Use the cached contacts data.
      contacts = cachedContacts;
      filteredContacts = contacts;
      notifyListeners();
    }
  }

//   //--------------------------------------* METHOD CHANNELING
  final MethodChannel channel =
      MethodChannel('com.example.newadbee/contact_edit_screen');
  bool isSuccess = false;

  Future<void> openContactDetailsScreen(String phoneNumber) async {
    if (await Permission.contacts.request().isGranted) {
      try {
        final bool success = await channel.invokeMethod(
            'openContactDetailsScreen', {'phoneNumber': phoneNumber});
        isSuccess = success;
        notifyListeners();
      } on PlatformException catch (e) {
        log('Failed to open contact details screen: ${e.message}');
      }
    } else {
      log('Permission denied. Please grant contacts access.');
    }
    notifyListeners();
  }
}

// List<sDatum> parentConcernlist = [];
// List<String> sortedlist = [];
// Future<void> callParentConcernList() async {
//   SSorting? response = await Sortserv().Sortit();
//   if (response != null) {
//     if (response.data != null) {
//       notifyListeners();
//       parentConcernlist = response.data ?? [];
//       for (int i = 0; i < parentConcernlist.length; i++) {
//         sortedlist.add(parentConcernlist[i].firstName!);
//         sortedlist.sort();
//         // Convert the list to a Set to remove duplicates
//         Set<String> uniqueItems = Set<String>.from(sortedlist);
//         // Convert the Set back to a list
//         sortedlist = uniqueItems.toList();
//       }
//       notifyListeners();
//     } else {
//       log('null');
//     }
//   } else {
//     log('null');
//   }
//   notifyListeners();
// }
