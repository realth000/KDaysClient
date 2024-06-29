import 'package:bloc/bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kdays_client/features/home/exception/exception.dart';
import 'package:kdays_client/features/home/models/models.dart';
import 'package:kdays_client/features/home/repository/home_repository.dart';

part 'home_bloc.freezed.dart';
part 'home_event.dart';
part 'home_state.dart';

typedef _Emit = Emitter<HomeState>;

/// 主页bloc
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  /// Constructor.
  HomeBloc(this._repo) : super(const HomeState.initial()) {
    on<HomeEvent>((event, emit) async {
      switch (event) {
        case _LoadForumInfo():
          await _onLoadForumInfo(emit);
      }
    });
  }

  final HomeRepository _repo;

  Future<void> _onLoadForumInfo(_Emit emit) async {
    emit(const HomeState.loading());

    final forumInfo = await _repo.fetchForumInfo();
    switch (forumInfo) {
      case Left(value: final e):
        emit(HomeState.failure(e: e));
      case Right(value: final v):
        emit(HomeState.success(forumInfoList: v));
    }
  }
}
