enum TypeCode { PMNT, RTRN, MTRL }

enum DeliveryType { OFFICE, DELIVERYAGENT, WALLET, BANK, INSTPY }

enum StatusCode { NEW, INPROGRESS, DELIVERED, CANCELLED, FINISHED }

class AppQueriesAndMutations {
  AppQueriesAndMutations._(); // static const String  = r"""""";

// ************************Auth****************************
  static const String login =
      r"""mutation login($input: LoginInput!) { login(input: $input) { token } }""";
// ************************Requests****************************
  static const String customerRequests =
      r"""query ListCustomerRequests($typeCode: CustomerRequestTypeCode!, $first: Int!, $page: Int!) { listCustomerRequests(input: { typeCode: $typeCode }, first: $first, page: $page) { paginatorInfo { count currentPage firstItem hasMorePages lastItem lastPage perPage total } data { id date status { name } } } }""";
  static const String customerRequest =
      r"""query ($id: Int!) { customerRequest(id: $id) { id status { name } date deliveryType { name } notes payeeName type { code name } editable deletable } }""";
  static const String customerRequestSaving =
      r"""mutation ($input: CustomerRequestInput!) { saveCustomerRequest(input: $input) { id date status { name } } }""";
  static const String customerRequestEditing =
      r"""mutation ($input: CustomerRequestInput!) { saveCustomerRequest(input: $input) { id date status { name } } }""";
  static const String customerRequestCancelling =
      r"""mutation ($input: UpdateCustomerRequestStatusInput!) { updateCustomerRequestStatus(input: $input) { id date payeeName } }""";
}
