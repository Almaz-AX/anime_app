import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      child: BlocConsumer<ChangeUserNameBloc, ChangeUserNameState>(
        listener: (context, state) {
          if (state.status == ChangeUserNameStatus.nameIsChanged) {
            Navigator.of(context).pop(state.newUserName);
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
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
