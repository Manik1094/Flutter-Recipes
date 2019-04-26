import 'package:flutter/material.dart';


abstract class BlocBase{
  void dispose();
}
class BlocProvider<T extends BlocBase> extends StatefulWidget {

  final T bloc;
  final Widget child;

  static Type _typeOf<T>() => T;

  static T of<T extends BlocBase>(BuildContext context){
    final _type = _typeOf<BlocProvider<T>>();
    BlocProvider<T> _provider = context.ancestorWidgetOfExactType(_type);
    return _provider.bloc;
  }

  BlocProvider({this.bloc , this.child});
  @override
  _BlocProviderState<T> createState() => _BlocProviderState<T>();
}

class _BlocProviderState<T> extends State<BlocProvider<BlocBase>> {

@override
  void dispose() {
    // TODO: implement dispose
    widget.bloc.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) => widget.child;
}