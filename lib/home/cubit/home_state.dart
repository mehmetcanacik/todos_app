part of 'home_cubit.dart';

enum HomeTab { todos, stats }

final class HomeState extends Equatable {
  final HomeTab tab;

  const HomeState({
    this.tab = HomeTab.todos,
  });
  @override
  List<Object?> get props => [tab];
}
