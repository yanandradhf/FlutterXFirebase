part of 'pages.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final ctrlEmail = TextEditingController();
  final ctrlPassword = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    ctrlEmail.dispose();
    ctrlPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Sign In"),
        ),
        body: Stack(children: [
          Container(
              margin: EdgeInsets.all(10),
              child: ListView(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: ctrlEmail,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.mail),
                              labelText: 'Email',
                              hintText: "Write your active email",
                              border: OutlineInputBorder())),
                      TextFormField(
                          obscureText: true,
                          controller: ctrlPassword,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.vpn_key),
                              labelText: 'password',
                              hintText: "input your password",
                              border: OutlineInputBorder())),
                      SizedBox(height: 40),
                      RaisedButton.icon(
                        icon: Icon(Icons.cloud_download),
                        label: Text("Sign In"),
                        textColor: Colors.white,
                        color: Colors.blue[500],
                        onPressed: () async {
                          if (ctrlEmail.text == "" || ctrlPassword.text == "") {
                            Fluttertoast.showToast(
                              msg: "Please Fill All Field!",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 20.0,
                            );
                          } else {
                            setState(() {
                              isLoading = true;
                            });
                            String result = await AuthServices.signIn(
                                ctrlEmail.text, ctrlPassword.text);
                            if (result == "success") {
                              Fluttertoast.showToast(
                                msg: "Login Sucess",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 20.0,
                              );
                              setState(() {
                                isLoading = false;
                              });
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return MainMenu();
                              }));
                            } else {
                              Fluttertoast.showToast(
                                msg: result,
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 20.0,
                              );
                              setState(() {
                                isLoading = false;
                              });
                            }
                          }
                        },
                      ),
                      SizedBox(height: 25),
                      RichText(
                          text: TextSpan(
                              text: 'Not Registered? Sign Up',
                              style: TextStyle(color: Colors.blue),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) {
                                    return SignUpPage();
                                  }));
                                })),
                    ],
                  )
                ],
              )),
          isLoading == true
              ? Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.transparent,
                  child: SpinKitFadingCircle(
                    size: 50,
                    color: Colors.blue,
                  ))
              : Container()
        ]),
      ),
    );
  }
}
