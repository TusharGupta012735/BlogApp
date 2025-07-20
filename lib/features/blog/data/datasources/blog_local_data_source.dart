import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:hive/hive.dart';

abstract interface class BlogLocalDataSource {
  void uploadLocalBlogs({required List<BlogModel> blogs});
  List<BlogModel> loadBlogs();
}

class BlogLocalDataSourceImpl implements BlogLocalDataSource {
  final Box box;
  BlogLocalDataSourceImpl({required this.box});

  @override
  List<BlogModel> loadBlogs() {
    List<BlogModel> blogs = [];
    box.read(() {
      for (int i = 0; i < box.length; i++) {
        final blogData = box.get(i.toString());
        if (blogData != null) {
          blogs.add(BlogModel.fromJSON(blogData));
        }
      }
    });
    return blogs;
  }

  @override
  void uploadLocalBlogs({required List<BlogModel> blogs}) {
    box.clear();
    box.write(
      () => {
        for (int i = 0; i < blogs.length; i++)
          {box.put(i.toString(), blogs[i].toJSON())},
      },
    );
  }
}
