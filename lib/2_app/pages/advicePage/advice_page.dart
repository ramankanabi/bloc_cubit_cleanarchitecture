import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_course/2_app/pages/advicePage/cubit/advice_cubit.dart';
import 'package:flutter_bloc_course/injection.dart';

class AdvicePageWrapperProvider extends StatelessWidget {
  const AdvicePageWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AdviceCubit>(),
      child: const AdvicePage(),
    );
  }
}

class AdvicePage extends StatelessWidget {
  const AdvicePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Advice page")),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BlocBuilder<AdviceCubit, AdviceCubitState>(
              builder: (context, state) {
                if (state is AdviceStateInitial) {
                  const Text("Welcom to our hub , let's play something");
                } else if (state is AdviceStateLoading) {
                  return const CircularProgressIndicator();
                } else if (state is AdviceStateLoaded) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      state.advice,
                      style: const TextStyle(
                        fontSize: 26,
                      ),
                    ),
                  );
                } else if (state is AdviceStateError) {
                  return Text(
                    state.message,
                    style: const TextStyle(fontSize: 26, color: Colors.red),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<AdviceCubit>(context).adviceRequestData();
              },
              child: const Text("Press to get"),
            )
          ],
        ),
      ),
    );
  }
}
