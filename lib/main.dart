import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Rolling Pages', home: MyPageView());
  }
}

class MyPageView extends StatefulWidget {
  const MyPageView({Key? key}) : super(key: key);

  @override
  _MyPageViewState createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  final PageController _pageController =
      PageController(initialPage: 0, viewportFraction: 0.8);
  int _counter = 0;

  void _initCounter() {
    setState(() {
      _counter = 0;
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rolling Pages'),
      ),
      body: PageView.builder(
        scrollDirection: Axis.horizontal,
        controller: _pageController,
        itemBuilder: (context, horizontalIndex) =>
            _buildHorizontalView(context, horizontalIndex),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _initCounter();
          _pageController.animateToPage(
            0,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );
        },
        tooltip: 'Back to Top Page',
        child: Icon(Icons.restart_alt),
      ),
    );
  }

  Widget _buildHorizontalView(BuildContext context, int horizontalIndex) {
    final imageUrl =
        'https://source.unsplash.com/1600x900/?nature,water?_=$horizontalIndex';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Card(
        child: Column(children: [
          Image.network(imageUrl),
          ElevatedButton(
            onPressed: () {
              _incrementCounter();
              _pageController.animateToPage(
                _counter,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              );
            },
            child: Text(horizontalIndex.toString()),
          ),
        ]),
      ),
    );
  }
}
