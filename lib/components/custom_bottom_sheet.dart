// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

const Duration _kBottomSheetDuration = Duration(milliseconds: 400);
const double _kMinFlingVelocity = 1000.0;
const double _kCloseProgressThreshold = 0.5;

/// A material design bottom sheet.
///
/// There are two kinds of bottom sheets in material design:
///
///  * _Persistent_. A persistent bottom sheet shows information that
///    supplements the primary content of the app. A persistent bottom sheet
///    remains visible even when the user interacts with other parts of the app.
///    Persistent bottom sheets can be created and displayed with the
///    [ScaffoldState.showBottomSheet] function or by specifying the
///    [Scaffold.bottomSheet] constructor parameter.
///
///  * _Modal_. A modal bottom sheet is an alternative to a menu or a dialog and
///    prevents the user from interacting with the rest of the app. Modal bottom
///    sheets can be created and displayed with the [showModalBottomSheet]
///    function.
///
/// The [BottomSheet] widget itself is rarely used directly. Instead, prefer to
/// create a persistent bottom sheet with [ScaffoldState.showBottomSheet] or
/// [Scaffold.bottomSheet], and a modal bottom sheet with [showModalBottomSheet].
///
/// See also:
///
///  * [ScaffoldState.showBottomSheet]
///  * [showModalBottomSheet]
///  * <https://material.google.com/components/bottom-sheets.html>
class BottomSheet extends StatefulWidget {
  /// Creates a bottom sheet.
  ///
  /// Typically, bottom sheets are created implicitly by
  /// [ScaffoldState.showBottomSheet], for persistent bottom sheets, or by
  /// [showModalBottomSheet], for modal bottom sheets.
  const BottomSheet(
      {Key key,
      this.animationController,
      this.enableDrag = true,
      @required this.onClosing,
      @required this.builder})
      : assert(enableDrag != null),
        assert(onClosing != null),
        assert(builder != null),
        super(key: key);

  /// The animation that controls the bottom sheet's position.
  ///
  /// The BottomSheet widget will manipulate the position of this animation, it
  /// is not just a passive observer.
  final AnimationController animationController;

  /// Called when the bottom sheet begins to close.
  ///
  /// A bottom sheet might be prevented from closing (e.g., by user
  /// interaction) even after this callback is called. For this reason, this
  /// callback might be call multiple times for a given bottom sheet.
  final VoidCallback onClosing;

  /// A builder for the contents of the sheet.
  ///
  /// The bottom sheet will wrap the widget produced by this builder in a
  /// [Material] widget.
  final WidgetBuilder builder;

  /// If true, the bottom sheet can dragged up and down and dismissed by swiping
  /// downards.
  ///
  /// Default is true.
  final bool enableDrag;

  @override
  _BottomSheetState createState() => new _BottomSheetState();

  /// Creates an animation controller suitable for controlling a [BottomSheet].
  static AnimationController createAnimationController(TickerProvider vsync) {
    return new AnimationController(
      duration: _kBottomSheetDuration,
      debugLabel: 'BottomSheet',
      vsync: vsync,
    );
  }
}

class _BottomSheetState extends State<BottomSheet> {
  final GlobalKey _childKey = new GlobalKey(debugLabel: 'BottomSheet child');

  double get _childHeight {
    final RenderBox renderBox = _childKey.currentContext.findRenderObject();
    return renderBox.size.height;
  }

  bool get _dismissUnderway =>
      widget.animationController.status == AnimationStatus.reverse;

  void _handleDragUpdate(DragUpdateDetails details) {
    if (_dismissUnderway) return;
    widget.animationController.value -=
        details.primaryDelta / (_childHeight ?? details.primaryDelta);
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_dismissUnderway) return;
    if (details.velocity.pixelsPerSecond.dy > _kMinFlingVelocity) {
      final double flingVelocity =
          -details.velocity.pixelsPerSecond.dy / _childHeight;
      if (widget.animationController.value > 0.0)
        widget.animationController.fling(velocity: flingVelocity);
      if (flingVelocity < 0.0) widget.onClosing();
    } else if (widget.animationController.value < _kCloseProgressThreshold) {
      if (widget.animationController.value > 0.0)
        widget.animationController.fling(velocity: -1.0);
      widget.onClosing();
    } else {
      widget.animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final Widget bottomSheet = new Material(
      key: _childKey,
      child: BackdropFilter(
          filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: widget.builder(context)),
      color: Colors.white30,
    );
    return !widget.enableDrag
        ? bottomSheet
        : new GestureDetector(
            // onVerticalDragUpdate: _handleDragUpdate,
            // onVerticalDragEnd: _handleDragEnd,
            child: bottomSheet,
          );
  }
}

// PERSISTENT BOTTOM SHEETS

// See scaffold.dart

// MODAL BOTTOM SHEETS

class _ModalBottomSheetLayout extends SingleChildLayoutDelegate {
  _ModalBottomSheetLayout(this.progress);

  final double progress;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return new BoxConstraints(
        minWidth: constraints.maxWidth,
        maxWidth: constraints.maxWidth,
        minHeight: 0.0,
        maxHeight: constraints.maxHeight);
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    return new Offset(0.0, size.height - childSize.height * progress);
  }

  @override
  bool shouldRelayout(_ModalBottomSheetLayout oldDelegate) {
    return progress != oldDelegate.progress;
  }
}

class _ModalBottomSheet<T> extends StatefulWidget {
  const _ModalBottomSheet({Key key, this.route}) : super(key: key);

  final _ModalBottomSheetRoute<T> route;

