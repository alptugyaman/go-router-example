import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<bool> {
  AuthCubit() : super(false);

  void signIn() => emit(true);
  void signOut() => emit(false);
}
