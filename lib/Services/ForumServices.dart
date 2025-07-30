import '../Models/BaseModel.dart';
import '../Models/SocialForumModel.dart';
import '../Utils/Constants.dart';
import '../Utils/restApi.dart';

Future<void> createPost({
  required String title,
  required String description,
  required String photo,
  required Function(SocialForumModel baseModel) onSuccess,
  required Function(String error) onError}) async {
  invokeAsync(
      method: Method.Multipart,
      endPoint: Constants.posts,
      body: {
        'title': title,
        'description': description,
      },
      files: {
        'photo': photo
      },
      onSuccess: (BaseModel basemodel) {
        onSuccess(SocialForumModel.fromJson(basemodel.data));
      },
      onError: (String error) {
        onError(error);
      });
}

Future<void> getPosts({
  required Function(List<SocialForumModel> data) onSuccess,
  required Function(String error) onError}) async {
  invokeAsync(
      method: Method.Get,
      endPoint: Constants.posts,

      onSuccess: (BaseModel basemodel) {
        onSuccess((basemodel.data as List)
            .map((e) => SocialForumModel.fromJson(e))
            .toList());
      },
      onError: (String error) {
        onError(error);
      });
}

Future<void> getPostsDetails({
  required String postId,
  required Function(List<Comments> data) onSuccess,
  required Function(String error) onError}) async {
  invokeAsync(
      method: Method.Get,
      endPoint: "${Constants.posts}/$postId/${Constants.comments}",

      onSuccess: (BaseModel basemodel) {

        onSuccess((basemodel.data as List).map((e) => Comments.fromJson(e)).toList());
      },
      onError: (String error) {
        onError(error);
      });
}
Future<void> postComment({
  required String comment,
  required String postId,
  required Function(BaseModel data) onSuccess,
  required Function(String error) onError}) async {
  invokeAsync(
      method: Method.Post,
      endPoint: "${Constants.posts}/$postId/${Constants.comments}",
body: {
        "content": comment
},
      onSuccess: (BaseModel basemodel) {

        onSuccess(basemodel);
      },
      onError: (String error) {
        onError(error);
      });
}
Future<void> likePost({

  required String postId,
  required Function(BaseModel data) onSuccess,
  required Function(String error) onError}) async {
  invokeAsync(
      method: Method.Post,
      endPoint: "${Constants.posts}/$postId/${Constants.likePost}",
      onSuccess: (BaseModel basemodel) {

        onSuccess(basemodel);
      },
      onError: (String error) {
        onError(error);
      });
}

Future<void> followUnfollow({

  required String postId,
  required Function(BaseModel data) onSuccess,
  required Function(String error) onError}) async {
  invokeAsync(
      method: Method.Post,
      endPoint: "${Constants.followUser}/$postId/${Constants.followPost}",
      onSuccess: (BaseModel basemodel) {

        onSuccess(basemodel);
      },
      onError: (String error) {
        onError(error);
      });
}
