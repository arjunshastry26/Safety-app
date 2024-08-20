import 'package:frontend/app_properties.dart';
import 'package:frontend/models/article.dart';
import 'package:frontend/screens/product/product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class DViolenceList extends StatelessWidget {
  final List<Article> articles = [
    Article(
        'assets/im1.jpg',
        '\‘I know why women don\’t walk out\’: domestic violence commissioner opens up',
        'Domestic violence commissioner Samantha Pace Gasan has spoken about how she experienced violent relationships in the past, in a bid to encourage other survivors. \nThe 30-year-old has encountered gender-based violence twice in her life. When she was a child, she witnessed violence towards someone close to her. She also experienced it as an adult when she was in an abusive relationship. “I always knew something was not right. I realised that this was not on,” she says. That was when she realised that her childhood memory and her relationship with her partner were abusive. \nShe decided to break up with her partner but soon realised she was pregnant. It crossed her mind to get back together with her partner for the child. “I was going to give him the chance. Which is why I understand why women find it hard to leave.\nShe took her life into her own hands and decided to follow her passion and start studying social policy. \nNot everyone has to share their story publicly and they should not feel pressured. But I want victims to know that I know what it feels like. \nA woman should never stay for the children - Samantha Pace Gasan. \n“I like to share my personal experiences because it sends a message of support,” she says.'),
    Article(
        'assets/im5.jpg',
        'Domestic violence crisis: Number of women allegedly killed in family violence incidents soars',
        'A spike in the number of women dying as a result of domestic violence in Australia has sparked urgent calls for action, including establishing a national list of offenders. \nWARNING: This story contains discussion of domestic and family violence. \nKey points: \n58 women have allegedly been killed this year across the country \nExperts say it\'s a national crisis \nThey want a national register of of family violence offenders \nSix women have been killed across Australia in 10 days — five allegedly by violence inflicted upon them by men. \nOne of the most prominent cases was the murder of 21-year-old sports coach Lilie James, whose body was found at her workplace, a high school in central Sydney. \nHer colleague and former boyfriend Paul Thijssen\'s body was found on Friday.'),
    Article(
        'assets/im3.jpg',
        'Is emotional abuse considered domestic violence?',
        'Emotional abuse is domestic violence, and it is a crime. Several institutions and organizations offer victims of emotional abuse or any other type of domestic violence support. \nPeople may think domestic violence only includes physical abuse. However, it also encompasses much more than physical violence. Domestic violence includes any form of abuse, including emotional abuse, financial abuse, mental abuse, and stalking. \nThese types of abuse are a crime, and they are not less serious or dangerous than physical violence. \nThis article will review emotional abuse, its signs and effects, the other types of domestic violence, and how people can get the support they need.'),
    Article(
        'assets/im4.jpg',
        'What Can Cause or Contribute to Domestic Violence?',
        'The factors that cause or contribute to domestic violence are complex. It’s important to remember that the only behavior you’re responsible for is your own. Likewise, a person who commits an act of violence or ongoing pattern of abuse is solely responsible for their decisions. \nWhy do some people become domestic abusers? The answer is complicated. \nIf you’ve experienced domestic abuse, you might wonder why your abuser acted the way they did. You may hope that learning about the risk factors for abuse can help you make sense of your abuser’s behavior. \nDomestic violence can take many forms, including physical, sexual, emotional, financial, technological, and psychological abuse. \nPerpetrators may target their partners (called intimate partner violence), children, siblings, parents, or anyone else in their household. Approximately 10 millionTrusted Source people in the United States experience domestic violence every year. \nTheir actions are their responsibility — and none of the blame lies with the person who is being abused or violated.'),
    Article(
        'assets/im5.jpg',
        'World cup: Women prepare for increased domestic abuse',
        'Many people in relationships with abusive partners dread major footballing competitions like the world cup. This is because they’re linked to an increase in incidents of domestic abuse. \nResearch by the University of Lancaster shows violent domestic abuse incidents increase by 38% when England loses football matches. Rates are also 26% higher when the team wins or draws. \nDomestic abuse consists of a pattern of coercive and controlling behaviours, where one partner seeks to hold power and control over the other’s life. It is a gendered form of abuse, predominantly perpetrated by men against women, which can combine emotional, verbal, psychological, financial, sexual or physical forms of violence. \nThe severity of domestic abuse can range from consistently critical comments and verbal belittling to physical violence, strangulation and rape. \nFor survivors of domestic abuse, international football tournaments are too often marked by anxious anticipation of violent incidents at home.'),
    Article(
        'assets/im6.jpg',
        'Facts and figures: Ending violence against women ',
        'The availability of data on violence against women and girls has improved considerably in recent years and data on the prevalence of intimate partner violence is now available for at least 161 countries. Please visit our research and data page to better understand how data is crucial to UN Women’s work on preventing and responding to violence against women and girls. '),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Flexible(
          child: Container(
            padding: EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0),
            child: StaggeredGridView.countBuilder(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              crossAxisCount: 4,
              itemCount: articles.length,
              itemBuilder: (BuildContext context, int index) => new ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => ProductPage(product: articles[index]))),
                  child: Container(
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                            colors: [
                              Colors.grey.withOpacity(0.3),
                              Colors.grey.withOpacity(0.7),
                            ],
                            center: Alignment(0, 0),
                            radius: 0.6,
                            focal: Alignment(0, 0),
                            focalRadius: 0.1),
                      ),
                      child: Hero(
                          tag: articles[index].image,
                          child: Image.asset(articles[index].image))),
                ),
              ),
              staggeredTileBuilder: (int index) =>
                  StaggeredTile.count(2, index.isEven ? 3 : 2),
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
            ),
          ),
        ),
      ],
    );
  }
}
