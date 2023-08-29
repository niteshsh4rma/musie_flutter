import 'package:flutter/material.dart';
import 'package:musie/shared/extensions/context_extensions.dart';

class SuggestedTab extends StatelessWidget {
  const SuggestedTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          _buildRecentlyPlayed(context),
          const SizedBox(height: 16),
          _buildArtists(context),
          const SizedBox(height: 16),
          _buildMostPlayed(context),
        ],
      ),
    );
  }

  Widget _buildMostPlayed(BuildContext context) {
    return Column(
      children: [
        _buildTitle(
          context,
          text: context.loc.mostPlayed,
          onSeeAll: () {},
        ),
        SizedBox(
          height: 170,
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (context, index) => _buildSongTile(context),
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemCount: 10,
          ),
        ),
      ],
    );
  }

  Widget _buildArtists(BuildContext context) {
    return Column(
      children: [
        _buildTitle(
          context,
          text: context.loc.artists,
          onSeeAll: () {},
        ),
        SizedBox(
          height: 170,
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (context, index) => _buildArtistTile(context),
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemCount: 10,
          ),
        ),
      ],
    );
  }

  Widget _buildArtistTile(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {},
      child: AspectRatio(
        aspectRatio: 0.85,
        child: Column(
          children: [
            Container(
              height: 128,
              width: 128,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(
                  Icons.music_note,
                  size: 64,
                  color: Colors.white,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(4),
              child: Text(
                'Shades of Lovesdfsdfsdfsdfsdfsdfsdfds sdfdsfsd sdfds',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRecentlyPlayed(BuildContext context) {
    return Column(
      children: [
        _buildTitle(
          context,
          text: context.loc.recentlyPlayed,
          onSeeAll: () {},
        ),
        SizedBox(
          height: 170,
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (context, index) => _buildSongTile(context),
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemCount: 10,
          ),
        ),
      ],
    );
  }

  Widget _buildTitle(
    BuildContext context, {
    required String text,
    VoidCallback? onSeeAll,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          if (onSeeAll != null)
            TextButton(
              onPressed: onSeeAll,
              child: Text(context.loc.seeAll),
            ),
        ],
      ),
    );
  }

  Widget _buildSongTile(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {},
      child: AspectRatio(
        aspectRatio: 0.85,
        child: Column(
          children: [
            Container(
              height: 128,
              width: 128,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Icon(
                  Icons.music_note,
                  size: 64,
                  color: Colors.white,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(4),
              child: Text(
                'Shades of Lovesdfsdfsdfsdfsdfsdfsdfds sdfdsfsd sdfds',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}
