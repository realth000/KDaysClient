part of 'models.dart';

// /// 设置项 Model
// @freezed
// sealed class Settings {
//   Settings._();
//
//   /// Constructor
//   const factory Settings({
//     // 当前已登录用户
//     required String? currentUser,
//   }) = SettingsModel;
//
//   /// Deserializer
//   factory Settings.fromJson(Map<String, dynamic> json) =>
//       _$SettingsFromJson(json);
//
//   /// Serializer
//   Map<String, dynamic> toJson() => _$StorageValue(this);
// }
//
// /// [Settings]模型和歌曲的结合
// class SettingsConverter extends d.TypeConverter<Settings, String> {
//   /// Constructor.
//   const SettingsConverter();
//
//   @override
//   Settings fromSql(String fromDb) =>
//       Settings.fromJson(jsonDecode(fromDb) as Map<String, dynamic>);
//
//   @override
//   String toSql(Settings value) => jsonEncode(value);
// }
