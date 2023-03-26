import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:calories/data/repositories/repo.dart';
import 'package:calories/modules/blog/blog_controller.dart';
import 'package:calories/widgets/base/base.dart';
import 'package:calories/widgets/text_custom.dart';
import 'package:calories/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:onyxsio_grid_view/onyxsio_grid_view.dart';
import 'package:url_launcher/url_launcher.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({Key? key}) : super(key: key);
  static const String routeName = '/blog';
  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  BlogController blogController = Get.put(BlogController());

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
        actions: [],
        bigTitle: false,
      ),
    );
  }

  Widget _buildBody() {
    return blogController.obx(
      (state) => SafeArea(
        child: OnyxsioGridView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: blogController.listBlogs.length,
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
            child: InkWell(
              onTap: () async {
                final url = Uri.parse('https://vqhapps.blogspot.com/');
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        '$baserUrlMedia${blogController.listBlogs[index]?.image}'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.3),
                      BlendMode.darken,
                    ),
                  ),
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
                      text: blogController.listBlogs[index]?.title ?? '',
                      color: Colors.white,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
