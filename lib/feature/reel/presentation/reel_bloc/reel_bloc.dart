import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reel/core/local_storage/hive_data.dart';
import 'package:reel/core/services/service_locator.dart';
import 'package:reel/feature/reel/domain/model/comment_model.dart';
import 'package:reel/feature/reel/domain/model/item_reel_model.dart';
import 'package:reel/feature/reel/domain/model/like_model.dart';

part 'reel_event.dart';
part 'reel_state.dart';

class ReelBloc extends Bloc<ReelEvent, ReelState> {
  ReelBloc() : super(ReelInitial()) {
    on<ReelEvent>((event, emit) {});

    /// Reel Reset
    on<ReelRestartEvent>((event, emit) => emit(ReelInitial()));

    on<ReelStartEvent>((event, emit) async {
      ItemReelModel? saveData =
          await getIt<HiveData>().getReelData(key: event.url);
      ItemReelModel currentItem = saveData ?? state.itemModel;

      emit(
        state.copyWith(
          itemModel: currentItem.copyWith(
            reelUrl: event.url,
          ),
        ),
      );
    });

    /// Like Event

    on<ReelLikeEvent>((event, emit) async {
      ItemReelModel currentItem = state.itemModel;
      LikeModel? likeModel = currentItem.likeUrl;
      if (likeModel?.isLike ?? false) {
        emit(
          state.copyWith(
            itemModel: currentItem.copyWith(
              likeUrl: LikeModel(
                isLike: false,
                likeCount: 0,
              ),
            ),
          ),
        );
        await getIt<HiveData>().saveReelData(
            key: currentItem.reelUrl ?? '', itemModel: state.itemModel);
      } else {
        emit(
          state.copyWith(
            itemModel: currentItem.copyWith(
              likeUrl: LikeModel(
                isLike: true,
                likeCount: 1,
              ),
            ),
          ),
        );
        await getIt<HiveData>().saveReelData(
            key: currentItem.reelUrl ?? '', itemModel: state.itemModel);
      }
    });

    /// Add Comment
    on<ReelCommentEvent>((event, emit) async {
      ItemReelModel currentItem = state.itemModel;
      List<CommentModel> commentList = currentItem.commentUrl ?? [];
      commentList.add(CommentModel(
        comment: event.comment,
        userName: event.userName,
        commentTime: event.date,
        userProfilePic: event.userProfile,
      ));

      emit(
        state.copyWith(
          itemModel: currentItem.copyWith(
            commentUrl: commentList,
          ),
        ),
      );
      await getIt<HiveData>().saveReelData(
          key: state.itemModel.reelUrl ?? '', itemModel: state.itemModel);
    });
  }
}
