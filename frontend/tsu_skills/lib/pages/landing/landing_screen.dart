import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:tsu_skills/app/router/app_router.dart';
import 'package:tsu_skills/shared/assets/assets.gen.dart';
import 'package:tsu_skills/shared/lib/ui/widgets/other/header_image.dart';

@RoutePage()
class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'SKILLS — Твоя точка роста в университете',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            HeaderImage(
              imgProvider: Assets.image.girlSendApplication380380.keyName,
              title: '',
            ),
            const SizedBox(height: 16.0),
            const Text(
              'SKILLS – это кроссплатформенный агрегатор, созданный для централизации всех внутренних вакансий, волонтерских инициатив и мероприятий Томского государственного университета. Мы связываем студентов, готовых развиваться, с организаторами, ищущими таланты.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                color: Colors.black54,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 32.0),

            const Divider(height: 32, thickness: 2, color: Color(0xFFD1D5DB)),
            const SizedBox(height: 16.0),

            _buildSectionTitle(
              context,
              'Для Организаторов: Найдите нужные кадры 🚀',
            ),
            const SizedBox(height: 16.0),
            _buildBenefitCard(
              context,
              imgProvider: Assets.image.manCreateVacancy380380.keyName,
              title: 'Централизованный Поиск',
              description:
                  'Публикуйте объявления в одном месте. Больше не нужно рассылать информацию по десяткам чатов и досок объявлений.',
            ),
            _buildBenefitCard(
              context,
              imgProvider: Assets.image.girlSendApplication380380.keyName,
              title: 'Актуальность и Безопасность',
              description:
                  'Доступ только для верифицированных участников университетской экосистемы. Вы взаимодействуете только со студентами ТГУ.',
            ),
            _buildBenefitCard(
              context,
              imgProvider: Assets.image.manBuild380380.keyName,
              title: 'Удобное Управление Откликами',
              description:
                  'Получайте и просматривайте резюме студентов прямо в приложении. Экономьте время на обработке заявок.',
            ),

            const SizedBox(height: 32.0),

            // --- Разделитель ---
            const Divider(height: 32, thickness: 2, color: Color(0xFFD1D5DB)),
            const SizedBox(height: 16.0),

            // Секция для Студентов
            _buildSectionTitle(
              context,
              'Для Студентов: Откройте свои SKILLS ✨',
            ),
            const SizedBox(height: 16.0),
            _buildBenefitCard(
              context,
              imgProvider: Assets.image.girlAndLetters380380.keyName,
              title: 'Все Возможности в Одном Месте',
              description:
                  'Быстро находите релевантные вакансии, стажировки и волонтерские проекты, доступные только внутри ТГУ.',
            ),
            _buildBenefitCard(
              context,
              imgProvider: Assets.image.girlWithResumes380380.keyName,
              title: 'Простое Цифровое Резюме',
              description:
                  'Создайте и редактируйте свое цифровое резюме, которое можно отправить организатору в один клик.',
            ),
            _buildBenefitCard(
              context,
              imgProvider: Assets.image.girlAndDashboard380380.keyName,
              title: 'Удобный Поиск и Фильтр',
              description:
                  'Используйте фильтры, чтобы найти именно те предложения, которые соответствуют вашим навыкам и интересам.',
            ),

            const SizedBox(height: 48.0),

            ElevatedButton.icon(
              onPressed: () {
                AutoRouter.of(context).push(LoginRoute());
              },
              icon: const Icon(Icons.arrow_forward),
              label: Text('Начать использовать SKILLS'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      textAlign: TextAlign.left,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
        fontSize: 24,
        color: const Color(0xFF047857),
      ), // Зеленый для акцента
    );
  }

  Widget _buildBenefitCard(
    BuildContext context, {
    required String imgProvider,
    required String title,
    required String description,
  }) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderImage(imgProvider: imgProvider, title: title),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 4.0),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
