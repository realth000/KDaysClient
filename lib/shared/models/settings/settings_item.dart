/// 设置项的值的类型
///
/// 操作数据库时，设置项的值的类型
enum SettingsValueType {
  /// int
  int,

  /// [String]
  string,

  /// bool
  bool,
}

/// 单个设置项的定义
sealed class SettingsItem<T> {
  /// Constructor
  const SettingsItem({
    required this.key,
    required this.valueType,
    required this.defaultValue,
    required this.value,
  });

  /// 键名
  final String key;

  /// 值的类型
  final SettingsValueType valueType;

  /// 默认值
  final T defaultValue;

  /// 当前值
  final T value;

  /// 取值[value]，若值为空，返回默认值
  T get valueOrDefault => value ?? defaultValue;

// @override
// bool operator ==(Object other) {
//   return other is SettingsItem<T> && other.key == key;
// }

// @override
// int get hashCode => Object.hashAll([key, valueType, defaultValue, value]);
}

/// 当前用户
final class SettingsCurrentUser extends SettingsItem<String?> {
  /// Constructor
  const SettingsCurrentUser({
    required super.key,
    required super.defaultValue,
    required super.value,
    super.valueType = SettingsValueType.string,
  });

  /// 应用值[value]并返回应用后的实例
  SettingsCurrentUser applyFromValue(String? value) => SettingsCurrentUser(
        key: key,
        valueType: valueType,
        value: value ?? this.value,
        defaultValue: defaultValue,
      );
}

/// 主题模式
final class SettingsThemeMode extends SettingsItem<int> {
  /// Constructor.
  const SettingsThemeMode({
    required super.key,
    required super.value,
    required super.defaultValue,
    super.valueType = SettingsValueType.int,
  });

  /// 应用值[value]并返回应用后的实例
  SettingsThemeMode applyFromValue(int? value) => SettingsThemeMode(
        key: key,
        valueType: valueType,
        value: value ?? this.value,
        defaultValue: defaultValue,
      );
}
