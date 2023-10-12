part of 'send_email_otp_cubit.dart';

@immutable
abstract class SendEmailOtpState {}

class SendEmailOtpInitial extends SendEmailOtpState {}

class SendEmailOtpLoading extends SendEmailOtpState {}

class SendEmailOtpLoaded extends SendEmailOtpState {}

class SendEmailOtpError extends SendEmailOtpState {
  String? error;

  SendEmailOtpError({this.error});
}
