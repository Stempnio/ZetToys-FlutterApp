import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_joy_ble/bloc/app_bloc.dart';
import 'package:flutter_joy_ble/l10n/l10n.dart';
import 'package:flutter_joy_ble/view/view.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => AppBloc()..add(const AppEvent.discoverDevices()),
        child: MaterialApp(
          title: context.l10n.appTitle,
          debugShowCheckedModeBanner: false,
          home: const _AppBody(),
          theme: ThemeData.dark(),
        ),
      );
}

class _AppBody extends StatelessWidget {
  const _AppBody();

  @override
  Widget build(BuildContext context) => BlocBuilder<AppBloc, AppState>(
        builder: (context, state) => switch (state) {
          Initial() => const InitialView(),
          DiscoveringDevices() => const DiscoveringDevicesView(),
          Connecting() => const ConnectingView(),
          Connected() => ConnectedView(state: state),
          Disconnected(:final devices) => DisconnectedView(devices: devices),
          NoDevicesFound() => const NoDevicesFoundView(),
          Error() => const ErrorView(),
        },
      );
}