import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';

enum RequestResource { camera, storage, microphone, location }

class AppPermissions {
  final FirebaseMessaging messaging = FirebaseMessaging.instance;

  static final AppPermissions _appPermissions = AppPermissions._internal();

  factory AppPermissions() => _appPermissions;

  AppPermissions._internal();

  Future<void> initializeAllPermissions() async {
    // await _registerNotification();
    // await _requestTrackingPermission();
    await _requestPermission(RequestResource.location).then((value) {
      debugPrint("Permission Status is $value");
    });
  }

  // Future<void> _registerNotification() async {
  //   NotificationSettings settings = await messaging.requestPermission(
  //     alert: true,
  //     badge: true,
  //     provisional: false,
  //     sound: true,
  //   );
  //   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //     // Handle authorized state
  //   } else {
  //     debugPrint('User declined or has not accepted permission');
  //   }
  // }

  // Future<void> _requestTrackingPermission() async {
  //   if (Platform.isIOS) {
  //     final status = await AppTrackingTransparency.trackingAuthorizationStatus;
  //     if (status == TrackingStatus.notDetermined) {
  //       await AppTrackingTransparency.requestTrackingAuthorization();
  //     }
  //   } else if (Platform.isAndroid) {
  //     await Permission.appTrackingTransparency.request();
  //   }

  //   final newStatus = await AppTrackingTransparency.trackingAuthorizationStatus;
  //   if (newStatus == TrackingStatus.authorized) {
  //     debugPrint('User granted permission for tracking');
  //   } else {
  //     debugPrint('User denied or restricted permission for tracking');
  //   }
  // }

  Future<bool> _requestPermission(RequestResource requestResource) async {
    final permission = _mapRequestResourceToPermission(requestResource);

    switch (await permission.status) {
      case PermissionStatus.granted:
        debugPrint('Granted');
        return true;
      case PermissionStatus.permanentlyDenied:
        debugPrint('permanentlyDenied');
        return false;
      case PermissionStatus.restricted:
        debugPrint('restricted');
        return false;
      default:
        var newStatus = await [permission].request();
        debugPrint('Latest Status $newStatus');
        return newStatus[permission] == PermissionStatus.granted;
    }
  }

  Permission _mapRequestResourceToPermission(RequestResource requestResource) {
    switch (requestResource) {
      case RequestResource.camera:
        return Permission.camera;
      case RequestResource.storage:
        return Platform.isAndroid ? Permission.storage : Permission.photos;
      case RequestResource.microphone:
        return Permission.microphone;
      case RequestResource.location:
        return Permission.location;
      default:
        throw Exception('Unknown resource requested');
    }
  }
}
