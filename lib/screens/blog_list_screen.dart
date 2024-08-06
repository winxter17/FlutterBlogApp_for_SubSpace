import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blog_explorer/bloc/blog_bloc.dart';
import 'package:blog_explorer/bloc/blog_event.dart';
import 'package:blog_explorer/bloc/blog_state.dart';
import 'package:blog_explorer/models/blog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'blog_detail_screen.dart';

class BlogListScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    //BlocProvider.of<BlogBloc>(context).add(FetchBlogs());
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black12,
        title: Text('Subspace',style: TextStyle(color: Colors.white),),
        elevation: 4,
      ),
      body: BlocBuilder<BlogBloc, BlogState>(
        builder: (context, state) {
          if (state is BlogLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is BlogLoaded) {
            return ListView.builder(
              itemCount: state.blogs.length,
              itemBuilder: (context, index) {
                final Blog blog = state.blogs[index];
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlogDetailScreen(blog: blog),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(16)
                          ),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16.0),
                                child: CachedNetworkImage(
                                  imageUrl: blog.imageUrl,
                                  placeholder: (context, url) => CircularProgressIndicator(),
                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Text(blog.title,style: TextStyle(color: Colors.white,fontSize: 20),), // Adjust this if you have more content
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          } else if (state is BlogError) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text('No blogs available',style: TextStyle(color: Colors.white),));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<BlogBloc>(context).add(FetchBlogs());
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
