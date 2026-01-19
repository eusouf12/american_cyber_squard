class ApiUrl {
  static const String baseUrl = "https://florist-pros-beijing-housing.trycloudflare.com";
  static const String imageUrl = baseUrl;
  static String socketUrl = baseUrl;
  static String mapKey = "AIzaSyBuSZJklSc1j0D4kqhkJcmyArcZbWujbXQ";

  ///========================= Authentication =========================
  static const String signUp = "/api/v1/user/create_user";
  static const String refreshToken = "/api/v1/auth/refresh-token";
  static const String verificationOtp = "/api/v1/user/user_verification";
  static const String verificationOtpForgetPass = "/api/v1/user/verification_forgot_user";
  static const String signIn = "/api/v1/auth/login_user";
  static const String forgotPassword = "/api/v1/user/forgot_password";
  static const String newPassword = "/api/v1/user/reset_password";
  static const String updateProfile = "/api/v1/auth/update_my_profile";
  static const String myProfile = "/api/v1/auth/myprofile";
  static const String termsCondition = "/api/v1/setting/find_by_terms_conditions";
  static const String privacyPolicy = "/api/v1/setting/find_by_privacy_policys";
  static const String changePassword = "/api/v1/user/change_password";
  static const String googleAuth = "/api/v1/user/google_auth";
  static  String  deleteAccount({required String userId})=> "/api/v1/auth/delete_account/$userId";



  ///========================= Host =========================
  static const String createEvent = "/api/v1/event/create_event";
  static  String  updateEvent({required String eventId})=> "/api/v1/event/update_event/$eventId";
  static  String  getEventById({required String eventId})=> "/api/v1/event/find_by_specific_event/$eventId";
  static String allHostEvent({required int page}) => "/api/v1/event/find_my_event_list?page=$page&limit=10";
  static String allHostEventChatRoom({required int page}) => "/api/v1/event_chat_room/find_by_my_event_chatroom?page=$page&limit=10";
  static String allDmChatRoom({required int page}) => "/api/v1/event_chat_room/my_event_chatroom?page=1&limit=10";
  static String allDmGroup({required int page}) => "/api/v1/join_group/find_my_join_group?page=$page&limit=10";
  static String  allHostEventGroup({required int page}) => "/api/v1/join_group/find_by_my_join_event_Group?page=$page&limit=10";
  static String createPostEvent= "/api/v1/event_post/create_post_event";
  static String createStory= "/api/v1/social_feed_route/social_feed";
  static String getAllPosts({required int page}) =>  "/api/v1/followup/find_by_my_event_social_feed?page=$page&limit=10";
  static String searchUser({required String userName}) =>  "/api/v1/auth/tag_user?searchTerm=$userName";
  static String getAllStories({required int page}) => "/api/v1/social_feed_route/find_my_follow_waie_social_feed?page=$page&limit=10";
  static String reactPost= "/api/v1/event_social_post/react_event";
  static String commentEvent= "/api/v1/event_social_post/event_comment";
  static  String  getComment({required String postId})=> "/api/v1/event_post_reply/find_by_specific_event_comment_filtering/$postId";
  static  String  replyComment= "/api/v1/event_post_reply/reply";
  static String getRepliesByCommentId(String commentId) => "/api/v1/event_post_reply/find_by_specific_event_reply_filtering/$commentId";
  static String postShare= "/api/v1/event_social_post/event_share";
  static String createGalleryPost= "/api/v1/memories_event/memories_post_event";
  static String getGalleryPosts({required int page})=> "/api/v1/memories_event/find_my_upload_memories_event?page=$page&limit=10";
  static String getGalleryPostFilter({required  int page, required String filter})=> "/api/v1/memories_event/find_my_upload_memories_event?contentType=$filter&page=$page&limit=10";
  static String notificationList({required int page})=>"/api/v1/notification/specific_user_notification_list?page=$page&limit=10";
  //share post
  static String sharePost(String postId)=>"post/$postId";
  static String shareNonEventLatAndLong(String type,String lat, String lon, String title)=>"${type}/${title}/${lat},${lon}";



  //String userId = await SharePrefsHelper.getString(AppConstants.userId);
  ///========================= Dm  =========================
  static  String  dmLiveEvent({required String searchTime,required int page})=> "/api/v1/event/find_by_all_live_event_filtering?page=$page&limit=10&searchTerm=live&eventDate=$searchTime";
  static  String  joinLiveEvent({required String eventId})=> "/api/v1/payment/is_live_event_payment_exist/$eventId";
  static  String  liveEventDetails({required String eventId})=> "/api/v1/event/find_by_specific_event/$eventId";
  static  String  liveEventCreatePost = "/api/v1/event_post/create_post_event";
  static  String  liveEventGetPost({required String eventId,required int page})=> "/api/v1/event_post/find_by_all_specific_event_post_list/$eventId?page=$page&limit=10";
  static  String  postLiveComment = "/api/v1/event_social_post/live_event_comment";
  static  String  getPoint = "/api/v1/point_system/recorded_point_system";
  static  String  postRating = "/api/v1/rating/record_rating_event";
  static  String  getLiveComment({required String eventId})=> "/api/v1/event_social_post/find_by_specific_live_comment/$eventId";
  static  String  addFollowLiveDetailsPage= "/api/v1/followup/recorded_followup";
  static  String  addBlockUser= "/api/v1/followup/user_block";
  static  String  dmUpcomingEvent({required int page})=> "/api/v1/event/find_by_all_upcomming_and_past_event?page=$page&limit=10";
  static  String  getFavouriteList({required int page})=>  "/api/v1/favorite_event/find_by_all_my_favorite_event?page=$page&limit=10";
  static  String  deleteFavouriteList({required String deleteId})=> "/api/v1/favorite_event/delete_my_favorite_event/$deleteId";
  static  String  addFavouriteList = "/api/v1/favorite_event/recorded_my_favorite_event";
  static String paymentMethod= "/api/v1/payment/payment_onboarding";
  static String loveEmoji= "/api/v1/memories_event/love_eemoji_memories_event_count";
  static String getFavouriteDetails({required String specificId}) => "/api/v1/favorite_event/find_by_specific_my_favorite_event/$specificId";
  static  String  nonEventNearbyGet({required String lat, required String lon, required String type})=> "/api/v1/event/nearest_location_ways_non_event?latitude=$lat&longitude=$lon&type=$type";
  static String getPaymentStripe= "/api/v1/payment/create-onboarding-link";
  static String postPaymentStripe= "/api/v1/payment/create-checkout-session";
  static String uploadFile= "/api/v1/message/new_message";
  static String uploadSingleFile= "/api/v1/message/single_new_message";
  static  String  getGroupChat({required String eventId,required int page})=> "/api/v1/conversation/specific_event_wise_conversation/$eventId?page=$page&limit=15";
  static String singleMessageList({required int page})=>"/api/v1/conversation/get_single_conversation?page=$page&limit=10";
  static String findFollowedList({required int page})=>"/api/v1/followup/find_my_followed_list?page=$page&limit=10";
  static String findFollowingList({required int page})=>"/api/v1/followup/find_my_following_list?page=$page&limit=10";
  static String getBlockedUsersList({required int page})=>"/api/v1/followup/blocked-users?page=$page&limit=10";
  static  String  deletePost({required String deleteId})=> "/api/v1/event_post/delete_event_post/$deleteId";
  static  String  joinGroup({required String groupId})=> "/api/v1/join_group/join_event_group/$groupId";
  static String postReport="/api/v1/social_feed_report/recorded_report";
  static  String  deleteFollowing({required String deleteId})=> "/api/v1/followup/delete_follower_list/$deleteId";
  static  String  updatePost({required String postId})=> "/api/v1/event_post/update_event_post/$postId";
  static  String  inviteFriend= "/api/v1/followup/send_invitasation_notification";
  static String findNearestEvent({required String category, required String features  }) => "/api/v1/event/find_by_nearest_event?event_category=$category&event_features=$features";
  static String avgRating= "/api/v1/event/host_all_event_avg_rating";
  static String pushNotification= "/api/v1/notification/find_my_notification";
  static String patchNotification= "/api/v1/notification/change_notification_status";
  static String getAveragePoints="/api/v1/point_system/my_avg_point";
  static String sendReaction="/api/v1/event_social_post/live_event_emoji";
  static  String  getReaction({required String eventId})=> "/api/v1/event_social_post/find_by_specific_live_emoji/$eventId";
  static  String  deletepost({required String deleteId})=> "/api/v1/event_post/delete_event_post/$deleteId";
  static String paymentHistory({required int page})=>"/api/v1/payment/find_my_payment_history?page=$page&limit=10";
  static String eventHistory({required int page})=>"/api/v1/payment/completed_event_past_list?page=$page&limit=10";
  static  String  eventGallery({required String eventId,required int page})=> "/api/v1/event_post/completed_live_event_post_media_file/$eventId?page=$page&limit=10";
  static  String  getSingleChatInbox({required String conversionId,required int page})=> "/api/v1/message/find_by_specific_conversation/$conversionId?page=$page&limit=10";
  static  String  personalProfileDetails({required String id})=> "/api/v1/followup/find_my_following_and_followed_list/$id";
  static String personalProfilePosts({required String id,required int page}) =>  "/api/v1/event_post/find_my_all_event_post_list/$id?page=$page&limit=10";
  static String filterMap({required String filter}) =>  "/api/v1/event/find_by_nearest_event?$filter";
  static String nearbyMyLocation({required String lat, required String lon}) =>  "/api/v1/event/find_my_nearest_event?lat=$lat&lon=$lon}";

  // map
  static const String getMap = "/map?sw_lat=18&sw_lng=89&ne_lat=24&ne_lng=92&category_id=68185fc91db8477bce1fade2";

}