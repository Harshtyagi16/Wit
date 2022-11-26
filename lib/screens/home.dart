import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wit/controller/RecipeP.dart';
import 'detailsScreen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

bool isloading = false;

@override
  void initState() {
  Future.delayed(Duration.zero).then((_){
    setState(() {
      isloading = true;
    });
    Provider.of<RecipeProvider>(context,listen: false).fetchRecipe();}).then((value){
      setState(() {
        isloading = false;
      });
  });
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    final recipeCont = Provider.of<RecipeProvider>(context).allRecipe;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green.withOpacity(0.5),
        title: Text('Home'),
      ),
      body: isloading ? Center( child: CircularProgressIndicator(),):Container(
        height: size.height,
        width: size.width,
        child: Center(
          child: ListView.builder(itemCount: recipeCont.length,itemBuilder: (context, i){
            return GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DetailsScreen(i: i,)));
              },
              child: Container(margin: EdgeInsets.all(20),padding: EdgeInsets.all(10),height: size.height*0.2,width: size.width,decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10),boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ]),child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(recipeCont[i].recipeName,style: GoogleFonts.lexendDeca(fontSize: 22),),
                  Text('Can be Sever- ${recipeCont[i].serve}',style: GoogleFonts.lexendDeca(fontSize: 15),),
                  Text('Time for prep- ${recipeCont[i].prepTime}',style: GoogleFonts.lexendDeca(fontSize: 12),),
                  Text('Cooking Time-${recipeCont[i].cookTime}',style: GoogleFonts.lexendDeca(fontSize: 12),),
                ],
              ),),
            );
          }),
        ),
      ),
    );
  }
}
