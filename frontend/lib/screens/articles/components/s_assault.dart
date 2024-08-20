import 'package:frontend/app_properties.dart';
import 'package:frontend/models/article.dart';
import 'package:frontend/screens/product/product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SAssaultList extends StatelessWidget {
  final List<Article> articles = [
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
        'assets/im10.jpg',
        'Indian women set fire to house of suspect as Manipur sex assault case triggers outrage',
        'NEW DELHI, July 21 (Reuters) - Women in India\'s northeastern state of Manipur attacked the house of the main suspect in a sexual assault case that has enraged the nation, state police said on Friday. \nThe person had allegedly dragged two tribal women onto the streets in May and incited a mob to rape and parade them naked, police said on Friday. \nThe sexual assault took place over two months ago but it captured national attention after a video went viral on social media this week, triggering unrest in Manipur. \nThe main suspect, a Manipur resident, was arrested on Thursday hours after Prime Minister Narendra Modi condemned the assault as "shameful" and promised tough action. \nThree others also were arrested and police are tracing at least 30 others involved in the crime. \n"Local women pelted stones and burnt some parts of the house belonging to the prime accused in a village," said Hemant Pandey, a senior police official in the state capital Imphal. \n"We request women to protest peacefully as there is intense unease. We understand their rage," he said.'),
    Article(
        'assets/im11.jpg',
        'Rights bodies demand action in case of sexual assault on Kuki women in Manipur ',
        'Rights groups have demanded swift action against the perpetrators of sexual assault in Manipur and speedy justice for two Kuki women paraded naked by a mob.  \nThe groups said they were aghast by a video clip showing a large group of men parading two women stripped naked and molesting them while dragging them toward a paddy field. The incident reportedly took place on May 4. \n“The torture and looting of the dignity of women in broad daylight in such a grotesque manner cannot be accepted or tolerated in any civilised society. We condemn the incident in the strongest possible term and demand swift action from the State government,” Dilip Chakma of the New Delhi-based Indigenous Rights Advocacy Centre said on Thursday. \n“We demand that a fair, unbiased investigation be completed within a specific time period, and the perpetrators must be brought to justice at the earliest,” he said, appealing to both the communities – Kuki and Meitei – to maintain peace.'),
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
