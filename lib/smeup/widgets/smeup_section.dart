import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/models/smeup_options.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_section_model.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/services/smeup_dynamism_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_log_service.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_not_available.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_wait.dart';
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
    with TickerProviderStateMixin {
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
              ? SmeupWait()
              : Container();
        } else {
          if (snapshot.hasError) {
            SmeupLogService.writeDebugMessage(
                'Error SmeupSection: ${snapshot.error}',
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
    if (!smeupSectionModel.hasSections() &&
        !smeupSectionModel.hasComponents()) {
      return SmeupWidgetBuilderResponse(smeupSectionModel, Container());
    }

    Widget children;

    if (smeupSectionModel.hasSections()) {
      var sections = List<Widget>.empty(growable: true);
      double maxDim = 100;
      double totalDim = 0;
      smeupSectionModel.smeupSectionsModels.forEach((section) {
        totalDim += section.dim;
      });
      if (totalDim == 0 && smeupSectionModel.smeupSectionsModels.length > 0) {
        double singleDim =
            (maxDim / smeupSectionModel.smeupSectionsModels.length)
                .ceil()
                .toDouble();
        double spareDim =
            maxDim - (singleDim * smeupSectionModel.smeupSectionsModels.length);
        for (var i = 0; i < smeupSectionModel.smeupSectionsModels.length; i++) {
          var s = smeupSectionModel.smeupSectionsModels[i];
          if (i == 0) {
            s.dim = singleDim + spareDim;
          } else {
            s.dim = singleDim;
          }
        }
        totalDim = maxDim;
      }

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
        color: SmeupOptions.theme.scaffoldBackgroundColor,
        width: 120,
        height: 30,
        // decoration: BoxDecoration(
        //   color: SmeupOptions.theme.scaffoldBackgroundColor,
        // ),
        child: Tab(
          text: e.title,
        ),
        //),
      );
    }).toList();

    return Container(
      height: SmeupOptions.deviceHeight,
      child: Theme(
        data: SmeupOptions.theme,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: AppBar(
              elevation: 0,
              shape: Border(
                  bottom: BorderSide(
                      color: SmeupOptions.theme.scaffoldBackgroundColor)),
              backgroundColor: Color.fromRGBO(255, 255, 255, 0),
              automaticallyImplyLeading: false,
              bottom: TabBar(
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                      width: 5.0, color: SmeupOptions.theme.primaryColor),
                ),
                labelColor: SmeupOptions.theme.primaryColor,
                unselectedLabelColor:
                    SmeupOptions.theme.textTheme.bodyText1.color,
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
    SmeupDynamismService
            .variables[widget.smeupSectionModel.selectedTabColName] =
        index.toString();

    SmeupDynamismService.run(widget.smeupSectionModel.dynamisms, context,
        'change', widget.scaffoldKey);
  }
}
