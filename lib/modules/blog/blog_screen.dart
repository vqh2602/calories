import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:calories/widgets/base/base.dart';
import 'package:calories/widgets/text_custom.dart';
import 'package:calories/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:onyxsio_grid_view/onyxsio_grid_view.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({Key? key}) : super(key: key);
  static const String routeName = '/blog';
  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  @override
  void initState() {
    // Future.delayed(const Duration(seconds: 4), () {
    //  // Get.offAndToNamed(HomeScreen.routeName);
    //   Get.offAndToNamed(SignupScreen.routeName);
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildBody(
      context: context,
      body: _buildBody(),
      appBar: appBarCustom(
        title: 'Danh sách bài đăng',
        isPadding: false,
        marginTop: 0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(LucideIcons.x)),
        mainAxisAlignment: MainAxisAlignment.start,
        actions: [
        ],
        bigTitle: false,
      ),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: OnyxsioGridView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: 21,
        physics: const BouncingScrollPhysics(),
        staggeredTileBuilder: (index) =>
            OnyxsioStaggeredTile.extent(2, index.isEven ? 200 : 300),
        crossAxisCount: 4,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        shrinkWrap: true,
        itemBuilder: (context, index) => OnyxsioGridTile(
          index: index,
          heightList: const [],
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'https://cdn.pixabay.com/photo/2017/12/03/18/04/christmas-balls-2995437_960_720.jpg'),
                  fit: BoxFit.cover),
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: BlurryContainer(
                blur: 5,
                elevation: 0,
                color: Colors.white.withOpacity(0.3),
                padding: const EdgeInsets.all(8),
                borderRadius: BorderRadius.zero,
                child: textBodyMedium(
                    text: 'Aaaa aaa aaa aa bài tập mông hiệu quả aaa',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
