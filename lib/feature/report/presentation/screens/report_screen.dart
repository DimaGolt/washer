import 'package:bloc_widgets/bloc_widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:washer/app/router.dart';
import 'package:washer/feature/report/domain/entities/report.dart';
import 'package:washer/feature/report/presentation/bloc/report_bloc.dart';
import 'package:washer/shared/domain/entities/laundromat_entity.dart';
import 'package:washer/shared/domain/repositories/auth_repository.dart';
import 'package:washer/shared/widgets/appbar_wave.dart';
import 'package:washer/shared/widgets/washer_scroll_view.dart';

import '../../../../shared/domain/entities/dorm_entity.dart';
import '../../../../shared/domain/entities/floor_entity.dart';
import '../../../../shared/widgets/styled_dropdown_button.dart';

@RoutePage()
class ReportScreen extends BlocConsumerWidget<ReportBloc, ReportState> {
  const ReportScreen({super.key});

  @override
  void onMount(ReportBloc bloc) {
    super.onMount(bloc);
    bloc.add(ReportStart());
  }

  @override
  Widget buildWithState(context, bloc, state) {
    var theme = Theme.of(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const AppBarWave(
        title: 'report_machine',
      ),
      floatingActionButton: _fab(context, bloc, state),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: WasherScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'place',
                style: TextStyle(color: theme.primaryColor, fontSize: 32),
              ).tr(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 17.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 24.0),
                    child: Column(
                      children: [
                        StyledDropdownButton<Dorm>(
                          selectedValue: state.selectedDorm,
                          values: state.dorms
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e.name),
                                  ))
                              .toList(),
                          onChanged: state.status != ReportStatus.initial
                              ? (val) {
                                  if (val != null && val != state.selectedDorm) {
                                    bloc.add(ReportPickDorm(val));
                                  }
                                }
                              : null,
                          hintText: 'choose_dorm'.tr(),
                          isPrimary: true,
                        ),
                        StyledDropdownButton<Floor>(
                          selectedValue: state.selectedFloor,
                          values: state.floors
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: const Text('floor').tr(args: [e.level.toString()]),
                                  ))
                              .toList(),
                          onChanged: state.selectedDorm != null
                              ? (val) {
                                  if (val != null && val != state.selectedFloor) {
                                    bloc.add(ReportPickFloor(val));
                                  }
                                }
                              : null,
                          hintText: 'choose_floor'.tr(),
                          isPrimary: true,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'machine_nr',
                                style: TextStyle(
                                  color: theme.primaryColor,
                                  fontSize: 24,
                                ),
                              ).tr(args: ['']),
                              Container(
                                height: 42,
                                width: 120,
                                decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x7FA3A3A3),
                                    ),
                                    BoxShadow(
                                        color: Colors.white,
                                        blurRadius: 10,
                                        spreadRadius: -1,
                                        blurStyle: BlurStyle.inner),
                                  ],
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: StyledDropdownButton<Laundromat>(
                                  selectedValue: state.selectedLaundromat,
                                  values: state.laundromats
                                      .map((e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(e.number!.toString()),
                                          ))
                                      .toList(),
                                  onChanged: state.selectedFloor != null
                                      ? (val) {
                                          if (val != null && val != state.selectedLaundromat) {
                                            bloc.add(ReportPickMachine(val));
                                          }
                                        }
                                      : null,
                                  hintText: '',
                                  isExpanded: false,
                                  isTransparent: true,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'what_broke',
                  style: TextStyle(color: theme.primaryColor, fontSize: 24),
                ).tr(),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Transform.scale(
                            scale: 1.5,
                            child: Checkbox(
                                value: !state.descriptionEnabled,
                                side: MaterialStateBorderSide.resolveWith(
                                  (states) => BorderSide(width: 1.0, color: theme.primaryColor),
                                ),
                                shape: const CircleBorder(),
                                onChanged: (_) {
                                  bloc.add(const ReportSwitchDesc());
                                }),
                          ),
                          Text(
                            'not_sure',
                            style: TextStyle(color: theme.primaryColor, fontSize: 20),
                          ).tr(),
                        ],
                      ),
                      Container(
                        height: 320,
                        decoration: BoxDecoration(
                          color: state.descriptionEnabled
                              ? const Color(0xBAEBEBEB)
                              : const Color(0xBAEBEBEB),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: TextField(
                          maxLines: null,
                          expands: true,
                          enabled: state.descriptionEnabled,
                          onChanged: (val) {
                            bloc.add(ReportUpdateDescription(val));
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText: 'describe_issue'.tr(),
                              hintStyle: TextStyle(
                                  color: state.descriptionEnabled
                                      ? theme.primaryColor
                                      : const Color(0x4A6896AD))),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _fab(BuildContext context, ReportBloc bloc, ReportState state) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
        child: Container(
          constraints: const BoxConstraints(minWidth: double.infinity, maxHeight: 58),
          child: ElevatedButton(
            onPressed: state.readyToReport
                ? () {
                    bloc.add(ReportSend(
                        Report(
                            laundromat: state.selectedLaundromat!,
                            description: state.description,
                            timestamp: DateTime.now()),
                        context.read<AuthRepository>().user!.uid));
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: const Text('report_success').tr()));
                  }
                : null,
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFF86666)),
            child: Center(
              child: const Text(
                'report',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ).tr(),
            ),
          ),
        ),
      );
}
