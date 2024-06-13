// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
                StreamBuilder<QuerySnapshot>(
                  stream: tricksController.listarTricks().snapshots(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return Center(
                          child: Text('Falha na conexão.'),
                        );
                      case ConnectionState.waiting:
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      default:
                        final dados = snapshot.requireData;

                        if (dados.size > 0) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: dados.size,
                            itemBuilder: (context, index) {
                              String id = dados.docs[index].id;
                              dynamic item = dados.docs[index].data();

                              return _cardTrick(
                                trick: TrickModel(
                                  uid: id,
                                  name: item["name"],
                                  idUser: item["idUser"],
                                  isFavorite: item["isFavorite"] ?? false,
                                ),
                              );
                            },
                          );
                        }

                        return SizedBox();
                    }
                  },
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

  Widget _cardTrick({required TrickModel trick, bool isOpen = false}) {
    final isOpenNotify = ValueNotifier<bool>(isOpen);
    final isFavoriteNotify = ValueNotifier<bool>(trick.isFavorite);

    return ValueListenableBuilder<bool>(
      valueListenable: isOpenNotify,
      builder: (context, isOpen, child) => Card(
        margin: const EdgeInsets.only(bottom: 24.0),
        child: AnimatedContainer(
          height: isOpen ? 520.0 : 48.0,
          duration: Duration(milliseconds: 0),
          child: Column(
            children: [
              ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                onTap: () => isOpenNotify.value = !isOpen,
                leading: ValueListenableBuilder<bool>(
                  valueListenable: isFavoriteNotify,
                  builder: (context, isFavorite, child) => IconButton(
                    onPressed: () {
                      isFavoriteNotify.value = !isFavorite;
                      tricksController.updateFavoriteTrick(
                        context: context,
                        idTrick: trick.uid,
                        isFavorite: !isFavorite,
                      );
                    },
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
    return StreamBuilder<QuerySnapshot>(
      stream: tricksController.listarStepTricks(trick.uid).snapshots(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Center(
              child: Text('Falha na conexão.'),
            );
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
          default:
            final dados = snapshot.requireData;
            final hasSteps = dados.size > 0;

            return ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 460.0),
              child: Container(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  top: 16.0,
                ),
                child: Column(
                  children: [
                    hasSteps
                        ? SizedBox(
                            height: 380.0,
                            child: ListView.builder(
                              itemCount: dados.size,
                              itemBuilder: (context, index) {
                                String id = dados.docs[index].id;
                                dynamic item = dados.docs[index].data();

                                return _trickSubItem(
                                  step: TrickStepModel(
                                    uid: id,
                                    name: item["name"],
                                    idTrick: item["idTrick"],
                                    isChecked: item["isChecked"],
                                  ),
                                );
                              },
                            ),
                          )
                        : Expanded(
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
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => showDialog(
                            context: context,
                            builder: (context) =>
                                _showDialogAddStepBottomSheet(trick),
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
                          icon: Icon(Icons.delete_outline),
                          onPressed: () => showDialog(
                            context: context,
                            builder: (context) =>
                                _showDialogRemoveStep(trick: trick),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
        }
      },
    );
  }

  Widget _trickSubItem({required TrickStepModel step}) {
    final isCheckedNotify = ValueNotifier(step.isChecked);

    return ValueListenableBuilder<bool>(
      valueListenable: isCheckedNotify,
      builder: (context, isChecked, child) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Checkbox(
              value: isChecked,
              onChanged: (value) {
                isCheckedNotify.value = !isChecked;
                tricksController.updateCheckTrickStep(
                  context: context,
                  idTrickStep: step.uid,
                  isChecked: !isChecked,
                );
              },
            ),
            SizedBox(width: 16.0),
            Text(step.name),
          ],
        ),
      ),
    );
  }

  Widget _showDialogAddStepBottomSheet(TrickModel trick) {
    final txtNameStepTrick = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return AlertDialog(
      content: Container(
        height: 340.0,
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
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
                controller: txtNameStepTrick,
                maxLength: 30,
                label: 'Nova etapa',
                hintText: 'fs ollie',
                validator: (value) =>
                    tricksController.validateNameTrickStep(name: value),
              ),
              Spacer(),
              ButtonWidget(
                color: Colors.red[700]!,
                textColor: Colors.white,
                onPressed: () => tricksController.addTrickStep(
                  formKey: formKey,
                  context: context,
                  trickStep: TrickStepModel(
                    uid: '',
                    name: txtNameStepTrick.text,
                    idTrick: trick.uid,
                  ),
                ),
                text: 'Nova etapa',
              ),
              SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _showDialogRemoveStep({required TrickModel trick}) {
    return AlertDialog(
      actions: [
        TextButton(
          onPressed: () => tricksController.excluir(
            context: context,
            id: trick.uid,
          ),
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
    final txtNameTrick = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return AlertDialog(
      actions: [
        TextButton(
          onPressed: () => tricksController.addTrick(
            formKey: formKey,
            context: context,
            name: txtNameTrick.text,
          ),
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
        child: Form(
          key: formKey,
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
                controller: txtNameTrick,
                label: 'nome',
                maxLength: 35,
                validator: (value) =>
                    tricksController.validateTrickName(name: value),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
