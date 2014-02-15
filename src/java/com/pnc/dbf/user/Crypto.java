package com.pnc.dbf.user;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import sun.misc.BASE64Encoder;

public class Crypto {

    public static String encryption(String message) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            digest.update(message.getBytes());
            BASE64Encoder encoder = new BASE64Encoder();
            return encoder.encode(digest.digest());
        } catch (NoSuchAlgorithmException ns) {
            ns.printStackTrace();
            return message;
        }
    }
}
