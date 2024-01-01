import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_app/home/cubit/home_cubit.dart';
import 'package:todos_app/todos/view/todos_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) => HomeCubit(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab = context.select<HomeCubit, HomeTab>((c) => c.state.tab);

    return Scaffold(
      body: IndexedStack(
        index: selectedTab.index,
        children: [
          const TodosPage(),
          // Scaffold(
          //   appBar: AppBar(title: const Text('Page 1')),
          // ),
          Scaffold(
            appBar: AppBar(title: const Text('Page 2')),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _HomeTabButton(
              value: HomeTab.todos,
              groupValue: selectedTab,
              icon: const Icon(Icons.list_rounded),
            ),
            _HomeTabButton(
              value: HomeTab.stats,
              groupValue: selectedTab,
              icon: const Icon(Icons.show_chart_rounded),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeTabButton extends StatelessWidget {
  const _HomeTabButton({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.icon,
  }) : super(key: key);

  final HomeTab value;
  final HomeTab groupValue;
  final Widget icon;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => context.read<HomeCubit>().setTab(value),
      iconSize: 32,
      color: groupValue != value ? null : Colors.teal,
      icon: icon,
    );
  }
}
