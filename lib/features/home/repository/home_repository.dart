import 'package:fpdart/fpdart.dart';
import 'package:kdays_client/constants/api/forum.dart';
import 'package:kdays_client/features/home/exception/exception.dart';
import 'package:kdays_client/features/home/models/models.dart';
import 'package:kdays_client/instance.dart';
import 'package:kdays_client/shared/models/server_resp.dart';
import 'package:kdays_client/shared/providers/net_client_provider/net_client_provider.dart';
import 'package:kdays_client/utils/logger.dart';

extension _ServerRespToExceptionExt on ServerResp {
  /// 将[ServerResp]转化成[HomeException]
  ///
  /// 调用者需要仅在确实有错误的情况下调用该方法，否则可能会将没有报错的响应解读为报错。
  HomeException toException() => switch (code) {
        _ => HomeException.unknown(code: code, message: message),
      };
}

/// 主页的repo
///
/// 获取主页用到的数据，不一定都是板块的，也包含用户信息等其他数据
final class HomeRepository with LoggerMixin {
  /// Constructor.
  HomeRepository(this._netClientProvider);

  final NetClientProvider _netClientProvider;

  /// 拉取论坛所有的板块的信息
  Future<Either<HomeException, List<ForumInfoModel>>> fetchForumInfo() async {
    final state = await _netClientProvider.getClient().postForum(
      ForumApi.forumList,
      // 获取全部的论坛信息，parent必定填0
      {'parent': '0'},
    );

    switch (state) {
      case Left(value: final e):
        return Left(
          HomeException.networkError(
            code: e.code,
            message: e.message,
          ),
        );
      case Right(value: final v):
        final resp = ServerResp.fromJson(v.data as Map<String, dynamic>);
        if (!resp.ok) {
          return Left(resp.toException());
        }

        final List<ForumInfoModel> forumInfoList;

        switch (resp.data) {
          case <String, dynamic>{'items': final List<dynamic> listData}:
            forumInfoList = listData
                .map((e) => e as Map<String, dynamic>)
                .map(ForumInfoModel.fromJson)
                .toList();
            return Right(forumInfoList);
          case _:
            talker.error('unrecognized forum info list format: ${resp.data}');
            return const Left(HomeException.invalidReply());
        }
    }
  }
}
