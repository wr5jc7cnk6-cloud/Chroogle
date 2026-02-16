import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
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
  final controller = WebViewController();
  final urlController = TextEditingController(text: "https://google.com");

  @override
  void initState() {
    super.initState();
    controller.loadRequest(Uri.parse(urlController.text));
  }

  void go() {
    String input = urlController.text;

    if (!input.contains(".")) {
      input =
          "https://www.google.com/search?q=${Uri.encodeComponent(input)}";
    } else if (!input.startsWith("http")) {
      input = "https://$input";
    }

    controller.loadRequest(Uri.parse(input));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: urlController,
          decoration: const InputDecoration(
            hintText: "検索またはURL入力",
            border: InputBorder.none,
          ),
          onSubmitted: (_) => go(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => controller.reload(),
          ),
        ],
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
