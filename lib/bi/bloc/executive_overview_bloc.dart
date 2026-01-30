import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../repositories/bi_repository.dart';

// Events
abstract class ExecutiveOverviewEvent extends Equatable {
  const ExecutiveOverviewEvent();

  @override
  List<Object> get props => [];
}

class LoadOverviewData extends ExecutiveOverviewEvent {}

// States
abstract class ExecutiveOverviewState extends Equatable {
  const ExecutiveOverviewState();

  @override
  List<Object> get props => [];
}

class ExecutiveOverviewInitial extends ExecutiveOverviewState {}

class ExecutiveOverviewLoading extends ExecutiveOverviewState {}

class ExecutiveOverviewLoaded extends ExecutiveOverviewState {
  final List<Map<String, dynamic>> kpis;
  final List<Map<String, dynamic>> insights;
  final Map<String, dynamic> charts;
  final List<Map<String, dynamic>> tableData;

  const ExecutiveOverviewLoaded({
    required this.kpis,
    required this.insights,
    required this.charts,
    required this.tableData,
  });

  @override
  List<Object> get props => [kpis, insights, charts, tableData];
}

class ExecutiveOverviewError extends ExecutiveOverviewState {
  final String message;

  const ExecutiveOverviewError(this.message);

  @override
  List<Object> get props => [message];
}

// Bloc
class ExecutiveOverviewBloc
    extends Bloc<ExecutiveOverviewEvent, ExecutiveOverviewState> {
  final BiRepository repository;

  ExecutiveOverviewBloc({required this.repository})
    : super(ExecutiveOverviewInitial()) {
    on<LoadOverviewData>(_onLoadOverviewData);
  }

  Future<void> _onLoadOverviewData(
    LoadOverviewData event,
    Emitter<ExecutiveOverviewState> emit,
  ) async {
    emit(ExecutiveOverviewLoading());
    try {
      final data = await repository.getOverviewMetrics();
      emit(
        ExecutiveOverviewLoaded(
          kpis: List<Map<String, dynamic>>.from(data['kpis']),
          insights: List<Map<String, dynamic>>.from(data['insights']),
          charts: Map<String, dynamic>.from(data['charts']),
          tableData: List<Map<String, dynamic>>.from(data['top_products']),
        ),
      );
    } catch (e) {
      emit(const ExecutiveOverviewError('Failed to load dashboard data'));
    }
  }
}
