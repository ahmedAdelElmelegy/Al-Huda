import 'package:al_huda/main.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

push(Widget child) => Navigator.of(
  navigator.currentContext!,
).push(PageTransition(child: child, type: PageTransitionType.rightToLeft));

pushAndRemoveUntil(Widget child) =>
    Navigator.of(navigator.currentContext!).pushAndRemoveUntil(
      PageTransition(child: child, type: PageTransitionType.fade),
      (route) => false,
    );

pushReplacement(Widget child) => Navigator.of(
  navigator.currentContext!,
).pushReplacement(PageTransition(child: child, type: PageTransitionType.fade));
pop() => Navigator.of(navigator.currentContext!).pop();
