import 'package:axalta/model/weighing_product_dto.dart';
import 'package:axalta/services/weight/weight_service.dart';
import 'package:flutter/material.dart';

class PigmentView extends StatefulWidget {
  const PigmentView({super.key});

  @override
  State<PigmentView> createState() => _PigmentViewState();
}

class _PigmentViewState extends State<PigmentView> {
  late final TextEditingController _lineNo;
  late final TextEditingController _bacthNo;
  late final TextEditingController _mixNo;
  late final TextEditingController _productNumber;
  late final TextEditingController _sequenceNo;
  late final TextEditingController _weight;
  late final TextEditingController _qrCode;

  @override
  void initState() {
    _lineNo = TextEditingController();
    _bacthNo = TextEditingController();
    _mixNo = TextEditingController();
    _productNumber = TextEditingController();
    _sequenceNo = TextEditingController();
    _weight = TextEditingController();
    _qrCode = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _lineNo.dispose();
    _bacthNo.dispose();
    _mixNo.dispose();
    _productNumber.dispose();
    _sequenceNo.dispose();
    _weight.dispose();
    _qrCode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pigment Tartım"),
      ),
      body: FutureBuilder(
        future: createNewWeighing(),
        builder: (context, snapshot) {
          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 150,
                  color: Colors.grey[400],
                  child: Column(
                    children: [
                      TextField(
                        controller: _lineNo,
                        keyboardType: TextInputType.text,
                        maxLines: null,
                        decoration: const InputDecoration(
                            hintText: "Hat No",
                            contentPadding: EdgeInsets.all(8)),
                      ),
                      TextField(
                        controller: _bacthNo,
                        keyboardType: TextInputType.text,
                        maxLines: null,
                        decoration: const InputDecoration(
                            hintText: "Batch No",
                            contentPadding: EdgeInsets.all(8)),
                      ),
                      TextField(
                        controller: _mixNo,
                        keyboardType: TextInputType.text,
                        maxLines: null,
                        decoration: const InputDecoration(
                            hintText: "Mix No",
                            contentPadding: EdgeInsets.all(8)),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  color: Colors.grey[400],
                  child: Column(
                    children: [
                      TextField(
                        controller: _qrCode,
                        keyboardType: TextInputType.text,
                        maxLines: null,
                        decoration: const InputDecoration(
                            hintText: "Ürün Barkodu Okut",
                            contentPadding: EdgeInsets.all(8)),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  color: Colors.grey[400],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Birinci butonun işlevi
                        },
                        child: const Text('Başla'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // İkinci butonun işlevi
                        },
                        child: const Text('Detay'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          WeighingProductDto dto = WeighingProductDto(
                              id: 1,
                              lineNumber: int.parse(_lineNo.text),
                              batchNo: _bacthNo.text,
                              mixNo: int.parse(_mixNo.text),
                              isExtra: false,
                              sequenceNumber: 2,
                              productNumber: _qrCode.text,
                              weight: "22",
                              isDone: true);

                          await ApiService().postData(dto);
                          // Üçüncü butonun işlevi
                        },
                        child: const Text('Ok'),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 40,
                  color: Colors.grey[400],
                  child: DataTable(
                    headingRowHeight: 20,
                    dataRowHeight: 20,
                    columns: const [
                      DataColumn(
                        label: Text('Sıra', style: TextStyle(fontSize: 10)),
                        tooltip: 'Sıra',
                      ),
                      DataColumn(
                          label: Text('Ürün Kodu',
                              style: TextStyle(fontSize: 10))),
                      DataColumn(
                          label:
                              Text('Ağırlık', style: TextStyle(fontSize: 10))),
                    ],
                    rows: getTableRowData(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  color: Colors.grey[400],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Birinci butonun işlevi
                        },
                        child: const Text('Duraklat'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // İkinci butonun işlevi
                        },
                        child: const Text('Tartımı Bitir'),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

Future createNewWeighing() async {}
List<DataRow> getTableRowData() {
  // Tablo verilerini döndüren bir fonksiyon
  List<DataRow> rows = [
    DataRow(cells: [
      DataCell(Text('John', style: TextStyle(fontSize: 10))),
      DataCell(Text('Doe', style: TextStyle(fontSize: 10))),
      DataCell(Text('30', style: TextStyle(fontSize: 10))),
    ])
  ];
  return rows;
}
