import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'magic_link_confirmation_state.dart';

class MagicLinkConfirmationCubit extends Cubit<MagicLinkConfirmationState> {

  MagicLinkConfirmationCubit()
  : super(MagicLinkConfirmationState.pure());
}