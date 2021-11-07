import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/services/smeup_configuration_service.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_section_model.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/services/smeup_dynamism_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_log_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_variables_service.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_not_available.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_wait.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_mixin.dart';
import 'smeup_component.dart';

class SmeupSection extends StatefulWidget {
  final SmeupSectionModel smeupSectionModel;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState> formKey;

  SmeupSection(this.smeupSectionModel, this.scaffoldKey, this.formKey);

  @override
  _SmeupSectionState createState() => _SmeupSectionState();
}

class _SmeupSectionState extends State<SmeupSection>
    with TickerProviderStateMixin, SmeupWidgetStateMixin {
  var _tabController;

  @override
  void initState() {
    _tabController = TabController(
        length: widget.smeupSectionModel.components.length,
        vsync: this,
        initialIndex: widget.smeupSectionModel.selectedTabIndex);

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
    //MediaQueryData deviceInfo = MediaQuery.of(context);

    return FutureBuilder<SmeupWidgetBuilderResponse>(
      future: _getSectionChildren(widget.smeupSectionModel),
      builder: (BuildContext context,
          AsyncSnapshot<SmeupWidgetBuilderResponse> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return widget.smeupSectionModel.showLoader
              ? SmeupWait(widget.scaffoldKey, widget.formKey)
              : Container();
        } else {
          if (snapshot.hasError) {
            SmeupLogService.writeDebugMessage(
                'Error SmeupSection: ${snapshot.error}. StackTrace: ${snapshot.stackTrace}',
                logType: LogType.error);
            return SmeupNotAvailable();
          } else {
            return snapshot.data.children;
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

    Widget children;

    if (hasSections(smeupSectionModel)) {
      var sections = List<Widget>.empty(growable: true);

      double maxDim = 100;
      double totalDim = 0;
      int sectionWithNoDim = 0;

      for (var i = 0; i < smeupSectionModel.smeupSectionsModels.length; i++) {
        var s = smeupSectionModel.smeupSectionsModels[i];
        totalDim += s.dim;
        if (s.dim == 0) sectionWithNoDim += 1;
      }

      double dimToSplit = 100 - totalDim;

      if (totalDim < 100 && sectionWithNoDim > 0 && dimToSplit > 0) {
        double singleDim = (dimToSplit / sectionWithNoDim).ceil().toDouble();
        double spareDim = dimToSplit - (singleDim * sectionWithNoDim);
        for (var i = 0; i < smeupSectionModel.smeupSectionsModels.length; i++) {
          var s = smeupSectionModel.smeupSectionsModels[i];
          if (s.dim != 0) continue;
          if (i == 0) {
            s.dim = singleDim + spareDim;
          } else {
            s.dim = singleDim;
          }
        }
        totalDim = maxDim;
      }

      smeupSectionModel.smeupSectionsModels.forEach((s) {
        MediaQueryData deviceInfo = MediaQuery.of(context);
        if (s.dim <= 0) {
          s.height = deviceInfo.size.height;
          s.width = deviceInfo.size.width;
        } else {
          s.height = smeupSectionModel.layout == 'column'
              ? smeupSectionModel.height / totalDim * s.dim
              : smeupSectionModel.height;
          s.width = smeupSectionModel.layout == 'row'
              ? smeupSectionModel.width / totalDim * s.dim
              : smeupSectionModel.width;
        }
      });

      if (smeupSectionModel.autoAdaptHeight) {
        smeupSectionModel.smeupSectionsModels.forEach((s) {
          var section;
          section = Expanded(
              flex: s.dim.floor(),
              child: SmeupSection(s, widget.scaffoldKey, widget.formKey));
          sections.add(section);
        });
        if (smeupSectionModel.layout == 'column') {
          children = Container(
            constraints: BoxConstraints(minHeight: 0),
            child: SingleChildScrollView(
              child: Column(children: sections),
            ),
          );
        } else {
          children = Container(
            constraints: BoxConstraints(minHeight: 0),
            child: SingleChildScrollView(
              child: Row(children: sections),
            ),
          );
        }
      } else {
        smeupSectionModel.smeupSectionsModels.forEach((s) {
          var section;

          if (s.dim <= 0) {
            section = SmeupSection(s, widget.scaffoldKey, widget.formKey);
          } else {
            section = Expanded(
                flex: s.dim.floor(),
                child: SmeupSection(s, widget.scaffoldKey, widget.formKey));
          }
          sections.add(section);
        });

        if (smeupSectionModel.layout == 'column') {
          children = Container(
            child: SingleChildScrollView(
              child: Column(children: sections),
            ),
          );
        } else {
          children = Container(
            child: SingleChildScrollView(
              child: Row(children: sections),
            ),
          );
        }
      }
    }

    if (smeupSectionModel.hasComponents()) {
      if (smeupSectionModel.components.length == 1) {
        children = SmeupComponent(smeupSectionModel.components.first,
            widget.scaffoldKey, widget.formKey);
      } else {
        children = _getTabs();
      }
    }

    return SmeupWidgetBuilderResponse(smeupSectionModel, children);
  }

  Widget _getTabs() {
    final tabsView = widget.smeupSectionModel.components.map((e) {
      return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: SmeupComponent(e, widget.scaffoldKey, widget.formKey),
      );
    }).toList();

    final tabsTitles = widget.smeupSectionModel.components.map((e) {
      return
          //Padding(
          //padding: const EdgeInsets.only(bottom: 8.0),
          //child:
          Container(
        color: SmeupConfigurationService.getTheme().scaffoldBackgroundColor,
        width: 120,
        height: 30,
        // decoration: BoxDecoration(
        //   color: SmeupOptions.getTheme().scaffoldBackgroundColor,
        // ),
        child: Tab(
          text: e.title,
        ),
        //),
      );
    }).toList();

    MediaQueryData deviceInfo = MediaQuery.of(context);

    return Container(
      height: deviceInfo.size.height,
      child: Theme(
        data: SmeupConfigurationService.getTheme(),
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: AppBar(
              elevation: 0,
              shape: Border(
                  bottom: BorderSide(
                      color: SmeupConfigurationService.getTheme()
                          .scaffoldBackgroundColor)),
              backgroundColor: Color.fromRGBO(255, 255, 255, 0),
              automaticallyImplyLeading: false,
              bottom: TabBar(
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                      width: 5.0,
                      color: SmeupConfigurationService.getTheme().primaryColor),
                ),
                labelColor: SmeupConfigurationService.getTheme().primaryColor,
                unselectedLabelColor: SmeupConfigurationService.getTheme()
                    .textTheme
                    .bodyText1
                    .color,
                controller: _tabController,
                isScrollable: true,
                onTap: (index) {
                  _onTabChanged(index);
                },
                labelStyle: TextStyle(fontSize: 16, color: Color(0xFF151026)),
                labelPadding: EdgeInsets.all(3),
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

  void _onTabChanged(int index) {
    SmeupVariablesService.setVariable(
        widget.smeupSectionModel.selectedTabColName, index.toString(),
        formKey: widget.formKey);

    SmeupDynamismService.run(widget.smeupSectionModel.dynamisms, context,
        'change', widget.scaffoldKey, widget.formKey);
  }
}
