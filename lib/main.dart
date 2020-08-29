import 'package:flutter/material.dart';
import 'package:sliding_panel/sliding_panel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  Stream<List> waitForItems() async* {
    await Future.delayed(Duration(seconds: 1));
    yield [1, 2, 3, 4];
  }

  @override
  Widget build(BuildContext context) {
    PanelController panelController = PanelController();

    return Container(
      color: Colors.white,
      child: Center(
        child: RaisedButton(
          child: Text('Click me'),
          onPressed: () {
            showModalSlidingPanel(
                context: context,
                panel: (BuildContext context) {
                  return SlidingPanel(
                    panelController: panelController,
                    content: PanelContent(
                      panelContent: [
                        StreamBuilder<dynamic>(
                          stream: waitForItems(),
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            if (!snapshot.hasData) {
                              return Container(
                                color: Colors.red,
                                height: 200,
                                width: double.infinity,
                              );
                            }
                            return Container(
                              color: Colors.blue,
                              height: 200,
                              width: double.infinity,
                            );
                          },
                        ),
                      ],
                    ),
                  );
                });
          },
        ),
      ),
    );
  }
}
