import 'package:frontend/app_properties.dart';
import 'package:frontend/models/article.dart';
import 'package:frontend/screens/product/product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SDefenseList extends StatelessWidget {
  final List<Article> articles = [
    Article(
        'assets/im12.jpg',
        'More women turning to firearms for self-defense to even the scales: Protecting \'the lives we love\'',
        'It\'s no secret. Across America, crime continues to ravage communities, putting the innocent on high alert as they wonder how they might fend off attackers should they make their move. \nBut some women are stepping up to the challenge, fueling the demographic\'s identity as a growing group arming up with guns across the nation, \n"Women are the fastest-growing group of gun owners in America," Jane Milhans, a firearms instructor in Washington State, told FOX News earlier this year. \nThe claim is backed by data from Gallup showing the percentage of women who reported owning a gun rising from 15% in 2016 to 22% in 2022, the highest percentage since the organization began gathering data on the subject approximately 15 years ago.'),
    Article('assets/im13.jpg', 'Women’s Health: Self Defense Tips ',
        'The potential to become a victim of a crime is a very real threat to the health and security of all women, regardless of their age or where they live. These threats are varied and include sexual assault, domestic violence, or assault in general. The best way for women to protect themselves is through caution and learning self-defense techniques that can deter or fend off an attacker. \nIt’s always important to be aware of one’s surroundings, particularly when walking alone or in isolated locations such as parking garages or lots at night. This involves paying complete attention to what is happening and not talking on the phone or listening to music until a secure and safe location has been reached. One should avoid dark or seemingly empty areas where there’s little foot traffic and be cautious of individuals who seem out of place, uncomfortable, or otherwise suspicious. Additionally, it’s just as important to walk with confidence and make eye contact as opposed to appearing timid or afraid. If approached by a person who attempts to touch or grab them, women should know what actions are most likely to help them escape. One of the best ways to do that is to take a self-defense class that’s taught by a trained professional. These classes teach women how to break free from an attacker’s hold and ways to effectively strike an assailant if necessary to make an escape. Other methods of self-defense include carrying a whistle that can be used to attract the attention of anyone who may be within earshot and startle the attacker, or one might choose to carry pepper spray in areas where it is legal to use. \nFive Simple Self-Defense Moves Every Woman Should Know \nWomen can learn to defend themselves when they learn and master self-defense moves. This page on the Prevention magazine website outlines five moves that are simple for women to learn. \nNine Myths About Self-Protection \nWhen protecting oneself from an attacker, it’s important to know what to do and what not to do. Click this link to the Women’s Health website and read about nine common myths associated with self-protection. \nSelf-Defense: What Every Woman Needs to Know \nWomen can contribute to their personal safety when they know how to defend themselves. This page provides helpful tips on being smart, escaping, combating assailants, and building strength. \nEight Important Self-Defense Moves for Runners \nRunning is an activity that can potentially leave individuals at risk of assault. Running magazine outlines eight self-defense moves that people who run should know to help protect themselves.'),
    Article('assets/im14.jpg', '3 SELF-DEFENSE BOOKS EVERY WOMAN SHOULD READ',
        'Self-defense is often talked about as a physical event. We’re taught to scream, kick, and poke the creep’s eyes out. The truth is that self-defense starts in your mind. And we use it daily, whether we’re aware of it or not. \nThe best way to survive an attack is to avoid it altogether. So, every time you recognize behavior red flags or steer clear of dark alleys, you’re practicing self-defense. It’s as much mental as it is physical. Maybe even more. \nMany of the principles of self-defense can be learned at home through books, videos, and courses. As a writer, books are my go-to for education. Let’s look at the three I recommend to every woman I know.'),
    Article(
        'assets/im15.jpg',
        '10 Self Defense Strategies Every Woman Needs To Know',
        'You might not prevail against a pro MMA fighter in the octagon; but everyone has the power to survive or avoid the most common attacks that occur in the real world. This power comes not from being stronger but by understanding strategy. Strategy is what allows you to succeed without fighting- and what gives you the advantage when fighting is necessary. Here are ten of those strategies. \n\n"One need not destroy his enemy, one need only destroy his willingness to engage" - Sun Tzu'),
    Article(
        'assets/im16.jpg',
        'Best Self Defense Weapons for Women: Stay Safe in Any Situation',
        'Attacks against women are proportionally high, so the need for women to carry a self defense weapon is vitally important. While there are several ways to help prevent being a victim, sometimes the unthinkable happens, and one is forced to defend themselves despite being vigilant. \nThat’s why it’s crucial to carry at least one of the best self defense weapons for women. We’ve created this list of the top eight safety defense weapons for ladies so you can choose one that will help keep you safe. \nYou should be aware of gimmicks and poorly made articles that won’t protect you; not all self defense weapons for women are worth buying.'),
    Article(
        'assets/im17.jpg',
        'Empowering Women: Female Awareness Self Defense Guide and Tips',
        'In recent years, the issue of personal safety and self-defense has gained significant attention, especially among women. Every woman has the right to feel secure and confident in their ability to protect themselves. That is why female awareness self-defense is more important than ever. \nFemale awareness self-defense refers to the techniques and strategies that women can use to protect themselves in various situations. Women’s safety training programs and self-defense classes that are specifically tailored for women have become increasingly popular as more women recognize the importance of personal safety and self-defense.'),
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
