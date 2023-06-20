import 'package:flutter/widgets.dart';


enum Reaction { happy, cheers, unsure, info, warning, error }

extension StringExtension on String {
  void log([Reaction reaction = Reaction.happy, Object? tag]) {
    String logPrefix;
    switch (reaction) {
      case Reaction.info:
        logPrefix = "🐛 INFO:";
        break;
      case Reaction.warning:
        logPrefix = "🦠 WARN:";
        break;
      case Reaction.error:
        logPrefix = "❌ ERROR:";
        break;
      case Reaction.happy:
        logPrefix = "👌 HAPPY:";
        break;
      case Reaction.unsure:
        logPrefix = "❓ UNSURE:";
        break;
      case Reaction.cheers:
        logPrefix = "🍺 CHEERS:";
        break;
    }
    debugPrint("${tag == null ? '' : '${tag.runtimeType} '}$logPrefix $this");
  }
}







