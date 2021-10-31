part of '../crise_med_bloc/crise_med_bloc.dart';

@immutable
abstract class CrisesWithMedEvent extends Equatable {
  const CrisesWithMedEvent();

  @override
  List<Object> get props => [];
}

class GetCrisesWithMedEvent extends CrisesWithMedEvent {}
