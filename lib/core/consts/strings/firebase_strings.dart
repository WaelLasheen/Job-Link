class FirebaseStrings {
  static final FirebaseStrings _instance = FirebaseStrings._();
  factory FirebaseStrings() => _instance;
  const FirebaseStrings._();

  // ----------*** Cloud firestore Collections ***----------
  final String usersCollection = 'users';
  final String jobsCollection = 'jobs';
  final String jobApplicationsCollection = 'jobApplications';
  final String tasksCollection = 'tasks';

  // ----------*** user collection model ***----------
  final String id = 'id';
  final String userType = 'userType';
  final String freelancer = 'freelancer';
  final String jobOwner = 'jobOwner';
  final String hourlyRate = 'hourlyRate';
  final String monthlyRate = 'monthlyRate';

  // ----------*** Freelancer fields ***----------
  final String name = 'name';
  final String experience = 'experience';
  final String jobTitle = 'jobTitle';
  final String cvUrl = 'cvUrl';

  // ----------*** Job Owner fields ***----------
  final String jobOwnerName = 'companyName';

  // ----------*** Job fields ***----------
  final String jobId = "jobId";
  final String title = "title";
  final String description = "description";
  final String paymentRate = "paymentRate";
  final String paymentType = "paymentType";
  final String requiredSkills = "requiredSkills";
  final String jobOwnerId = "jobOwnerId";
  final String jobOwnerCompanyName = "jobOwnerCompanyName";
  final String acceptedFreelancers = "acceptedFreelancers";
  // simple model of freelancer
  final String freelancerId = "freelancerId";
  final String freelancerName = "freelancerName";

  // ----------*** Job Application fields ***----------
  final String applicationId = "applicationId";
  final String applicationStatus = "status";
  final String applicationAppliedAt = "appliedAt";

  // ----------*** Mentions Task fields ***----------
  final String taskId = "taskId";
  final String taskTitle = "taskTitle";
  final String taskDescription = "taskDescription";
  final String startDate = 'startDate';
  final String endDate = 'endDate';
  final String taskStatue = 'taskStatus';
  final String createdAt = 'createdAt';

}
