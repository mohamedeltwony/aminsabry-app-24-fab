import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

/// Iqonic product
/// DO NOT CHANGE THIS PACKAGE NAME
var iqonicAppPackageName = isIOS ? 'apps.iqonic.streamit' : 'com.iqonic.streamit';
const DEFAULT_EMAIL = "john@demo.com";
const DEFAULT_PASS = "123456";

/// Livestream Keys
const PauseVideo = 'PauseVideo';
const RefreshHome = 'RefreshHome';


const msg = 'message';

const postPerPage = 10;

String? fontFamily = GoogleFonts.nunito().fontFamily;

/// default date format
const defaultDateFormat = 'dd, MM yyyy';
const dateFormatPmp = 'MMMM d, yyyy';

const DATE_FORMAT_1 = 'yyyy-MM-DD HH:mm:ss';
const DATE_FORMAT_2 = 'yyyy-MM-DDTHH:mm:ss';

const passwordLength = 5;
const passwordLengthMsg = 'Password length should be more than $passwordLength';

const checkValidation = 1;

/// SharedPreferences Keys
const isFirstTime = 'isFirstTime';
const isLoggedIn = 'isLoggedIn';
const TOKEN = 'TOKEN';
const EXPIRATION_TOKEN_TIME = 'EXPIRATION_TOKEN_TIME';
const USERNAME = 'USERNAME';
const NAME = 'NAME';
const LAST_NAME = 'LAST_NAME';
const USER_ID = 'USER_ID';
const USER_EMAIL = 'USER_EMAIL';
const USER_PROFILE = 'USER_PROFILE';
const PASSWORD = 'PASSWORD';
const DEVICE_ID = 'DEVICE_ID';
const PMP_CURRENCY = 'PMP_CURRENCY';
const CURRENCY_SYMBOL = 'CURRENCY_SYMBOL';
const WOO_NONCE = 'WOO_NONCE';
const USER_NONCE = 'USER_NONCE';
const MOVIE_DETAILS_ = 'MOVIE_DETAILS_';

/// Video last timestamp
const LAST_TIMESTAMPS = "LAST_TIMESTAMPS";

///user plan
const userPlanStatus = "active";
const SUBSCRIPTION_PLAN_ID = 'SUBSCRIPTION_PLAN_ID';
const SUBSCRIPTION_PLAN_START_DATE = 'SUBSCRIPTION_PLAN_START_DATE';
const SUBSCRIPTION_PLAN_EXP_DATE = 'SUBSCRIPTION_PLAN_EXP_DATE';
const SUBSCRIPTION_PLAN_STATUS = 'SUBSCRIPTION_PLAN_STATUS';
const SUBSCRIPTION_PLAN_TRIAL_STATUS = 'SUBSCRIPTION_PLAN_TRIAL_STATUS';
const SUBSCRIPTION_PLAN_NAME = 'SUBSCRIPTION_PLAN_NAME';
const SUBSCRIPTION_PLAN_AMOUNT = 'SUBSCRIPTION_PLAN_AMOUNT';
const SUBSCRIPTION_PLAN_TRIAL_END_DATE = 'SUBSCRIPTION_PLAN_TRIAL_END_DATE';
const SUBSCRIPTION_PLAN_IDENTIFIER = 'SUBSCRIPTION_PLAN_IDENTIFIER';
const SUBSCRIPTION_PLAN_GOOGLE_IDENTIFIER = 'SUBSCRIPTION_PLAN_GOOGLE_IDENTIFIER';
const SUBSCRIPTION_PLAN_APPLE_IDENTIFIER = 'SUBSCRIPTION_PLAN_APPLE_IDENTIFIER';
const SUBSCRIPTION_ENTITLEMENT_ID = 'SUBSCRIPTION_ENTITLEMENT_ID';
const SUBSCRIPTION_GOOGLE_API_KEY = 'SUBSCRIPTION_GOOGLE_API_KEY';
const SUBSCRIPTION_APPLE_API_KEY = 'SUBSCRIPTION_APPLE_API_KEY';
const HAS_IN_APP_PURCHASE_ENABLE = 'HAS_IN_APP_PURCHASE_ENABLE';
const HAS_IN_APP_SDK_INITIALISE_AT_LEASE_ONCE = 'HAS_IN_APP_SDK_INITIALISE_AT_LEASE_ONCE';
const HAS_PURCHASE_STORED = 'HAS_PURCHASE_STORED';
const PURCHASE_REQUEST = 'PURCHASE_REQUEST';
const IS_SUBSCRIPTION_PURCHASE_RESTORE_REQUIRED = 'IS_SUBSCRIPTION_PURCHASE_RESTORE_REQUIRED';

