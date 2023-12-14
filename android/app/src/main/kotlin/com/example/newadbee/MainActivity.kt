package com.example.newadbee
//
//import android.content.ContentResolver
//import android.content.Intent
//import android.net.Uri
//import android.provider.ContactsContract
//import android.util.Log
//import io.flutter.embedding.android.FlutterActivity
//import io.flutter.embedding.engine.FlutterEngine
//import io.flutter.plugin.common.MethodCall
//import io.flutter.plugin.common.MethodChannel
//import io.flutter.plugins.GeneratedPluginRegistrant
//
//class MainActivity : FlutterActivity() {
//    private val myContentResolver: ContentResolver by lazy { contentResolver }
//
//
//    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
//        GeneratedPluginRegistrant.registerWith(flutterEngine)
//        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call: MethodCall, result: MethodChannel.Result ->
//            if (call.method == "openContactDetailsScreen") {
//                val phoneNumber = call.argument<String>("phoneNumber")
//                Log.d("MainActivity", "Opening contact details screen for phone number: $phoneNumber")
//                openContactDetailsScreen(phoneNumber)
//            } else {
//                result.notImplemented()
//            }
//        }
//    }
//
//    private fun openContactDetailsScreen(phoneNumber: String?) {
//        val lookupUri = Uri.withAppendedPath(ContactsContract.PhoneLookup.CONTENT_FILTER_URI, Uri.encode(phoneNumber))
//        val cursor = contentResolver.query(lookupUri, arrayOf(ContactsContract.Contacts._ID), null, null, null)
//        if (cursor != null && cursor.moveToFirst()) {
//            val columnIndex = cursor.getColumnIndex(ContactsContract.Contacts._ID)
//            val contactId = if (columnIndex >= 0) cursor.getString(columnIndex) else null
//
//            val editUri = Uri.withAppendedPath(ContactsContract.Contacts.CONTENT_URI, contactId)
//            val intent = Intent(Intent.ACTION_EDIT, editUri)
//            startActivity(intent)
//        } else {
//            Log.d("MainActivity", "Contact not found for phone number: $phoneNumber")
//        }
//        cursor?.close()
//    }
//
//
//
//    companion object {
//        private const val CHANNEL = "com.example.newadbee/contact_edit_screen"
//    }
//}
import android.app.Activity
import android.content.ContentResolver
import android.content.Intent
import android.net.Uri
import android.provider.ContactsContract
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {
    private val myContentResolver: ContentResolver by lazy { contentResolver }
    private var contactActivityResult: ((Boolean) -> Unit)? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call: MethodCall, result: MethodChannel.Result ->
            if (call.method == "openContactDetailsScreen") {
                val phoneNumber = call.argument<String>("phoneNumber")
                Log.d("MainActivity", "Opening contact details screen for phone number: $phoneNumber")
                openContactDetailsScreen(phoneNumber) { success ->
                    result.success(success)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun openContactDetailsScreen(phoneNumber: String?, callback: (Boolean) -> Unit) {
        val lookupUri =
                Uri.withAppendedPath(ContactsContract.PhoneLookup.CONTENT_FILTER_URI, Uri.encode(phoneNumber))
        val cursor = contentResolver.query(
                lookupUri, arrayOf(ContactsContract.Contacts._ID), null, null, null
        )
        if (cursor != null && cursor.moveToFirst()) {
            val columnIndex = cursor.getColumnIndex(ContactsContract.Contacts._ID)
            val contactId = if (columnIndex >= 0) cursor.getString(columnIndex) else null

            val editUri = Uri.withAppendedPath(ContactsContract.Contacts.CONTENT_URI, contactId)
            val intent = Intent(Intent.ACTION_EDIT, editUri)
            contactActivityResult = callback
            startActivityForResult(intent, CONTACT_DETAILS_REQUEST_CODE)
        } else {
            Log.d("MainActivity", "Contact not found for phone number: $phoneNumber")
            callback(false)
        }
        cursor?.close()
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == CONTACT_DETAILS_REQUEST_CODE) {
            val success = resultCode == Activity.RESULT_OK
            contactActivityResult?.invoke(success)
            contactActivityResult = null
        }
    }

    companion object {
        private const val CHANNEL = "com.example.newadbee/contact_edit_screen"
        private const val CONTACT_DETAILS_REQUEST_CODE = 1
    }
}