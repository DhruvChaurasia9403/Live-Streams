import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:streamstreak/Widgets/TextFields.dart';
class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    // RxBool isSearching = false.obs;
    return Scaffold(
      appBar: AppBar(
        title: Text('Live Streams',style:Theme.of(context).textTheme.headlineSmall),
        ),
      body:Container(
        child: Column(
          children: [
            Row(
              children:[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SearchHome(text:"Search ...",icon: Icon(Icons.search),),
                  ),
                ),
                IconButton(
                  iconSize: 40,
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                    side: MaterialStateProperty.all(BorderSide(color: Theme.of(context).colorScheme.secondary,width: 2)),
                  ),
                  color: Theme.of(context).colorScheme.primaryContainer,
                  onPressed: (){
                    Get.toNamed("/createStreamPage");
                  },
                  icon: Icon(Icons.add),
                )
              ]
            )
          ],
        ),
      ),
    );
  }
}
