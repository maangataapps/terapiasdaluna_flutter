import 'package:terapiasdaluna/infrastructure/utils/prefs_keys.dart';

extension NullableStringExtensions on String? {
  bool isNotEmptyOrNull() {
    if (this != null && this != '') {
      return true;
    } else {
      return false;
    }
  }

  bool isEmptyOrNull() {
    if (this == null || this == '') {
      return true;
    } else {
      return false;
    }
  }

  String orEmpty() {
    if (this == null) {
      return '';
    } else {
      return this!;
    }
  }

  bool isNull() {
    if (this == null) {
      return true;
    } else {
      return false;
    }
  }

  bool isNotNull() {
    if (this == null) {
      return false;
    } else {
      return true;
    }
  }
}

extension StringExtensions on String {
  bool isNotEmpty() {
    if (this != '') {
      return true;
    } else {
      return false;
    }
  }

  bool isEmpty() {
    if (this == '') {
      return true;
    } else {
      return false;
    }
  }

  String appendColon() {
    return '$this:';
  }

  String firstLetterToUpperCase() {
    return '${substring(0,1).toUpperCase()}${substring(1)}';
  }
}

extension ListExtensions<T> on List<T> {

  String convertToBinary(int binarySize) {
    String binary = '';
    for (int i = 0; i < binarySize; i++) {
      if (contains(i)) {
        binary += '1';
      } else {
        binary += '0';
      }
    }
    return binary;
  }
}

extension NullableListExtensions<T> on List<T>? {
  List<T> orEmpty() {
    if (this == null) {
      return <T>[];
    } else {
      return this!;
    }
  }

}

extension PrefsKeysExtensions on PrefsKeys {
  String getKey() => name.orEmpty();
}

extension IntExtensions on int? {
  int getHiveKey() => this!~/(1000000);

  int orZero() {
    if (this == null) {
      return 0;
    } else {
      return this!;
    }
  }
}

extension ObjectExtensions on Object? {
  bool isNull() {
    if (this == null) {
      return true;
    } else {
      return false;
    }
  }

  bool aintNull(Function action) {
    if (this == null) {
      return false;
    } else {
      return true;
    }
  }

  void doIfNull(Function action) {
    if (this == null) {
      action.call();
    }
  }

  void doIfAintNull(Function action) {
    if (this != null) {
      action.call();
    }
  }

}

extension BoolExtensions on bool {
  void doIfTrue(Function action) {
    if (this) {
      action.call();
    }
  }

  void doIfFalse(Function action) {
    if (!this) {
      action.call();
    }
  }
}

extension DoubleExtensions on double? {
  double orZero() {
    if (this == null) {
      return 0.0;
    } else {
      return this!;
    }
  }
}

extension IterableExtensions on Iterable {
  Iterable<E> mapIndexed<E, T>(
      E Function(int index, T item) f,
      ) sync* {
    var index = 0;

    for (final item in this) {
      yield f(index, item);
      index = index + 1;
    }
  }
}
