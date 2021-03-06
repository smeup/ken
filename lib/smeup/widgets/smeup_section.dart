import 'package:flutter/material.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/models/widgets/smeup_section_model.dart';
import 'package:ken/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:ken/smeup/services/smeup_dynamism_service.dart';
import 'package:ken/smeup/services/smeup_log_service.dart';
import 'package:ken/smeup/services/smeup_variables_service.dart';
import 'package:ken/smeup/widgets/smeup_not_available.dart';
import 'package:ken/smeup/widgets/smeup_wait.dart';
import 'package:ken/smeup/widgets/smeup_widget_state_mixin.dart';
import 'smeup_component.dart';

class SmeupSection extends StatefulWidget {
  final SmeupSectionModel smeupSectionModel;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState>? formKey;
  final dynamic parentForm;

  SmeupSection(
      this.smeupSectionModel, this.scaffoldKey, this.formKey, this.parentForm);

  @override
  _SmeupSectionState createState() => _SmeupSectionState();
}

class _SmeupSectionState extends State<SmeupSection>
    with TickerProviderStateMixin, SmeupWidgetStateMixin {
  var _tabController;

  @override
  void initState() {
    _tabController = TabController(
        length: widget.smeupSectionModel.components!.length,
        vsync: this,
        initialIndex: widget.smeupSectionModel.selectedTabIndex!);

    _tabController.addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    _onTabChanged(_tabController.index);
  }

  @override
  void dispose() {
    _tabController.removeListener(_scrollListener);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SmeupWidgetBuilderResponse>(
      future: _getSectionChildren(widget.smeupSectionModel),
      builder: (BuildContext context,
          AsyncSnapshot<SmeupWidgetBuilderResponse> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return widget.smeupSectionModel.showLoader!
              ? SmeupWait(widget.scaffoldKey, widget.formKey)
              : Container();
        } else {
          if (snapshot.hasError) {
            SmeupLogService.writeDebugMessage(
                'Error SmeupSection: ${snapshot.error}. StackTrace: ${snapshot.stackTrace}',
                logType: LogType.error);
            return SmeupNotAvailable();
          } else {
            return snapshot.data!.children!;
          }
        }
      },
    );
  }

  Future<SmeupWidgetBuilderResponse> _getSectionChildren(
      SmeupSectionModel smeupSectionModel) async {
    if (!hasSections(smeupSectionModel) && !smeupSectionModel.hasComponents()) {
      return SmeupWidgetBuilderResponse(smeupSectionModel, Container());
    }

    Widget? children;

    if (hasSections(smeupSectionModel)) {
      var sections = List<Widget>.empty(growable: true);

      double maxDim = 100;
      double totalDim = 0;
      int sectionWithNoDim = 0;

      for (var i = 0; i < smeupSectionModel.smeupSectionsModels!.length; i++) {
        var s = smeupSectionModel.smeupSectionsModels![i];
        totalDim += s.dim!;
        if (s.dim == 0) sectionWithNoDim += 1;
      }

      double dimToSplit = 100 - totalDim;

      if (totalDim < 100 && sectionWithNoDim > 0 && dimToSplit > 0) {
        double singleDim = (dimToSplit / sectionWithNoDim).ceil().toDouble();
        double spareDim = dimToSplit - (singleDim * sectionWithNoDim);
        for (var i = 0; i < smeupSectionModel.smeupSectionsModels!.length; i++) {
          var s = smeupSectionModel.smeupSectionsModels![i];
          if (s.dim != 0) continue;
          if (i == 0) {
            s.dim = singleDim + spareDim;
          } else {
            s.dim = singleDim;
          }
        }
        totalDim = maxDim;
      }

      smeupSectionModel.smeupSectionsModels!.forEach((s) {
        MediaQueryData deviceInfo = MediaQuery.of(context);
        if (s.dim! <= 0) {
          s.height = deviceInfo.size.height;
          s.width = deviceInfo.size.width;
        } else {
          s.height = smeupSectionModel.layout == 'column'
              ? smeupSectionModel.height! / totalDim * s.dim!
              : smeupSectionModel.height;
          s.width = smeupSectionModel.layout == 'row'
              ? smeupSectionModel.width! / totalDim * s.dim!
              : smeupSectionModel.width;
        }
      });

      smeupSectionModel.smeupSectionsModels!.forEach((s) {
        var section;
        section = Expanded(
            flex: s.dim!.floor(),
            child: SmeupSection(
                s, widget.scaffoldKey, widget.formKey, widget.parentForm));
        sections.add(section);
      });

      if (smeupSectionModel.layout == 'column') {
        if (smeupSectionModel.autoAdaptHeight!) {
          children = Container(
            height: smeupSectionModel.height,
            width: smeupSectionModel.width,
            //constraints: BoxConstraints(minHeight: 0),
            //child: SingleChildScrollView(
            child: Column(children: sections),
            //),
          );
        } else {
          children = Container(
            child: Column(children: sections),
          );
        }
      } else {
        children = Container(
          child: SingleChildScrollView(
            child: Row(children: sections),
          ),
        );
      }
    }

    if (smeupSectionModel.hasComponents()) {
      if (smeupSectionModel.components!.length == 1) {
        children = SmeupComponent(smeupSectionModel.components!.first,
            widget.scaffoldKey, widget.formKey, widget.parentForm);
      } else {
        children = _getTabs();
      }
    }

    return SmeupWidgetBuilderResponse(smeupSectionModel, children);
  }

  Widget _getTabs() {
    final tabsView = widget.smeupSectionModel.components!.map((e) {
      return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: SmeupComponent(
            e, widget.scaffoldKey, widget.formKey, widget.parentForm),
      );
    }).toList();

    final tabsTitles = widget.smeupSectionModel.components!.map((e) {
      return Container(
        color: SmeupConfigurationService.getTheme()!.scaffoldBackgroundColor,
        width: 120,
        height: 30,
        child: Tab(
          text: e.title,
        ),
      );
    }).toList();

    MediaQueryData deviceInfo = MediaQuery.of(context);

    var appBarTheme = _getAppBarTheme();

    return Container(
      height: deviceInfo.size.height,
      child: Theme(
        data: SmeupConfigurationService.getTheme()!,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(appBarTheme.toolbarHeight!),
            child: AppBar(
              backgroundColor: appBarTheme.backgroundColor,
              automaticallyImplyLeading: false,
              bottom: TabBar(
                controller: _tabController,
                isScrollable: true,
                onTap: (index) {
                  _onTabChanged(index);
                },
                tabs: tabsTitles,
              ),
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: tabsView,
          ),
        ),
      ),
    );
  }

  void _onTabChanged(int? index) {
    SmeupVariablesService.setVariable(
        widget.smeupSectionModel.selectedTabColName, index.toString(),
        formKey: widget.formKey);

    SmeupDynamismService.run(widget.smeupSectionModel.dynamisms, context,
        'change', widget.scaffoldKey, widget.formKey);
  }

  AppBarTheme _getAppBarTheme() {
    return SmeupConfigurationService.getTheme()!.appBarTheme.copyWith(
        backgroundColor:
            SmeupConfigurationService.getTheme()!.scaffoldBackgroundColor);
  }
}
