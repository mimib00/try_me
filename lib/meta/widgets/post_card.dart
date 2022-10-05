import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:try_me/meta/models/post.dart';
import 'package:try_me/meta/utils/constants.dart';
import 'package:try_me/meta/widgets/blurry_background.dart';
import 'package:try_me/meta/widgets/custom_button.dart';

class PostCard extends StatelessWidget {
  final Post post;
  const PostCard({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: GestureDetector(
        onTap: () {
          Get.dialog(PostDetails(post: post));
        },
        child: Card(
          elevation: 5,
          shadowColor: Colors.black45,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: post.owner.photo,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(180),
                  child: CachedNetworkImage(
                    imageUrl: post.owner.photo,
                    fit: BoxFit.cover,
                    width: 40,
                    height: 40,
                  ),
                ),
                title: Text(
                  post.name,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                subtitle: Text(
                  "von ${post.owner.name}",
                ),
                trailing: GestureDetector(
                  onTap: () {},
                  child: const Icon(Icons.favorite_outline),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PostDetails extends StatelessWidget {
  final Post post;
  const PostDetails({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const BluryBackground()),
        ),
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 80),
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.more_horiz_rounded,
                            color: ksecondaryColor,
                            size: 35,
                          ),
                        ),
                      ],
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                        imageUrl: post.owner.photo,
                        fit: BoxFit.cover,
                        width: 70.w,
                        height: 50.h,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                post.name,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.favorite,
                                  color: kprimaryColor,
                                  size: 35,
                                ),
                              ),
                            ],
                          ),
                          Visibility(
                            visible: post.notes.isNotEmpty,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  post.notes,
                                  style: Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: post.size.isNotEmpty,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Größe",
                                  style: Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  post.size,
                                  style: Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: post.brand.isNotEmpty,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Marke",
                                  style: Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  post.brand,
                                  style: Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(180),
                                child: CachedNetworkImage(
                                  imageUrl: post.owner.photo,
                                  fit: BoxFit.cover,
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                post.owner.name,
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          const CustomButton(
                            child: Text("Anfragen"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
