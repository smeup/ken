# ken: super-rich components for Flutter applications

![ken Logo](https://github.com/smeup/ken/blob/develop/assets/images/logo_KEN.png)

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

## Intro

Ken is a library for [Flutter](https://flutter.dev/) applications. All widgets in this library can be used both as static and dynamic.
The static use of the widgets, is a declaration of the widget in the page like any other widget in Flutter.
The dynamic use of the component, is a definition of the widget in a json file which can be received as input in a SmeupDynamicScreen. This methodology allow you to have a single page application where the content of the page could be sent from a backend. 

## ken Showcase

There is a project entirely dedicated to the [ken Showcase](https://github.com/smeup/ken-showcase). Feel free to download it and check out the examples provided. 

## ken API

The [API documentation](https://github.com/smeup/ken/blob/develop/doc/api/index.md) provide with a full description of: classes, services, models and widgeds included in the ken library.

## ken Development

The following documents will provide all material you need to start using ken library: 
- [Dependencies](https://github.com/smeup/ken/blob/develop/doc/development/dependencies.md)
- [Widgets](https://github.com/smeup/ken/blob/develop/doc/development/widgets.md)
- [publish](https://github.com/smeup/ken/blob/develop/doc/development/publish_procedure.md)

## How to use ken in your project

Create a new Flutter app:
    
    > flutter create myapp

To install the ken library, add the following dependency into the pubspec.yaml:

    dependencies:
        ken: ^0.0.1

Add the ken library initilization in the main.dart file. In the initialization statement, you can set many attributes. Follow a minimal configuration:

    SmeupConfigurationService.init(
        context,
    );

## Issues

If you run into an error or an unexpected behavior, or you just want to give us feedback on how to improve, feel free to use the [issues](https://github.com/smeup/ken/issues) page.
