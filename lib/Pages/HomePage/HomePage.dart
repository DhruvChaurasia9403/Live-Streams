import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:streamstreak/Controller/StreamController.dart';
import 'package:streamstreak/Pages/HomePage/OverLay.dart';
import '../../Widgets/TextFields.dart';

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
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Theme.of(context).colorScheme.primaryContainer),
        ),
      ),
      body: Stack(
        children: [
          Column(
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
                      iconSize: 50,
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
                      return Dismissible(
                        key: Key(stream['id']),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          streamsController.deleteStream(stream['id']);
                          Get.snackbar("Success", "${stream['title']} deleted", snackPosition: SnackPosition.BOTTOM);
                        },
                        background: Container(
                          color: Theme.of(context).colorScheme.background,
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Icon(Icons.delete, color: Theme.of(context).colorScheme.primaryContainer),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed("/editStreamPage", arguments: stream);
                          },
                          child: Card(
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
                                              ?.copyWith(color: Theme.of(context).colorScheme.secondary),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
          FirstTimeOverlay(),
        ],
      ),
    );
  }
}