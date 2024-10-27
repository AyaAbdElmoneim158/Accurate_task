// TypeCode enum extension
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../constants/queries_and_mutations.dart';

extension AnimateExtension on Widget {
  // FadeIn Animations
  Widget fadeIn({
    int? milliseconds,
    int delay = 0,
    bool manualTrigger = false,
  }) =>
      FadeIn(
        duration: Duration(milliseconds: milliseconds ?? 500),
        delay: Duration(milliseconds: delay),
        manualTrigger: manualTrigger,
        child: this,
      );

  Widget fadeInDown({
    int? milliseconds,
    int delay = 0,
  }) =>
      FadeInDown(
        duration: Duration(milliseconds: milliseconds ?? 500),
        delay: Duration(milliseconds: delay),
        child: this,
      );

  Widget fadeInDownBig({
    int? milliseconds,
    int delay = 0,
  }) =>
      FadeInDownBig(
        duration: Duration(milliseconds: milliseconds ?? 500),
        delay: Duration(milliseconds: delay),
        child: this,
      );

  Widget fadeInUp({
    int? milliseconds,
    int delay = 0,
  }) =>
      FadeInUp(
        duration: Duration(milliseconds: milliseconds ?? 500),
        delay: Duration(milliseconds: delay),
        child: this,
      );

  Widget fadeInUpBig({
    int? milliseconds,
    int delay = 0,
  }) =>
      FadeInUpBig(
        duration: Duration(milliseconds: milliseconds ?? 500),
        delay: Duration(milliseconds: delay),
        child: this,
      );

  Widget fadeInLeft({
    int? milliseconds,
    int delay = 0,
  }) =>
      FadeInLeft(
        duration: Duration(milliseconds: milliseconds ?? 500),
        delay: Duration(milliseconds: delay),
        child: this,
      );

  Widget fadeInLeftBig({
    int? milliseconds,
    int delay = 0,
  }) =>
      FadeInLeftBig(
        duration: Duration(milliseconds: milliseconds ?? 500),
        delay: Duration(milliseconds: delay),
        child: this,
      );

  Widget fadeInRight({
    int? milliseconds,
    int delay = 0,
  }) =>
      FadeInRight(
        duration: Duration(milliseconds: milliseconds ?? 500),
        delay: Duration(milliseconds: delay),
        child: this,
      );

  Widget fadeInRightBig({
    int? milliseconds,
    int delay = 0,
  }) =>
      FadeInRightBig(
        duration: Duration(milliseconds: milliseconds ?? 500),
        delay: Duration(milliseconds: delay),
        child: this,
      );

  // FadeOut Animations
  Widget fadeOut({
    int? milliseconds,
    int delay = 0,
  }) =>
      FadeOut(
        duration: Duration(milliseconds: milliseconds ?? 500),
        delay: Duration(milliseconds: delay),
        child: this,
      );

  Widget fadeOutDown({
    int? milliseconds,
    int delay = 0,
  }) =>
      FadeOutDown(
        duration: Duration(milliseconds: milliseconds ?? 500),
        delay: Duration(milliseconds: delay),
        child: this,
      );

  Widget fadeOutDownBig({
    int? milliseconds,
    int delay = 0,
  }) =>
      FadeOutDownBig(
        duration: Duration(milliseconds: milliseconds ?? 500),
        delay: Duration(milliseconds: delay),
        child: this,
      );

  Widget fadeOutUp({
    int? milliseconds,
    int delay = 0,
  }) =>
      FadeOutUp(
        duration: Duration(milliseconds: milliseconds ?? 500),
        delay: Duration(milliseconds: delay),
        child: this,
      );

  Widget fadeOutUpBig({
    int? milliseconds,
    int delay = 0,
  }) =>
      FadeOutUpBig(
        duration: Duration(milliseconds: milliseconds ?? 500),
        delay: Duration(milliseconds: delay),
        child: this,
      );

  Widget fadeOutLeft({
    int? milliseconds,
    int delay = 0,
  }) =>
      FadeOutLeft(
        duration: Duration(milliseconds: milliseconds ?? 500),
        delay: Duration(milliseconds: delay),
        child: this,
      );

  Widget fadeOutLeftBig({
    int? milliseconds,
    int delay = 0,
  }) =>
      FadeOutLeftBig(
        duration: Duration(milliseconds: milliseconds ?? 500),
        delay: Duration(milliseconds: delay),
        child: this,
      );

  Widget fadeOutRight({
    int? milliseconds,
    int delay = 0,
  }) =>
      FadeOutRight(
        duration: Duration(milliseconds: milliseconds ?? 500),
        delay: Duration(milliseconds: delay),
        child: this,
      );

