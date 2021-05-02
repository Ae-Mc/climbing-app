import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:itmo_climbing/generated/l10n.dart';
import 'package:itmo_climbing/models/guide.dart';

class TrackPage extends StatelessWidget {
  final Track track;

  TrackPage({Key? key, required this.track}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  track.name,
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              SizedBox(width: 16),
              Container(
                constraints: BoxConstraints(minHeight: 88, minWidth: 88),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryVariant,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                padding: EdgeInsets.all(8),
                child: Text(
                  track.category,
                  style: Theme.of(context).textTheme.headline2?.copyWith(
                        color: Theme.of(context).colorScheme.background,
                      ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            '${S.current.Marks}: ${track.marksColor.toLowerCase()}',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(height: 16),
          if (track.description != null) ...[
            Text(
              track.description!,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(height: 16),
          ],
          _buildInteractiveViewerWithColumn(context),
        ],
      ),
    );
  }

  Widget _buildInteractiveViewerWithColumn(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return InteractiveViewer(
            maxScale: 4,
            constrained: false,
            child: ConstrainedBox(
                constraints: constraints.copyWith(maxHeight: double.infinity),
                child: _buildImagesColumn(context)),
          );
        },
      ),
    );
  }

  Widget _buildImagesColumn(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: track.images.reversed
          .map(
            (e) => Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: ClipRect(
                child: CachedNetworkImage(
                  imageUrl: e,
                  fit: BoxFit.contain,
                  placeholder: (context, url) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
