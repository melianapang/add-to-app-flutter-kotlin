import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:livekit_client/livekit_client.dart';

part 'livekit_participant_metadata.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class LiveKitParticipantMetadata {
  LiveKitParticipantMetadata({
    this.userType,
    this.isModerator = false,
    this.admitted = false,
  });

  String? userType;
  bool isModerator;
  bool admitted;

  factory LiveKitParticipantMetadata.fromJson(Map<String, dynamic> json) =>
      _$LiveKitParticipantMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$LiveKitParticipantMetadataToJson(this);
}

extension ParticipantExt on Participant {
  LiveKitParticipantMetadata getMetadata() {
    if (metadata == null || metadata?.isEmpty == true) {
      return LiveKitParticipantMetadata();
    }

    final Map<String, String> parsed = json.decode(metadata!);
    return LiveKitParticipantMetadata.fromJson(parsed);
  }

  bool get isTeacher {
    return getMetadata().userType == "2";
  }
}

extension RoomExt on Room {
  List<RemoteParticipant> get remoteParticipantsList {
    return remoteParticipants.values.toList();
  }

  bool get hasTeacherAsParticipant {
    return remoteParticipantsList.firstWhereOrNull(
          (e) => e.isTeacher,
        ) !=
        null;
  }

  RemoteParticipant? get teacherParticipant {
    if (!hasTeacherAsParticipant) return null;
    return remoteParticipantsList.firstWhereOrNull(
      (e) => e.isTeacher,
    );
  }
}
