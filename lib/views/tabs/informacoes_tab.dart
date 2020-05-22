import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:my_event/repositories/evento_repository.dart';
import 'package:my_event/stores/evento_store.dart';

class InformacoesTab extends StatelessWidget {
  final _eventoStore = GetIt.instance<EventoStore>();

  Widget _backgroundGradient() => Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.grey[700], Colors.black38],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
      );

  _cardPatrocinadores(
      String parceiroTitle, String parceiroTipo) {
    return Container(
      padding: EdgeInsets.only(top: 10, right: 10, left: 10),
      // height: MediaQuery.of(context).size.height,
      // width: MediaQuery.of(context).size.width,
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(parceiroTitle,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
            GridView.extent(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                maxCrossAxisExtent: 200,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                padding: const EdgeInsets.all(5),
                children: _buildGridTiles(parceiroTipo))
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        elevation: 5,
        margin: EdgeInsets.only(top: 5),
      ),
    );
  }

  List<Widget> _buildGridTiles(String tipo_parceiro) {
    switch (tipo_parceiro) {
      case 'patrocinador':
        List<Widget> containers = List<Container>.generate(
            _eventoStore.evento.patrocinadores.length, (int index) {
          return Container(
              child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
              EventoRepository.url_production + _eventoStore.evento.img_link,
              fit: BoxFit.fill,
            ),
          ));
        });
        return containers;
      case 'apoiador':
        List<Widget> containers = List<Container>.generate(
            // _eventoStore.evento.apoiadores.length, (int index) {
            _eventoStore.evento.patrocinadores.length, (int index) {
          return Container(
              child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
              EventoRepository.url_production + _eventoStore.evento.patrocinadores[2],
              fit: BoxFit.fill,
            ),
          ));
        });
        return containers;
      default: //organizadores
        List<Widget> containers = List<Container>.generate(
            // _eventoStore.evento.organizadores.length, (int index) {
            _eventoStore.evento.patrocinadores.length, (int index) {
          return Container(
              child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
              EventoRepository.url_production + _eventoStore.evento.img_link,
              fit: BoxFit.fill,
            ),
          ));
        });
        return containers;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _backgroundGradient(),
        SingleChildScrollView(
          padding: EdgeInsets.all(5.0),
          child: Column(children: <Widget>[
            Container(
              // backgroundColor: Colors.grey[800]
              padding: EdgeInsets.only(top: 10, right: 10, left: 10),
              height: 500,
              width: MediaQuery.of(context).size.width,
              child: Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Image.network(
                      EventoRepository.url_production +
                          _eventoStore.evento.img_link,
                      fit: BoxFit.fill,
                    ),
                    Text(_eventoStore.evento.titulo,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                    SizedBox(
                      height: 5,
                    ),
                    Row(children: <Widget>[
                      Column(
                        children: <Widget>[
                          Row(children: <Widget>[
                            Icon(
                              Icons.calendar_today,
                              color: Colors.blue,
                              size: 20.0,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(_eventoStore.evento.data_inicio,
                                  style: TextStyle(fontSize: 18)),
                            )
                          ]),
                          SizedBox(
                            height: 5,
                          ),
                          Row(children: <Widget>[
                            Icon(
                              Icons.location_on,
                              color: Colors.blue,
                              size: 20.0,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(_eventoStore.evento.local,
                                  style: TextStyle(fontSize: 18)),
                            )
                          ]),
                        ],
                      ),

                      // Column(children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 30, right: 10),
                          child: RaisedButton(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 20.0,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "Inscrever-se",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ],
                            ),
                            color: Colors.green[800],
                            onPressed: () {
                              print('click...');
                            },
                          ),
                        ),
                      )

                      // ]),
                    ]),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      _eventoStore.evento.descricao,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'Roboto',
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                elevation: 5,
                margin: EdgeInsets.only(top: 5),
              ),
            ),
            if (_eventoStore.evento.patrocinadores.length > 0)
              _cardPatrocinadores('Patrocínio', 'patrocinador'),

            // if (snapshot.data['apoiadores'].length > 0)
            //   _cardPatrocinadores(
            //       snapshot, 'Apoio', 'apoiadores'),
            // if (snapshot.data['organizadores'].length > 0)
            //   _cardPatrocinadores(
            //       snapshot, 'Organização', 'organizadores')
          ]),
        ),
      ],
    );
  }
}