const DOWNLOADED_DATA = 'DOWNLOADED_DATA';

const RESUME_VIDEO_DATA = 'RESUME_VIDEO_DATA';

const planName = "Free";
const basicPlanName = 'Basic';
const premiumPlanName = 'Premium';
const freePlanGoogleIdentifier = 'free_plan:free-plan';
const freePlanAppleIdentifier = 'free_plan';

/// Post Type
enum PostType { MOVIE, TV_SHOW, EPISODE, NONE, VIDEO, LIVE_TV }

/// Like Dislike
const postLike = 'like';
const postUnlike = 'unlike';

// Dashboard Type
const dashboardTypeHome = 'home';
const dashboardTypeTVShow = 'tv_show';
const dashboardTypeMovie = 'movie';
const dashboardTypeVideo = 'video';
const dashboardTypeLive = 'live_tv';

const movieChoiceEmbed = 'movie_embed';
const movieChoiceURL = 'movie_url';
const movieChoiceFile = 'movie_file';
const movieChoiceLiveStream = 'movie_live_stream';

const videoChoiceEmbed = 'video_embed';
const videoChoiceURL = 'video_url';
const videoChoiceFile = 'video_file';
const videoChoiceLiveStream = "video_live_stream";

const episodeChoiceEmbed = 'episode_embed';
const episodeChoiceURL = 'episode_url';
const episodeChoiceFile = 'episode_file';
const episodeChoiceLiveStream = "episode_live_stream";

//region Playlist
const playlistMovie = "movie_playlist";
const playlistTvShows = "tv_show_playlist";
const playlistEpisodes = "episode_playlist";
const playlistVideo = "video_playlist";
//endregion

///restriction setting
const UserRestrictionStatus = 'loggedin';
const RestrictionTypeMessage = 'message';
const RestrictionTypeRedirect = 'redirect';
const RestrictionTypeTemplate = 'template';

/// error message
const redirectionUrlNotFound = 'Something went wrong. Please contact your administrator.';
const writeSomething = 'Write something';
const commentAdded = 'comment added';

///comment text
const reply = 'Add reply';

/// Network timeout message
const timeOutMsg = "Looks like you have an unstable network at the moment, please try again when network stabilizes";

const blankImage = "https://external-content.duckduckgo.com/iu/?u=http%3A%2F%2Fwww.pixelstalk.net%2Fwp-content%2Fuploads%2F2016%2F10%2FBlank-Wallpaper-HD.jpg";

/// PaymentMethods
class PaymentMethods {
  static const card = 'card';
  static const upi = 'upi';
  static const netBanking = 'netbanking';
  static const paylater = 'paylater';
}

//Comments SHOW-HIDE
const MOVIE_TYPE = 'MOVIE_TYPE';
const VIDEO_TYPE = 'VIDEO_TYPE';
const TV_SHOW_TYPE = 'TV_SHOW_TYPE';
const EPISODE_TYPE = 'EPISODE_TYPE';

class APIEndPoint {
  static const login = 'jwt-auth/v1/token';
  static const forgotPassword = 'streamit/api/v1/user/forgot-password';
  static const registration = 'streamit/api/v1/user/registration';
  static const validateToken = 'streamit/api/v1/user/validate-token';
  static const changePassword = 'streamit/api/v1/user/change-password';
  static const profile = 'streamit/api/v1/user/profile';
  static const devices = 'streamit/api/v1/user/devices';
  static const deleteAccount = 'streamit/api/v1/user/delete-account';
  static const dashboard = 'streamit/api/v1/content/dashboard';
  static const watchlist = 'streamit/api/v1/user/watchlist';
  static const search = 'streamit/api/v1/content/search';
  static const viewAll = 'streamit/api/v1/content/view-all';
  static const movieDetails = 'streamit/api/v1/movies';
  static const tvShowDetails = 'streamit/api/v1/tv-shows';
  static const episodeDetails = 'streamit/api/v1/tv-show/season/episodes';
  static const videoDetails = 'streamit/api/v1/videos';
  static const like = 'streamit/api/v1/user/like-dislike';
  static const wpComments = 'wp/v2/comments';
  static const personDetails = 'streamit/api/v1/cast/person';
  static const genre = 'streamit/api/v1/content';
  static const continueWatch = 'streamit/api/v1/user/continue-watch';
  static const playlist = 'streamit/api/v1/playlists';
  static const authNonce = 'streamit/api/v1/user/nonce';
  static const settings = 'streamit/api/v1/content/settings';
  static const blogComment = 'streamit/api/v1/wp-posts/comment';
  static const wpPost = 'wp/v2/posts';
  static const getNotificationsList = 'streamit/api/v1/notification/list';
  static const clearNotification = 'streamit/api/v1/notificaton/clear';
  static const notificationCount = 'streamit/api/v1/notificaton/count';
  static const manageFirebaseToken = 'streamit/api/v1/user/player-ids';
  static const liveChannelDetail = 'streamit/api/v1/live-tv/channels';
  static const liveTvCategoryList = 'streamit/api/v1/content/live_tv/genre';
}

