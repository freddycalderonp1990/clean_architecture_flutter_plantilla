part of 'customWidgets.dart';

class WorkAreaPageWidget extends StatefulWidget {
  final bool peticionServer;
  final String title;
  final List<Widget> contenido;
  final bool btnAtras;
  final Route<Object?>? pantallaIrAtras;
  final Widget? widgetBtnFinal;
  final EdgeInsetsGeometry? paddin;
  final FloatingActionButtonLocation ubicacionBtnFinal;
  final imgPerfil;
  final imgFondo;
  final double sizeTittle;
  final bool mostrarVersion;

  const WorkAreaPageWidget({
    this.peticionServer = false,
    this.title = '',
    required this.contenido,
    this.btnAtras = false,
    this.widgetBtnFinal,
    this.paddin,
    this.ubicacionBtnFinal = FloatingActionButtonLocation.centerFloat,
    this.imgPerfil = null,
    this.imgFondo,
    this.sizeTittle = 0,
    this.mostrarVersion = false,
    this.pantallaIrAtras,
  });

  @override
  _WorkAreaPageWidgetState createState() => _WorkAreaPageWidgetState();
}

class _WorkAreaPageWidgetState extends State<WorkAreaPageWidget> {
  String version = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadVersion();
  }

  _loadVersion() async {
    String _version = await UtilidadesUtil.getVersionCodeNameApp();
    setState(() {
      version = _version;
    });
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil();

    return Scaffold(
        floatingActionButtonLocation: widget.ubicacionBtnFinal,
        floatingActionButton: widget.widgetBtnFinal,
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Stack(
              children: [
                Container(
                  height: responsive.alto,
                  width: responsive.ancho,
                  child: Image.asset(
                    widget.imgFondo == null
                        ? SiipneImages.imgFondoDefault
                        : widget.imgFondo,
                    fit: BoxFit.cover,
                  ),
                ),
                SafeArea(
                  child: Column(
                    children: [
                      Container(
                        width: responsive.ancho,
                        height: responsive.isVertical()
                            ? responsive.altoP(8.5)
                            : responsive.altoP(20),
                        child: Stack(
                          children: [
                            Positioned(
                              right: 0,
                              top: 0,
                              bottom: 0,
                              child: Container(
                                width: responsive.anchoP(38),
                                height: responsive.anchoP(38),
                              ),
                            ),
                            widget.btnAtras
                                ? BtnAtrasWidget(
                                    pantallaIrAtras: widget.pantallaIrAtras,
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: SingleChildScrollView(
                              padding: widget.paddin,
                              child: Container(
                                  padding: EdgeInsets.only(
                                      top: responsive.isVertical()
                                          ? responsive.anchoP(13)
                                          : 0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        width: responsive.anchoP(100),
                                        margin: EdgeInsets.only(
                                          top: responsive.altoP(2.0),
                                        ),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                SiipneConfig.radioBordecajas),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.blue
                                                      .withOpacity(0.5),
                                                  blurRadius: 25)
                                            ]),
                                        child: Center(
                                          child: Column(
                                            children: <Widget>[
                                              imgPerfilRedonda(
                                                size: 22,
                                                img: widget.imgPerfil,
                                              ),
                                              widget.title != ''
                                                  ? Text(
                                                      widget.title,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: widget
                                                                      .sizeTittle ==
                                                                  0
                                                              ? responsive
                                                                  .anchoP(5)
                                                              : responsive
                                                                  .anchoP(widget
                                                                      .sizeTittle)),
                                                    )
                                                  : Container(),
                                              widget.mostrarVersion
                                                  ? Text(
                                                      'Versi??n 2: ' +
                                                          version +
                                                          ' ' +
                                                          "UrlApi.ambiente",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black
                                                              .withOpacity(
                                                                  0.5)),
                                                    )
                                                  : Container()
                                            ],
                                          ),
                                        ),
                                      ),
                                      Column(
                                        children: widget.contenido != null
                                            ? widget.contenido
                                            : [Container()],
                                      ),
                                    ],
                                  ))),
                        ),
                      )
                    ],
                  ),
                ),
                CargandoWidget(
                  mostrar: widget.peticionServer,
                )
              ],
            )));
  }
}

class imgPerfilRedonda extends StatefulWidget {
  final double size;

  final img;

  const imgPerfilRedonda({Key? key, this.size = 22, this.img})
      : super(key: key);

  @override
  _imgPerfilRedondaState createState() => _imgPerfilRedondaState();
}

class _imgPerfilRedondaState extends State<imgPerfilRedonda> {
  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil();

    return widget.img != null
        ? Container(
            width: responsive.isVertical()
                ? responsive.anchoP(widget.size)
                : responsive.anchoP(widget.size - 8),
            height: responsive.isVertical()
                ? responsive.anchoP(widget.size)
                : responsive.anchoP(widget.size - 8),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white.withOpacity(0.5),
                style: BorderStyle.solid,
                width: 2.5,
              ),
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(150.0),
            ),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: Image.memory(widget.img).image, fit: BoxFit.fill),
              ),
            ),
          )
        : Container();
  }
}
