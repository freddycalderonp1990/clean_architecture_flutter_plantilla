part of '../pages.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(builder: (_)=> Scaffold(body: SafeArea(child: Center(child: Text('Es Splash'),),),));
  }
}