class MembershipAPIEndPoint {
  static const getMembershipLevelForUser = 'pmpro/v1/get_membership_level_for_user';
  static const membershipLevels = 'streamit/api/v1/membership/levels';
  static const membershipOrders = 'streamit/api/v1/membership/orders';
  static const wcProducts = 'wc/v3/products';
  static const wcOrders = 'wc/v3/orders';
  static const cancelMembershipLevel = 'pmpro/v1/cancel_membership_level';
  static const changeMembershipLevel = 'pmpro/v1/change_membership_level';
}

class NonceTypes {
  static const user = 'user';
  static const woo = 'woo';
}

class FirebaseMsgConst {
  //region Firebase Notification
  static const additionalDataKey = 'additional_data';
  static const notificationGroupKey = 'notification_group';
  static const idKey = 'id';
  static const userWithUnderscoreKey = 'user_';
  static const notificationDataKey = 'Notification Data';
  static const fcmNotificationTokenKey = 'FCM Notification Token';
  static const apnsNotificationTokenKey = 'APNS Notification Token';
  static const notificationErrorKey = 'Notification Error';
  static const notificationTitleKey = 'Notification Title';

  static const notificationKey = 'Notification';

  static const onClickListener = "Error On Notification Click Listener";
  static const onMessageListen = "Error On Message Listen";
  static const onMessageOpened = "Error On Message Opened App";
  static const onGetInitialMessage = 'Error On Get Initial Message';

  static const messageDataCollapseKey = 'MessageData Collapse Key';

  static const messageDataMessageIdKey = 'MessageData Message Id';

  static const messageDataMessageTypeKey = 'MessageData Type';
  static const notificationBodyKey = 'Notification Body';
  static const backgroundChannelIdKey = 'background_channel';
  static const backgroundChannelNameKey = 'background_channel';

  static const notificationChannelIdKey = 'notification';
  static const notificationChannelNameKey = 'Notification';

  static const topicSubscribed = 'topic-----subscribed---->';

  static const topicUnSubscribed = 'topic-----Unsubscribed---->';

  //endregion
  // Notification Click Post type Keys
  static const postTypeKey = 'post_type';
  static const movieKey = 'movie';
  static const tvShowKey = 'tv_show';
  static const episodeKey = 'episode';
  static const videoKey = 'video';

  static const notificationType = 'type';
  static const notificationTypeRead = 'read';
  static const notificationTypeUnread = 'unread';

  static const newContentType = 'new-content';

//region
}

const IN_REVIEW_VIDEO = 'https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_10mb.mp4';

FirebaseOptions defaultFirebaseOption() {
  return FirebaseOptions(
      apiKey: 'AIzaSyBWNvYRlb73wucjlDIGxz3gaeCuMv33kx0',
      appId: isIOS ? '1:24891214351:ios:f30856243554a2cd67717a' : '1:24891214351:android:f9a6e8a9ebbd488a67717a',
      messagingSenderId: '24891214351',
      projectId: 'streamit-ae5a1',
      storageBucket: 'streamit-ae5a1.appspot.com',
      iosBundleId: 'apps.iqonic.streamit');
}

class PMProPayments {
  static const String inAppPayment = 'in-app';
  static const String defaultPayment = 'default';
  static const String disable = 'disable';
}

//Trailer Link Type
class VideoType {
  static  const String typeVimeo = 'vimeo';
  static  const String typeYoutube = "youtube";
  static  const String typeHLS = 'hls';
  static  const String typeURL = 'url';
  static  const String typeFile='file';
}

//LiveStream Keys
const DISPOSE_YOUTUBE_PLAYER='DISPOSE_YOUTUBE_PLAYER';
const PAUSE_YOUTUBE_PLAYER='PAUSE_YOUTUBE_PLAYER';
