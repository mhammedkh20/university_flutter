class ApiSettings{
  static const apiUrl = "https://dargonsoftt.com/api/";
  static const forgotPassword = apiUrl +"forgotPassword";

  static const storeUser = apiUrl + "storeUser";
  static const login = apiUrl + "login";
  static const logout = apiUrl +"logout";
  static const universities = apiUrl + "universities" ;
 // static const univById = apiUrl + "universities/{id}";
  static const departmentByUniv = apiUrl+ "getDepartments/{id}";
 // static const department = apiUrl + "departments";
  static const departmentById = apiUrl+ "departments/{id}";
  static const majorInDepartment = apiUrl + "getMajors/{id}";
  //static const majors = apiUrl +"majors";
  //static const majorById = apiUrl +"majors/{id}";
//static const semestercourses = apiUrl + "getSemesterCourses/{major_id}/{semester_id}";


static const yearsemestercourses = apiUrl + "getYearSemesterCourses/{major_id}/{year_id}/{semester_id}";
//static const yearCourses = apiUrl + "getYearCourses/{major_id}/{year_id}";
// static const allCourses = apiUrl + "courses";
// static const course = apiUrl + "courses/{id}";
//static const resources = apiUrl +"getAllResources/{id}";

static const video = apiUrl + "getVideoResources/{id}";
static const sounds = apiUrl + "getSoundResources/{id}";
static const urlResource = apiUrl + "getUrlResources/{id}";
static const summarizations  = apiUrl + "getSummarizationResources/{id}";
static const samples  = apiUrl + "getSamplesResources/{id}";
static const videoUrl = apiUrl + "getVideoUrlResources/{id}";
static const allBooks = apiUrl + "getBookResources/{id}";
static const lectures = apiUrl + "getOtherResources/{id}";

//static const allResources = apiUrl + "resources";
static const resourcesById = apiUrl + "resources/{id}";
static const resourceTypes = apiUrl+ "resourceTypes";
//static const resourceTypeBYiD = apiUrl+ "resourceTypes/{id}";

static const semesters  = apiUrl + "semesters";
//static const semesterInformation = apiUrl +"semesters/{id}";

static const years = apiUrl +"years";
static const getCategories = apiUrl +"getCardCategories";
static const getDistributionPoints = apiUrl +"getDistributionPoints";
static const chargeUserCard = apiUrl +"chargeUserCard";
static const search = apiUrl +"searchCourses";
//static const yearById = apiUrl + "years/{id}";


}