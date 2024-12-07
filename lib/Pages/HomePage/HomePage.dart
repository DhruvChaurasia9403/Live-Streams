import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:streamstreak/Controller/StreamController.dart';
import 'package:streamstreak/Widgets/TextFields.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final StreamsController streamsController = Get.put(StreamsController());
    streamsController.fetchStreams();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Live Streams',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Expanded(
                  child: SearchHome(
                    text: "Search ...",
                    icon: Icon(Icons.search),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  iconSize: 40,
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    side: MaterialStateProperty.all(
                      BorderSide(
                        color: Theme.of(context).colorScheme.secondary,
                        width: 2,
                      ),
                    ),
                  ),
                  color: Theme.of(context).colorScheme.primaryContainer,
                  onPressed: () {
                    Get.toNamed("/createStreamPage");
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              if (streamsController.streams.isEmpty) {
                return const Center(child: Text("No streams available."));
              }
              return ListView.builder(
                itemCount: streamsController.streams.length,
                itemBuilder: (context, index) {
                  final stream = streamsController.streams[index];
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 120,
                          height: 70,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(stream['thumbnail']),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.horizontal(left: Radius.circular(10)),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  stream['title'],
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  stream['platform'],
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.play_circle_fill,
                            color: Colors.red,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
