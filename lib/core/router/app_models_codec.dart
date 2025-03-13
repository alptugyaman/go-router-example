import 'dart:convert';

import 'package:go_router_example/core/constants/app_model_codec_constats.dart';
import 'package:go_router_example/core/models/micro_app_model.dart';

class AppModelsCodec extends Codec<Object?, Object?> {
  const AppModelsCodec();

  @override
  Converter<Object?, Object?> get encoder => const _AppModelsEncoder();

  @override
  Converter<Object?, Object?> get decoder => const _AppModelsDecoder();
}

class _AppModelsEncoder extends Converter<Object?, Object?> {
  const _AppModelsEncoder();

  @override
  Object? convert(Object? input) {
    if (input == null) return null;

    // Handle MicroAppModel
    if (input is MicroAppModel) {
      return {
        'type': AppModelCodecConstants.microAppModel,
        'data': {
          'title': input.title,
          'image': input.image,
          'link': input.link,
        },
      };
    }

    // Handle List of MicroAppModel
    if (input is List && input.isNotEmpty && input.first is MicroAppModel) {
      return {
        'type': AppModelCodecConstants.listMicroAppModel,
        'data': input.map((model) => convert(model)).toList(),
      };
    }

    // For any other type, return as is
    return input;
  }
}

class _AppModelsDecoder extends Converter<Object?, Object?> {
  const _AppModelsDecoder();

  @override
  Object? convert(Object? input) {
    if (input == null) return null;

    // Handle Map that might contain our serialized objects
    if (input is Map) {
      final type = input['type'];
      final data = input['data'];

      if (type == AppModelCodecConstants.microAppModel && data is Map) {
        return MicroAppModel(
          title: data['title'] as String?,
          image: data['image'] as String?,
          link: data['link'] as String?,
        );
      }

      if (type == AppModelCodecConstants.listMicroAppModel && data is List) {
        return data.map((item) => convert(item)).toList();
      }
    }

    // For any other type, return as is
    return input;
  }
}
