import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../assets.dart';
import '../../../constants/constants.dart';
import '../../../core/platform/network_info.dart';
import '../../../injection_container.dart';


class MainPage extends StatelessWidget {
  const MainPage({
    Key? key,
    required this.navigationShell,
  }) : super(
            key: key ?? const ValueKey<String>('ScaffoldWithNestedNavigation'));
  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 450) {
        return ScaffoldWithNavigationBar(
          body: navigationShell,
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: _goBranch,
        );
      } else {
        return ScaffoldWithNavigationRail(
          body: navigationShell,
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: _goBranch,
        );
      }
    });
  }
}

class ScaffoldWithNavigationBar extends StatefulWidget {
  const ScaffoldWithNavigationBar({
    super.key,
    required this.body,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });
  final Widget body;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  State<ScaffoldWithNavigationBar> createState() =>
      _ScaffoldWithNavigationBarState();
}

class _ScaffoldWithNavigationBarState extends State<ScaffoldWithNavigationBar> {
  late final StreamSubscription subcription;
  final NetworkInfo networkInfo = sl();
  @override
  void initState() {
    super.initState();
    subcription = networkInfo.watchConnection.listen(_showDialog);
  }

  void _showDialog(bool isConnected) async {
    if (!isConnected) {
      Future.delayed(
          Duration.zero,
          () => showDialog(
              context: context,
              builder: (context) => const AlertDialog(
                    content: Text("Отсутсвует подключение к интернету"),
                  )));
      await Future.delayed(
          const Duration(seconds: 3), () => Navigator.pop(context));
    }
  }

  @override
  void dispose() {
    subcription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: widget.body,
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(IconAseet.home)),
              label: Constants.main,
            ),
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage(IconAseet.search)),
                label: Constants.search),
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage(IconAseet.favorite)),
                label: Constants.favorites),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(IconAseet.user)),
              label: Constants.profile,
            ),
          ],
          currentIndex: widget.selectedIndex,
          onTap: widget.onDestinationSelected,
        ));
  }
}

class ScaffoldWithNavigationRail extends StatelessWidget {
  const ScaffoldWithNavigationRail({
    super.key,
    required this.body,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });
  final Widget body;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: selectedIndex,
            onDestinationSelected: onDestinationSelected,
            labelType: NavigationRailLabelType.all,
            destinations: const <NavigationRailDestination>[
              NavigationRailDestination(
                label: Text('Section A'),
                icon: Icon(Icons.home),
              ),
              NavigationRailDestination(
                label: Text('Section B'),
                icon: Icon(Icons.settings),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          // This is the main content.
          Expanded(
            child: body,
          ),
        ],
      ),
    );
  }
}

class InternetConnectionFailure extends StatefulWidget {
  const InternetConnectionFailure({super.key});

  @override
  State<InternetConnectionFailure> createState() =>
      _InternetConnectionFailureState();
}

class _InternetConnectionFailureState extends State<InternetConnectionFailure> {
  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      title: Text('Отсутсвует подключение к интернету'),
    );
  }
}
