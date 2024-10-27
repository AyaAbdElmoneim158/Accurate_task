// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/common/app_app_bar.dart';
import '../../../../core/common/app_button.dart';
import '../../../../core/common/app_dropdown.dart';
import '../../../../core/common/app_field.dart';
import '../../../../core/common/full_scroll_screen_container.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/queries_and_mutations.dart';
import '../../../../core/constants/sizes.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/helper/function_helper.dart';
import '../../data/models/request_customer_request_saving.dart';
import '../../data/models/response_customer_request_fetching.dart';
import '../view_model/customer_requests_provider.dart';
import '../view_model/date_provider.dart';

class RequestAdditionOrUpdating extends StatefulWidget {
  const RequestAdditionOrUpdating({
    super.key,
    this.isEdit = false,
    this.id = 000,
    required this.request,
  });

  final bool isEdit;
  final int id;
  final ResponseCustomerRequestFetching request;

  @override
  State<RequestAdditionOrUpdating> createState() => _RequestAdditionOrUpdatingState();
}

class _RequestAdditionOrUpdatingState extends State<RequestAdditionOrUpdating> {
  final GlobalKey<FormState> requestFormKey = GlobalKey();
  final requestDateController = TextEditingController();
  final requestTypeController = TextEditingController();
  final requestDeliveryTypeController = TextEditingController();
  final requestPayeeNameController = TextEditingController();
  final requestNotesController = TextEditingController();

  @override
  void initState() {
    super.initState();

    requestDateController.text = widget.request.date;
    requestPayeeNameController.text = widget.request.payeeName;
    requestNotesController.text = widget.request.notes;
    requestTypeController.text = widget.request.type.name;
    requestDeliveryTypeController.text = widget.request.deliveryType.name;
  }

  @override
  Widget build(BuildContext context) {
    return FullScrollScreenContainer(
      appBar: AppAppBar(
        title: widget.isEdit ? "Edit request" : "Create request",
        hasLeading: true,
      ),
      body: Consumer<CustomerRequestProvider>(
        builder: (context, requestProvider, child) {
          _listenToProvider(context, requestProvider);
          return Form(
            key: requestFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildDateField(context, requestDateController),
                AppSizes.verticalSpace(AppSizes.defaultBtwFields),
                if (widget.isEdit)
                  _buildDropdownField(
                    controller: requestTypeController,
                    hintText: "Request type",
                    mapping: requestTypeMapping,
                    display: requestTypeDisplay,
                    initialSelectedValue: requestTypeMapping2[requestTypeController.text],
                  ),
                AppSizes.verticalSpace(AppSizes.defaultBtwFields),
                _buildDropdownField(
                  controller: requestDeliveryTypeController,
                  hintText: "Delivery type",
                  mapping: deliveryTypeMapping,
                  display: (widget.request.type == TypeCode.PMNT) ? deliveryTypePMNTDisplay : deliveryTypeDisplay,
                  initialSelectedValue: requestDeliveryTypeController.text,
                ),
                AppSizes.verticalSpace(AppSizes.defaultBtwFields),
                _buildTextField("Payee name", requestPayeeNameController),
                AppSizes.verticalSpace(AppSizes.defaultBtwFields),
                _buildNotesField(requestNotesController),
                AppSizes.verticalSpace(AppSizes.defaultBtwFields),
                _buildSaveButton(
                  context,
                  requestProvider,
                  requestTypeController,
                  requestDeliveryTypeController,
                  requestPayeeNameController,
                  requestNotesController,
                  requestDateController,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDateField(BuildContext context, TextEditingController controller) {
    return AppField(
      hintText: "Date",
      controller: controller,
      suffixIcon: IconButton(
        icon: const Icon(Icons.calendar_today),
        onPressed: () {
          final dateProvider = Provider.of<DateProvider>(context, listen: false);
          dateProvider.selectDate(context);
          controller.text = dateProvider.formattedDate;
        },
        tooltip: 'Show Calendar',
      ),
    );
  }

  Widget _buildDropdownField({
    required TextEditingController controller,
    required String hintText,
    required Map<String, String> mapping,
    required List<String> display,
    String? initialSelectedValue = '',
    bool readOnly = false,
  }) {
    return AppDropdown(
      controller: controller,
      hintText: hintText,
      mapping: mapping,
      display: display,
      initialSelectedValue: initialSelectedValue,
      readOnly: readOnly,
    );
  }

  Widget _buildTextField(String hintText, TextEditingController controller) {
    return AppField(
      hintText: hintText,
      controller: controller,
    );
  }

  Widget _buildNotesField(TextEditingController controller) {
    return AppField(
      hintText: AppStrings.notes,
      controller: controller,
      maxLines: 3,
    );
  }

  Widget _buildSaveButton(
    BuildContext context,
    CustomerRequestProvider requestProvider,
    TextEditingController typeController,
    TextEditingController deliveryTypeController,
    TextEditingController payeeNameController,
    TextEditingController notesController,
    TextEditingController dateController,
  ) {
    return (requestProvider.customerRequestStatus == CustomerRequestStatus.saving)
        ? FunctionHelper.showLoader()
        : AppButton(
            onPressed: widget.isEdit
                ? () {
                    RequestCustomerRequestSaving requestCustomerRequestSaving = RequestCustomerRequestSaving(
                      id: widget.id,
                      date: requestDateController.text.trim(),
                      deliveryTypeCode: requestDeliveryTypeController.text.trim(),
                      notes: requestNotesController.text.trim(),
                      payeeName: requestPayeeNameController.text.trim(),
                      typeCode: requestTypeController.text.trim(),
                    );
                    requestProvider.editCustomerRequest(requestCustomerRequestSaving);
                  }
                : () {
                    final newRequest = RequestCustomerRequestSaving(
                      date: dateController.text.trim(),
                      deliveryTypeCode: deliveryTypeController.text.trim(),
                      notes: notesController.text.trim(),
                      payeeName: payeeNameController.text.trim(),
                      typeCode: typeController.text.trim(),
                    );
                    requestProvider.saveCustomerRequest(newRequest);
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
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.white),
                ),
              ],
            ),
          );
  }

  void _listenToProvider(BuildContext context, CustomerRequestProvider requestProvider) {
    if (requestProvider.customerRequestStatus == CustomerRequestStatus.error && requestProvider.errorMessage != null) {
      Future.delayed(Duration.zero, () {
        FunctionHelper.showErrorDialog(context, requestProvider.errorMessage!);
      });
    } else if (requestProvider.customerRequestStatus == CustomerRequestStatus.saved) {
      FunctionHelper.showSnackbar(context, "Saved successfully", AppColors.primary);
      Future.delayed(
        const Duration(seconds: 3),
        () => Navigator.pushReplacementNamed(context, "/CustomerRequests"),
      );
    } else if (requestProvider.customerRequestStatus == CustomerRequestStatus.edited) {
      // FunctionHelper.showSnackbar(
      //     context, "Edited successfully", AppColors.primary);

      Future.delayed(
        const Duration(seconds: 3),
        () => Navigator.pushReplacementNamed(context, "/CustomerRequests"),
      );
    }
  }
}
