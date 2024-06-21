import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kdays_client/app.dart';
import 'package:kdays_client/features/home/view/home_page.dart';
import 'package:kdays_client/features/my/view/my_page.dart';

void main() {
  group('root navigation', () {
    // 测试宽度 < 450，窄屏幕
    testWidgets(
      'in narrow screen',
      (tester) async {
        tester.view.physicalSize = const Size(400, 800);
        tester.view.devicePixelRatio = 1;

        await tester.pumpWidget(const App());
        await tester.pumpAndSettle();

        // 窄屏幕上应该在用NavigationBar，而不是NavigationRail
        final navbarFinder = find.byType(NavigationBar);
        expect(navbarFinder, findsOneWidget);
        final navRailFinder = find.byType(NavigationRail);
        expect(navRailFinder, findsNothing);

        // 窄屏幕上应该在用NavigationBar，而不是NavigationRail
        final navDesHomeFinder =
            find.widgetWithText(NavigationDestination, '主页');
        expect(navDesHomeFinder, findsOneWidget);
        final navDesMyFinder = find.widgetWithText(NavigationDestination, '我的');
        expect(navDesMyFinder, findsOneWidget);

        // 默认在主页
        expect(find.byType(HomePage), findsOneWidget);
        // 默认在主页，主页上再点击一次依然应该在主页
        await tester.tap(navDesHomeFinder);
        await tester.pumpAndSettle();
        expect(find.byType(HomePage), findsOneWidget);
        // 点一下我的，在我的里了
        await tester.tap(navDesMyFinder);
        await tester.pumpAndSettle();
        expect(find.byType(HomePage), findsNothing);
        expect(find.byType(MyPage), findsOneWidget);

        addTearDown(tester.view.resetPhysicalSize);
      },
      skip: true,
    );

    // 测试宽度 > 450 宽屏幕
    testWidgets(
      'in wide screen',
      (tester) async {
        tester.view.physicalSize = const Size(1000, 1000);
        tester.view.devicePixelRatio = 1;
        await tester.pumpWidget(const App());
        await tester.pumpAndSettle();

        // 窄屏幕上应该在用NavigationBar，而不是NavigationRail
        final navbarFinder = find.byType(NavigationBar);
        expect(navbarFinder, findsNothing);
        final navRailFinder = find.byType(NavigationRail);
        expect(navRailFinder, findsOneWidget);

        // 窄屏幕上应该在用NavigationBar，而不是NavigationRail
        // FIXME: 这地方找不到
        final navDesHomeFinder = find.byType(
          NavigationRailDestination,
        );
        expect(navDesHomeFinder, findsOneWidget);
        final navDesMyFinder = find.widgetWithText(
          NavigationRailDestination,
          '我的',
        );
        expect(navDesMyFinder, findsOneWidget);

        // 默认在主页
        expect(find.byType(HomePage), findsOneWidget);
        // 默认在主页，主页上再点击一次依然应该在主页
        await tester.tap(navDesHomeFinder);
        await tester.pumpAndSettle();
        expect(find.byType(HomePage), findsOneWidget);
        // 点一下我的，在我的里了
        await tester.tap(navDesMyFinder);
        await tester.pumpAndSettle();
        expect(find.byType(HomePage), findsNothing);
        expect(find.byType(MyPage), findsOneWidget);

        addTearDown(tester.view.resetPhysicalSize);
      },
      skip: true,
    );
  });
}
