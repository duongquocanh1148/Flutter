import 'package:flutter/material.dart';


class FavoriteFragment extends StatefulWidget {
  const FavoriteFragment({super.key});

  @override
  State<FavoriteFragment> createState() => _FavoriteFragmentState();
}

class _FavoriteFragmentState extends State<FavoriteFragment> {
  @override
  Widget build(BuildContext context) {
    return Expanded(child: SizedBox(          
      child: ListView.builder(
        itemCount: 3,
        itemBuilder: (context,index){
          return Padding(
            padding: const EdgeInsets.all(8),
            child: SizedBox(                    
              child: Row(children: [
                SizedBox(      
                  width: 120,
                  height: 120,
                  child: Image.asset("asset/image/ic_black_coffee.png", fit: BoxFit.fill),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: SizedBox(
                    height: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [  
                        Text("Coffee", style: TextStyle(color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold),),
                        Expanded(child: 
                        Text("Description", maxLines: 5, overflow: TextOverflow.ellipsis,))                
                    ],),
                  )
                )
              ]),
            ),
          );
        }
      ),
      ));
  }
}