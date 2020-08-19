import 'package:flutter/material.dart';

enum DialogOptions {
  approve,
  abort,
}
//Example Dialog Box:
              //  () async {
              //     DialogOptions response = await showDialog(
              //         context: context,
              //         builder: (BuildContext context) {
              //           return DialogBox(
              //             content: Text(
              //                 'Do you really want to delete? This action cannot be undone',
              //                 textAlign: TextAlign.center,),
              //             color: CurrencyColors.lossColor,
              //           );
              //         });
              //     if (response == DialogOptions.approve) {
              //       print('Approved');
              //     } else {
              //       print('Aborted');
              //     }
//                 }
class DialogBox extends StatelessWidget {
  final String title;
  final Widget content;
  final String approveText;
  final String abortText;
  final Color color;

  const DialogBox({
    this.title,
    @required this.content,
    this.approveText = 'Yes',
    this.abortText = 'No',
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            (title != null)
                ? Container(
                    color: color,
                    height: 60,
                    width: double.infinity,
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        title,
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .apply(color: Colors.white),
                      ),
                    ),
                  )
                : null,
            Container(
              constraints: BoxConstraints(minHeight: 100),
              padding: EdgeInsets.all(24.0),
              child: Center(
                child: content,
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: OutlineButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Text(abortText),
                    onPressed: () {
                      Navigator.pop(context, DialogOptions.abort);
                    },
                    textColor: color,
                    color: color,
                  ),
                ),
                Expanded(
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Text(approveText),
                    onPressed: () {
                      Navigator.pop(context, DialogOptions.approve);
                    },
                    color: color,
                    textColor: Colors.white,
                  ),
                ),
              ],
            ),
          ].where((widget) => widget != null).toList(),
        ),
      ),
    );
  }
}