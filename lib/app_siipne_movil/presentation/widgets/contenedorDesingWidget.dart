
part of 'customWidgets.dart';

class ContenedorDesingWidget extends StatelessWidget {
  final Widget child;
  final double anchoPorce;

  final EdgeInsetsGeometry? margin;

  const ContenedorDesingWidget({
    Key? key,
    required this.child,
    this.anchoPorce = 97.0,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

      final responsive = ResponsiveUtil();
      return Container(

          width: responsive.anchoP(anchoPorce),
          margin: margin,
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(1),
              borderRadius: BorderRadius.circular(SiipneConfig.radioBordecajas),
              boxShadow: [
                BoxShadow(
                    color: SiipneConfig.colorBordecajas,
                    blurRadius: SiipneConfig.sobraBordecajas)
              ]),
          child: child);

  }

}
