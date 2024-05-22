import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:refilc/api/providers/database_provider.dart';
import 'package:refilc/api/providers/user_provider.dart';
import 'package:refilc/helpers/average_helper.dart';
import 'package:refilc/ui/widgets/grade/grade_tile.dart';
import 'package:refilc_kreta_api/models/grade.dart';
import 'package:refilc_kreta_api/models/subject.dart';
import 'package:refilc_kreta_api/providers/grade_provider.dart';
import 'package:refilc_mobile_ui/common/average_display.dart';
import 'package:refilc_mobile_ui/common/bottom_sheet_menu/rounded_bottom_sheet.dart';
import 'package:refilc_plus/ui/mobile/goal_planner/goal_input.dart';
import 'package:refilc_plus/ui/mobile/goal_planner/goal_planner.dart';
import 'package:refilc_plus/ui/mobile/goal_planner/goal_planner_screen.i18n.dart';

class GoalTrackPopup extends StatefulWidget {
  const GoalTrackPopup({super.key, required this.subject});

  final GradeSubject subject;

  static void show(BuildContext context, {required GradeSubject subject}) =>
      showRoundedModalBottomSheet(
        context,
        child: GoalTrackPopup(subject: subject),
        showHandle: true,
      );

  @override
  GoalTrackPopupState createState() => GoalTrackPopupState();
}

class GoalTrackPopupState extends State<GoalTrackPopup> {
  late UserProvider user;
  late DatabaseProvider dbProvider;
  late GradeProvider gradeProvider;

  List<Grade> getSubjectGrades(GradeSubject subject) =>
      gradeProvider.grades.where((e) => e.subject == subject).toList();

  double goalValue = 4.0;
  List<Grade> grades = [];

  Plan? recommended;
  Plan? fastest;
  Plan? selectedRoute;
  List<Plan> otherPlans = [];

  @override
  void initState() {
    super.initState();
    user = Provider.of<UserProvider>(context, listen: false);
    dbProvider = Provider.of<DatabaseProvider>(context, listen: false);
  }

  Future<Map<String, String>> fetchGoalPlans() async {
    return await dbProvider.userQuery.subjectGoalPlans(userId: user.id!);
  }

  Future<Map<String, String>> fetchGoalAverages() async {
    return await dbProvider.userQuery.subjectGoalAverages(userId: user.id!);
  }

  // haha bees lol
  Future<Map<String, String>> fetchGoalBees() async {
    return await dbProvider.userQuery.subjectGoalBefores(userId: user.id!);
  }

  Future<Map<String, String>> fetchGoalPinDates() async {
    return await dbProvider.userQuery.subjectGoalPinDates(userId: user.id!);
  }

  void getGrades() {
    grades = getSubjectGrades(widget.subject).toList();
  }

  @override
  Widget build(BuildContext context) {
    gradeProvider = Provider.of<GradeProvider>(context);

    final currentAvg = GoalPlannerHelper.averageEvals(grades);

    List<Grade> subjectGrades = getSubjectGrades(widget.subject);

    double avg = AverageHelper.averageEvals(subjectGrades);

    return Container(
      padding: const EdgeInsets.only(top: 24.0),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AverageDisplay(
                        average: avg,
                        scale: 1.3,
                      ),
                      const SizedBox(width: 12.0),
                      const Icon(
                        Icons.arrow_forward,
                        size: 24.0,
                      ),
                      const SizedBox(width: 12.0),
                      AverageDisplay(
                        average: goalValue,
                        border: true,
                        dashed: true,
                        scale: 1.3,
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 24.0),
              GoalInput(
                value: goalValue,
                currentAverage: currentAvg,
                onChanged: (v) => setState(() {
                  selectedRoute = null;
                  goalValue = v;
                }),
              ),
              const SizedBox(height: 24.0),
              SizedBox(
                width: double.infinity,
                child: RawMaterialButton(
                  onPressed: () async {
                    if (selectedRoute == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${"pick_route".i18n}...')));
                    }

                    final goalPlans = await fetchGoalPlans();
                    final goalAvgs = await fetchGoalAverages();
                    final goalBeforeGrades = await fetchGoalBees();
                    final goalPinDates = await fetchGoalPinDates();

                    goalPlans[widget.subject.id] = selectedRoute!.dbString;
                    goalAvgs[widget.subject.id] = goalValue.toStringAsFixed(2);
                    goalBeforeGrades[widget.subject.id] =
                        avg.toStringAsFixed(2);
                    goalPinDates[widget.subject.id] =
                        DateTime.now().toIso8601String();
                    // goalPlans[widget.subject.id] = '1,2,3,4,5,';
                    // goalAvgs[widget.subject.id] = '3.69';
                    // goalBeforeGrades[widget.subject.id] = '3.69';
                    // goalPinDates[widget.subject.id] =
                    //     DateTime.now().toIso8601String();

                    await dbProvider.userStore
                        .storeSubjectGoalPlans(goalPlans, userId: user.id!);
                    await dbProvider.userStore
                        .storeSubjectGoalAverages(goalAvgs, userId: user.id!);
                    await dbProvider.userStore.storeSubjectGoalBefores(
                        goalBeforeGrades,
                        userId: user.id!);
                    await dbProvider.userStore.storeSubjectGoalPinDates(
                        goalPinDates,
                        userId: user.id!);

                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop();
                  },
                  fillColor: Theme.of(context).colorScheme.secondary,
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    "track_it".i18n,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
