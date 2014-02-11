package com.pnc.dbf.user;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.logging.Level;
import java.util.logging.Logger;
import sun.misc.BASE64Encoder;

public class Crypto {

    public Crypto() {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            digest.update("bokanga".getBytes());
            BASE64Encoder encoder = new BASE64Encoder();
            System.err.println(encoder.encode(digest.digest()));
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(Crypto.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static void main(String[] args) {
        new Crypto();
    }
}
