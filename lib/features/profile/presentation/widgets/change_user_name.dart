import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../blocs/change_user_name_bloc/change_user_name_bloc.dart';

class ChangeUserName extends StatelessWidget {
  final String userName;
  const ChangeUserName({
    super.key,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ChangeUserNameBloc>();
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      width: double.infinity,
      child: BlocBuilder<ChangeUserNameBloc, ChangeUserNameState>(
        builder: (context, state) {
          return Column(
            children: [
              Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      onPressed: () => context.pop(),
                      icon: const Icon(
                        Icons.cancel,
                        size: 30,
                      ))),
              Text(
                'Изменить имя пользователя',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: TextFormField(
                  onChanged: (value) =>
                      bloc.add(ChangeUserNameCheckEvent(newUserName: value)),
                  onEditingComplete:
                      state.status == ChangeUserNameStatus.nameIsUsed
                          ? null
                          : () {
                              bloc.add(
                                const ChangeUserNameSendEvent(),
                              );
                              Navigator.of(context).pop(state.newUserName);
                            },
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: userName,
                    helperText:
                        state.status != ChangeUserNameStatus.nameIsNotUsed
                            ? ''
                            : 'Имя пользователя ${state.newUserName} свободно',
                    errorText: state.status == ChangeUserNameStatus.nameIsUsed
                        ? 'Имя пользователя ${state.newUserName} занято'
                        : null,
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                  onPressed: state.status == ChangeUserNameStatus.nameIsNotUsed
                      ? () {
                          bloc.add(const ChangeUserNameSendEvent());
                          Navigator.of(context).pop(state.newUserName);
                        }
                      : null,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text('Изменить имя'),
                  ))
            ],
          );
        },
      ),
    );
  }
}
