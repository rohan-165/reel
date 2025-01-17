part of 'reel_bloc.dart';

sealed class ReelState {
  final ItemReelModel itemModel;

  const ReelState({
    required this.itemModel,
  });

  ReelState copyWith({
    ItemReelModel? itemModel,
  }) {
    return ReelStateImpl(
      itemModel: itemModel ?? this.itemModel,
    );
  }
}

final class ReelStateImpl extends ReelState {
  const ReelStateImpl({
    required super.itemModel,
  });

  @override
  ReelStateImpl copyWith({
    ItemReelModel? itemModel,
  }) {
    return ReelStateImpl(
      itemModel: itemModel ?? this.itemModel,
    );
  }
}

final class ReelInitial extends ReelStateImpl {
  ReelInitial()
      : super(
          itemModel: ItemReelModel(),
        );
}
