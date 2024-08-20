import 'package:frontend/app_properties.dart';
import 'package:frontend/models/article.dart';
import 'package:frontend/screens/product/product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class RecommendedList extends StatelessWidget {
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
        'assets/im12.jpg',
        'More women turning to firearms for self-defense to even the scales: Protecting \'the lives we love\'',
        'It\'s no secret. Across America, crime continues to ravage communities, putting the innocent on high alert as they wonder how they might fend off attackers should they make their move. \nBut some women are stepping up to the challenge, fueling the demographic\'s identity as a growing group arming up with guns across the nation, \n"Women are the fastest-growing group of gun owners in America," Jane Milhans, a firearms instructor in Washington State, told FOX News earlier this year. \nThe claim is backed by data from Gallup showing the percentage of women who reported owning a gun rising from 15% in 2016 to 22% in 2022, the highest percentage since the organization began gathering data on the subject approximately 15 years ago.'),
    Article('assets/im13.jpg', 'Women’s Health: Self Defense Tips ',
        'The potential to become a victim of a crime is a very real threat to the health and security of all women, regardless of their age or where they live. These threats are varied and include sexual assault, domestic violence, or assault in general. The best way for women to protect themselves is through caution and learning self-defense techniques that can deter or fend off an attacker. \nIt’s always important to be aware of one’s surroundings, particularly when walking alone or in isolated locations such as parking garages or lots at night. This involves paying complete attention to what is happening and not talking on the phone or listening to music until a secure and safe location has been reached. One should avoid dark or seemingly empty areas where there’s little foot traffic and be cautious of individuals who seem out of place, uncomfortable, or otherwise suspicious. Additionally, it’s just as important to walk with confidence and make eye contact as opposed to appearing timid or afraid. If approached by a person who attempts to touch or grab them, women should know what actions are most likely to help them escape. One of the best ways to do that is to take a self-defense class that’s taught by a trained professional. These classes teach women how to break free from an attacker’s hold and ways to effectively strike an assailant if necessary to make an escape. Other methods of self-defense include carrying a whistle that can be used to attract the attention of anyone who may be within earshot and startle the attacker, or one might choose to carry pepper spray in areas where it is legal to use. \nFive Simple Self-Defense Moves Every Woman Should Know \nWomen can learn to defend themselves when they learn and master self-defense moves. This page on the Prevention magazine website outlines five moves that are simple for women to learn. \nNine Myths About Self-Protection \nWhen protecting oneself from an attacker, it’s important to know what to do and what not to do. Click this link to the Women’s Health website and read about nine common myths associated with self-protection. \nSelf-Defense: What Every Woman Needs to Know \nWomen can contribute to their personal safety when they know how to defend themselves. This page provides helpful tips on being smart, escaping, combating assailants, and building strength. \nEight Important Self-Defense Moves for Runners \nRunning is an activity that can potentially leave individuals at risk of assault. Running magazine outlines eight self-defense moves that people who run should know to help protect themselves.'),
    Article(
        'assets/im7.jpg',
        '₹5 crore released for women survivors of sexual assault, other crimes in Manipur, SC told',
        'The Manipur government on November 20 informed the Supreme Court that ₹5 crore has been credited to a dedicated bank account to disburse compensation to women who are survivors of sexual assault and other crimes committed since May 3, when ethnic violence erupted in the State. The affidavit filed by the State government did not state the number of women compensated so far. \nThe affidavit said that as per the latest report from the Deputy Commissioners of Noney and Senapati districts, the exercise for identification of religious districts was complete and there were no reports of vandalising or destruction of religious buildings in the said two districts till date. \nEarlier in September, the court had ordered the State government to “immediately identify all religious buildings in the State which would include churches, Hindu temples, Sanamahi temples, mosques and any building of any other religion, whether existing at present or vandalised/damaged/burnt in the violence” which started on May 3 and asked that sites of these religious buildings be protected from encroachment and destruction.'),
    Article(
        'assets/im8.jpg',
        'Female doctors vulnerable to sexual assault due to hospital work environments, expert says',
        'Female doctors who have experienced sexual assault have spoken of work conditions they felt made them more vulnerable to harm from senior colleagues, an Australian researcher says. \n“[They described] the enforced closeness that can occur in long sessions in operating theatres,” said Dr Louise Stone, an associate professor at the Australian National University. \n“[The] emotionally intense experiences in traumatic situations, and relocation to rural hospital environments where they had little support and lived in hospital accommodation.” \nStone, who has researched sexual harassment in medicine, said women had also spoken about “the boys’ club culture” that reduced their confidence and sense of self”.'),
    Article(
        'assets/im9.jpg',
        'Student’s sexual assault and murder shows women’s safety in India ‘not a priority’',
        'The list of complaints made by female students living at the women’s hostel in the south of Mumbai is depressingly long and goes back years. The women were regularly harassed by male staff, by the drug addicts who hung around outside and other men who made crude gestures. But whenever the women complained, they were threatened with eviction or simply ignored. \nIt makes what happened to Rani*, a second-year computer science student at a higher education college in the west Indian city, feel inevitable. \nLast month, the 18-year-old was found dead in her room on the fourth floor of a government-run hostel in south Mumbai. \nRani was allegedly sexually assaulted and murdered by a security guard, Prakash Kanojia, who later killed himself. He had free access to the hostel rooms and Rani’s friends said he had been harassing the teenager for weeks before her death.'),
    Article(
        'assets/im15.jpg',
        '10 Self Defense Strategies Every Woman Needs To Know',
        'You might not prevail against a pro MMA fighter in the octagon; but everyone has the power to survive or avoid the most common attacks that occur in the real world. This power comes not from being stronger but by understanding strategy. Strategy is what allows you to succeed without fighting- and what gives you the advantage when fighting is necessary. Here are ten of those strategies. \n\n"One need not destroy his enemy, one need only destroy his willingness to engage" - Sun Tzu'),
    Article(
        'assets/im16.jpg',
        'Best Self Defense Weapons for Women: Stay Safe in Any Situation',
        'Attacks against women are proportionally high, so the need for women to carry a self defense weapon is vitally important. While there are several ways to help prevent being a victim, sometimes the unthinkable happens, and one is forced to defend themselves despite being vigilant. \nThat’s why it’s crucial to carry at least one of the best self defense weapons for women. We’ve created this list of the top eight safety defense weapons for ladies so you can choose one that will help keep you safe. \nYou should be aware of gimmicks and poorly made articles that won’t protect you; not all self defense weapons for women are worth buying.'),
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
