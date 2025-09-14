import 'package:flutter/material.dart';

class ShimmerBox extends StatefulWidget {
  final double width;
  final double height;
  final double borderRadius;
  final EdgeInsetsGeometry? margin;
  final Color baseColor;
  final Color highlightColor;

  const ShimmerBox({
    super.key,
    this.width = 100,
    this.height = 20,
    this.borderRadius = 4,
    this.margin,
    this.baseColor = const Color(0xFFE5E7EB),
    this.highlightColor = const Color(0xFFF3F4F6),
  });

  @override
  State<ShimmerBox> createState() => _ShimmerBoxState();
}

class _ShimmerBoxState extends State<ShimmerBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      margin: widget.margin,
      decoration: BoxDecoration(
        color: widget.baseColor,
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  widget.baseColor,
                  widget.highlightColor,
                  widget.baseColor,
                ],
                stops: const [
                  0.0,
                  0.5,
                  1.0,
                ],
                transform: ShimmerGradientTransform(_animation.value),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ShimmerGradientTransform extends GradientTransform {
  final double progress;

  const ShimmerGradientTransform(this.progress);

  @override
  Matrix4 transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * progress, 0.0, 0.0);
  }
}

class ShimmerCard extends StatelessWidget {
  const ShimmerCard({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
                   ShimmerBox(
                width: 40,
                height: 40,
                borderRadius: 20,
              ),
                 SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                       ShimmerBox(width: 120, height: 16),
                       SizedBox(height: 4),
                    ShimmerBox(width: 80, height: 12),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ShimmerBox(width: screenWidth - 80, height: 12),
          const SizedBox(height: 4),
          ShimmerBox(width: screenWidth - 120, height: 12),
          const SizedBox(height: 4),
          ShimmerBox(width: screenWidth - 160, height: 12),
        ],
      ),
    );
  }
}

class ShimmerList extends StatelessWidget {
  final int count;

  const ShimmerList({super.key, this.count = 3});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        count,
        (index) => const ShimmerCard(),
      ),
    );
  }
}

class ShimmerNewsCard extends StatelessWidget {
  const ShimmerNewsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(right: 16, left:16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
             ShimmerBox(
            width: double.infinity, 
            height: 140,
            borderRadius: 12,
          ),
          Padding(
            padding:  EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShimmerBox(width: 80, height: 12, borderRadius: 6),
                    ShimmerBox(width: 60, height: 10, borderRadius: 5),
                  ],
                ),
                SizedBox(height: 8),
                ShimmerBox(width: 240, height: 16),
                SizedBox(height: 8),
                ShimmerBox(width: 200, height: 12),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShimmerBox(width: 60, height: 10),
                    ShimmerBox(width: 40, height: 10),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ShimmerServiceCard extends StatelessWidget {
  const ShimmerServiceCard({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.symmetric( vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              ShimmerBox(
                width: 44,
                height: 44,
                borderRadius: 22,
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerBox(width: 120, height: 16),
                    SizedBox(height: 4),
                    ShimmerBox(width: 80, height: 12, borderRadius: 12),
                  ],
                ),
              ),
              ShimmerBox(width: 20, height: 20),
            ],
          ),
          const SizedBox(height: 12),
          ShimmerBox(width: screenWidth - 80, height: 12),
          const SizedBox(height: 8),
          ShimmerBox(width: screenWidth - 120, height: 12),
          const SizedBox(height: 12),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ShimmerBox(width: 14, height: 14),
                  SizedBox(width: 4),
                  ShimmerBox(width: 80, height: 10),
                ],
              ),
              Row(
                children: [
                  ShimmerBox(width: 14, height: 14),
                  SizedBox(width: 4),
                  ShimmerBox(width: 60, height: 10),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ShimmerNewsList extends StatelessWidget {
  final int count;

  const ShimmerNewsList({super.key, this.count = 3});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            count,
            (index) => const ShimmerNewsCard(),
          ),
        ),
      ),
    );
  }
}

class ShimmerServicesList extends StatelessWidget {
  final int count;

  const ShimmerServicesList({super.key, this.count = 5});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        count,
        (index) => const ShimmerServiceCard(),
      ),
    );
  }
}

// Example usage widget
class ShimmerExample extends StatelessWidget {
  const ShimmerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shimmer Loading Examples'),
      ),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Basic Shimmer Cards',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ShimmerList(count: 2),
            
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'News Cards',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ShimmerNewsList(count: 3),
            
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Service Cards',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ShimmerServicesList(count: 3),
          ],
        ),
      ),
    );
  }
}