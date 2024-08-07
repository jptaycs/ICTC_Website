import 'package:ICTC_Website/models/program.dart';
import 'package:ICTC_Website/models/course.dart';
import 'package:ICTC_Website/pages/desktop/footer.dart';
import 'package:ICTC_Website/pages/mobile/course_card_mobile.dart';
import 'package:ICTC_Website/pages/mobile/program_card_mobile.dart';
import 'package:ICTC_Website/widgets/appBarDesktop.dart';
import 'package:ICTC_Website/widgets/cards/program_card.dart';
import 'package:ICTC_Website/widgets/cards/course_card.dart';
import 'package:ICTC_Website/widgets/drawerDesktop.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProgramPages extends StatefulWidget {
  const ProgramPages({super.key});

  @override
  State<ProgramPages> createState() => _ProgramPagesState();
}

class _ProgramPagesState extends State<ProgramPages> {
  int _currentTabIndex = 0; // 0 for Courses, 1 for Programs

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawerdesktop(),
      appBar: AppBarDesktop(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Color(0xff19306B),
                bottom: TabBar(
                  onTap: (index) {
                    setState(() {
                      _currentTabIndex = index;
                    });
                  },
                  tabs: [
                    Tab(child: Text(
                      'Courses',
                      style: TextStyle(color: Colors.white),
                    ),),
                    Tab(child: Text(
                      'Programs',
                      style: TextStyle(color: Colors.white),
                    ),),
                  ],
                ),
              ),
              body: LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth < 1118) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                            if (_currentTabIndex == 0) // Courses tab selected
                              _buildCoursesMobile(context),
                            if (_currentTabIndex == 1) // Programs tab selected
                              _buildProgramsMobile(context),
                            FooterWidget(),
                          ],
                      ),
                    );
                  } else {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                            if (_currentTabIndex == 0) // Courses tab selected
                              _buildCourses(context),
                            if (_currentTabIndex == 1) // Programs tab selected
                              _buildPrograms(context),
                            FooterWidget(),
                          ],
                      ),
                    );
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget _buildPrograms(context) {
  return Container(
    color: Color(0xfffff0),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Programs",
              style: Theme.of(context).textTheme.bodyLarge),
          SizedBox(height: 50),
          FutureBuilder(
            future: Supabase.instance.client
                .from('program')
                .select()
                .neq('is_hidden', true)
                .withConverter(
                    (data) => data.map((e) => Program.fromJson(e)).toList()),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final programs = snapshot.data as List<Program>;
              programs.sort((a, b) => a.title.compareTo(b.title)); // order

              if (MediaQuery.of(context).size.width < 1450) {
                // ListView for small screen sizes
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: programs.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ProgramCardWidget(program: programs[index]),
                      );
                    },
                  ),
                );
              } else {
                // GridView for larger screen sizes
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 300),
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: programs.length,
                    itemBuilder: (context, index) {
                      return ProgramCardWidget(program: programs[index]);
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    ),
  );
}
Widget _buildCourses(context) {
  final today = DateTime.now();
  return Container(
    color: Color(0xfffff0),
    child: Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 20), // Adjust top padding here
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15), // Adjust top padding for the title
            child: Text(
              "Courses",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          SizedBox(height: 20),
          FutureBuilder(
            future: Supabase.instance.client
                .from('course')
                .select()
                .neq('is_hidden', true)
                .gt('start_date', today.toIso8601String())
                .withConverter(
                    (data) => data.map((e) => Course.fromJson(e)).toList()),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              // Get the list of courses from the snapshot data
              final courses = snapshot.data as List<Course>;

              // Sort courses alphabetically by title
              courses.sort((a, b) => a.title.compareTo(b.title));

              if (MediaQuery.of(context).size.width < 1450) {
                // ListView for small screen sizes
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: courses.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: CourseCard(course: courses[index]),
                      );
                    },
                  ),
                );
              } else {
                // GridView for larger screen sizes
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 300),
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: courses.length,
                    itemBuilder: (context, index) {
                      return CourseCard(course: courses[index]);
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    ),
  );
}


Widget _buildProgramsMobile(context) {
  return Container(
    color: Color(0xfffff0),
    child: Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0), // Adjust top padding here
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 00), // Adjust top padding for the title
            child: Text(
              "Programs",
              style: TextStyle(
                color: Color(0xFF153FAA),
                fontSize: 32,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w700,
                height: 0,
              ),
            ),
          ),
          SizedBox(height: 20),
          FutureBuilder(
            future: Supabase.instance.client
                .from('program')
                .select()
                .neq('is_hidden', true )
                .withConverter(
                    (data) => data.map((e) => Program.fromJson(e)).toList()),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final programs = snapshot.data as List<Program>;
              programs.sort((a, b) => a.title.compareTo(b.title));
              if (MediaQuery.of(context).size.width < 1450) {
                // ListView for small screen sizes
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: programs.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ProgramCardMobileWidget(program: programs[index]),
                      );
                    },
                  ),
                );
              } else {
                // GridView for larger screen sizes
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 300),
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: programs.length,
                    itemBuilder: (context, index) {
                      return ProgramCardMobileWidget(program: programs[index]);
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    ),
  );
}

Widget _buildCoursesMobile(context) {
  final today = DateTime.now();
  return Container(
    color: Color(0xfffff0),
    child: Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0), // Adjust top padding here
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 0), // Adjust top padding for the title
            child: Text(
              "Courses",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          SizedBox(height: 20),
          FutureBuilder(
            future: Supabase.instance.client
                .from('course')
                .select()
                .neq('is_hidden', true)
                .gt('start_date', today.toIso8601String())
                .withConverter(
                    (data) => data.map((e) => Course.fromJson(e)).toList()),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              // Get the list of courses from the snapshot data
              final courses = snapshot.data as List<Course>;

              // Sort courses alphabetically by title
              courses.sort((a, b) => a.title.compareTo(b.title));

              if (MediaQuery.of(context).size.width < 1450) {
                // ListView for small screen sizes
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: courses.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: CourseCardMobile(course: courses[index]),
                      );
                    },
                  ),
                );
              } else {
                // GridView for larger screen sizes
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 300),
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: courses.length,
                    itemBuilder: (context, index) {
                      return CourseCard(course: courses[index]);
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    ),
  );
}

