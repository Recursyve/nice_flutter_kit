import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nice_flutter_kit/nice_flutter_kit.dart';
import 'package:path/path.dart';

class NiceOnboardingPermissionPage extends StatefulWidget {
  final NiceOnboardingPermissionConfiguration configuration;
  final VoidCallback onNext;

  const NiceOnboardingPermissionPage({
    required this.configuration,
    required this.onNext,
  });

  @override
  State<NiceOnboardingPermissionPage> createState() => _NiceOnboardingPermissionPageState();
}

class _NiceOnboardingPermissionPageState extends State<NiceOnboardingPermissionPage> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: _buildImage(widget.configuration.imageUrl),
              ),
            ),
            widget.configuration.title,
            const SizedBox(height: 20),
            widget.configuration.paragraph,
            const SizedBox(height: 20),
            NiceButton(
              displayText: widget.configuration.activate,
              padding: EdgeInsets.zero,
              onPressed: !loading ? _activate : null,
              themeColors: Theme.of(context).buttonTheme.colorScheme?.primary,
              child: loading
                  ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(),
                    )
                  : null,
            ),
            const SizedBox(height: 20),
            NiceButton(
              displayText: widget.configuration.activateLater,
              padding: EdgeInsets.zero,
              onPressed: widget.onNext,
              themeColors: Theme.of(context).backgroundColor,
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(String imageUrl) {
    final ext = extension(imageUrl);
    switch (ext) {
      case ".svg":
        return SvgPicture.asset(imageUrl, width: 196);
      default:
        return Image.asset(widget.configuration.imageUrl, width: 196);
    }
  }

  Future<void> _activate() async {
    setState(() => loading = true);
    await NicePermissionUtils.requestPermission(widget.configuration.type);
    if (widget.configuration.onActivated != null) await widget.configuration.onActivated!();
    setState(() => loading = false);
    widget.onNext();
  }
}
