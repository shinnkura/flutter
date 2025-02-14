// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'env.dart';

// **************************************************************************
// EnviedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// generated_from: .env
final class _Env {
  static const List<int> _enviedkeydbPassword = <int>[
    3175743209,
    3642003943,
    2774983698,
    2234134847,
    776266119,
    3460629094,
    2118227522,
    209157887,
    2325619839,
    559751284,
  ];

  static const List<int> _envieddatadbPassword = <int>[
    3175743192,
    3642003925,
    2774983713,
    2234134795,
    776266162,
    3460629072,
    2118227573,
    209157831,
    2325619782,
    559751236,
  ];

  static final String dbPassword = String.fromCharCodes(List<int>.generate(
    _envieddatadbPassword.length,
    (int i) => i,
    growable: false,
  ).map((int i) => _envieddatadbPassword[i] ^ _enviedkeydbPassword[i]));

  static const String dbPort = '3000';
}
