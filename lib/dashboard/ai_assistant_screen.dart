import 'package:flutter/material.dart';

class AIAssistantScreen extends StatelessWidget {
  const AIAssistantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FE),
      appBar: AppBar(
        title: const Text(
          'AI Assistant',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4318FF), Color(0xFF1E40AF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildSystemMessage(),
                const SizedBox(height: 20),
                _buildUserMessage("Show me the sales forecast for next month"),
                const SizedBox(height: 20),
                _buildAiResponse(
                  "Based on current trends, sales are projected to grow by 12% next month. Top performing categories are Electronics and Home Office.",
                ),
                const SizedBox(height: 20),
                const Text(
                  "SUGGESTED ACTIONS",
                  style: TextStyle(
                    color: Color(0xFFA3AED0),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _buildSuggestionChip("Analyze Inventory"),
                    _buildSuggestionChip("Draft Marketing Email"),
                    _buildSuggestionChip("Check Server Health"),
                    _buildSuggestionChip("Generate Q3 Report"),
                  ],
                ),
              ],
            ),
          ),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildSystemMessage() {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFE0E5F2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Text(
          "Today, 9:41 AM",
          style: TextStyle(
            color: Color(0xFF707EAE),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildUserMessage(String text) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 280),
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Color(0xFF4318FF),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(4),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            height: 1.5,
          ),
        ),
      ),
    );
  }

  Widget _buildAiResponse(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF4318FF), width: 1.5),
            ),
            child: const CircleAvatar(
              radius: 16,
              backgroundColor: Color(0xFF4318FF),
              child: Icon(Icons.auto_awesome, size: 16, color: Colors.white),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x0D000000), // 5% opacity black
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: const TextStyle(
                      color: Color(0xFF1B2559),
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(
                        Icons.thumb_up_alt_outlined,
                        size: 16,
                        color: Color(0xFFA3AED0),
                      ),
                      const SizedBox(width: 16),
                      const Icon(
                        Icons.thumb_down_alt_outlined,
                        size: 16,
                        color: Color(0xFFA3AED0),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.copy,
                        size: 16,
                        color: Color(0xFFA3AED0),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestionChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE0E5F2)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF4318FF),
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFF4F7FE),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.add, color: Color(0xFF4318FF)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFFF4F7FE),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: const [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Ask anything...",
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Color(0xFFA3AED0)),
                        ),
                      ),
                    ),
                    Icon(Icons.mic, color: Color(0xFFA3AED0)),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Color(0xFF4318FF),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.send, color: Colors.white, size: 20),
            ),
          ],
        ),
      ),
    );
  }
}
