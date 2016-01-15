package com.syk.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * MD5 工具类 2015年8月29日
 */
public class MD5Utils {
	private String mResult;
	private String mKey;
	private MessageDigest currentAlgorithm;

	/**
	 * @param paramString
	 *            paramString
	 */
	public MD5Utils(String paramString) {
		this.mKey = paramString;
		try {
			this.currentAlgorithm = MessageDigest.getInstance("MD5");
			this.mResult = computeDigest(loadBytes(this.mKey));
		} catch (NoSuchAlgorithmException localNoSuchAlgorithmException) {
			localNoSuchAlgorithmException.toString();
		}
	}

	/**
	 * 
	 * @param paramArrayOfByte
	 *            paramArrayOfByte
	 * @return String
	 */
	private String computeDigest(byte[] paramArrayOfByte) {
		this.currentAlgorithm.reset();
		this.currentAlgorithm.update(paramArrayOfByte);
		byte[] arrayOfByte = this.currentAlgorithm.digest();
		String str = "";
		int i = 0;
		for (int j = 0; j < arrayOfByte.length; j += 2) {
			i = arrayOfByte[j] & 0xFF;
			if (i < 16) {
				str = str + "0" + Integer.toHexString(i);
			} else {
				str = str + Integer.toHexString(i);
			}
			i = arrayOfByte[(j + 1)] & 0xFF;
			if (i < 16) {
				str = str + "0" + Integer.toHexString(i);
			} else {
				str = str + Integer.toHexString(i);
			}
		}

		return str.trim().toLowerCase();
	}

	public String getResult() {
		return this.mResult;
	}

	/**
	 * 
	 * @param paramString
	 *            paramString
	 * @return arrayOfByte
	 */
	private static byte[] loadBytes(String paramString) {
		byte[] arrayOfByte = paramString.getBytes();

		return arrayOfByte;
	}

	public static void main(String[] args) {
		MD5Utils m = new MD5Utils("sunyukun");

		System.out.println(m.getResult());
	}
}