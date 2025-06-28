import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hamza/Features/home/cubit/get_user_cubit.dart';
import 'package:hamza/Features/home/cubit/get_user_states.dart';
import 'package:hamza/Features/home/data/get_user_model.dart';
import 'package:hamza/Features/video%20List/presentation/views/video_list_views.dart';
import 'package:hamza/core/responsive/responsive_size.dart';
import 'package:hamza/core/widgets/loading_page.dart';
import 'package:hamza/core/widgets/navigator.dart';

class HomeWidget extends StatefulWidget {
  final String phone;

  const HomeWidget({super.key, required this.phone});

  @override
  State<HomeWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<HomeWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final List<String> items = [
    'Pediatrics',
    'NeuroMedicine',
    'NeuroSurgery',
    'GITMedicine',
    'Urology',
    'Orthopedics',
    'Ophthalmology',
    'Gynecology',
  ];
  List<GetUserModel> builld = [];
  List<String> m = [];
  bool set = true;
  @override
  Widget build(BuildContext context) {
    var course = BlocProvider.of<GetCoursesCubit>(context);
    Future<void> mmm() async {
      await course.getuser(widget.phone);
      await course;
      builld = await course.get;
      m = [
        "${builld[0].a}",
        "${builld[0].b}",
        "${builld[0].c}",
        "${builld[0].d}",
        "${builld[0].e}",
        "${builld[0].f}",
        "${builld[0].g}",
        "${builld[0].h}"
      ];
    }

    mmm();
    // course.getuser(widget.phone);
    // course;
    // Future.delayed(Duration(seconds: 3)).then((value) {
    //   builld = course.get;
    //    m = [
    //   "${builld[0].a}",
    //   "${builld[0].b}",
    //   "${builld[0].c}",
    //   "${builld[0].d}",
    //   "${builld[0].e}",
    //   "${builld[0].f}",
    //   "${builld[0].g}",
    //   "${builld[0].h}"
    // ];
    // if (set == true) {
    //   set=false;
    //   setState(() {

    //   });
    // }
    // },);

    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return BlocBuilder<GetCoursesCubit, GetCourseStates>(
      builder: (context, state) {
        if (state is GetCourseinitState) {
          return LoadingPage();
        } else if (state is GetCourseloading) {
          return LoadingPage();
        } else if (state is GetCourseSuccessful) {
          return ListView.builder(
            itemCount: m.length,
            itemBuilder: (context, index) => m[index] == "false"
                ? Gap(1)
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        
                        navigateToSecondPage(
                            context,
                            VideoListViews(
                              coursename: m[index],
                            ));
                        print(m[index]);
                      },
                      child: Card(
                        elevation: 8,
                        shadowColor: Colors.black54,
                        child: Container(
                          width: width * 0.6,
                          height: height * 0.15,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.shade200),
                          child: Row(
                            children: [
                              Gap(20),
                              Text(
                                m[index],
                                style: TextStyle(
                                    fontSize: ResponsiveSize(
                                            context: context, size: 25)
                                        .size,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Spacer(),
                              Padding(
                                  padding: EdgeInsets.only(right: 15),
                                  child: Icon(Icons.school))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
          );
        } else {
          return Center(
            child: Text("Error"),
          );
        }
      },
    );
  }
}
