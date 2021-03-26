import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:randomapiusers/randomuserhelper.dart';
import 'package:intl/intl.dart';

class UserDetail extends StatefulWidget {
  final Result userDetails;

  UserDetail({ this.userDetails });

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

    final userName = '${widget.userDetails.name.title}.${widget.userDetails.name.first} ${widget.userDetails.name.last}';
    final description = '${widget.userDetails.location.timezone.description}';
    final latitute = double.parse(widget.userDetails.location.coordinates.latitude);
    final longitude = double.parse(widget.userDetails.location.coordinates.longitude);

    final marker = Marker(
      markerId: MarkerId(userName),
      position: LatLng(latitute, longitude),
      infoWindow: InfoWindow(
        title: userName,
        snippet: description,
      ),
    );

    _markers[userName] = marker;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Page"),
        backgroundColor: colorBlue,
      ),
      body: _renderBody(),
    );
  }

  _renderBody() {
    return Stack(
      children: <Widget>[
        _renderMap(),
        _renderUserCard(),
      ],
    );
  }

  _renderMap() {
    final latitute = double.parse(widget.userDetails.location.coordinates.latitude);
    final longitude = double.parse(widget.userDetails.location.coordinates.longitude);

    return Container(
      height: 180,
      child: GoogleMap(
        mapType: MapType.terrain,
        initialCameraPosition: CameraPosition(
          target: LatLng(latitute, longitude),
          zoom: 1,
        ),
        compassEnabled: false,
        scrollGesturesEnabled: true,
        myLocationButtonEnabled: false,
        markers: _markers.values.toSet(),
      ),
    );
  }

  _renderUserCard() {
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

  _renderUserGeneralInfo() {
    return Container(
      height: 175,
      child: Row(
        children: <Widget>[
          _renderImage(),
          Row(
            children: [
              _renderUserInfo(),
            ],
          )
        ],
      ),
    );
  }

  _renderImage() {
    final userImage = '${widget.userDetails.picture.large}';

    return Container(
      width: 120,
      height: 120,
      margin: EdgeInsets.only( left: 20, right: 20 ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: NetworkImage(userImage),
          fit: BoxFit.cover
        ),
      ),
    );
  }

  _renderUserInfo() {
    final userName = '${widget.userDetails.name.title}.${widget.userDetails.name.first} ${widget.userDetails.name.last}';
    final gender = toBeginningOfSentenceCase('${widget.userDetails.gender}');

    final DateFormat formatter = DateFormat('dd MMM yyyy');
    final String formatted = formatter.format(widget.userDetails.dob.date);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container( child: Text("Name", style: TextStyle(fontSize: 11, color: Colors.white)) ),
        Container( child: Text(userName, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)) ),
        SizedBox(height: 8),
        Container( child: Text("Gender", style: TextStyle(fontSize: 11, color: Colors.white)) ),
        Container( child: Text(gender, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)) ),
        SizedBox(height: 8),
        Container( child: Text("Date of Birth", style: TextStyle(fontSize: 11, color: Colors.white)) ),
        Container( child: Text(formatted, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)) ),
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
    final email = '${widget.userDetails.email}';
    final phone = '${widget.userDetails.phone}';

    return phoneVisible ? Container(
      color: colorGrey,
      height: screenHeight / 2 - 57,
      margin: EdgeInsets.only(top: 3),
      padding: EdgeInsets.only(top: 20, left: 25, right: 25),
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container( child: Text("Phone Number", style: TextStyle(fontSize: 11, color: Colors.black)) ),
              Container( child: Text(phone, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)) ),
              SizedBox(height: 10),
              Container( child: Text("Email Address", style: TextStyle(fontSize: 11, color: Colors.black)) ),
              Container( child: Text(email, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)) ),
            ],
          )
        ],
      ),
    ) : Container();
  }
  
  _renderAddressInfo() {
    final screenHeight = MediaQuery.of(context).size.height;
    final street = '${widget.userDetails.location.street.number} - ${widget.userDetails.location.street.name}';
    final city = '${widget.userDetails.location.city}';
    final state = '${widget.userDetails.location.state}';
    final country = '${widget.userDetails.location.country}';

    return addressVisible ? Container(
      color: colorGrey,
      height: screenHeight / 2 - 57,
      margin: EdgeInsets.only(top: 3),
      padding: EdgeInsets.only(top: 20, left: 25, right: 25),
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container( child: Text("Street", style: TextStyle(fontSize: 11, color: Colors.black)) ),
                  Container( child: Text(street, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)) ),
                ]
              ),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container( child: Text("State", style: TextStyle(fontSize: 11, color: Colors.black)) ),
                  Container( child: Text(state, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)) ),
                ]
              ),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container( child: Text("City", style: TextStyle(fontSize: 11, color: Colors.black)) ),
                  Container( child: Text(city, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)) ),
                ]
              ),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container( child: Text("Country", style: TextStyle(fontSize: 11, color: Colors.black)) ),
                  Container( child: Text(country, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)) ),
                ]
              ),
            ],
          ),
        ],
      )
    ) : Container();
  }

  _renderPhoneVisibleBar() {
    return phoneVisible ? Container( height: 5, color: colorGrey ) : Container();
  }

  _renderAddressVisibleBar() {
    return addressVisible ? Container( height: 5, color: colorGrey ) : Container();
  }
}