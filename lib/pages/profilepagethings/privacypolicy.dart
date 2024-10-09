
// // import 'package:flutter/material.dart';

// // class PrivacyPolicy extends StatelessWidget {
// //   const PrivacyPolicy({Key? key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Privacy Policy'),
// //         backgroundColor: const Color(0xFF17A2B8),
// //       ),
// //       body: Center(
// //         child: const Text('Privacy Policy Page Content'),
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';

// class PrivacyPolicy extends StatelessWidget {
//   const PrivacyPolicy({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Privacy Policy'),
//         backgroundColor: const Color(0xFF17A2B8),
//       ),
//       body: Container(
//         padding: const EdgeInsets.all(16.0),
//         child: const SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Text(
//               //   'Privacy Policy',
//               //   style: TextStyle(
//               //     fontSize: 24,
//               //     fontWeight: FontWeight.bold,
//               //     color: Colors.teal,
//               //   ),
//               // ),
//               // SizedBox(height: 8),
//               // Text(
//               //   'Effective Date: August 12, 2024',
//               //   style: TextStyle(fontSize: 14, color: Colors.grey),
//               // ),
//               // Divider(),
//               // SizedBox(height: 16),
//               Text(
//                 '1. Introduction',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 'Welcome to Inventivo. This Privacy Policy describes how we collect, use, and protect your personal information when you use our application. By using Inventivo, you agree to the terms outlined in this policy.',
//                 style: TextStyle(fontSize: 16),
//               ),
//               SizedBox(height: 16),
//               Text(
//                 '2. Information Collection and Use',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 'We collect personal information that you voluntarily provide when you create an account, such as your name, email address, and profile photo. We also collect data related to your usage of the app, including inventory details and analytics.',
//                 style: TextStyle(fontSize: 16),
//               ),
//               SizedBox(height: 16),
//               Text(
//                 '3. Data Security',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 'We are committed to ensuring the security of your data. We use industry-standard security measures to protect your information from unauthorized access, disclosure, or alteration.',
//                 style: TextStyle(fontSize: 16),
//               ),
//               SizedBox(height: 16),
//               Text(
//                 '4. Cookies and Tracking',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 'Inventivo does not use cookies or tracking technologies.',
//                 style: TextStyle(fontSize: 16),
//               ),
//               SizedBox(height: 16),
//               Text(
//                 '5. User Rights',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 'You have the right to access, update, and delete your personal information stored in the app. If you wish to exercise these rights, please contact us at support@inventivo.com.',
//                 style: TextStyle(fontSize: 16),
//               ),
//               SizedBox(height: 16),
//               Text(
//                 '6. Changes to This Privacy Policy',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 'We may update this Privacy Policy from time to time. Any changes will be posted on this page with an updated effective date. Please review this policy periodically for any updates.',
//                 style: TextStyle(fontSize: 16),
//               ),
//               SizedBox(height: 16),
//               Text(
//                 '7. Contact Information',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 'If you have any questions or concerns about our Privacy Policy, please contact us at:',
//                 style: TextStyle(fontSize: 16),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 'Email: support@inventivo.com\nAddress: 1234 App Lane, Suite 100, Tech City, Country',
//                 style: TextStyle(fontSize: 16, color: Colors.teal),
//               ),
//               SizedBox(height: 16),
//               Text(
//                 'Thank you for using Inventivo.',
//                 style: TextStyle(fontSize: 16),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:project/pages/color.dart';
import 'package:webview_flutter/webview_flutter.dart';


class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color.fromARGB(0, 20, 10, 10))
      ..setNavigationDelegate(
        NavigationDelegate(

          onProgress: (int progress) {},

          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to load page')),
            );
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(
          'https://www.freeprivacypolicy.com/live/849a66ef-ab4b-4c04-8214-59ac3b6cbfde'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: CustomeColors.Primary,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: WebViewWidget(controller: _controller),
          ),
        ],
      ),
    );
  }
}
