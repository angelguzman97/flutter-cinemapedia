import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  Stream<String> getLoadingMessages() {
    final message = <String>[
      'Cargando película',
      'Comprando palomitas de maíz',
      'Cargando populares',
      'LLamando a mi novia',
      'Ya mero...',
      'Esto está cargando más de lo esperado',
    ];

    return Stream.periodic(const Duration(milliseconds: 1200), (step) {
      return message[step];
    }).take(message.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Espere por favor'),
          const SizedBox(
            height: 10,
          ),
          const CircularProgressIndicator(
            strokeWidth: 2,
          ),
          const SizedBox(
            height: 10,
          ),
          StreamBuilder(
            stream: getLoadingMessages(), 
            builder: (context,snapshot){
              if (!snapshot.hasData) return const Text('Carggando...');

              return Text(snapshot.data!);
            }
            )
        ],
      ),
    );
  }
}
