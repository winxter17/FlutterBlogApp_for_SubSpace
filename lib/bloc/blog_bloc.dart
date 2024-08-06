import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blog_explorer/services/api_service.dart';
import 'package:blog_explorer/bloc/blog_event.dart';
import 'package:blog_explorer/bloc/blog_state.dart';
import 'package:blog_explorer/models/blog.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final ApiService apiService;

  BlogBloc(this.apiService) : super(BlogInitial()) {
    on<FetchBlogs>((event, emit) async {
      emit(BlogLoading());
      try {
        final List<dynamic> blogList = await apiService.fetchBlogs();
        final blogs = blogList.map((json) => Blog.fromJson(json)).toList();
        emit(BlogLoaded(blogs));
      } catch (e) {
        emit(BlogError(e.toString()));
      }
    });
  }
}
