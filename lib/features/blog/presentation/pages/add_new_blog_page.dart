import 'dart:io';

import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/pick_image.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddNewBlogPage extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const AddNewBlogPage());
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final List<String> selected = [];
  File? image;

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Blog"),
        actions: [
          IconButton(
            onPressed: () {
              // Logic to save the new blog post
            },
            icon: Icon(CupertinoIcons.check_mark_circled),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Column(
            children: [
              image != null
                  ? GestureDetector(
                    onTap: selectImage,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Image.file(
                        image!,
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                  : GestureDetector(
                    onTap: selectImage,
                    child: DottedBorder(
                      options: RectDottedBorderOptions(
                        color: AppPallete.borderColor,
                        dashPattern: [20, 4],
                      ),
                      child: SizedBox(
                        height: 150,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(CupertinoIcons.folder, size: 40),
                              SizedBox(height: 20),
                              Text(
                                "Select an image",
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
              SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                      ['Technology', 'Business', 'Programming', 'Entertainment']
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: GestureDetector(
                                onTap: () {
                                  if (selected.contains(e)) {
                                    selected.remove(e);
                                  } else {
                                    selected.add(e);
                                  }
                                  setState(() {});
                                },
                                child: Chip(
                                  label: Text(e),
                                  color:
                                      selected.contains(e)
                                          ? WidgetStatePropertyAll(
                                            AppPallete.gradient1,
                                          )
                                          : null,
                                  side:
                                      !selected.contains(e)
                                          ? BorderSide(
                                            color: AppPallete.borderColor,
                                          )
                                          : BorderSide.none,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                ),
              ),
              SizedBox(height: 20),
              BlogEditor(
                controller: titleController,
                hintText: "Title for your blog",
              ),
              SizedBox(height: 20),
              BlogEditor(
                controller: contentController,
                hintText: "Content for your blog",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
