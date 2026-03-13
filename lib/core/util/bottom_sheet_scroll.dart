import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:keymoneydemo/core/theme/app_colors.dart';

void customBottomSheetScroll(
  BuildContext context, {
  required List<Widget> scrollableContent, // Ahora recibe una lista de widgets
  double initialChildSize = 0.5, // Altura inicial (50% de la pantalla)
  double minChildSize = 0.4, // Altura mínima
  double maxChildSize = 0.9, // Altura máxima
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled:
        true, // Vital para que DraggableScrollableSheet funcione
    backgroundColor: Colors.transparent,
    useRootNavigator: true,
    barrierColor: Colors.black.withOpacity(0.5),
    builder: (context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: DraggableScrollableSheet(
          initialChildSize: initialChildSize,
          minChildSize: minChildSize,
          maxChildSize: maxChildSize,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: AppColors.background2,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                children: [
                  // El "Handle" o barrita superior estética
                  const SizedBox(height: 12),
                  Container(
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                      color: AppColors.background3.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // El contenido con scroll elegante
                  Expanded(
                    child: ListView.builder(
                      controller:
                          scrollController, // Conecta el scroll con el gesto de arrastre
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      itemCount: scrollableContent.length,
                      itemBuilder: (context, index) {
                        return scrollableContent[index];
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}
