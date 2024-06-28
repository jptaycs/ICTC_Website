import 'package:ICTC_Website/pages/desktop/styles.dart';
import 'package:ICTC_Website/widgets/appBarDesktop.dart';
import 'package:flutter/material.dart';
import 'package:ICTC_Website/models/program.dart';
import 'package:ICTC_Website/pages/desktop/footer.dart';
import 'package:ICTC_Website/widgets/appBarDesktop.dart';
import 'package:ICTC_Website/widgets/cards/program_card.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ICTC_Website/widgets/carousel/carousel.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDesktop(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 1118) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  _buildHeroSmallScreen(context),
                  _buildPrograms(context),
                  FooterWidget(),
                ],
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  _buildHero(context),
                  _buildPrograms(context),
                  FooterWidget(),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

Widget _buildHero(context) {
  return Stack(
    children: [
      Container(
        alignment: Alignment.topLeft,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.8,
        color: Color(0xff19306B),
        child: Padding(
          padding: EdgeInsets.fromLTRB(180, 15, 15, 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "MISSION",
                          style: TextStyle(
                            fontSize: 55,
                            fontWeight: FontWeight.bold,
                            color : Color.fromARGB(255, 255, 200, 73),
                          )
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "ICTC seeks to share in the",
                          style: AppTextStyles.bodyLarge,
                        ),
                        Text(
                          "University mission in achieving",
                          style: AppTextStyles.bodyLarge,
                        ),
                        Text(
                          "academic excellence through",
                          style: AppTextStyles.bodyLarge,
                        ),
                        Text(
                          "developing, designing, and",
                          style: AppTextStyles.bodyLarge,
                        ),
                        Text(
                          "delivering quality ICT programs",
                          style: AppTextStyles.bodyLarge,
                        ),
                        Text(
                          "responsive to the needs of the",
                          style: AppTextStyles.bodyLarge,
                        ),
                        Text(
                          "community.",
                          style: AppTextStyles.bodyLarge,
                        ),
                      ],
                    ),
                  ]),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 155, 0),
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                    Row(
                      children: [
                        Text(
                          "VISION",
                           style: TextStyle(
                           fontSize: 55,
                           fontWeight: FontWeight.bold,
                          color : Color.fromARGB(255, 255, 200, 73),
                          )
                         ),
                          ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                       Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "ICTC seeks to share in the",
                            style: AppTextStyles.bodyLarge,
                          ),
                          Text(
                            "University mission in achieving",
                            style: AppTextStyles.bodyLarge,
                          ),
                          Text(
                            "academic excellence through",
                            style: AppTextStyles.bodyLarge,
                          ),
                          Text(
                            "developing, designing, and",
                            style: AppTextStyles.bodyLarge,
                          ),
                          Text(
                            "delivering quality ICT programs",
                            style: AppTextStyles.bodyLarge,
                          ),
                          Text(
                            "responsive to the needs of the",
                            style: AppTextStyles.bodyLarge,
                          ),
                          Text(
                            "community.",
                            style: AppTextStyles.bodyLarge,
                          ),
                        ],
                      ),
                      
                    ],
                                    ),
                  ),
            ],
          ),
        ),
      ),
      
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/ictc_logo.png',
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width*0.7,
            alignment: Alignment.center,
          ),
        ],
      ),
    ],
  );
}

//mobile
Widget _buildHeroSmallScreen(context) {
  return Container(
    alignment: Alignment.topLeft,
    width: MediaQuery.of(context).size.width,
    height: 750,
    color: Color(0xff19306B),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "BE A ",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              Text("CERTIFIED", style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
          Text(
            "PROFESSIONAL.",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Seize the opportunity to gain a competitive edge by mastering",
                style: Theme.of(context).textTheme.labelSmall,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "essential skills. Unlock new horizons of expertise, from hands-on",
                style: Theme.of(context).textTheme.labelSmall,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "learning experiences to industry-relevant skills. Delve into",
                style: Theme.of(context).textTheme.labelSmall,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "specialized courses with Ateneo ICTC.",
                style: Theme.of(context).textTheme.labelSmall,
              ),
              SizedBox(
                height: 8,
              ),
            ],
          )
        ],
      ),
    ),
  );
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
          Text("Featured Programs",
              style: Theme.of(context).textTheme.bodyLarge),
          SizedBox(height: 50),
          FutureBuilder(
            future: Supabase.instance.client
                .from('program')
                .select()
                .withConverter(
                    (data) => data.map((e) => Program.fromJson(e)).toList()),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final programs = snapshot.data as List<Program>;
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