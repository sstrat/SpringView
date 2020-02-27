import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:social_app/Authentification.dart';
import 'DialogBox.dart';

class LoginRegisterPage extends StatefulWidget{
  LoginRegisterPage({
    this.auth,
    this.onSignedIn,
  });
  final AuthImplementaion auth;
  final VoidCallback onSignedIn;
  State<StatefulWidget> createState(){
    return _LoginRegisterState();
  }

}

enum FormType{
  login,
  register
}

class _LoginRegisterState extends State<LoginRegisterPage> {
  DialogBox dialogBox = new DialogBox();

  final formKey = new GlobalKey<FormState>();
  FormType _formType  = FormType.login;
  String _email = "";
  String _password = "";

  //metode
  bool validateAndSave(){
    final form = formKey.currentState;
    if(form.validate()){
      form.save();
      return true;
    }else{
      return false;
    }
  }

  void validateAndSubmit() async {
    if(validateAndSave()){
      try{
        if(_formType == FormType.login){
          String userId = await widget.auth.SignIn(_email, _password);
          //dialogBox.information(context, "Felicitari ", "te-ai logat cu succes");
          print("login userId = " + userId);
        }else {
          String userId = await widget.auth.SignUp(_email, _password);
          //dialogBox.information(context, "Felicitari ", "Contul tau a fost creat cu succes!");
          print("Register userId = " + userId);
        }

        widget.onSignedIn();
      }catch(e){
        dialogBox.information(context, "Error = ", e.toString());
        print("Error = " + e.toString());

      }
    }
  }

  void moveToRegister(){
    formKey.currentState.reset();

    setState(() {
      _formType = FormType.register;
    });
  }
  void moveToLogin(){
    formKey.currentState.reset();

    setState(() {
      _formType = FormType.login;
    });
  }

  //design
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Social App"),
      ),
      body: new Container(
        margin: EdgeInsets.all(15.0),
        child: new Form(

          key: formKey,

          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: createInputs() + createButtons(),

          ),
        ),
      ),
    );
  }

  
  List<Widget> createInputs(){
    return[
      SizedBox(height: 10.0),
      logo(),
      SizedBox(height: 20.0),

      new TextFormField(
        
        decoration: new InputDecoration(labelText: 'Email'),
        validator: (value){
          return value.isEmpty ? 'Trebuie sa introduci emailul.' : null;
        },

        onSaved: (value){
          return _email = value;
        },
      ),
      SizedBox(height: 10.0),
      new TextFormField(
        
        decoration: new InputDecoration(labelText: 'Parola'),
        obscureText: true,
        validator: (value){
          return value.isEmpty ? 'Trebuie sa introduci parola.' : null;
        },

        onSaved: (value){
          return _password = value;
        },
      ),
      SizedBox(height: 20.0),

    ];
  }

  Widget logo(){
    return new Flexible(
      child: new CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 110.0,
        child: Image.asset('images/logo.png'),
      )
    );
  }

  List<Widget> createButtons(){
    if(_formType == FormType.login){
       return[
        new RaisedButton(
          child: new Text("Logare", style: new TextStyle(fontSize: 20.0)),
          textColor: Colors.white,
          color: Colors.green,
          onPressed: validateAndSubmit,
        ),

        new FlatButton(
          child: new Text("Nui ai un cont? Vrei sa creezi unul?", style: new TextStyle(fontSize: 14.0)),
          textColor: Colors.green,

          
          onPressed: moveToRegister,
        ),
      ];
    }
    else{
      return[
        new RaisedButton(
          child: new Text("Creeaza Cont", style: new TextStyle(fontSize: 20.0)),
          textColor: Colors.white,
          color: Colors.green,
          onPressed: validateAndSubmit,
        ),

        new FlatButton(
          child: new Text("Ai deja un cont? Logare?", style: new TextStyle(fontSize: 14.0)),
          textColor: Colors.green,

          
          onPressed: moveToLogin,
        ),
      ];

    }
  }

}

