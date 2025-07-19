import 'package:blog_app/core/utils/calculate_reading_time.dart';
import 'package:blog_app/core/utils/format_date.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:flutter/material.dart';

class BlogViewerPage extends StatelessWidget {
  final Blog blog;
  static route(Blog blog) =>
      MaterialPageRoute(builder: (context) => BlogViewerPage(blog: blog));
  const BlogViewerPage({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Scrollbar(
          thickness: 1,
          interactive: true,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blog.title,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 6),
                Text(
                  '~By ${blog.posterName ?? "Unknown"}',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                SizedBox(height: 13),
                Text(
                  '${formatDateByDMMMMYYYY(blog.updatedAt)} . ${calculateReadngTime(blog.content)} min read',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                SizedBox(height: 13),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    blog.imageUrl,
                    fit: BoxFit.cover,
                    color: const Color.fromARGB(213, 255, 255, 255),
                    colorBlendMode: BlendMode.colorBurn,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  blog.content,
                  style: const TextStyle(fontSize: 16, height: 1.9),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
