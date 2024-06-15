import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'root_cubit.freezed.dart';
part 'root_state.dart';

/// App顶层页面的Cubit
final class RootCubit extends Cubit<RootState> {
  /// Constructor.
  RootCubit(RootTab tab) : super(RootState(tab: tab));

  /// 设置当前选项卡。
  void setTab(RootTab tab) => emit(state.copyWith(tab: tab));
}
