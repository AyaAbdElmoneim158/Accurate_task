import 'package:accurate_task/core/common/app_dropdown.dart';
import 'package:accurate_task/core/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../../../core/common/app_app_bar.dart';
import '../../../../core/common/app_button.dart';
import '../../../../core/common/app_field.dart';
import '../../../../core/common/full_scroll_screen_container.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/sizes.dart';
import '../../../../core/helper/function_helper.dart';
import '../../data/models/request_customer_request_saving.dart';
import '../../data/models/response_customer_request_fetching.dart';
import '../view_model/customer_requests_provider.dart';
import '../view_model/date_provider.dart';

class RequestAddtionOrUpdating extends StatefulWidget {
  const RequestAddtionOrUpdating(
      {Key? key,
      this.isEdit = false,
      this.id = 000,
      required this.request // = ResponseCustomerRequestFetching.empty(),
      })
      : super(key: key);
  final bool isEdit;
  final int id;
  final ResponseCustomerRequestFetching request;

  @override
  State<RequestAddtionOrUpdating> createState() =>
      _RequestAddtionOrUpdatingState();
}

class _RequestAddtionOrUpdatingState extends State<RequestAddtionOrUpdating> {
  // final provider =
  //       Provider.of<CustomerRequestProvider>(context, listen: false);
  //   final dateProvider = Provider.of<DateProvider>(context, listen: false);
  GlobalKey<FormState> requestFormKey = GlobalKey();
  TextEditingController requestDataController = TextEditingController();
  TextEditingController requestTypeController = TextEditingController();
  TextEditingController requestDeliveryTypeController = TextEditingController();
  TextEditingController requestPayeeNameController = TextEditingController();
  TextEditingController requestNotesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Safely accessing `request` values and providing default values
    requestDataController.text = widget.request.date; // default empty string
    requestTypeController.text = widget.request.type.name;
    requestDeliveryTypeController.text = widget.request.deliveryType.name;
    requestPayeeNameController.text = widget.request.payeeName;
    requestNotesController.text = widget.request.notes;
  }

  @override
  Widget build(BuildContext context) {
    return FullScrollScreenContainer(
      ///  AppBar - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      appBar: const AppAppBar(
        title: AppStrings.createRequest,
        hasLeading: true,
      ),

      ///  Body - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      body: Consumer<CustomerRequestProvider>(
          builder: (context, requestProvider, child) {
        _listen(context, requestProvider, child);
        return Form(
          key: requestFormKey,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// Data.field - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
              AppField(
                hintText: "Data",
                controller: requestDataController,
                // initialValue: DateTime.now().toIso8601String(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () {
                    final dateProvider =
                        Provider.of<DateProvider>(context, listen: false);
                    dateProvider.selectDate(context);
                    requestDataController.text = dateProvider.formattedDate;
                  },
                  tooltip: 'Show Calendar',
                ),
              ),
              AppSizes.verticalSpace(AppSizes.defaultBtwFields),

              /// Request_type.field - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
              // AppField(
              //   hintText: "Request type",
              //   controller: requestTypeController,
              // ),
              AppDropdown(
                controller: requestTypeController,
                hintText: "Request type",
                mapping: requestTypemapping,
                display: requestTypeDisplay,
              ),
              AppSizes.verticalSpace(AppSizes.defaultBtwFields),

              /// Delivery_type.field - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
              AppDropdown(
                controller: requestDeliveryTypeController,
                hintText: "Delivery type",
                mapping: deliveryTypemapping,
                display: deliveryTypeDisplay,
              ),
              AppSizes.verticalSpace(AppSizes.defaultBtwFields),

              /// Payee_name.field - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
              //todo: dropdown
              AppField(
                hintText: "Payee name",
                controller: requestPayeeNameController,
              ),
              AppSizes.verticalSpace(AppSizes.defaultBtwFields),

              /// Notes.field - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
              AppField(
                hintText: AppStrings.notes,
                controller: requestNotesController,
                maxLines: 3,
              ),
              AppSizes.verticalSpace(AppSizes.defaultBtwFields),

              ///  Save.btn - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
              (requestProvider.customerRequestStatus ==
                          CustomerRequestStatus.saving ||
                      requestProvider.customerRequestStatus ==
                          CustomerRequestStatus.editing)
                  ? FunctionHelper.showLoader()
                  : AppButton(
                      onPressed: widget.isEdit
                          ? () {
                              RequestCustomerRequestSaving
                                  requestCustomerRequestSaving =
                                  RequestCustomerRequestSaving(
                                id: widget.id,
                                date: requestDataController.text.trim(),
                                deliveryTypeCode:
                                    requestDeliveryTypeController.text.trim(),
                                notes: requestNotesController.text.trim(),
                                payeeName:
                                    requestPayeeNameController.text.trim(),
                                typeCode: requestTypeController.text.trim(),
                              );
                              requestProvider.editCustomerRequest(
                                  requestCustomerRequestSaving);
                            }
                          : () {
                              RequestCustomerRequestSaving
                                  requestCustomerRequestSaving =
                                  RequestCustomerRequestSaving(
                                date: requestDataController.text.trim(),
                                deliveryTypeCode:
                                    requestDeliveryTypeController.text.trim(),
                                notes: requestNotesController.text.trim(),
                                payeeName:
                                    requestPayeeNameController.text.trim(),
                                typeCode: requestTypeController.text.trim(),
                              );
                              requestProvider.saveCustomerRequest(
                                  requestCustomerRequestSaving);
                            },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.check_circle_outline,
                            color: AppColors.white,
                            size: AppSizes.iconSm + 4,
                          ),
                          AppSizes.horizontalSpace(AppSizes.sm),
                          Text(
                            widget.isEdit ? "Edit" : AppStrings.save,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: AppColors.white),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        );
      }),
    );
  }

  _listen(context, CustomerRequestProvider requestProvider, child) {
    if (requestProvider.customerRequestStatus == CustomerRequestStatus.error &&
        requestProvider.errorMessage != null) {
      Future.delayed(Duration.zero, () {
        FunctionHelper.showErrorDialog(context, requestProvider.errorMessage!);
      });
    } else if (requestProvider.customerRequestStatus ==
        CustomerRequestStatus.saved) {
      final request = requestProvider.defaultCustomerRequest;

      // FunctionHelper.showSnackbar(
      //   context,
      //   "The request has been added with number ${request.id} on ${FunctionHelper.formatDate(request.date)} with status is ${request.status.name}.",
      //   AppColors.primary,
      // );

      Future.delayed(
        const Duration(seconds: 2),
        () => Navigator.pushReplacementNamed(context, "/CustomerRequests"),
      );
    } else if (requestProvider.customerRequestStatus ==
        CustomerRequestStatus.edited) {
      final request = requestProvider.defaultCustomerRequest;

      FunctionHelper.showSnackbar(
        context,
        "The request has been Edited with number ${request.id} on ${FunctionHelper.formatDate(request.date)} with status is ${request.status.name}.",
        AppColors.primary,
      );

      Future.delayed(
        const Duration(seconds: 2),
        () => Navigator.pushReplacementNamed(context, "/CustomerRequests"),
      );
    }
  }
}
