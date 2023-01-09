const String baseProdURL =
    "https://wwa-salutemmetrics-ncus-prod.azurewebsites.net";
//Base URL

const String individualAPIURL = "api/v1/GetCheckFreshPingMetrics";
// api/v1/GetCheckFreshPingMetrics/{freshpingid}/{datetime}/{clientName}
// Grabs specific API's by freshping ID

const String allAPIData = "api/v1/GetAllChecksCurrentStatus/Page0";
//Grabs all data of every tracked API
//api/v1/GetAllCheckFreshPingMetrics/{clientName}/{datetime}   specifies time
