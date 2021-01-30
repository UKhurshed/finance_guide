import 'package:finance_guide/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';

class IdeasScreen extends StatefulWidget {
  @override
  _IdeasScreenState createState() => _IdeasScreenState();
}

class _IdeasScreenState extends State<IdeasScreen> {
  var nameOfCompany = List();
  var nameOfInd = List();
  var earnedPtc = List();
  var currentPrc = List();
  var dateOfPublish = List();

  @override
  void initState() {
    getIdeas();
    super.initState();
  }

  Future<void> getIdeas() async {
    try {
      final response = await http.get("https://www.tinkoff.ru/invest/ideas/");
      if (response.statusCode == 200) {
        fetchElements(response.body);
      }
    } catch (error) {
      debugPrint("Error getsIdea: $error");
    }
  }

  //<div class="UITradingIdeaObject__subtitle_OQrny" data-qa-file="UITradingIdeaObject">ЛМС</div>
  //<span class="Avatar-module__image_2WFrC" style="background-image:url(//static.tinkoff.ru/brands/traiding/US31188V1008x160.png)"></span>
  //<div class="UITradingIdeaObject__title_PeHeO" data-qa-file="UITradingIdeaObject">Fastly - быстрее, еще быстрее</div>
  //<div class="UITradingIdeaObject__title_PeHeO UITradingIdeaObject__noWrap_RYqtB" data-qa-file="UITradingIdeaObject">до <!-- -->40.67<!-- -->%</div>
  //<div class="IdeaCard__contentContainer_38P3c" data-qa-file="IdeaCard"><div class="IdeaCard__badgeWrapper_3YYhp" data-qa-file="IdeaCard"><span data-qa-file="IdeaCard" tabindex="-1" type="button" data-qa-type="uikit/badge" class="Badge__root_BdB0d Badge__root_size_s_3pJjO Badge__root_color_onDark_SlYwH"><span class="Badge__innerClickable_3q8hf" style="outline: none;"><span class="Badge__innerClassname_6hvnq" style="padding-right: 12px; padding-left: 12px;"><span class="Badge__content_2tH9M">Идея</span></span></span></span></div><div class="IdeaCard__info_3z4VW" data-qa-file="IdeaCard"><div class="IdeaCard__titleContainer_2Johe" data-qa-file="IdeaCard"><div class="IdeaCard__title_2zd36" data-qa-file="IdeaCard"><span data-qa-file="IdeaCard">М.Видео: спойлер перед SPO</span></div><div class="IdeaCard__description_23XJN" data-qa-file="IdeaCard" style="color: rgb(255, 255, 255);"><div class="Text__text_3OSYn Text__text_size_13_jiqJ9 Text__text_sizeTabletS_13_1n7-8 Text__text_sizeTabletL_13_2UncI Text__text_sizeDesktopS_13_1tiwA Text__text_sizeDesktopM_13_2Xy9z Text__text_sizeDesktopL_13_11l0f">Можно заработать
  void fetchElements(String body) {
    setState(() {
      var document = parse(body);

      nameOfInd = document.getElementsByClassName("UITradingIdeaObject__subtitle_OQrny");
      // document.sourceSpan.
      var docName = document.getElementsByClassName("UITradingIdeaObject__title_PeHeO");
      // nameOfCompany.add(docName[0]);
      for(var i = 0; i <= 100; i=i+4){
        nameOfCompany.add(docName[i]);
      }

      for(var j = 1; j<= 101; j = j + 4){
        earnedPtc.add(docName[j]);
      }

      for(var k = 2; k<=100; k=k+4){
        currentPrc.add(docName[k]);
      }

      for(var d = 3; d<=100; d=d+4){
        dateOfPublish.add(docName[d]);
      }
     


      debugPrint('Name ' +
          document
              .getElementsByClassName("UITradingIdeaObject__title_PeHeO")[0]
              .firstChild
              .text);
      debugPrint(document
          .getElementsByClassName(
              "UITradingIdeaObject__title_PeHeO UITradingIdeaObject__noWrap_RYqtB")[0]
          .firstChild
          .text);
      debugPrint(document
          .getElementsByClassName(
              "UITradingIdeaObject__title_PeHeO UITradingIdeaObject__noWrap_RYqtB")[1]
          .firstChild
          .text);
      debugPrint(document
          .getElementsByClassName(
              "UITradingIdeaObject__title_PeHeO UITradingIdeaObject__noWrap_RYqtB")[2]
          .firstChild
          .text);
      debugPrint(document
          .getElementsByClassName(
              "UITradingIdeaObject__title_PeHeO UITradingIdeaObject__noWrap_RYqtB")[3]
          .firstChild
          .text);

      // debugPrint("Percent: " + document.getElementsByClassName("IdeaCard__prognosisContainer_1pbya")[0].firstChild.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                children: [
                  Text('Инвестиционные идеи для вас', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: kWhite),),
                  SizedBox(
                    height: 20,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(right: 9, left: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Идеи', style: TextStyle(fontSize: 15,  color: kWhite),),
                        Text('Можно заработать ', style: TextStyle(fontSize: 15, color: kWhite),),
                      ],
                    ),
                  ),
                  Divider(
                    color: kDivider,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  nameOfCompany.isEmpty
                      ? CircularProgressIndicator()
                      : Expanded(
                        child: ListView.separated(
                            // physics: const BouncingScrollPhysics(
                            //     parent: AlwaysScrollableScrollPhysics()),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            separatorBuilder: (context, index) => Divider(
                                  color: kDivider,
                                ),
                            itemCount: nameOfCompany.length,
                            itemBuilder: (context, index) {
                              return
                              //   Container(
                              //   child: Column(
                              //     children: [
                              //       Text('${nameOfCompany[index].text}', style: TextStyle(fontSize: 14),),
                              //       SizedBox(
                              //         height: 10,
                              //       ),
                              //       Text('${nameOfInd[index].text}'),
                              //     ],
                              //   ) ,
                              // );
                                ListTile(
                                // leading: Text('${dateOfPublish[index].text}'),
                                title: Text('${nameOfCompany[index].text}', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: kWhite),),
                                subtitle: Text('${nameOfInd[index].text}', style: TextStyle(fontSize: 14, color: kWhite),),
                                trailing: Text('${earnedPtc[index].text}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: kWhite),),
                              );
                            }),
                      )
                ],
              ),
            ),
          ),
        ),
    );
  }
}
