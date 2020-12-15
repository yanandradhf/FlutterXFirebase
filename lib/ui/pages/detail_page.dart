part of "pages.dart";

class Detailpage extends StatefulWidget {
  Products product;
  Detailpage({Key key, this.product}) : super(key: key);
  @override
  _DetailpageState createState() => _DetailpageState();
}

class _DetailpageState extends State<Detailpage> {
  final ctrlName = TextEditingController();
  final ctrlPrice = TextEditingController();
  bool isLoading = false;
  CollectionReference productCollection =
      FirebaseFirestore.instance.collection("products");
  //.doc("${widget.id}");
  @override
  void dispose() {
    ctrlName.dispose();
    ctrlPrice.dispose();
    super.dispose();
  }

  void clearForm() {
    ctrlName.clear();
    ctrlPrice.clear();
    setState(() {
      imageFile = null;
    });
  }

  PickedFile imageFile;
  final ImagePicker imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Data"),
        centerTitle: true,
        leading: Container(),
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: [
                Column(
                  children: [
                    SizedBox(height: 10),
                    TextFormField(
                      controller: ctrlName..text = "${widget.product.name}",
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.add_box),
                          labelText: 'Product Name',
                          hintText: "Write your product name",
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: ctrlPrice..text = "${widget.product.price}",
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.attach_money),
                          labelText: 'Product Price',
                          hintText: "Write your price",
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(height: 20),
                    Container(
                      child: Image.network("${widget.product.image}"),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton(
                            color: Colors.blue,
                            textColor: Colors.white,
                            padding: EdgeInsets.all(15),
                            child: Text("Edit Product"),
                            onPressed: () async {
                              if (ctrlName.text == "" || ctrlPrice.text == "") {
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
                                bool result = await ProductServices.editProduct(
                                    ctrlName.text,
                                    ctrlPrice.text,
                                    "${widget.product.id}");
                                print(result);
                                if (result == true) {
                                  Fluttertoast.showToast(
                                    msg: "Edit Products Success",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: Colors.green,
                                    textColor: Colors.white,
                                    fontSize: 20.0,
                                  );
                                  clearForm();
                                  setState(() {
                                    isLoading = false;
                                  });
                                  Navigator.of(context).pop();
                                } else {
                                  Fluttertoast.showToast(
                                    msg: "Failed! Try Again",
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
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        RaisedButton(
                          color: Colors.red,
                          textColor: Colors.white,
                          padding: EdgeInsets.all(15),
                          child: Text("Delete Product"),
                          onPressed: () async {
                            showAlertDialog(context);
                          },
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
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
        ],
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed: () async {
        bool result =
            await ProductServices.deleteProduct("${widget.product.id}");
        if (result == true) {
          Fluttertoast.showToast(
            msg: "Delete Products Success",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 20.0,
          );
          clearForm();
          setState(() {
            isLoading = false;
          });
        } else {
          Fluttertoast.showToast(
            msg: "Failed! Try Again",
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
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Delete Confirmation"),
      content: Text("Are you sure to delete " + "${widget.product.name}"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
