import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key, required Widget this.nextScreen}) : super(key: key);
  final nextScreen;

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 2), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => widget.nextScreen));
  }

  @override
  Widget build(BuildContext context) {
    final productNameStyle = Theme.of(context).textTheme.titleLarge;
    final ownerStyle = Theme.of(context).textTheme.subtitle2;
    const productName = "Qelem";
    const owner = "owner";

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  productName,
                  style: productNameStyle,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "by its " + owner,
                  style: ownerStyle,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
