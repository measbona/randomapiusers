import 'package:flutter/material.dart';
import 'package:randomapiusers/randomuserhelper.dart';
import './user_detail.dart';

class UsersList extends StatefulWidget {
  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Random Users"),
        centerTitle: true,
        backgroundColor: Color(0xFF5098E4),
      ),
      drawer: _buildDrawer(),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return Container(
      child: FutureBuilder<RandomUser>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("something went wrong!"),
            );
          } else {
            if (snapshot.connectionState == ConnectionState.done) {
              RandomUser randomUser = snapshot.data;
              return _buildListView(randomUser);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }
        },
      ),
    );
  }

  _buildListView(RandomUser randomUser) {
    List<Result> resultLists = randomUser.results;

    return Container(
      color: Color(0xfff6f6f6),
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: resultLists.length,
          itemBuilder: (context, index) {
            return _buildItem(resultLists[index]);
          }),
    );
  }

  _buildItem(Result _result) {

    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 0),
      padding: EdgeInsets.all(7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            spreadRadius: 0.5,
            offset: Offset(0, 0),
            color: Colors.black.withOpacity(0.5),
          )
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 80,
                    width: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white30,
                      image: DecorationImage(
                          image: NetworkImage(_result.picture.large),
                          fit: BoxFit.cover),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${_result.name.title} ${_result.name.first} ${_result.name.last}",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                height: 1),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "${_result.phone}",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(height: 1.5),
                          ),
                          Text(
                            "${_result.location.country}",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(height: 1.5),
                          ),
                          Text(
                            "${_result.email}",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(height: 1.5),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Icon(Icons.navigate_next),
                  )
                ],
              ),
            ],
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => UserDetail(userDetails: _result)
              )
            );
          },
        ),
      ),
    );
  }

  _buildDrawer() {
    return Drawer(
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: Color(0xfff6f6f6),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 190,
                color: Color(0xff5098e4),
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 30, bottom: 10),
                child: Image.asset("assets/images/randomapiusers_logo.png"),
              ),
              Container(
                height: 50,
                alignment: Alignment.center,
                child: Text(
                  "Assignment Random Users",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17),
                  textAlign: TextAlign.center,
                ),
              ),
              Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/bona_meas.jpg"),
                  ),
                  title: Text("MEAS Bona"),
                  subtitle: Text("Team Lead"),
                  dense: true,
                ),
              ),
              Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        AssetImage("assets/images/menghuo_lao.jpg"),
                  ),
                  title: Text("LAO Menghuo"),
                  subtitle: Text("Member"),
                  dense: true,
                ),
              ),
              Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        AssetImage("assets/images/sopheak_seng.jpg"),
                  ),
                  title: Text("SENG Sopheak"),
                  subtitle: Text("Member"),
                  dense: true,
                ),
              ),
              Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        AssetImage("assets/images/phearum_chhom.jpg"),
                  ),
                  title: Text("CHHOM Phearum"),
                  subtitle: Text("Member"),
                  dense: true,
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
/*_buildListView(RandomUser randomUser){
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            Text("${randomUser.info.seed}", style: TextStyle(fontSize: 30),),
            SizedBox(height: 10,),
            Text("${randomUser.info.results}", style: TextStyle(fontSize: 20),),
            Text("${randomUser.info.page}", style: TextStyle(fontSize: 20),),
            Text("${randomUser.info.version}", style: TextStyle(fontSize: 20),),
          ],
        ),
      ),
    );
  }*/

}