  Widget fadeOutRightBig({
    int? milliseconds,
    int delay = 0,
  }) =>
      FadeOutRightBig(
        duration: Duration(milliseconds: milliseconds ?? 500),
        delay: Duration(milliseconds: delay),
        child: this,
      );

  // Bounce Animations
  Widget bounceInDown({
    int? milliseconds,
    int delay = 0,
  }) =>
      BounceInDown(
        duration: Duration(milliseconds: milliseconds ?? 500),
        delay: Duration(milliseconds: delay),
        child: this,
      );

  Widget bounceInUp({
    int? milliseconds,
    int delay = 0,
  }) =>
      BounceInUp(
        duration: Duration(milliseconds: milliseconds ?? 500),
        delay: Duration(milliseconds: delay),
        child: this,
      );

  Widget bounceInLeft({
    int? milliseconds,
    int delay = 0,
  }) =>
      BounceInLeft(
        duration: Duration(milliseconds: milliseconds ?? 500),
        delay: Duration(milliseconds: delay),
        child: this,
      );

  Widget bounceInRight({
    int? milliseconds,
    int delay = 0,
  }) =>
      BounceInRight(
        duration: Duration(milliseconds: milliseconds ?? 500),
        delay: Duration(milliseconds: delay),
        child: this,
      );

  // Elastic Animations
  Widget elasticIn({
    int? milliseconds,
    int delay = 0,
  }) =>
      ElasticIn(
        duration: Duration(milliseconds: milliseconds ?? 500),
        delay: Duration(milliseconds: delay),
        child: this,
      );

  Widget elasticInDown({
    int? milliseconds,
    int delay = 0,
  }) =>
      ElasticInDown(
        duration: Duration(milliseconds: milliseconds ?? 500),
        delay: Duration(milliseconds: delay),
        child: this,
      );

  Widget elasticInUp({
    int? milliseconds,
    int delay = 0,
  }) =>
      ElasticInUp(
        duration: Duration(milliseconds: milliseconds ?? 500),
        delay: Duration(milliseconds: delay),
        child: this,
      );

  Widget elasticInLeft({
    int? milliseconds,
    int delay = 0,
  }) =>
      ElasticInLeft(
        duration: Duration(milliseconds: milliseconds ?? 500),
        delay: Duration(milliseconds: delay),
        child: this,
      );

  Widget elasticInRight({
    int? milliseconds,
    int delay = 0,
  }) =>
      ElasticInRight(
        duration: Duration(milliseconds: milliseconds ?? 500),
        delay: Duration(milliseconds: delay),
        child: this,
      );

  // SlideIn Animations
  Widget slideInDown({
    int? milliseconds,
    int delay = 0,
  }) =>
      SlideInDown(
        duration: Duration(milliseconds: milliseconds ?? 500),
        delay: Duration(milliseconds: delay),
        child: this,
      );

  Widget slideInUp({
    int? milliseconds,
    int delay = 0,
  }) =>
      SlideInUp(
        duration: Duration(milliseconds: milliseconds ?? 500),
        delay: Duration(milliseconds: delay),
        child: this,
      );

  Widget slideInLeft({
    int? milliseconds,
    int delay = 0,
  }) =>
      SlideInLeft(
        duration: Duration(milliseconds: milliseconds ?? 500),
        delay: Duration(milliseconds: delay),
        child: this,
      );

  Widget slideInRight({
    int? milliseconds,
    int delay = 0,
  }) =>
      SlideInRight(
        duration: Duration(milliseconds: milliseconds ?? 500),
        delay: Duration(milliseconds: delay),
        child: this,
      );

  // Flip Animations
  Widget flipInX({
    int? milliseconds,
    int delay = 0,
  }) =>
      FlipInX(
        duration: Duration(milliseconds: milliseconds ?? 500),
        delay: Duration(milliseconds: delay),
        child: this,
      );

  Widget flipInY({
    int? milliseconds,
    int delay = 0,
  }) =>
      FlipInY(
        duration: Duration(milliseconds: milliseconds ?? 500),
        delay: Duration(milliseconds: delay),
        child: this,
      );

  // Zoom Animations
  Widget zoomIn({
    int? milliseconds,
    int delay = 0,
  }) =>
      ZoomIn(
        duration: Duration(milliseconds: milliseconds ?? 500),
        delay: Duration(milliseconds: delay),
        child: this,
      );

  Widget zoomOut({
    int? milliseconds,
    int delay = 0,
  }) =>
      ZoomOut(
        duration: Duration(milliseconds: milliseconds ?? 500),
        delay: Duration(milliseconds: delay),
        child: this,
      );

  // Jello, Bounce, Dance, Flash Animations
  Widget jelloIn({
    int? milliseconds,
    int delay = 0,
  }) =>
      JelloIn(
        duration: Duration(milliseconds: milliseconds ?? 500),
        delay: Duration(milliseconds: delay),
        child: this,
      );

