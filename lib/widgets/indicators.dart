import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';

Center chasingDotsProgress(context) {
  return Center(
    child: SpinKitChasingDots(
      size: 60.0,
      color: Theme.of(context).accentColor,
    ),
  );
}

Center circularProgress(context) {
  return Center(
    child: SpinKitCircle(
      size: 60.0,
      color: Theme.of(context).accentColor,
    ),
  );
}

Container linearProgress(context) {
  return Container(
    child: LinearProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Theme.of(context).accentColor),
    ),
  );
}
