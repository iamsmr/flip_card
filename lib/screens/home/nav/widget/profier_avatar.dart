
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final double radius;
  final String? profileImageUrl;
  final File? profileImage;
  const ProfileAvatar({
    this.radius = 40,
    this.profileImageUrl = "",
    this.profileImage,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.grey[200],
      child: _noProfileIcon(),
      backgroundImage: profileImage != null
          ? FileImage(profileImage!)
          : profileImageUrl!.isNotEmpty
              ? CachedNetworkImageProvider(profileImageUrl!) as ImageProvider
              : null,
    );
  }

  _noProfileIcon() {
    if (profileImage == null && profileImageUrl!.isEmpty) {
      return Icon(
        Icons.account_circle,
        color: Colors.grey[400],
        size: radius * 2,
      );
    }
  }
}
