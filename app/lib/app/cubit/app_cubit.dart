import 'package:bloc/bloc.dart';
import 'package:lockie_account/lockie_account.dart';
import 'package:lockie_locker/lockie_locker.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {

  final IAuthenticationRepository authenticationRepository;
  final IPasswordsRepository passwordsRepository;
  final IProfileRepository profileRepository;
  final String? authenticationLink;

  AppCubit({
    required this.authenticationRepository,
    required this.passwordsRepository,
    required this.profileRepository,
    this.authenticationLink
  }) : super(AppState.loading) {
    if(authenticationLink != null) {
      authenticationRepository.authenticateWithLink(authenticationLink!);
    }
    
    emit(_mapAccountToState(authenticationRepository.currentAccount));
    authenticationRepository.stream.listen((account) => emit(_mapAccountToState(account)));
  }

  AppState _mapAccountToState(Account account) {
    if(account.isEmpty) {
      return AppState.unauthenticated;
    }
    else {
      profileRepository.initialize(account.id);
      passwordsRepository.initialize(account.id);
      return AppState.authenticated;
    }
  }
}
