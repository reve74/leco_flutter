import 'package:get/get.dart';
import 'package:leco_flutter/model/post.dart';
import 'package:leco_flutter/repository/post_repository.dart';

class ReviewController extends GetxController {
  final PostRepository _postRepository = PostRepository();
  final postList = <Post>[].obs;
  final myPostList = <Post>[].obs;

  @override
  void onInit() {
    super.onInit();
    // loadFeedList();
    findAll();
  }

  // void loadFeedList() async {
  //   var feedList = await PostRepository.loadFeedList();
  //   postList.addAll(feedList);
  // }

  Future<List<Post>> findAll() async {
    List<Post> postList = await _postRepository.findAll();
    this.postList.value = postList;
    return postList;
  }

  Future<List<Post>> findMyPost() async {
    List<Post> myPostList = await _postRepository.findMyPost();
    this.myPostList.value = myPostList;
    return myPostList;
  }
}
