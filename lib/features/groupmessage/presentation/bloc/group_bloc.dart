import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkathon/features/groupmessage/domain/usecase/group_usecase.dart';
import 'package:talkathon/features/groupmessage/presentation/bloc/group_event.dart';
import 'package:talkathon/features/groupmessage/presentation/bloc/group_state.dart';

class GroupCreationBloc extends Bloc<GroupCreationEvent, GroupCreationState> {
  final CreateGroupUseCase createGroupUseCase;

  GroupCreationBloc(this.createGroupUseCase) : super(GroupCreationInitial()) {
    on<CreateGroupEvent>(_onCreateGroup);
  }

  Future<void> _onCreateGroup(
      CreateGroupEvent event, Emitter<GroupCreationState> emit) async {

    emit(GroupCreationInProgress());
    try {
      await createGroupUseCase.execute(event.groupName, event.participantIds, event.adminId);
      emit(GroupCreationSuccess());
    } catch (e) {
      emit(GroupCreationFailure(e.toString()));
    }
  }
}
