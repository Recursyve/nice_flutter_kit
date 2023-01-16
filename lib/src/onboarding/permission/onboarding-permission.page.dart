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
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 64.0, left: 24.0, right: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.center,
                child: _buildImage(widget.configuration.imageUrl),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  widget.configuration.title,
                  const SizedBox(height: 20),
                  widget.configuration.paragraph,
                  const Spacer(),
                ],
              ),
            ),
            _buildButton(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(String imageUrl) {
    final ext = extension(imageUrl);
    switch (ext) {
      case ".svg":
        return SvgPicture.asset(imageUrl, width: 260);
      default:
        return Image.asset(widget.configuration.imageUrl, width: 260);
    }
  }

  Widget _buildButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: loading ? null : _activate,
        child: loading
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(),
              )
            : Text(
                widget.configuration.activate,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
      ),
    );
  }

  Future<void> _activate() async {
    setState(() => loading = true);
    await NicePermissionUtils.requestPermission(widget.configuration.type);
    if (widget.configuration.onActivated != null) await widget.configuration.onActivated!();
    setState(() => loading = false);
    widget.onNext();
  }
}
