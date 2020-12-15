part of 'pages.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final ctrlName = TextEditingController();
  final ctrlEmail = TextEditingController();
  final ctrlPassword = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    ctrlName.dispose();
    ctrlEmail.dispose();
    ctrlPassword.dispose();
    super.dispose();
  }

  void clearForm() {
    ctrlName.clear();
    ctrlEmail.clear();
    ctrlPassword.clear();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              title: Text("Sign Up"),
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
                              controller: ctrlName,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.account_circle),
                                  labelText: 'Full Name',
                                  hintText: "Write your full name",
                                  border: OutlineInputBorder())),
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
                            icon: Icon(Icons.cloud_upload),
                            label: Text("Sign Up"),
                            textColor: Colors.white,
                            color: Colors.blue[500],
                            onPressed: () async {
                              if (ctrlName.text == "" ||
                                  ctrlEmail.text == "" ||
                                  ctrlPassword.text == "") {
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
                                String result = await AuthServices.signUp(
                                    ctrlEmail.text,
                                    ctrlPassword.text,
                                    ctrlName.text);
                                if (result == "success") {
                                  Fluttertoast.showToast(
                                    msg: "Sign Up Success",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 20.0,
                                  );
                                  setState(() {
                                    isLoading = false;
                                    clearForm();
                                  });
                                } else {
                                  Fluttertoast.showToast(
                                    msg: result,
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: Colors.green,
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
                                text: 'Already Registered? Sign In',
                                style: TextStyle(color: Colors.blue),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (context) {
                                      return SignInPage();
                                    }));
                                  }),
                          ),
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
            ])));
  }
}
