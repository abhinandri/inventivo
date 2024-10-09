
// import 'package:flutter/material.dart';

// class TermsOfUse extends StatelessWidget {
//   const TermsOfUse({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Terms of Use'),
//         backgroundColor: const Color(0xFF17A2B8),
//       ),
//       body: Container(
//         padding: const EdgeInsets.all(16.0),
//         child: const SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Terms of Use',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.teal,
//                 ),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 'Effective Date: August 12, 2024',
//                 style: TextStyle(fontSize: 14, color: Colors.grey),
//               ),
//               Divider(),
//               SizedBox(height: 16),
//               Text(
//                 '1. Acceptance of Terms',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 'By using Inventivo, you agree to comply with and be bound by these Terms of Use. If you do not agree to these terms, please do not use our application.',
//                 style: TextStyle(fontSize: 16),
//               ),
//               SizedBox(height: 16),
//               Text(
//                 '2. Use of the Application',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 'You agree to use Inventivo only for lawful purposes and in a way that does not infringe the rights of, restrict, or inhibit anyone else\'s use and enjoyment of the application.',
//                 style: TextStyle(fontSize: 16),
//               ),
//               SizedBox(height: 16),
//               Text(
//                 '3. Account Responsibility',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 'You are responsible for maintaining the confidentiality of your account information, including your password, and for all activities that occur under your account.',
//                 style: TextStyle(fontSize: 16),
//               ),
//               SizedBox(height: 16),
//               Text(
//                 '4. Intellectual Property',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 'All content included on Inventivo, such as text, graphics, logos, images, and software, is the property of Inventivo or its content suppliers and is protected by intellectual property laws.',
//                 style: TextStyle(fontSize: 16),
//               ),
//               SizedBox(height: 16),
//               Text(
//                 '5. Termination',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 'We may terminate or suspend your access to Inventivo without prior notice or liability for any reason, including if you breach these Terms of Use.',
//                 style: TextStyle(fontSize: 16),
//               ),
//               SizedBox(height: 16),
//               Text(
//                 '6. Limitation of Liability',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 'In no event shall Inventivo, nor its directors, employees, partners, agents, suppliers, or affiliates, be liable for any indirect, incidental, special, consequential, or punitive damages arising out of your use of the application.',
//                 style: TextStyle(fontSize: 16),
//               ),
//               SizedBox(height: 16),
//               Text(
//                 '7. Changes to These Terms',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 'We may update these Terms of Use from time to time. Any changes will be posted on this page with an updated effective date. Please review these terms periodically for any updates.',
//                 style: TextStyle(fontSize: 16),
//               ),
//               SizedBox(height: 16),
//               Text(
//                 '8. Contact Information',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 'If you have any questions or concerns about these Terms of Use, please contact us at:',
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


class TermsConditions extends StatefulWidget {
  const TermsConditions({super.key});

  @override
  _TermsConditionsState createState() => _TermsConditionsState();
}

class _TermsConditionsState extends State<TermsConditions> {
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
          'https://www.freeprivacypolicy.com/live/ef045d38-c58d-4539-8998-56aa463e4a20'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms and condition',style: TextStyle(color: Colors.white),),
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