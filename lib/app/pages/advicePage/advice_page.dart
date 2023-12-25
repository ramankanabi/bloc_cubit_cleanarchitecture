import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_course/app/pages/advicePage/bloc/advice_bloc.dart';

class AdVicePage extends StatelessWidget {
  const AdVicePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Advice page")),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BlocBuilder<AdviceBloc, AdviceState>(
              builder: (context, state) {
                if (state is AdviceStateInitial) {
                  const Text("Welcom to our hub , let's play something");
                } else if (state is AdviceStateLoading) {
                  return const CircularProgressIndicator();
                } else if (state is AdviceStateLoaded) {
                  return Text(
                    state.advice,
                    style: const TextStyle(
                      fontSize: 26,
                    ),
                  );
                } else if (state is AdviceStateError) {
                  return const Text(
                    "ooooppssssssss",
                    style: TextStyle(fontSize: 26, color: Colors.red),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<AdviceBloc>(context).add(AdviceRequestData());
              },
              child: const Text("Press to get"),
            )
          ],
        ),
      ),
    );
  }
}
