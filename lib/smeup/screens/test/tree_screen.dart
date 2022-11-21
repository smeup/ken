import 'package:flutter/material.dart';
import 'package:ken/smeup/widgets/ken_tree.dart';
import 'package:ken/smeup/services/ken_utilities.dart';

// import 'package:flutter/material.dart';
// import 'package:ken/smeup/services/shiro_configuration_service.dart';
// import 'package:ken/smeup/widgets/ken_tree.dart';
// import 'package:flutter_treeview/tree_view.dart';

// class TreeScreen extends StatelessWidget {
//   static const routeName = '/TreeScreen';
//   static const drawerId = 'tree1';
//   final _scaffoldKey = GlobalKey<ScaffoldState>();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

// ignore: unused_element
KenTree _getTree(BuildContext context, scaffoldKey, formKey) {
  // var data = List<Node>.empty(growable: true);

  // var node1 = Node(
  //     key: 'node1',
  //     data: 'data1',
  //     label: 'node 1',
  //     icon: IconData(0xe737, fontFamily: 'MaterialIcons'),
  //     expanded: true,
  //     children: [
  //       Node(
  //           key: 'node11',
  //           data: 'data11',
  //           label: 'node 11',
  //           expanded: true,
  //           children: [
  //             Node(key: 'node111', data: 'data111', label: 'node 111'),
  //             Node(key: 'node112', data: 'data112', label: 'node 112')
  //           ])
  //     ]);

  // var node2 = Node(
  //     key: 'node2',
  //     data: 'data2',
  //     label: 'node 2',
  //     icon: IconData(57400, fontFamily: 'MaterialIcons'),
  //     children: [
  //       Node(key: 'node22', data: 'data22', label: 'node 22', children: [
  //         Node(key: 'node222', data: 'data222', label: 'node 222')
  //       ])
  //     ]);

  // data.addAll([node1, node2]);

  return KenTree(
    scaffoldKey,
    formKey,
    data: null,
    width: 300,
    height: 300,
    labelFontSize: 20,
    labelFontColor: Colors.red,
    parentFontSize: 30,
    onClientClick: (node) {
      KenUtilities.invokeScaffoldMessenger(context,
          "selected the node with key: ${node.key} and data: ${node.data}");
    },
  );
}