  @override
  _ModalBottomSheetState<T> createState() => new _ModalBottomSheetState<T>();
}

class _ModalBottomSheetState<T> extends State<_ModalBottomSheet<T>> {
  @override
  initState() {
    SystemChrome.setEnabledSystemUIOverlays(
      [SystemUiOverlay.bottom],
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
        //  onTap: () => Navigator.pop(context),
        child: new AnimatedBuilder(
            animation: widget.route.animation,
            builder: (BuildContext context, Widget child) {
              return new ClipRect(
                  child: new CustomSingleChildLayout(
                      delegate: new _ModalBottomSheetLayout(
                          widget.route.animation.value),
                      child: new BottomSheet(
                          animationController:
                              widget.route._animationController,
                          onClosing: () => Navigator.pop(context),
                          builder: widget.route.builder)));
            }));
  }
}

class _ModalBottomSheetRoute<T> extends PopupRoute<T> {
  _ModalBottomSheetRoute({
    this.builder,
    this.theme,
    this.barrierLabel,
    RouteSettings settings,
  }) : super(settings: settings);

  final WidgetBuilder builder;
  final ThemeData theme;

  @override
  Duration get transitionDuration => _kBottomSheetDuration;

  @override
  bool get barrierDismissible => true;

  @override
  final String barrierLabel;

  @override
  Color get barrierColor => Color(0x80000000);

  AnimationController _animationController;

  @override
  AnimationController createAnimationController() {
    assert(_animationController == null);
    _animationController =
        BottomSheet.createAnimationController(navigator.overlay);
    return _animationController;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    // By definition, the bottom sheet is aligned to the bottom of the page
    // and isn't exposed to the top padding of the MediaQuery.
    Widget bottomSheet = new MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: new _ModalBottomSheet<T>(route: this),
    );
    if (theme != null)
      bottomSheet = new Theme(
          data: ThemeData(backgroundColor: Colors.red), child: bottomSheet);
    return bottomSheet;
  }
}

/// Shows a modal material design bottom sheet.
///
/// A modal bottom sheet is an alternative to a menu or a dialog and prevents
/// the user from interacting with the rest of the app.
///
/// A closely related widget is a persistent bottom sheet, which shows
/// information that supplements the primary content of the app without
/// preventing the use from interacting with the app. Persistent bottom sheets
/// can be created and displayed with the [showBottomSheet] function or the
/// [ScaffoldState.showBottomSheet] method.
///
/// The `context` argument is used to look up the [Navigator] and [Theme] for
/// the bottom sheet. It is only used when the method is called. Its
/// corresponding widget can be safely removed from the tree before the bottom
/// sheet is closed.
///
/// Returns a `Future` that resolves to the value (if any) that was passed to
/// [Navigator.pop] when the modal bottom sheet was closed.
///
/// See also:
///
///  * [BottomSheet], which is the widget normally returned by the function
///    passed as the `builder` argument to [showModalBottomSheet].
///  * [showBottomSheet] and [ScaffoldState.showBottomSheet], for showing
///    non-modal bottom sheets.
///  * <https://material.google.com/components/bottom-sheets.html#bottom-sheets-modal-bottom-sheets>
Future<T> showModalCustomBottomSheet<T>({
  @required BuildContext context,
  @required WidgetBuilder builder,
}) {
  assert(context != null);
  assert(builder != null);
  return Navigator.push(
      context,
      new _ModalBottomSheetRoute<T>(
        builder: builder,
        theme: ThemeData(
            backgroundColor: Colors.transparent,
            canvasColor: Colors.transparent),
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
      ));
}

/// Shows a persistent material design bottom sheet in the nearest [Scaffold].
///
/// Returns a controller that can be used to close and otherwise manipulate the
/// bottom sheet.
///
/// To rebuild the bottom sheet (e.g. if it is stateful), call
/// [PersistentBottomSheetController.setState] on the controller returned by
/// this method.
///
/// The new bottom sheet becomes a [LocalHistoryEntry] for the enclosing
/// [ModalRoute] and a back button is added to the appbar of the [Scaffold]
/// that closes the bottom sheet.
///
/// To create a persistent bottom sheet that is not a [LocalHistoryEntry] and
/// does not add a back button to the enclosing Scaffold's appbar, use the
/// [Scaffold.bottomSheet] constructor parameter.
///
/// A persistent bottom sheet shows information that supplements the primary
/// content of the app. A persistent bottom sheet remains visible even when
/// the user interacts with other parts of the app.
///
/// A closely related widget is a modal bottom sheet, which is an alternative
/// to a menu or a dialog and prevents the user from interacting with the rest
/// of the app. Modal bottom sheets can be created and displayed with the
/// [showModalBottomSheet] function.
///
/// The `context` argument is used to look up the [Scaffold] for the bottom
/// sheet. It is only used when the method is called. Its corresponding widget
/// can be safely removed from the tree before the bottom sheet is closed.
///
/// See also:
///
///  * [BottomSheet], which is the widget typically returned by the `builder`.
///  * [showModalBottomSheet], which can be used to display a modal bottom
///    sheet.
///  * [Scaffold.of], for information about how to obtain the [BuildContext].
///  * <https://material.google.com/components/bottom-sheets.html#bottom-sheets-persistent-bottom-sheets>
PersistentBottomSheetController<T> showBottomSheett<T>({
  @required BuildContext context,
  @required WidgetBuilder builder,
}) {
  assert(context != null);
  assert(builder != null);
  return Scaffold.of(context).showBottomSheet<T>(builder);
}