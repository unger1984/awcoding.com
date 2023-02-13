import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:ndialog/ndialog.dart';
import 'package:portfolio/src/domain/entity/work_entity.dart';
import 'package:portfolio/src/domain/repositories/work_repository.dart';
import 'package:portfolio/src/presentation/blocs/work_bloc.dart';
import 'package:portfolio/src/presentation/styles/styles.dart';
import 'package:portfolio/src/presentation/widgets/common/main_menu.dart';
import 'package:portfolio/src/presentation/widgets/portfolio/portfolio_popup_desktop.dart';
import 'package:portfolio/src/presentation/widgets/portfolio/portfolio_popup_mobile.dart';
import 'package:portfolio/src/utils/const.dart';

@immutable
class PortfolioPage extends StatefulWidget {
  const PortfolioPage({Key? key}) : super(key: key);

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final workBLoC = WorkBLoC(workRepository: GetIt.instance<WorkRepository>());

  @override
  void dispose() {
    workBLoC.close();
    super.dispose();
  }

  void showPopup(BuildContext ctx, WorkEntity work) {
    NDialog(
      dialogStyle: DialogStyle(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        backgroundColor: Color(0xff1d2428),
        contentPadding: EdgeInsets.zero,
      ),
      content: Builder(
        builder: (ctx2) {
          if (MediaQuery.of(ctx2).size.width <= 600) {
            return PortfolioPopupMobile(work: work);
          }

          return PortfolioPopupDesktop(work: work);
        },
      ),
    ).show<dynamic>(
      context,
      transitionType: DialogTransitionType.Bubble,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WorkBLoC>.value(
      value: workBLoC,
      child: Container(
        decoration: BoxDecoration(
          gradient: gradientRadial,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints.tightFor(width: 800),
                child: LayoutBuilder(
                  builder: (context, constrain) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        if (constrain.maxWidth > widthMobile)
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Center(child: MainMenu()),
                          ),
                        SizedBox(height: 20),
                        BlocBuilder<WorkBLoC, WorkState>(
                          builder: (context, state) => state.map(
                            loading: (_) => Center(child: CircularProgressIndicator()),
                            success: (st) => Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: st.list
                                  .map(
                                    (work) => GestureDetector(
                                      onTap: () => showPopup(context, work),
                                      child: MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                                          color: Color(0xff1d2428).withOpacity(0.5),
                                          child: Column(
                                            children: [
                                              Text(
                                                work.created,
                                                style: TextStyle(color: Colors.white),
                                              ),
                                              Image.network(
                                                '/files/${work.img}',
                                                fit: BoxFit.cover,
                                                width: 150,
                                                height: 150,
                                              ),
                                              Text(
                                                work.title,
                                                style: TextStyle(color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
