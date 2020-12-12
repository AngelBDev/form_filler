import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:form_filler/core/utils/enviroment.dart';
import 'package:form_filler/features/form_fill/data/repositories/bill_repository_impl.dart';
import 'package:form_filler/features/form_fill/data/repositories/form_606_repository_impl.dart';
import 'package:form_filler/features/form_fill/state/bill_state/bill_cubit.dart';
import 'package:form_filler/features/form_fill/state/form_606_state/form_606_cubit.dart';
import 'package:form_filler/features/theming/domain/entities/app_theme.dart';
import 'package:form_filler/features/theming/state/theme/cubit/theme_cubit.dart';

class InitialProviders extends StatefulWidget {
  InitialProviders({
    Key key,
    @required this.child,
    @required this.initialTheme,
  }) : super(key: key);

  final Widget child;
  final AppTheme initialTheme;

  @override
  _InitialProvidersState createState() => _InitialProvidersState();
}

class _InitialProvidersState extends State<InitialProviders> {
  List<BlocProvider> providers = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(
          create: (context) => ThemeCubit(
            appTheme: widget.initialTheme,
          ),
        ),
        BlocProvider<BillCubit>(
          create: (context) => BillCubit(
            billRepository: BillRepositoryImpl(
              dio: Dio(),
              env: Enviroment(
                env: DotEnv().env,
              ),
            ),
          ),
        ),
        BlocProvider<Form606Cubit>(
          create: (context) => Form606Cubit(
            form606Repository: Form606RepositoryImpl(
              dio: Dio(),
              env: Enviroment(
                env: DotEnv().env,
              ),
            ),
          ),
        ),
      ],
      child: widget.child,
    );
  }
}
