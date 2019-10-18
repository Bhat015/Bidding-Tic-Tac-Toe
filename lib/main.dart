import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tic-Tac-Toe',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: HomePage()
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  BuildContext scaffoldContext;

  TextEditingController _textFieldControllerpo = TextEditingController();
  TextEditingController _textFieldControllerpx = TextEditingController();

  int _flag =0;

  String _playero;
  String _playerx;
  int po_balance, px_balance;
  String _lastChar ;

  List<List> _matrix;


  _HomePageState() {
    _initMatrix();
    _initBalance();
  }

  _initBalance(){
    _lastChar = ' ';
    po_balance=100;
    px_balance=100;

  }

  _initMatrix() {
    _matrix = List<List>(3);
    for (var i = 0; i < _matrix.length; i++) {
      _matrix[i] = List(3);
      for (var j = 0; j < _matrix[i].length; j++) {
        _matrix[i][j] = ' ';
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        resizeToAvoidBottomPadding: false,
        //key: scaffoldKey,

        appBar: AppBar(
          backgroundColor: Colors.greenAccent,
          title: Text(
              '                Tic Tac Toe',textAlign: TextAlign.center,
                  style: TextStyle(
              fontSize: 28.0,color: Colors.white,
          ),
          ),

        ),
        body:new Builder(builder: (BuildContext context) {
          scaffoldContext = context;
          return new Center(
          child: Column(

            children: [
             SizedBox(height: 10,),
              Row(
                children: <Widget>[
                  SizedBox(width: 06,),
                  _balance(),
                ],
              ),
              SizedBox(height: 20,),
              new Row(
                children:[
                  SizedBox(width: 10,),
                  new Container(
                    width: 150,
                    child: new TextField( keyboardType: TextInputType.number,
                      controller: _textFieldControllerpo,
                      autofocus: false,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'PO Bid',
                        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(132.0)),
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.attach_money,
                            color: Colors.deepPurple,
                          ),
                        ),
                      ),
                        onChanged: (val) {
                          _playero = val;
                        }
                    ),
                  ),
                  SizedBox(width: 25,),
                  new Container(
                    width: 150,
                    child: new TextField( keyboardType: TextInputType.number,
                        controller: _textFieldControllerpx,
                      obscureText: true,
                      autofocus: false,
                      decoration: InputDecoration(
                        hintText: 'PX Bid',
                        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(132.0)),
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.attach_money,
                            color: Colors.deepPurple,
                          ),
                        ),
                      ),
                        onChanged: (val) {
                          _playerx = val;
                        }
                    ),
                  ),
                ],
               ),
              SizedBox(height: 10,),
              new Container(
                width: 80,
                child:new Material(
                  borderRadius: BorderRadius.circular(30.5),
                  shadowColor: Colors.lightBlueAccent.shade100,
                  elevation: 1.0,
                  child: new MaterialButton(
                    onPressed: () {
                      _bid();

                    },
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                    child: Text('BID', style: TextStyle(color: Colors.black,fontSize: 15)),
                  ),
                ),
              ),
              SizedBox(height: 45,),

              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildElement(0, 0),
                  _buildElement(0, 1),
                  _buildElement(0, 2),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildElement(1, 0),
                  _buildElement(1, 1),
                  _buildElement(1, 2),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildElement(2, 0),
                  _buildElement(2, 1),
                  _buildElement(2, 2),
                ],
              ),
            ],
          ),
        );
        }
      ),
    );
  }




  _bid(){
    _flag = 1;
    int po,px;
    po = int.parse(_playero);
    px = int.parse(_playerx);


        if(po<=po_balance && px<=px_balance) {
          if (px > po) {
            createSnackBar('Player X wins the Bid',po,px);
            _lastChar = 'x';
            px_balance = px_balance - px;
            po_balance = po_balance + px;
          }
          else{

            createSnackBar('Player O wins the Bid',po,px);
            _lastChar = 'o';
            px_balance = px_balance + po;
            po_balance = po_balance - po;
          }


        }
        else if (px_balance < 0){
          _blanaceout("O","X");
        }
        else if (po_balance<0){
          _blanaceout("X","O");
        }
        else
          _error();



        setState((){
          _textFieldControllerpo.text = "";
          _textFieldControllerpx.text = "";

        });





  }

  _error(){
    return showDialog(

        context: context,
        builder: (_) => new AlertDialog(
          title: new Text("Error!",style: TextStyle(color: Colors.red)),
          content: new Text("Entered bid is greater than balance\n Please Re-Bid"),
        )
    );

  }

  _blanaceout(String p1,String p2){


      return showDialog(

          context: context,
          builder: (_) => new AlertDialog(
            title: new Text("GAME OVER!",style: TextStyle(color: Colors.red)),
            content: new Text("Player $p1 Wins as Player $p2 Balance = 0 "),
            actions: <Widget>[
              FlatButton(
                child: Text('Reset Game'),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    _initMatrix();
                  });
                },
              )
            ],
          )
      );


  }

  _balance(){
    return Container(
      width: 360,
      child: Column(
        children: <Widget>[
          new Text("    Balance : ",style: TextStyle(fontStyle: FontStyle.normal,fontSize: 20),),
          SizedBox(height: 10,),
          new Row(
            children: <Widget>[
              SizedBox(width: 15,),
              new Text("Player O Balance = $po_balance "),
              SizedBox(width: 25,),
              new Text("Player X Balance = $px_balance"),
            ],
          ),

        ],
      ),
    );
  }



  _buildElement(int i, int j) {



    return GestureDetector(
      onTap: () {
        _changeMatrixField(i, j);


        if (_checkWinner(i, j)) {
          _showDialog(_matrix[i][j]);
        } else {
          if (_checkDraw()) {
            _showDialog(null);
          }
        }
      },
      child: Container(
        width: 90.0,
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            border: Border.all(
                color: Colors.redAccent
            )
        ),
        child: Center(
          child: Text(
            _matrix[i][j],
            style: TextStyle(
                fontSize: 92.0
            ),
          ),
        ),
      ),
    );
  }



  _changeMatrixField(int i, int j) {
    setState(() {
      if (_matrix[i][j] == ' ') {
        if (_lastChar == 'o')
          _matrix[i][j] = 'o';

        else
          _matrix[i][j] = 'x';

        //_lastChar = _matrix[i][j];
      }
    });
  }

  _checkDraw() {
    var draw = true;
    _matrix.forEach((i) {
      i.forEach((j) {
        if (j == ' ')
          draw = false;
      });
    });
    return draw;
  }

  _checkWinner(int x, int y) {
    var col = 0, row = 0, diag = 0, rdiag = 0;
    var n = _matrix.length-1;
    var player = _matrix[x][y];

    for (int i = 0; i < _matrix.length; i++) {
      if (_matrix[x][i] == player)
        col++;
      if (_matrix[i][y] == player)
        row++;
      if (_matrix[i][i] == player)
        diag++;
      if (_matrix[i][n-i] == player)
        rdiag++;
    }
    if (row == n+1 || col == n+1 || diag == n+1 || rdiag == n+1) {
      return true;
    }
    return false;
  }

    void createSnackBar(String message,int po,int px) {
      final snackBar = new SnackBar(
          content: new Text("Player O bid  = $po \t Player X bid = $px\n"+message,style: TextStyle(color: Colors.black),textAlign: TextAlign.center,),
          backgroundColor: Colors.orangeAccent
      );

      // Find the Scaffold in the Widget tree and use it to show a SnackBar!
      Scaffold.of(scaffoldContext).showSnackBar(snackBar);
    }




  _showDialog(String winner) {
    String dialogText;
    if (winner == null) {
      dialogText = 'It\'s a draw';
    } else {
      dialogText = 'Player $winner won';
    }


    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Game over'),
            content: Text(dialogText),
            actions: <Widget>[
              FlatButton(
                child: Text('Reset Game'),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    _initMatrix();
                    _initBalance();
                  });
                },
              )
            ],
          );
        }
    );
  }
}