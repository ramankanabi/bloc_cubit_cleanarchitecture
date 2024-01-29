import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_course/2_app/pages/advicePage/cubit/advice_cubit.dart';
import 'package:flutter_bloc_course/2_app/pages/advicePage/widgets/custom_button.dart';
import 'package:flutter_bloc_course/2_app/pages/advicePage/widgets/error_message.dart';
import '../../../injection.dart';
import 'widgets/advice_field.dart';

class AdvicePageWrapperProvider extends StatelessWidget {
  const AdvicePageWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AdviceCubit>(),
      child: const AdvicerPage(),
    );
  }
}

class AdvicerPage extends StatelessWidget {
  const AdvicerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Advicer',
          style: themeData.textTheme.headlineMedium,
        ),
        centerTitle: true,
     
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: BlocBuilder<AdviceCubit, AdviceCubitState>(
                  builder: (context, state) {
                    if (state is AdviceStateInitial) {
                      return Text(
                        'Your Advice is waiting for you!',
                        style: themeData.textTheme.headlineMedium,
                      );
                    } else if (state is AdviceStateLoading) {
                      return CircularProgressIndicator(
                        color: themeData.colorScheme.secondary,
                      );
                    } else if (state is AdviceStateLoaded) {
                      return AdviceField(
                        advice: state.advice,
                      );
                    } else if (state is AdviceStateError) {
                      return ErrorMessage(message: state.message);
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ),
            SizedBox(
              height: 200,
              child: Center(
                child: CustomButton(
                  onTap: () => BlocProvider.of<AdviceCubit>(context).adviceRequestData(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}