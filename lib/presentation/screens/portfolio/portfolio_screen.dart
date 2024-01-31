import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:ndialog/ndialog.dart';
import 'package:portfolio/domain/entity/work_entity.dart';
import 'package:portfolio/domain/repositories/work_repository.dart';
import 'package:portfolio/presentation/blocs/work_bloc.dart';
import 'package:portfolio/presentation/common/main_menu.dart';
import 'package:portfolio/presentation/common/main_wrapper.dart';
import 'package:portfolio/presentation/screens/portfolio/portfolio_popup_desktop.dart';
import 'package:portfolio/presentation/screens/portfolio/portfolio_popup_mobile.dart';
import 'package:portfolio/utils/const.dart';

@immutable
@RoutePage()
class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  final _workBLoC = WorkBLoC(workRepository: GetIt.instance<WorkRepository>());

  @override
  void dispose() {
    unawaited(_workBLoC.close());
    super.dispose();
  }

  void _handleShowPopup(WorkEntity work) {
    unawaited(NDialog(
      dialogStyle: DialogStyle(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        backgroundColor: const Color(0xff1d2428),
        contentPadding: EdgeInsets.zero,
      ),
      content: Builder(
        builder: (ctx2) {
          return (MediaQuery.sizeOf(ctx2).width <= 600)
              ? PortfolioPopupMobile(work: work)
              : PortfolioPopupDesktop(work: work);
        },
      ),
    ).show(context, transitionType: DialogTransitionType.Bubble));
  }

  @override
  Widget build(BuildContext context) {
    return MainWrapper(
      child: BlocProvider<WorkBLoC>.value(
        value: _workBLoC,
        child: Container(
          decoration: const BoxDecoration(gradient: Consts.gradientRadial),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints.tightFor(width: 800),
                  child: LayoutBuilder(
                    builder: (context, constrain) => Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        if (constrain.maxWidth > Consts.widthMobile)
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Center(child: MainMenu(locale: Intl.getCurrentLocale())),
                          ),
                        const SizedBox(height: 20),
                        BlocBuilder<WorkBLoC, WorkState>(
                          builder: (context, state) => switch (state) {
                            SuccessWorkState(:List<WorkEntity> list) => Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: list
                                    .map(
                                      (work) => GestureDetector(
                                        onTap: () => _handleShowPopup(work),
                                        child: MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                                            color: const Color(0xff1d2428).withOpacity(0.5),
                                            child: Column(
                                              children: [
                                                Text(
                                                  work.created,
                                                  style: const TextStyle(color: Colors.white),
                                                ),
                                                Image.network(
                                                  '/files/${work.img}',
                                                  semanticLabel: work.img,
                                                  fit: BoxFit.cover,
                                                  width: 150,
                                                  height: 150,
                                                ),
                                                Text(
                                                  work.title,
                                                  style: const TextStyle(color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            _ => const Center(child: CircularProgressIndicator()),
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
