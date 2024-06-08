// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../controllers/tricks_controller.dart';
import '../models/trick_model.dart';
import '../models/trick_step_model.dart';
import '../widgets/button_widget.dart';
import '../widgets/textformfield_widget.dart';

class TricksView extends StatefulWidget {
  const TricksView({super.key});

  @override
  State<TricksView> createState() => _TricksViewState();
}

class _TricksViewState extends State<TricksView> {
  final tricksController = TricksController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset(
                  'assets/images/sls-logo_thumb-detail.png',
                  width: 32.0,
                  height: 32.0,
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _titleSession('Minhas tricks'),
                    IconButton(
                      onPressed: () => showDialog(
                        context: context,
                        builder: (context) => _showDialogAddTrick(),
                      ),
                      icon: Icon(Icons.add),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: tricksController.tricks.length,
                  itemBuilder: (context, index) => _cardTrick(
                    trick: TrickModel(
                      id: tricksController.tricks[index].id,
                      name: tricksController.tricks[index].name,
                      idUser: tricksController.tricks[index].idUser,
                      isFavorite: tricksController.tricks[index].isFavorite,
                      steps: tricksController.tricks[index].steps,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _titleSession(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16.0,
      ),
    );
  }

  Widget _cardTrick({required TrickModel trick}) {
    final hasSteps = trick.steps.isNotEmpty;
    final isOpenNotify = ValueNotifier<bool>(true);
    final isFavoriteNotify = ValueNotifier<bool>(false);

    return ValueListenableBuilder<bool>(
      valueListenable: isOpenNotify,
      builder: (context, isOpen, child) => Card(
        margin: const EdgeInsets.only(bottom: 24.0),
        child: AnimatedContainer(
          height: isOpen
              ? hasSteps
                  ? 260.0
                  : 180.0
              : 48.0,
          duration: Duration(milliseconds: 0),
          child: Column(
            children: [
              ListTile(
                onTap: () => isOpenNotify.value = !isOpen,
                leading: ValueListenableBuilder<bool>(
                  valueListenable: isFavoriteNotify,
                  builder: (context, isFavorite, child) => IconButton(
                    onPressed: () => isFavoriteNotify.value = !isFavorite,
                    icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border),
                    color: isFavorite ? Colors.red[700] : Colors.grey,
                  ),
                ),
                title: SizedBox(
                  width: double.infinity,
                  child: Text(
                    trick.name,
                    textAlign: TextAlign.center,
                  ),
                ),
                trailing: Icon(
                  isOpen
                      ? Icons.keyboard_arrow_up_sharp
                      : Icons.keyboard_arrow_down_sharp,
                  color: Colors.grey,
                ),
              ),
              isOpen ? _cardTrickOpen(trick: trick) : SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  Widget _cardTrickOpen({required TrickModel trick}) {
    bool hasSteps = trick.steps.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        children: [
          SizedBox(
            height: hasSteps ? 136.0 : 60.0,
            child: hasSteps
                ? ListView.builder(
                    itemCount: trick.steps.length,
                    itemBuilder: (context, index) => _trickSubItem(
                      step: TrickStepModel(
                        id: trick.steps[index].id,
                        name: trick.steps[index].name,
                        idTrick: trick.steps[index].idTrick,
                        isChecked: trick.steps[index].isChecked,
                      ),
                    ),
                  )
                : SizedBox(
                    child: Center(
                      child: Text(
                        'Você não adicionou nenhuma etapa aprendida\n em sua trick ainda',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ),
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () => showModalBottomSheet(
                  context: context,
                  builder: (context) => _showDialogAddStepBottomSheet(trick),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.add),
                      SizedBox(width: 16.0),
                      Text('Nova etapa'),
                    ],
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => _showDialogRemoveStep(trick: trick),
                  );
                },
                icon: Icon(
                  Icons.delete_outline,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _trickSubItem({required TrickStepModel step}) {
    final isCheckedNotify = ValueNotifier(step.isChecked);

    return ValueListenableBuilder<bool>(
      valueListenable: isCheckedNotify,
      builder: (context, isChecked, child) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Checkbox(
              value: isChecked,
              onChanged: (value) => isCheckedNotify.value = !isChecked,
            ),
            SizedBox(width: 16.0),
            Text(step.name),
          ],
        ),
      ),
    );
  }

  Widget _showDialogAddStepBottomSheet(TrickModel trick) {
    return Container(
      height: 320.0,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  trick.name,
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close),
                  color: Colors.grey,
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            'Nova etapa',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Informe a nova etapa a ser vencida para aprimorar sua trick',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12.0,
            ),
          ),
          SizedBox(height: 24.0),
          TextFormFieldWidget(
            maxLength: 30,
            label: 'Nova etapa',
            hintText: 'fs ollie',
          ),
          Spacer(),
          ButtonWidget(
            color: Colors.red[700]!,
            textColor: Colors.white,
            onPressed: () => Navigator.pop(context),
            text: 'Nova etapa',
          ),
        ],
      ),
    );
  }

  Widget _showDialogRemoveStep({required TrickModel trick}) {
    return AlertDialog(
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: SizedBox(
            width: 100.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.delete_outline),
                SizedBox(width: 8.0),
                Text('Apagar'),
              ],
            ),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Cancelar',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
      ],
      content: SizedBox(
        width: 280.0,
        height: 80.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  trick.name,
                  style: TextStyle(fontSize: 18.0),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              'Tem certeza que deseja apagar sua trick?',
              style: TextStyle(color: Colors.grey),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _showDialogAddTrick() {
    return AlertDialog(
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: SizedBox(
            width: 100.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.add),
                SizedBox(width: 8.0),
                Text('Nova trick'),
              ],
            ),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Cancelar',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
      ],
      content: SizedBox(
        width: 360.0,
        height: 200.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Nova trick',
                  style: TextStyle(fontSize: 18.0),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close),
                ),
              ],
            ),
            Spacer(),
            Text(
              'Informe o nome da sua nova trick',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 8.0),
            TextFormFieldWidget(
              label: 'nome',
              maxLength: 35,
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
