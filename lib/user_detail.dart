import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserDetail extends StatefulWidget {
  @override
  _UserDetailState createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  final Map<String, Marker> _markers = {};

  bool phoneVisible = true;
  bool addressVisible = false;

  var colorGrey = Color(0xfff6f6f6);
  var colorBlue = Color(0xff5098e4);

  @override
  void initState() {
    super.initState();

    _markers.clear();

    final marker = Marker(
      markerId: MarkerId("Martin"),
      position: LatLng(11.538036, 104.8397505),
      infoWindow: InfoWindow(
        title: "Mr.Andy Holt",
        snippet: "hello",
      ),
    );

    _markers["Mr.Andy Holt"] = marker;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Detail Page"),
        backgroundColor: colorBlue,
      ),
      body: _renderBody(),
    );
  }

  _renderBody() {
    return Stack(
      children: <Widget>[
        _renderMap(),
        _renderUserPanel(),
      ],
    );
  }

  _renderMap() {
    return Container(
      height: 180,
      child: GoogleMap(
        mapType: MapType.terrain,
        initialCameraPosition: CameraPosition(
          target: LatLng(11.538036, 104.8397505),
          zoom: 14,
        ),
        myLocationButtonEnabled: false,
        compassEnabled: false,
        markers: _markers.values.toSet(),
      ),
    );
  }

  _renderUserPanel() {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 150),
          width: MediaQuery.of(context).size.width,
          child: Container(
            decoration: BoxDecoration(
              color: colorBlue,
              borderRadius: BorderRadius.only( topLeft: Radius.circular(20), topRight: Radius.circular(20) ),
              boxShadow: [
                BoxShadow(
                  blurRadius: 2,
                  spreadRadius: 0.5,
                  offset: Offset(0, 0),
                  color: Colors.black.withOpacity(0.5),
                )
              ]
            ),
            height: 210,
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    _renderPanelBar(),
                    _renderUserGeneralInfo(),
                    _renderTabs(),
                  ],
                )
              ],
            ),
          ),
        ),
        _renderPhoneInfo(),
        _renderAddressInfo(),
      ],
    );
  }

  _renderPanelBar() {
    return Container(
      width: 50,
      height: 5,
      margin: EdgeInsets.only( top: 10 ),
      decoration: BoxDecoration( color: colorGrey, borderRadius: BorderRadius.circular(50)),
    );
  }

  _renderUserGeneralInfo() {
    return Container(
      height: 160,
      child: Row(
        children: <Widget>[
          _renderImage(),
          Row(
            children: [
              _renderTitle(),
              SizedBox(width: 10),
              _renderInfo(),
            ],
          )
        ],
      ),
    );
  }

  _renderImage() {
    return Container(
      width: 100,
      height: 100,
      margin: EdgeInsets.only( left: 20, right: 10 ),
      child: Image.network("https://randomuser.me/api/portraits/men/74.jpg"),
    );
  }

  _renderTitle() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container( child: Text("Name :", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)) ),
        SizedBox(height: 17),
        Container( child: Text("Gender :", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)) ),
        SizedBox(height: 17),
        Container( child: Text("Date of Birth :", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)) ),
      ],
    );
  }

  _renderInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container( child: Text("Mr.Andy Holt", style: TextStyle(fontSize: 16, color: Colors.white)) ),
        SizedBox(height: 17),
        Container( child: Text("Male", style: TextStyle(fontSize: 16, color: Colors.white)) ),
        SizedBox(height: 17),
        Container( child: Text("19 Feb 1999", style: TextStyle(fontSize: 16, color: Colors.white)) ),
      ],
    );
  }

  _renderTabs() {
    return Container(
      height: 35,
      child: Row(
        children: <Widget>[
          _renderPhoneTab(),
          _renderAddressTab()
        ]
      ),
    );
  }

  _renderPhoneTab() {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth / 2,
      child: InkWell(
        onTap: () {
          setState(() {
            phoneVisible= true;
            addressVisible= false;
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container( height: 20, child: Icon( Icons.phone_sharp, color: colorGrey, size: 24.0) ),
            _renderPhoneVisibleBar()
          ],
        ),
      ),  
    );
  }

  _renderAddressTab() {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth / 2,
      child: InkWell(
        onTap: () {
          setState(() {
            phoneVisible= false;
            addressVisible= true;
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container( height: 20, child: Icon( Icons.map_sharp, color: colorGrey, size: 24.0) ),
            _renderAddressVisibleBar()
          ],
        ),
      ),  
    );
  }

  _renderPhoneInfo() {
    final screenHeight = MediaQuery.of(context).size.height;

    return phoneVisible ? Container(
      color: colorGrey,
      height: screenHeight / 2 - 54,
      padding: EdgeInsets.only(left: 25, right: 25, top: 25),
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container( child: Text("Email :", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)) ),
              SizedBox(height: 17),
              Container( child: Text("Phone :", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)) ),
            ],
          ),
          SizedBox(width: 40),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container( child: Text("Andy.holt@example.com", style: TextStyle(fontSize: 16, color: Colors.black)) ),
              SizedBox(height: 17),
              Container( child: Text("01-4971-0101", style: TextStyle(fontSize: 16, color: Colors.black)) ),
            ],
          )
        ],
      ),
    ) : Container();
  }
  
  _renderAddressInfo() {
    final screenHeight = MediaQuery.of(context).size.height;

    return addressVisible ? Container(
      color: colorGrey,
      height: screenHeight / 2 - 54,
      padding: EdgeInsets.only(left: 25, right: 25, top: 25),
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container( child: Text("Street :", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)) ),
              SizedBox(height: 17),
              Container( child: Text("City :", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)) ),
              SizedBox(height: 17),
              Container( child: Text("State :", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)) ),
              SizedBox(height: 17),
              Container( child: Text("Country :", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)) ),
            ],
          ),
          SizedBox(width: 40),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container( child: Text("963, Mcclellan Rd", style: TextStyle(fontSize: 16, color: Colors.black)) ),
              SizedBox(height: 17),
              Container( child: Text("Rockhampton", style: TextStyle(fontSize: 16, color: Colors.black)) ),
              SizedBox(height: 17),
              Container( child: Text("Western Australia", style: TextStyle(fontSize: 16, color: Colors.black)) ),
              SizedBox(height: 17),
              Container( child: Text("Australia", style: TextStyle(fontSize: 16, color: Colors.black)) ),
            ],
          )
        ],
      ),
    ) : Container();
  }

  _renderPhoneVisibleBar() {
    return phoneVisible ? Container( height: 5, color: colorGrey ) : Container();
  }

  _renderAddressVisibleBar() {
    return addressVisible ? Container( height: 5, color: colorGrey ) : Container();
  }
}