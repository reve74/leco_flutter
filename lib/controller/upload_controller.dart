import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leco_flutter/controller/auth_controller.dart';
import 'package:leco_flutter/model/post.dart';
import 'package:leco_flutter/repository/post_repository.dart';
import 'package:leco_flutter/screens/main/app.dart';
import 'package:leco_flutter/screens/main/components/message_popup.dart';
import 'package:leco_flutter/screens/main/home/create/upload_description.dart';
import 'package:leco_flutter/screens/main/home/review_screen.dart';
import 'package:leco_flutter/util/data_util.dart';
import 'package:photo_manager/photo_manager.dart';

class UploadController extends GetxController {
  // final title = TextEditingController();
  // final content = TextEditingController();
  // File? image;
  // final picker = ImagePicker();
  //
  // Future getImageGallery() async {
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     image = File(pickedFile.path);
  //   } else {
  //     print('이미지를 선택해주세요');
  //   }
  // }
  //
  // Future getCameraImage() async {
  //   final pickedFile = await picker.pickImage(source: ImageSource.camera);
  //   if (pickedFile != null) {
  //     image = File(pickedFile.path);
  //   } else {
  //     print('이미지를 선택해주세요');
  //   }
  // }
  var albums = <AssetPathEntity>[]; // AssetPathEntity?
  RxString headerTitle = ''.obs;
  RxList<AssetEntity> imageList = <AssetEntity>[].obs; // AssetEntity?
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  Rx<AssetEntity> selectedImage = AssetEntity(
    id: '0',
    typeInt: 0,
    width: 0,
    height: 0,
  ).obs;

  File? filteredImage;
  Post? post;

  @override
  void onInit() {
    super.onInit();
    post = Post.init(AuthController.to.firestoreUser.value);
    _loadPhoto();
  }

  void _loadPhoto() async {
    // 사진 불러오기
    var result = await PhotoManager.requestPermissionExtend();
    if (result.isAuth) {
      albums = await PhotoManager.getAssetPathList(
        type: RequestType.image,
        filterOption: FilterOptionGroup(
          imageOption: const FilterOption(
            sizeConstraint: SizeConstraint(minHeight: 100, minWidth: 100),
          ),
          orders: [
            const OrderOption(type: OrderOptionType.createDate, asc: false),
            // 최신이미지 먼저 보기
          ],
        ),
      );
      _loadData();
    } else {
      // message
    }
  }

  void _loadData() async {
    changeAlbum(albums.first);
  }

  Future<void> _pagingPhotos(AssetPathEntity album) async {
    // 사진 불러오기 페이징
    imageList.clear();
    var photos = await album.getAssetListPaged(0, 30);
    imageList.addAll(photos);
    changeSelectedImage(imageList.first);
  }

  changeSelectedImage(AssetEntity image) {
    selectedImage(image);
  }

  void changeAlbum(AssetPathEntity album) async {
    headerTitle(album.name);
    await _pagingPhotos(album); // 이미지 파일이 많을경우 별도로 페이징 처리
  }

  void gotoImage() async {
    var file = await selectedImage.value.file;

    if (file != null) {
      filteredImage = file;
      Get.to(() => UploadDescription());
    }
  }

  void unfocusKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void uploadPost() {
    unfocusKeyboard();
    var filename = DataUtil.makeFilePath();
    var task = uploadXFile(filteredImage!,
        '${AuthController.to.firestoreUser.value.uid}/$filename');
    if (task != null) {
      task.snapshotEvents.listen(
        (event) async {
          if (event.bytesTransferred == event.totalBytes &&
              event.state == TaskState.success) {
            var downloadUrl = await event.ref.getDownloadURL();
            var updatedPost = post!.copyWith(
              image: downloadUrl,
              title: title.text,
              content: content.text,
            );
            _submitPost(updatedPost);
          }
        },
      );
    }
  }

  UploadTask uploadXFile(File file, String filename) {
    var f = File(file.path);
    var ref = FirebaseStorage.instance.ref().child('posts').child(filename);
    final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': file.path});
    return ref.putFile(f, metadata);
    //users/{uid}/profile.jpg or profile.png
  }

  void _submitPost(Post postData) async {
    await PostRepository.updatePost(postData);
    showDialog(
      context: Get.context!,
      builder: (context) => MessagePopUp(
        title: '포스트',
        message: '포스팅이 완료 되었습니다.',
        okCallback: () {
          // Get.until((route) => Get.currentRoute == '/');
          Get.to(() => App());
        },
      ),
    );
  }
}
