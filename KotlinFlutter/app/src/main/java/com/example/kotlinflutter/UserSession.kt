package com.example.kotlinflutter

import android.content.Context
import android.content.SharedPreferences

/**
 * This class is used only to get the session of the logged in user. So only very basic data included.
 * The data is saved in shared preference.
 * @param context context needed to get the data from shared preference
 * @property userId User ID of the account, set this variable will automatically saved to local shared preference.
 * @property uid token session of the account (in Geniebook, session is saved in uid), set this variable will automatically saved to local shared preference.
 * @property mcsToken MicroService Token (used in the GenieAsk, GenieSmart + GenieClass will follow in the future), set this variable will automatically saved to local shared preference.
 * @property mcsTokenExpired expired of the MCS token, set this variable will automatically saved to local shared preference.
 * @property firstName first name of the account, set this variable will automatically saved to local shared preference.
 * @property lastName last name of the account, set this variable will automatically saved to local shared preference.
 * @property levelId level id of the account, set this variable will automatically saved to local shared preference.
 * @property bubble bubble of the account, set this variable will automatically saved to local shared preference.
 */
class UserSession(private val context: Context) {

    private val keyPreferences
        get() = KEY_PREFERENCES

    private var mUserId: String? = null
    private var mStudentId: String? = null
    private var mUid: String? = null
    private var mApiKey: String? = null
    private var mMcsToken: String? = null
    private var mMcsTokenExpired: Long = 0L

    //will soon remove
    private var mFirstName: String? = null
    private var mLastName: String? = null
    private var mLevelId: String? = null
    private var mUserBubble: Int = 0

    var userId: String?
        get() = mUserId
        set(value) {
            getSharePref().edit().putString(PARAM_USER_ID, value).apply()
            mUserId = value
        }

    var uid: String?
        get() {
            return mUid
        }
        set(value) {
            getSharePref().edit().putString(PARAM_USER_UID, value).apply()
            mUid = value
        }

    var apiKey: String?
        get() {
            return mApiKey
        }
        set(value) {
            getSharePref().edit().putString(PARAM_API_KEY, value).apply()
            mApiKey = value
        }

    var mcsToken: String?
        get() {
            return mMcsToken
        }
        set(value) {
            getSharePref().edit().putString(PARAM_MCS_TOKEN, value).apply()
            mMcsToken = value
        }

    var mcsTokenExpired: Long
        get() {
            return  mMcsTokenExpired
        }
        set(value) {
            getSharePref().edit().putLong(PARAM_MCS_TOKEN_EXPIRED, value).apply()
            mMcsTokenExpired = value
        }

    var firstName: String?
        get() {
            return mFirstName
        }
        set(value) {
            getSharePref().edit().putString(PARAM_FIRST_NAME, value).apply()
            mFirstName = value
        }

    var lastName: String?
        get() {
            return mLastName
        }
        set(value) {
            getSharePref().edit().putString(PARAM_LAST_NAME, value).apply()
            mLastName = value
        }

    var levelId: String?
        get() {
            return mLevelId
        }
        set(value) {
            getSharePref().edit().putString(PARAM_LEVEL_ID, value).apply()
            mLevelId = value
        }

    var bubble: Int
        get() {
            return mUserBubble
        }
        set(value) {
            getSharePref().edit().putInt(PARAM_USER_BUBBLE, value).apply()
            mUserBubble = value
        }

    companion object {
        private const val KEY_PREFERENCES = "FlutterSharedPreferences"
//        private const val KEY_PREFERENCES = "com.geniebook.android.preferences_user_data_key"

        private const val PARAM_USER_ID = "user_id"
        private const val PARAM_USER_UID = "user_uid"
        private const val PARAM_API_KEY = "api_key"
        private const val PARAM_MCS_TOKEN = "mcs_token"
        private const val PARAM_MCS_TOKEN_EXPIRED = "mcs_token_exp"

        private const val PARAM_OLD_MCS_TOKEN = "access_token"
        private const val PARAM_OLD_MCS_TOKEN_EXPIRED = "expired_at"

        private const val PARAM_FIRST_NAME = "first_name"
        private const val PARAM_LAST_NAME = "last_name"

        private const val PARAM_LEVEL_ID = "level_id"
        private const val PARAM_USER_BUBBLE = "user_bubble"

        private const val PARAM_SELECTED_STUDENT_ID = "selected_student_id"
    }

    init {
        mUserId = getSharePref().getString(PARAM_USER_ID, null)
        mUid = getSharePref().getString(PARAM_USER_UID, null)
        mFirstName = getSharePref().getString(PARAM_FIRST_NAME, null)
        mLastName = getSharePref().getString(PARAM_LAST_NAME, null)
        mLevelId = getSharePref().getString(PARAM_LEVEL_ID, null)
        mUserBubble = getSharePref().getInt(PARAM_USER_BUBBLE, 0)
        mMcsToken = getSharePref().getString(PARAM_MCS_TOKEN, null)
        mMcsTokenExpired = getSharePref().getLong(PARAM_MCS_TOKEN_EXPIRED, 0L)
        mStudentId = getSharePref().getString(PARAM_SELECTED_STUDENT_ID, null)
    }

    private fun getSharePref(): SharedPreferences {
        return context.getSharedPreferences(keyPreferences, Context.MODE_PRIVATE)
    }

    fun clear() {
        getSharePref().edit().clear().apply()
    }
}