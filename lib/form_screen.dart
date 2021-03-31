import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {

  int _formCount=5;
  String _gradeDropdownValue = 'Grade';
  List<String> _gradeDropdownValues=[];
  Map<String, int> _gradeDropDownItems={'Grade':0,'A':5,'B':4,'C':3,'D':2,'E':1,'F':0,'Missing Script':0};

  void _intDropDown(){
    for(int i=0; i < _formCount; i++){
      _
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('GP Calculator')),
        actions: [
          IconButton(icon: Icon(Icons.add_circle_outline),
              onPressed:(){
              setState(() {
                _formCount ++;
              });
       }),
          IconButton(icon: Icon(Icons.remove_circle_outline),
         onPressed:(){
        setState(() {
          if(_formCount > 1){
            _formCount --;
          }
        });
    })

        ],
        ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:8.0),
        child: ListView(
          children: [
            ListView.builder(
                itemCount:_formCount,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index){
                  return Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Course Code',
                            hintText: 'Enter Course code here',
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      DropdownButton<String>(
                        value: _gradeDropdownValue,
                        icon: Icon(Icons.arrow_drop_down),
                        onChanged: (String grade){
                        setState(() {
                          _gradeDropdownValue=grade;
                        });
                        },
                        items:_gradeDropDownItems.keys
                            .map<DropdownMenuItem<String>>(
                                (String value){
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          maxLength: 2,
                          decoration: InputDecoration(
                            labelText: 'Unit Load',
                            hintText: 'Enter Unit Load here',
                          ),
                        ),
                      )
                    ],
                  );
                },
            ),
            ElevatedButton(
                onPressed: (){

                },
              child: Text('Continue'),
            )
          ],
        ),
      ),
    );
  }
}
