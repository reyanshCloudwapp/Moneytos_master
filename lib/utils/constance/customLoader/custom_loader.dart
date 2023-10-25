import 'package:flutter/material.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_loader_type.dart';

class CustomLoader {
  static gfloader() {
    return const GFLoader(
      type: GFLoaderType.custom,
      child: Image(
        image: AssetImage('assets/logo/progress_image.png'),
      ),
    );
  }

  static progressloadingDialog(BuildContext context, bool status) {
    if (status) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Container(
            color: Colors.black.withOpacity(0.00),
            child: const Center(
              child: GFLoader(
                type: GFLoaderType.custom,
                child: Image(
                  image: AssetImage('assets/logo/progress_image.png'),
                ),
              ),
            ),
          );
        },
      );
      // return pr.show();
    } else {
      Navigator.pop(context);
    }
  }

  static progressloadingDialog2(BuildContext context, bool status) {
    if (status) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Container(
            color: Colors.black.withOpacity(0.00),
            child: const Center(
              child: GFLoader(
                type: GFLoaderType.custom,
                child: Image(
                  image: AssetImage('assets/logo/progress_image.png'),
                ),
              ),
            ),
          );
        },
      );
      // return pr.show();
    } else {
      /* Navigator.pop(context);*/
    }
  }

  static progressloadingDialog4(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.30),
      child: const Center(
        child: GFLoader(
          type: GFLoaderType.custom,
          child: Image(
            image: AssetImage('assets/logo/progress_image.png'),
          ),
        ),
      ),
    );
  }

  static progressloadingDialog5(BuildContext context, bool status) {
    if (status) {
      return Container(
        color: Colors.white.withOpacity(0.30),
        child: const Center(
          child: GFLoader(
            type: GFLoaderType.custom,
            child: Image(
              image: AssetImage('assets/logo/progress_image.png'),
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  static progressloadingDialog6(BuildContext context, bool status) {
    if (status) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Container(
            color: Colors.black.withOpacity(0.00),
            child: const Center(
              child: GFLoader(
                type: GFLoaderType.custom,
                child: Image(
                  image: AssetImage('assets/logo/progress_image.png'),
                ),
              ),
            ),
          );
        },
      );
      // return pr.show();
    } else {
      Navigator.of(context, rootNavigator: true).pop(context);
    }
  }
}
