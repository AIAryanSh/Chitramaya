import 'package:cinebuddy/bloc/chat_bloc.dart';
import 'package:cinebuddy/models/chat_message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ChatBloc chatBloc = ChatBloc();
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ChatBloc, ChatState>(
        bloc: chatBloc,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case ChatSuccessState:
              List<ChatMessageModel> messages =
                  (state as ChatSuccessState).messages;
              return Container(
                width: double.maxFinite,
                height: double.maxFinite,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/cinema wallpaper.jpg'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.white.withOpacity(0.65), BlendMode.dstATop),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      height: 100,
                      // color: Color.fromARGB(255, 249, 207, 145),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "fp=e;",
                            style: TextStyle(
                              fontFamily: 'Pankaj-92Z5',
                              fontSize: 35,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 245, 158, 7),
                            ),
                          ),
                          Icon(
                            Icons.image,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: ListView.builder(
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.only(top: 5.0),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Color.fromARGB(156, 178, 157, 253),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      messages[index].role == "user"
                                          ? "User"
                                          : "fp=e;",
                                      style: TextStyle(
                                        fontFamily:
                                            messages[index].role == "user"
                                                ? 'CreativeThoughts'
                                                : 'Pankaj-92Z5',
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: messages[index].role == "user"
                                            ? Color.fromARGB(255, 0, 0, 0)
                                            : Color.fromARGB(255, 89, 4, 125),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      messages[index].parts.first.text,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'CreativeThoughts',
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            })),
                    if (chatBloc.generating)
                      Container(
                          height: 200,
                          width: 100,
                          child: Lottie.asset('assets/Loader.json')),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 16,
                      ),
                      // height: 120,
                      // color: const Color.fromARGB(255, 167, 210, 245),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: textEditingController,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontFamily: 'CreativeThoughts',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide.none,
                                ),
                                fillColor: Color.fromARGB(255, 116, 213, 242),
                                hintText: "Ask Something",
                                hintStyle:
                                    TextStyle(fontFamily: 'CreativeThoughts'),
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          InkWell(
                            onTap: () {
                              if (textEditingController.text.isNotEmpty) {
                                String text = textEditingController.text;
                                textEditingController.clear();
                                chatBloc.add(ChatGenerateNewTextMessageEvent(
                                    inputMessage: text));
                              }
                            },
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor:
                                  Color.fromARGB(255, 253, 212, 152),
                              child: Center(
                                child: Icon(
                                  Icons.send,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );

            default:
              return SizedBox();
          }
        },
      ),
    );
  }
}
