import 'dart:async';

import 'package:terapiasdaluna/domain/interactor/supplements/listen_to_supplements_interactor.dart';
import 'package:terapiasdaluna/domain/model/supplements/supplement.dart';
import 'package:terapiasdaluna/domain/repository/supplements/supplements_repository.dart';

class ListenToSupplementsInteractorImpl extends ListenToSupplementsInteractor {
  final SupplementsRepository supplementsRepository;

  ListenToSupplementsInteractorImpl({required this.supplementsRepository});

  @override
  Future<void> execute(String userId, StreamSink<List<Supplement>> streamSink) => supplementsRepository.listenToSupplements(userId, streamSink);

}