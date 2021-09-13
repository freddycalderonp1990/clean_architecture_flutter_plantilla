

part of 'customWidgets.dart';

class BotonesWidget  extends StatefulWidget {
  final String title;
  final VoidCallback? onPressed;
  final IconData? iconData;
  final EdgeInsetsGeometry? padding;

  const BotonesWidget({this.onPressed, this.title='', this.iconData, this.padding});


  @override
  _BotonesWidgetState createState() => _BotonesWidgetState();
}

class _BotonesWidgetState extends State<BotonesWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final responsive = ResponsiveUtil();

    return  Container(
        decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(color: SiipneConfig.colorBordecajas, blurRadius: 12)
            ]),
      margin: widget.padding,

      child: CupertinoButton(
        borderRadius: BorderRadius.circular(40),
        color: SiipneConfig.colorBotonesWidget,
        onPressed: widget.onPressed,
        child: SingleChildScrollView(
          scrollDirection:Axis.horizontal ,

          child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            widget.iconData!= null?
            Icon(
              widget.iconData,
              color: Colors.white,
            ):Container(),
            SizedBox(width: responsive.anchoP(1),),

            widget.title!=''?
            Text(
              widget.title,
              style: TextStyle(
                  fontSize: responsive.anchoP(SiipneConfig.tamTexto + 1.0)),
            ):Container()
          ],
        ),),
      ),
    );
  }
}
