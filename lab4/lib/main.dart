import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'КубГАУ Общежития',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Roboto',
      ),
      home: const DormitoryScreen(),
    );
  }
}

class DormitoryScreen extends StatefulWidget {
  const DormitoryScreen({super.key});

  @override
  State<DormitoryScreen> createState() => _DormitoryScreenState();
}

class _DormitoryScreenState extends State<DormitoryScreen> {
  bool _isFavorite = false;
  int _favoriteCount = 213;

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                'https://sun9-40.userapi.com/s/v1/ig2/m8wRvQ70t4diy--ngylsjzqPH0Q0zKd_zXn2MDsAG7jW6_HqWtmFZS9vQ-jA2h6Ybe842VvvBt7WkXUWPvdXymqG.jpg?quality=95&as=32x23,48x34,72x51,108x77,160x114,240x171,360x257,480x343,540x385,640x457,720x514,1080x771,1280x913,1435x1024&from=bu&u=vkdmz6YeWjWtphWD_EJyCAmvnI8spNDZd83OvRNVUpU&cs=604x431',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Общежитие №20',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      IconButton(
                        icon: Icon(
                          _isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: _isFavorite ? Colors.green : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _isFavorite = !_isFavorite;
                            _isFavorite ? _favoriteCount++ : _favoriteCount--;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Краснодар, ул. Калинина, 13',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildFeatureChip(Icons.people, 'Мест: 400'),
                      _buildFeatureChip(Icons.wifi, 'Wi-Fi'),
                      _buildFeatureChip(Icons.restaurant, 'Столовая'),
                      _buildFeatureChip(Icons.local_laundry_service, 'Прачечная'),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 100,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildActionButton(
                          context,
                          Icons.call,
                          'Позвонить',
                          Colors.green,
                          () => _launchUrl('tel:+78612622222'),
                        ),
                        _buildActionButton(
                          context,
                          Icons.map,
                          'Маршрут',
                          Colors.blue,
                          () => _launchUrl('https://yandex.ru/maps/-/CHRyvLPW'),
                        ),
                        _buildActionButton(
                          context,
                          Icons.share,
                          'Поделиться',
                          Colors.orange,
                          () => _launchUrl('https://kubsau.ru'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'О общежитии',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Современное 5-этажное общежитие коридорного типа. '
                    'Комнаты на 2-3 человека, оборудованы всей необходимой мебелью. '
                    'На каждом этаже кухня, санузел, душевые на нулевом этаже. Имеется '
                    'читальный зал, комната отдыха и спортивный уголок. Рядом расположены '
                    'дендрарий и студенческая столовая.',
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureChip(IconData icon, String label) {
    return Chip(
      avatar: Icon(icon, size: 18),
      label: Text(label),
      backgroundColor: Colors.green[50],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Widget _buildActionButton(
      BuildContext context, IconData icon, String label, Color color, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.2),
            radius: 30,
            child: IconButton(
              icon: Icon(icon, color: color),
              onPressed: onPressed,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: color,
                ),
          ),
        ],
      ),
    );
  }
}