import 'package:flutter/material.dart';

class ProjectTeamsScreen extends StatelessWidget {
  final VoidCallback? onBack;
  final VoidCallback? onMenu;

  const ProjectTeamsScreen({super.key, this.onBack, this.onMenu});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FE),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFF1B2559),
            size: 20,
          ),
          onPressed: onBack ?? () => Navigator.pop(context),
        ),
        title: const Text(
          'Team Members',
          style: TextStyle(
            color: Color(0xFF1B2559),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          if (onMenu != null)
            IconButton(
              icon: const Icon(Icons.menu_rounded, color: Color(0xFF1B2559)),
              onPressed: onMenu,
            ),
        ],
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(20),
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.8,
        children: [
          _buildMemberCard(
            'Alex Johnson',
            'Project Manager',
            'https://i.pravatar.cc/150?img=12',
          ),
          _buildMemberCard(
            'Sarah Stevens',
            'Lead Developer',
            'https://i.pravatar.cc/150?img=5',
          ),
          _buildMemberCard(
            'Mike Ross',
            'UI Designer',
            'https://i.pravatar.cc/150?img=3',
          ),
          _buildMemberCard(
            'Emily Blunt',
            'QA Engineer',
            'https://i.pravatar.cc/150?img=9',
          ),
        ],
      ),
    );
  }

  Widget _buildMemberCard(String name, String role, String imageUrl) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(radius: 35, backgroundImage: NetworkImage(imageUrl)),
          const SizedBox(height: 12),
          Text(
            name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1B2559),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            role,
            style: const TextStyle(fontSize: 12, color: Color(0xFFA3AED0)),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialButton(Icons.mail_outline),
              const SizedBox(width: 12),
              _buildSocialButton(Icons.phone_outlined),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F7FE),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 18, color: const Color(0xFF4318FF)),
    );
  }
}
