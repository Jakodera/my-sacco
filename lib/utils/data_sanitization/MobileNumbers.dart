class MobileNumbers {
    static String sanitizePhoneNumber(String thePhoneNumber) {
        thePhoneNumber = thePhoneNumber.replaceAll(new RegExp("\\s"), "");
        thePhoneNumber = thePhoneNumber.replaceFirst(new RegExp("^\\+"), "");
        if (thePhoneNumber.startsWith("+")) {
            thePhoneNumber = thePhoneNumber.replaceFirst(new RegExp("^\\+"), "");
        }

        if (thePhoneNumber.contains(new RegExp("^2547\\d{8}")) || thePhoneNumber.contains(new RegExp("^2541\\d{8}"))) {
            return thePhoneNumber;
        }

        if (thePhoneNumber.contains(new RegExp("^07\\d{8}")) || thePhoneNumber.contains(new RegExp("^01\\d{8}"))) {
            return thePhoneNumber.replaceFirst(new RegExp("^0"), "254");
        }

        if (thePhoneNumber.contains(new RegExp("^7\\d{8}")) || thePhoneNumber.contains(new RegExp("^1\\d{8}"))) {
            return "254" + thePhoneNumber;
        }

        if (thePhoneNumber.contains(new RegExp("^25407\\d{8}"))) {
            return thePhoneNumber.replaceFirst(new RegExp("^25407"), "2547");
        }

        if (thePhoneNumber.contains(new RegExp("^25401\\d{8}"))) {
            return thePhoneNumber.replaceFirst(new RegExp("^25401"), "2541");
        }

        if (thePhoneNumber.contains(new RegExp("^254\\+254\\d{9}"))) {
            return thePhoneNumber.replaceFirst(new RegExp("^254\\+254"), "254");
        }

        if (thePhoneNumber.contains(new RegExp("^254254\\d{9}"))) {
            return thePhoneNumber.replaceFirst(new RegExp("^254254"), "254");
        }

        if (thePhoneNumber.contains(new RegExp("^254\\+25401\\d{8}"))) {
            return thePhoneNumber.replaceFirst(new RegExp("^254\\+25401"), "2541");
        }

        if (thePhoneNumber.contains(new RegExp("^254\\+25407\\d{8}"))) {
            return thePhoneNumber.replaceFirst(new RegExp("^254\\+25407"), "2547");
        }

        if (thePhoneNumber.contains(new RegExp("^25425401\\d{8}"))) {
            return thePhoneNumber.replaceFirst(new RegExp("^25425401"), "2541");
        }

        if (thePhoneNumber.contains(new RegExp("^25425407\\d{8}"))) {
            return thePhoneNumber.replaceFirst(new RegExp("^25425407"), "2547");
        }
        return thePhoneNumber;
    }
}