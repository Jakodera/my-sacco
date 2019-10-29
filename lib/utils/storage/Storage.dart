class StorageKeys {
    //USER_DETAILS
    static const String PHONE_NUMBER = "PHONE_NUMBER";
    static const String USER_NAME = "USER_NAME";
    static const String PASSWORD = "PASSWORD";
    static const String IMEI_NUMBER = "IMEI_NUMBER";
    static const String SESSION_ID = "SESSION_ID";

    //ORG_DETAILS
    static const String APP_NAME = "APP_NAME";
    static const String APP_VERSION = "APP_VERSION";
    static const String APP_MAX_PASSWORD_ATTEMPTS = "APP_MAX_PASSWORD_ATTEMPTS";
    static const String FULL_NAME = "FULL_NAME";
    static const String SHORT_NAME = "SHORT_NAME";
    static const String SLOGAN = "SLOGAN";
    static const String PHONE = "PHONE";
    static const String EMAIL = "EMAIL";
    static const String ADDRESS = "ADDRESS";
    static const String LOGO = "LOGO";
}

class StorageValues {
    //USER_DETAILS
    // ignore: non_constant_identifier_names
    static String PHONE_NUMBER = "";

    // ignore: non_constant_identifier_names
    static String USER_NAME = "";

    // ignore: non_constant_identifier_names
    static String PASSWORD = "";

    // ignore: non_constant_identifier_names
    static String IMEI_NUMBER = "";

    // ignore: non_constant_identifier_names
    static String SESSION_ID = "";


    //ORG_DETAILS
    // ignore: non_constant_identifier_names
    static String APP_NAME = "";

    // ignore: non_constant_identifier_names
    static String APP_VERSION = "";

    // ignore: non_constant_identifier_names
    static String APP_MAX_PASSWORD_ATTEMPTS = "";

    // ignore: non_constant_identifier_names
    static String FULL_NAME = "";

    // ignore: non_constant_identifier_names
    static String SHORT_NAME = "";

    // ignore: non_constant_identifier_names
    static String SLOGAN = "";

    // ignore: non_constant_identifier_names
    static String PHONE = "";

    // ignore: non_constant_identifier_names
    static String EMAIL = "";

    // ignore: non_constant_identifier_names
    static String ADDRESS = "";

    // ignore: non_constant_identifier_names
    static String LOGO = "";
}

class Storage {
    // ignore: non_constant_identifier_names
    String PHONE_NUMBER;
    // ignore: non_constant_identifier_names
    String USER_NAME;
    // ignore: non_constant_identifier_names
    String PASSWORD;
    // ignore: non_constant_identifier_names
    String IMEI_NUMBER;
    // ignore: non_constant_identifier_names
    String SESSION_ID;
    // ignore: non_constant_identifier_names
    String APP_NAME;
    // ignore: non_constant_identifier_names
    String APP_VERSION;
    // ignore: non_constant_identifier_names
    String APP_MAX_PASSWORD_ATTEMPTS;
    // ignore: non_constant_identifier_names
    String FULL_NAME;
    // ignore: non_constant_identifier_names
    String SHORT_NAME;
    // ignore: non_constant_identifier_names
    String SLOGAN;
    // ignore: non_constant_identifier_names
    String PHONE;
    // ignore: non_constant_identifier_names
    String EMAIL;
    // ignore: non_constant_identifier_names
    String ADDRESS;
    // ignore: non_constant_identifier_names
    String LOGO;

    //Storage(this.PHONE_NUMBER, this.USER_NAME, this.PASSWORD, this.IMEI_NUMBER, this.SESSION_ID, this.APP_NAME, this.APP_VERSION, this.APP_MAX_PASSWORD_ATTEMPTS, this.FULL_NAME, this.SHORT_NAME, this.SLOGAN, this.PHONE, this.EMAIL, this.ADDRESS, this.LOGO);

    // ignore: non_constant_identifier_names
    Storage(String PHONE_NUMBER, String USER_NAME, String PASSWORD, String IMEI_NUMBER, String SESSION_ID, String APP_NAME, String APP_VERSION, String APP_MAX_PASSWORD_ATTEMPTS, String FULL_NAME, String SHORT_NAME, String SLOGAN, String PHONE, String EMAIL, String ADDRESS, String LOGO) {
        this.PHONE_NUMBER = PHONE_NUMBER;
        this.USER_NAME = USER_NAME;
        this.PASSWORD = PASSWORD;
        this.IMEI_NUMBER = IMEI_NUMBER;
        this.SESSION_ID = SESSION_ID;
        this.APP_NAME = APP_NAME;
        this.APP_VERSION = APP_VERSION;
        this.APP_MAX_PASSWORD_ATTEMPTS = APP_MAX_PASSWORD_ATTEMPTS;
        this.FULL_NAME = FULL_NAME;
        this.SHORT_NAME = SHORT_NAME;
        this.SLOGAN = SLOGAN;
        this.PHONE = PHONE;
        this.EMAIL = EMAIL;
        this.ADDRESS = ADDRESS;
        this.LOGO = LOGO;
    }
}