//
// import 'dart:async';
// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// /// Handles only link detection and navigation
// class DeepLinkService {
//   static final DeepLinkService _instance = DeepLinkService._internal();
//   factory DeepLinkService() => _instance;
//   DeepLinkService._internal();
//
//   final AppLinks _appLinks = AppLinks();
//   StreamSubscription<Uri>? _linkSubscription;
//
//   /// Initialize deep links
//   Future<void> initDeepLinks() async {
//     // Cold start
//     final initialLink = await _appLinks.getInitialLink();
//     if (initialLink != null) {
//       _handleLink(initialLink);
//     }
//
//     // Foreground/background
//     _linkSubscription = _appLinks.uriLinkStream.listen(
//           (uri) => _handleLink(uri),
//       onError: (err) => debugPrint("DeepLink error: $err"),
//     );
//   }
//
//   void _handleLink(Uri uri) {
//     log("DeepLink detected: ${uri.toString()}");
//
//     // Post link
//     if (uri.pathSegments.isNotEmpty && uri.pathSegments.first == "post") {
//       final postId = uri.pathSegments.length > 1 ? uri.pathSegments[1] : null;
//       if (postId != null) {
//         Get.to(() => PostScreen(postId: postId));
//       }
//       return;
//     }
//
//     // Map link: /map?lat=...&lng=...&title=...&selectedType=...
//     if (uri.pathSegments.isNotEmpty && uri.pathSegments.first == "map") {
//       final latString = uri.queryParameters['lat'];
//       final lngString = uri.queryParameters['lng'];
//       final title = uri.queryParameters['title'];
//       final type = uri.queryParameters['selectedType'];
//
//       if (latString != null && lngString != null) {
//         final lat = double.tryParse(latString);
//         final lng = double.tryParse(lngString);
//
//         if (lat != null && lng != null) {
//           // Use post frame callback to avoid context issues
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             Get.to(
//                   () => MapShare(),
//               transition: Transition.fade,
//               arguments: {
//                 "lat": lat,
//                 "lon": lng,
//                 "title": title,
//                 "selectedType": type,
//               },
//             );
//           });
//         } else {
//           debugPrint("Invalid latitude or longitude in deep link");
//         }
//       } else {
//         debugPrint("Latitude or longitude missing in deep link");
//       }
//       return;
//     }
//
//     debugPrint("Unknown deep link path: ${uri.path}");
//   }
//
//
//   void dispose() {
//     _linkSubscription?.cancel();
//   }
// }