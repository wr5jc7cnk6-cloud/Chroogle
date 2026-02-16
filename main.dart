import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ChroogleApp());
}

class ChroogleApp extends StatelessWidget {
  const ChroogleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BrowserScreen(),
    );
  }
}

class BrowserScreen extends StatefulWidget {
  const BrowserScreen({super.key});

  @override
  State<BrowserScreen> createState() => _BrowserScreenState();
}

class _BrowserScreenState extends State<BrowserScreen> {
  final WebViewController _controller = WebViewController();
  final TextEditingController _urlController =
      TextEditingController(text: "https://google.com");

  @override
  void initState() {
    super.initState();
    _controller.loadRequest(Uri.parse(_urlController.text));
  }

  void _loadUrl() {
    String url = _urlController.text;
    if (!url.startsWith("http")) {
      url = "https://$url";
    }
    _controller.loadRequest(Uri.parse(url));
  }

  Future<void> _loginWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return; // キャンセルした場合

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _urlController,
          decoration: const InputDecoration(
            hintText: "アドレスを入力",
            border: InputBorder.none,
          ),
          onSubmitted: (_) => _loadUrl(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => _controller.goBack(),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () => _controller.goForward(),
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => _controller.reload(),
          ),
          IconButton(
            icon: const Icon(Icons.login),
            onPressed: _loginWithGoogle,
          ),
        ],
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
