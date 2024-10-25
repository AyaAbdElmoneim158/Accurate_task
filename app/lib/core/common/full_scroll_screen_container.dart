import 'package:flutter/material.dart';

import '../constants/sizes.dart';

class FullScrollScreenContainer extends StatelessWidget {
  const FullScrollScreenContainer({
    super.key,
    this.body,
    this.hasHight = false,
    this.appBar,
    this.padding,
  });
  final Widget? body;
  final bool hasHight;
  final PreferredSizeWidget? appBar;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: padding ?? EdgeInsets.all(AppSizes.defaultPadding),
            child: SizedBox(
              height: hasHight ? MediaQuery.of(context).size.height : null,
              width: MediaQuery.of(context).size.width,
              child: body,
            ),
          ),
        ),
      ),
    );
  }
}
