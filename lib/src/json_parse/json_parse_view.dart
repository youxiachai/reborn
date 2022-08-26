import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:reborn/src/json_parse/json_strings.dart';

class JsonComplexPage extends StatelessWidget {
  const JsonComplexPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var objects = JsonStrings.complexObjects.map((e) {
      final parsedJson = json.decode(e) as Map<String, dynamic>;
      return ConvertedComplexObject.fromJson(parsedJson);
    }).toList();

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      children: [
        const SizedBox(height: 16.0),
        ComplexObjectViewList(complexObjects: objects),
        const SizedBox(height: 16.0),
      ],
    );
  }
}

class ComplexObjectViewList extends StatelessWidget {
  const ComplexObjectViewList({required this.complexObjects, super.key});

  final List<dynamic> complexObjects;

  @override
  Widget build(BuildContext context) {
    final widgets = <Widget>[];

    for (var i = 0; i < complexObjects.length; i++) {
      widgets.addAll([
        Text(
          'Complex Object $i:',
          style: Theme.of(context).textTheme.subtitle1,
        ),
        const SizedBox(height: 4.0),
        // ComplexObjectView(complexObject: complexObjects[i]),
        const SizedBox(height: 24.0),
      ]);
    }

    widgets.removeLast();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }
}

class ConvertedComplexObject {
  const ConvertedComplexObject({
    this.aString,
    this.anInt,
    this.aDouble,
    this.anObject,
    this.aListOfStrings,
    this.aListOfInts,
    this.aListOfDoubles,
    this.aListOfObjects,
  });

  final String? aString;
  final int? anInt;
  final double? aDouble;
  final ConvertedSimpleObject? anObject;
  final List<String>? aListOfStrings;
  final List<int>? aListOfInts;
  final List<double>? aListOfDoubles;
  final List<ConvertedSimpleObject>? aListOfObjects;

  factory ConvertedComplexObject.fromJson(Map<String, dynamic> json) {
    return ConvertedComplexObject(
        aString: json['aString'] as String?,
        anInt: json['anInt'] as int?,
        aDouble: json['aDouble'] as double?,
        anObject: json['anObject'] != null
            ? ConvertedSimpleObject.fromJson(
                json['anObject'] as Map<String, dynamic>)
            : null,
        aListOfStrings: json['aListOfStrings'] != null
            ? List<String>.from(json['aListOfStrings'] as Iterable<dynamic>)
            : null,
        aListOfInts: json['aListOfInts'] != null
            ? List<int>.from(json['aListOfInts'] as Iterable<dynamic>)
            : null,
        aListOfDoubles: json['aListOfDoubles'] != null
            ? List<double>.from(json['aListOfDoubles'] as Iterable<dynamic>)
            : null,
        aListOfObjects: json['aListOfObjects'] != null
            ? List<ConvertedSimpleObject>.from((json['aListOfObjects']
                    as Iterable<dynamic>)
                .map<dynamic>((dynamic o) =>
                    ConvertedSimpleObject.fromJson(o as Map<String, dynamic>)))
            : null);
  }
}

class ConvertedSimpleObject {
  const ConvertedSimpleObject({
    this.aString,
    this.anInt,
    this.aDouble,
    this.aListOfStrings,
    this.aListOfInts,
    this.aListOfDoubles,
  });

  final String? aString;
  final int? anInt;
  final double? aDouble;
  final List<String>? aListOfStrings;
  final List<int>? aListOfInts;
  final List<double>? aListOfDoubles;

  factory ConvertedSimpleObject.fromJson(Map<String, dynamic> json) {
    return ConvertedSimpleObject(
      aString: json['aString'] as String?,
      anInt: json['anInt'] as int?,
      aDouble: json['aDouble'] as double?,
      aListOfStrings: json['aListOfStrings'] != null
          ? List<String>.from(json['aListOfStrings'] as Iterable<dynamic>)
          : null,
      aListOfInts: json['aListOfInts'] != null
          ? List<int>.from(json['aListOfInts'] as Iterable<dynamic>)
          : null,
      aListOfDoubles: json['aListOfDoubles'] != null
          ? List<double>.from(json['aListOfDoubles'] as Iterable<dynamic>)
          : null,
    );
  }
}


