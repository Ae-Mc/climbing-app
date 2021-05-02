import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:itmo_climbing/models/guide.dart';
import 'package:itmo_climbing/pages/guides/base_listview_page.dart';
import 'package:itmo_climbing/router.gr.dart';

class GuidesPage extends BaseListViewPage<Guide> {
  @override
  List<Guide> get items => [
        Guide(
          date: DateTime(2020, 1),
          leftTracks: [],
          rightTracks: [
            Track(
              name: 'Из крайности в крайность',
              author: 'Маша/Настя Черная',
              category: '6c',
              marksColor: 'Белые',
              images: [
                'https://ae-mc.ru/files/ITMO_Climbing/Q1_2020/right/01/01.jpg',
                'https://ae-mc.ru/files/ITMO_Climbing/Q1_2020/right/01/02.jpg',
              ],
            ),
            Track(
              name: 'В добрый путь!',
              author: 'Артём Семенов',
              category: '7a',
              marksColor: 'Зелёные',
              images: [
                'https://ae-mc.ru/files/ITMO_Climbing/Q1_2020/right/02/01.jpg',
                'https://ae-mc.ru/files/ITMO_Climbing/Q1_2020/right/02/02.jpg',
              ],
            ),
            Track(
              name: 'Титаник',
              author: 'Артём Семенов',
              category: '7b',
              marksColor: 'Голубые со звёздочками',
              images: [
                'https://ae-mc.ru/files/ITMO_Climbing/Q1_2020/right/03/01.jpg',
                'https://ae-mc.ru/files/ITMO_Climbing/Q1_2020/right/03/02.jpg',
              ],
            ),
            Track(
              name: 'Солнечная',
              author: 'Ксюша',
              description: 'На потолке все зацепки под ноги!',
              category: '6b+/6c',
              marksColor: 'Жёлтые с золотым',
              images: [
                'https://ae-mc.ru/files/ITMO_Climbing/Q1_2020/right/04/01.jpg',
                'https://ae-mc.ru/files/ITMO_Climbing/Q1_2020/right/04/02.jpg',
                'https://ae-mc.ru/files/ITMO_Climbing/Q1_2020/right/04/03.jpg',
              ],
            ),
            Track(
              name: 'Последний день Помпеи',
              author: 'Коля Мошкин',
              category: '7b',
              marksColor: 'Белые с зелёным',
              images: [
                'https://ae-mc.ru/files/ITMO_Climbing/Q1_2020/right/05/01.jpg',
                'https://ae-mc.ru/files/ITMO_Climbing/Q1_2020/right/05/02.jpg',
              ],
            ),
            Track(
              name: 'Беглый обзор',
              author: 'Лёша',
              category: '6c',
              marksColor: 'Зелёные с оранжевым',
              images: [
                'https://ae-mc.ru/files/ITMO_Climbing/Q1_2020/right/06/01.jpg',
                'https://ae-mc.ru/files/ITMO_Climbing/Q1_2020/right/06/02.jpg',
              ],
            ),
            Track(
              name: 'СЫНЫ ГРАБЕЖА',
              author: 'Даня',
              category: '7b',
              marksColor: 'Жёлтые в зелёную полоску',
              images: [
                'https://ae-mc.ru/files/ITMO_Climbing/Q1_2020/right/07/01.jpg',
                'https://ae-mc.ru/files/ITMO_Climbing/Q1_2020/right/07/02.jpg',
              ],
            ),
            Track(
              name: 'Поражённый',
              author: 'Даня',
              category: '7a',
              marksColor: 'Жёлтые в зелёную полоску',
              images: [
                'https://ae-mc.ru/files/ITMO_Climbing/Q1_2020/right/08/01.jpg',
                'https://ae-mc.ru/files/ITMO_Climbing/Q1_2020/right/08/02.jpg',
              ],
            ),
            Track(
              name: 'Прикидка левая',
              author: 'Саня/Крэш',
              category: '7a+',
              marksColor: 'Фиолетовые с оранжевым',
              images: [
                'https://ae-mc.ru/files/ITMO_Climbing/Q1_2020/right/09/01.jpg',
                'https://ae-mc.ru/files/ITMO_Climbing/Q1_2020/right/09/02.jpg',
                'https://ae-mc.ru/files/ITMO_Climbing/Q1_2020/right/09/03.jpg',
              ],
            ),
          ],
        ),
      ]..sort((left, right) => -left.date.compareTo(right.date));

  @override
  String getItemTitle(Guide item) {
    return item.dateString;
  }

  @override
  void itemOnTap(BuildContext context, int index) {
    AutoRouter.of(context).push(GuideRoute(guide: items[index]));
  }
}
