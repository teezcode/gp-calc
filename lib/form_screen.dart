import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  int _formCount = 5;
  final _formKey = GlobalKey<FormState>();

  //String _gradeDropdownValue = 'Grade';
  List<String> _gradeDropdownValues = [];
  Map<String, int> _gradeDropDownItems = {
    'Grade': 0,
    'A': 5,
    'B': 4,
    'C': 3,
    'D': 2,
    'E': 1,
    'F': 0,
    'Missing Script': 0
  };

  List<TextEditingController> _unitLoadControllers = [];

  void _initForm() {
    _gradeDropdownValues.clear();
    for (int i = 0; i < _formCount; i++) {
      _gradeDropdownValues.add('Grade');
      _unitLoadControllers.add(TextEditingController());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _initForm();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('GP Calculator')),
        actions: [
          IconButton(
              icon: Icon(Icons.add_circle_outline),
              onPressed: () {
                setState(() {
                  _formCount++;
                  // _initDropDown();
                  _gradeDropdownValues.add('Grade');
                  _unitLoadControllers.add(TextEditingController());
                });
              }),
          IconButton(
              icon: Icon(Icons.remove_circle_outline),
              onPressed: () {
                setState(() {
                  if (_formCount > 1) {
                    _formCount--;
                    // _initDropDown();
                    _gradeDropdownValues.removeLast();
                    _unitLoadControllers.removeLast();
                  }
                });
              })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              ListView.builder(
                itemCount: _formCount,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: 'Course Code',
                              hintText: 'Enter Course code here',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 2,
                          child: DropdownButtonFormField<String>(
                            value: _gradeDropdownValues[index],
                            icon: Icon(Icons.arrow_drop_down),
                            onChanged: (String grade) {
                              setState(() {
                                _gradeDropdownValues[index] = grade;
                              });
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            items: _gradeDropDownItems.keys
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: _unitLoadControllers[index],
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Required';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Unit Load',
                              hintText: 'Enter Unit Load here',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(child:
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        if (_validateDropdown()) {
                          _showGradePoint(_calculate());
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                            'Enter all forms required',
                            textAlign: TextAlign.center,
                          )));
                        }
                      }
                    },
                    child: Text('Calculate'),
                  ),),
                  SizedBox(width: 20,),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        //_formKey.currentState.reset();
                        for(int i=0; i<_formCount; i++){
                          setState(() {
                            _unitLoadControllers[i].clear();
                            _gradeDropdownValues[i]='Grade';
                          });
                        }
                      },
                      child: Text('Reset'),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                    ),
                  )
                ],
              ),

            ],

          ),
        ),
      ),
    );
  }

  bool _validateDropdown() {
    bool valid = true;
    _gradeDropdownValues.forEach((value) {
      if (value == 'Grade') {
        valid = false;
      }
    });
    return valid;
  }

  double _calculate() {
    double totalPoint = 0, totalUnit = 0, gradePoint = 0;
    for (int i = 0; i < _formCount; i++) {
      totalUnit += double.parse(_unitLoadControllers[i].text);
      totalPoint += double.parse(_unitLoadControllers[i].text) *
          _gradeDropDownItems[_gradeDropdownValues[i]];
    }
    gradePoint = totalPoint / totalUnit;
    return gradePoint;
  }

  void _showGradePoint(double gradePoint) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Your Grade Point is:'),
        content: Text(
          '${gradePoint.toStringAsFixed(2)}',
          style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'))
        ],
      ),
    );
  }
}
