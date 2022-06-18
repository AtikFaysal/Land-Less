class AppUrl{
  static const String liveBaseURL = "https://www.pit-rangabali.com";
  static const String localBaseURL = "https://shelterproject.brightsoftai.com";

  static const String baseURL = liveBaseURL;
  static const String login = baseURL + "/api/Login/loginCheck";
  static const String commanLogin = baseURL + "/api/Login/userCommonData";
  static const String logout = baseURL + "/api/Account/Logout";
  //dashBoard
  static const String dashboardApi = baseURL + "/api/ShelterProject/dashboardData";
  //memberList
  static const String getPublicDataApi = baseURL + "/api/PublicUser/pablicUpazilaUPDData";
  static const String getPublicMemberApi = baseURL + "/api/PublicUser/pablicUserSearchMemberData";
  static const String getPublicMemberById = baseURL + "/api/PublicUser/pablicUserSearchMemberDataByID";
  static const String unionData = baseURL + "/api/PublicUser/pablicUPDPourashavaData";
  static const String memberListApi = baseURL + "/api/ShelterProject/shelterProjectMemberList";
  static const String memberEntry = baseURL + "/api/ShelterProject/shelterProjectMemberEntry";//memberEntry
  static const String memberEntryUpdate = baseURL + "/api/ShelterProject/shelterProjectMemberUpdate";
  static const String getMemberById = baseURL + "/api/ShelterProject/getMemberByID";
  static const String approvedMember = baseURL + "/api/ShelterProject/approvedMember";
  static const String rejectMember = baseURL + "/api/ShelterProject/rejectMember";
  static const String changePassword = baseURL + "/api/ShelterProject/changePassword";
  static const String showReport = baseURL + "/api/ShelterProject/getShelterProjectReport";

//Dio
  static const String dioMemebrEntry ="/api/ShelterProject/shelterProjectMemberEntry";
  static const String dioMemebrEntryUpdate ="/api/ShelterProject/shelterProjectMemberUpdate";
  static const String postHouseInformation ="/api/ShelterProject/houseInformationEntry";
  static const String postKabikhaProjectInformation ="/api/KabikhaProject/kabikhaProjectInformationEntry";


  //KabikhaProjectApi
  static const String kabikhaInfoListDataApi = baseURL + "/api/KabikhaProject/kabikhaProjectList";
  static const String kabikhaProjectEntry = baseURL + "/api/KabikhaProject/kabikhaProjectEntry";
  static const String kabikhaProjectById = baseURL + "/api/KabikhaProject/getKabikhaProjectByID";
  static const String khabikhaProjectUpdate = baseURL + "/api/KabikhaProject/kabikhaProjectUpdate";
  static const String approveKhabikha = baseURL + "/api/KabikhaProject/approvedKabikhaProject";
  static const String rejectKhabikha = baseURL + "/api/KabikhaProject/rejectKabikhaProject";
  static const String kabikhaInfoEntry = baseURL + "/api/KabikhaProject/kabikhaProjectInformationEntry";
  static const String kabikhaDashboard = baseURL + "/api/KabikhaProject/kabikhaDashboardData";
  static const String KabikhaReport = baseURL + "/api/KabikhaProject/getKabikhaProjectReport";
  static const String kabikhaLocationAndImageUpload = baseURL + "/api/KabikhaProject/kabikhaProjectMapAndImageCollect";

  //TrProject
  static const String trDashboard = baseURL + "/api/TRProject/trDashboardData";
  static const String trEntryProject = baseURL + "/api/TRProject/trProjectEntry";
  static const String trList = baseURL + "/api/TRProject/trProjectList";
  static const String trListItemById = baseURL + "/api/TRProject/getTRProjectByID";
  static const String trUpdateListItemById = baseURL + "/api/TRProject/trProjectUpdate";
  static const String trApprovedItem = baseURL + "/api/TRProject/approvedTRProject";
  static const String trRejectItem = baseURL + "/api/TRProject/rejectTRProject";
  static const String trProjectInfoEntry = baseURL + "/api/TRProject/trProjectInformationEntry";
  static const String trReportShow = baseURL + "/api/TRProject/getTRProjectReport";
  static const String trImageAndLocation = baseURL + "/api/TRProject/trProjectMapAndImageCollect";


}