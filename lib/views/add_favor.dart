import 'package:flutter/material.dart';

import '../models/favor.dart';
import '../models/repository/favor_repository.dart';

class AddFavorView extends StatefulWidget {
  const AddFavorView({Key? key}) : super(key: key);

  @override
  State<AddFavorView> createState() => _AddFavorViewState();
}

class _AddFavorViewState extends State<AddFavorView> {
  String valeurChoisi = FavorRepository.nameList[0];
  String? motif, contenu;
  DateTime? creneau;
  GlobalKey<FormState> keyForm = GlobalKey();
  TextEditingController motifController = TextEditingController();
  TextEditingController contenuController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Faire une demande"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
              key: keyForm,
              child: ListView(
                children: [
                  DropdownButtonFormField(
                      decoration: InputDecoration(border: OutlineInputBorder()),
                      value: FavorRepository.nameList[0],
                      items: FavorRepository.nameList
                          .map((name) =>
                              DropdownMenuItem(child: Text(name), value: name))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          valeurChoisi = value.toString();
                        });
                      }),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: motifController,
                    onChanged: (value) {
                      setState(() {
                        motif = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "Tapez le motif",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Ce champ ne peut pas être vide";
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: contenuController,
                    maxLines: 5,
                    onChanged: (value) {
                      setState(() {
                        contenu = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "Tapez le contenu",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Yiooah ce champ ne peut pas être vide";
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.parse("1970-01-01"),
                              lastDate: DateTime.parse("2040-12-31"))
                          .then((value) {
                        setState(() {
                          creneau = value;
                        });
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 10),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      height: 50,
                      //width: MediaQuery.of(context).size.width,
                      child: Text((creneau != null)
                          ? creneau.toString()
                          : "Choisir un creneau"),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (keyForm.currentState!.validate()) {
                          Favor favor = Favor(
                              nom: valeurChoisi,
                              motif: motif.toString(),
                              description: contenu.toString(),
                              creneau: creneau!.toLocal(),
                              statut: 0);
                          FavorRepository.favorList.add(favor);
                          setState(() {
                            motifController.clear();
                            contenuController.clear();
                            creneau = null;
                          });
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: Text("Alerte"),
                                    content:
                                        Text("Faveur ajoutée avec succès!!"),
                                  ));
                        }
                      },
                      child: Text("Valider"),
                      style: ButtonStyle())
                ],
              ))),
    );
  }
}
