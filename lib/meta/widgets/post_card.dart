import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:try_me/meta/models/post.dart';

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
    );
  }
}