  Widget bounce({
    int? milliseconds,
    int delay = 0,
  }) =>
      Bounce(
        duration: Duration(milliseconds: milliseconds ?? 500),
        delay: Duration(milliseconds: delay),
        child: this,
      );

  Widget dance({
    int? milliseconds,
    int delay = 0,
  }) =>
      Dance(
        duration: Duration(milliseconds: milliseconds ?? 500),
        delay: Duration(milliseconds: delay),
        child: this,
      );

  Widget flash({
    int? milliseconds,
    int delay = 0,
  }) =>
      Flash(
        duration: Duration(milliseconds: milliseconds ?? 500),
        delay: Duration(milliseconds: delay),
        child: this,
      );

  // Pulse, Roulette, ShakeX, ShakeY, Spin Animations
  Widget pulse({
    int? milliseconds,
    int delay = 0,
  }) =>
      Pulse(
        duration: Duration(milliseconds: milliseconds ?? 500),
        delay: Duration(milliseconds: delay),
        child: this,
      );

  Widget roulette({
    int? milliseconds,
    int delay = 0,
  }) =>
      Roulette(
        duration: Duration(milliseconds: milliseconds ?? 500),
        delay: Duration(milliseconds: delay),
        child: this,
      );

  Widget shakeX({
    int? milliseconds,
    int delay = 0,
  }) =>
      ShakeX(
        duration: Duration(milliseconds: milliseconds ?? 500),
        delay: Duration(milliseconds: delay),
        child: this,
      );

  Widget shakeY({
    int? milliseconds,
    int delay = 0,
  }) =>
      ShakeY(
        duration: Duration(milliseconds: milliseconds ?? 500),
        delay: Duration(milliseconds: delay),
        child: this,
      );

  Widget spin({
    int? milliseconds,
    int delay = 0,
  }) =>
      Spin(
        duration: Duration(milliseconds: milliseconds ?? 500),
        delay: Duration(milliseconds: delay),
        child: this,
      );

  Widget spinPerfect({
    int? milliseconds,
    int delay = 0,
  }) =>
      SpinPerfect(
        duration: Duration(milliseconds: milliseconds ?? 500),
        delay: Duration(milliseconds: delay),
        child: this,
      );

  Widget swing({
    int? milliseconds,
    int delay = 0,
  }) =>
      Swing(
        duration: Duration(milliseconds: milliseconds ?? 500),
        delay: Duration(milliseconds: delay),
        child: this,
      );
}

extension TypeCodeExtension on TypeCode {
  String get displayName {
    switch (this) {
      case TypeCode.PMNT:
        return "Payment";
      case TypeCode.RTRN:
        return "Return";
      case TypeCode.MTRL:
        return "Material";
    }
  }

  String get apiValue {
    switch (this) {
      case TypeCode.PMNT:
        return "pmnt";
      case TypeCode.RTRN:
        return "rtrn";
      case TypeCode.MTRL:
        return "mtrl";
    }
  }

  static TypeCode fromApiValue(String value) {
    switch (value) {
      case "pmnt":
        return TypeCode.PMNT;
      case "rtrn":
        return TypeCode.RTRN;
      case "mtrl":
        return TypeCode.MTRL;
      default:
        throw ArgumentError("Invalid TypeCode value");
    }
  }
}

// DeliveryType enum extension
extension DeliveryTypeExtension on DeliveryType {
  String get displayName {
    switch (this) {
      case DeliveryType.OFFICE:
        return "Office";
      case DeliveryType.DELIVERYAGENT:
        return "Delivery Agent";
      case DeliveryType.WALLET:
        return "Wallet";
      case DeliveryType.BANK:
        return "Bank";
      case DeliveryType.INSTPY:
        return "Installment Payment";
    }
  }

  String get apiValue {
    switch (this) {
      case DeliveryType.OFFICE:
        return "office";
      case DeliveryType.DELIVERYAGENT:
        return "delivery_agent";
      case DeliveryType.WALLET:
        return "wallet";
      case DeliveryType.BANK:
        return "bank";
      case DeliveryType.INSTPY:
        return "instpy";
    }
  }

  static DeliveryType fromApiValue(String value) {
    switch (value) {
      case "office":
        return DeliveryType.OFFICE;
      case "delivery_agent":
        return DeliveryType.DELIVERYAGENT;
      case "wallet":
        return DeliveryType.WALLET;
      case "bank":
        return DeliveryType.BANK;
      case "instpy":
        return DeliveryType.INSTPY;
      default:
        throw ArgumentError("Invalid DeliveryType value");
    }
  }
}
