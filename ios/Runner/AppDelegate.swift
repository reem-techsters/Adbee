// import UIKit
// import Flutter

// @UIApplicationMain
// @objc class AppDelegate: FlutterAppDelegate {
//   override func application(
//     _ application: UIApplication,
//     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
//   ) -> Bool {
//     GeneratedPluginRegistrant.register(with: self)
//     return super.application(application, didFinishLaunchingWithOptions: launchOptions)
//   }
// }
//-----
import Flutter
import UIKit
import Contacts

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        
        if let controller = window?.rootViewController as? FlutterViewController {
            let channel = FlutterMethodChannel(name: "com.example.newadbee/contact_edit_screen",
                                               binaryMessenger: controller.binaryMessenger)
            channel.setMethodCallHandler { [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
                if call.method == "openContactDetailsScreen" {
                    if let phoneNumber = call.arguments as? String {
                        print("Opening contact details screen for phone number: \(phoneNumber)")
                        self?.openContactDetailsScreen(phoneNumber: phoneNumber)
                    }
                } else {
                    result(FlutterMethodNotImplemented)
                }
            }
        }
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    private func openContactDetailsScreen(phoneNumber: String) {
    let store = CNContactStore()
    let keysToFetch = [CNContactIdentifierKey] as [CNKeyDescriptor]
    
    var contact: CNContact?
    do {
        let predicate = CNContact.predicateForContacts(matching: CNPhoneNumber(stringValue: phoneNumber))
        let contactsFetchRequest = CNContactFetchRequest(keysToFetch: keysToFetch)
        contactsFetchRequest.predicate = predicate
        try store.enumerateContacts(with: contactsFetchRequest, usingBlock: { (fetchedContact, stop) in
            contact = fetchedContact
            stop.pointee = true
        })
        
        if let contact = contact {
            let contactID = contact.identifier
            let editURL = URL(string: "com.apple.contacts://contacts/edit/\(contactID)")!
            
            if UIApplication.shared.canOpenURL(editURL) {
                UIApplication.shared.open(editURL)
            }
        } else {
            print("Contact not found for phone number: \(phoneNumber)")
        }
    } catch {
        print("Failed to fetch contact details: \(error)")
    }
}
}