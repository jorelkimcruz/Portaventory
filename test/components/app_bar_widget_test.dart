import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:portaventory/components/app_bar_widget.dart';

class _Wrapper extends StatelessWidget {
  const _Wrapper(this.child);

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return child;
  }
}

Widget testableWidget({required Widget child}) {
  return MediaQuery(
    data: const MediaQueryData(),
    child: GetMaterialApp(
      home: Scaffold(body: _Wrapper(child)),
    ),
  );
}

void main() {
  group('Given that an app bar is called', () {
    group('when using default settings', () {
      testWidgets('then it should display app bar with default settings',
          (WidgetTester tester) async {
        await tester.pumpWidget(testableWidget(
          child: const AppBarWidget(
            key: Key('appbarkey'),
            title: 'App bar title',
          ),
        ));

        final finder = find.byKey(const Key('AppBarTitle'));
        expect(finder, findsOneWidget);
        final text = finder.evaluate().single.widget as Text;
        expect(text.data, 'App bar title');
      });
    });

    group('when title is empty', () {
      testWidgets('then it should display app dvr center title',
          (WidgetTester tester) async {
        await tester.pumpWidget(testableWidget(
          child: const AppBarWidget(
            key: Key('appbarkey'),
          ),
        ));

        expect(find.byKey(const Key('AppBarTitleEmpty')), findsOneWidget);
      });
    });
    group('when actions is not empty', () {
      testWidgets('then it should display app bar with actions',
          (WidgetTester tester) async {
        bool value = false;

        await tester.pumpWidget(testableWidget(
          child: AppBarWidget(
            key: const Key('appbarkey'),
            title: 'App bar title',
            actions: [
              IconButton(
                key: const Key('action_button'),
                icon: const Icon(Icons.ac_unit),
                onPressed: () {
                  value = true;
                },
              )
            ],
          ),
        ));
        expect(value, false);
        final finder = find.byKey(const Key('AppBarTitle'));
        expect(finder, findsOneWidget);
        final text = finder.evaluate().single.widget as Text;
        expect(text.data, 'App bar title');
        await tester.tap(find.byKey(const Key('action_button')));

        await tester.pumpAndSettle(); // has an animation
        expect(value, true);
      });
    });
  });
}
