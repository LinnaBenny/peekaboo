import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoEx extends StatelessWidget {
  final List<Map<String, String>> videos = [
    {
      "url": "https://youtu.be/WfbZVyLWzpM",
      "title": "Morning Exercise Routine",
      "description": "Kickstart your day with a refreshing morning exercise routine. This video covers simple exercises to boost your energy levels."
    },
    {
      "url": "https://www.youtube.com/watch?v=-GjKHIzAtb0",
      "title": "Morning Yoga Session",
      "description": "Begin your day with a calming yoga session. Follow along to improve flexibility, balance, and mental clarity."
    },
    {
      "url": "https://www.youtube.com/watch?v=mbv63Lz2vAw",
      "title": "Good Habits for a Healthy Lifestyle",
      "description": "Explore essential good habits for maintaining a healthy lifestyle. Learn tips and tricks to integrate beneficial habits into your daily routine."
    },
    {
      "url": "https://www.youtube.com/watch?v=-nlzjPnNfrU",
      "title": "Lessons about Kindness in Daily Life",
      "description": "Learn valuable lessons about the importance of kindness in everyday life and how small acts of kindness can make a big difference."
    },
    {
         "url":"https://www.youtube.com/watch?v=m7R1sucXRFk",
         "title":"Kindness Activities",
         "description":"Kindness Makes Me Stronger"
    },
    {
        "url":"https://www.youtube.com/watch?v=GkipANiBspE",
        "title":"Moral Stories",
        "description": "A heartwarming moral story emphasizing the importance of respecting elders. Learn valuable lessons on kindness, empathy, and respect."
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('image/grey.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 12),
            Image.asset('image/logo.png'),
            Expanded(
              child: ListView.builder(
                itemCount: videos.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(videos[index]["title"]!),
                    subtitle: Text(videos[index]["description"]!),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VideoScreen(
                            videoUrl: videos[index]["url"]!,
                            title: videos[index]["title"]!,
                            description: videos[index]["description"]!,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VideoScreen extends StatelessWidget {
  final String videoUrl;
  final String title;
  final String description;

  const VideoScreen({
    required this.videoUrl,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    String? videoId = YoutubePlayerController.convertUrlToId(videoUrl);

    if (videoId == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('Invalid video URL'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: YoutubePlayerIFrame(
                controller: YoutubePlayerController(
                  initialVideoId: videoId,
                  params: YoutubePlayerParams(
                    autoPlay: true,
                    showControls: true,
                    showFullscreenButton: true,
                  ),
                ),
                aspectRatio: 16 / 9,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              description,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: VideoEx(),
  ));
}
