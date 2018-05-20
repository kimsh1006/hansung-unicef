package cmd.controller;

/**
 * GpsToAddress - GPS 위도 경도로 한글 주소로 변환 - google maps API
 * 2018.03.31 api 정책변화에따라 api 키 입력 및 https 로 변환
 */

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.*;



import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.json.simple.parser.JSONParser;

class GpsToAddress {
	double latitude;
	double longitude;
	String regionAddress;

	public GpsToAddress(double latitude, double longitude) throws Exception {
		this.latitude = latitude;
		this.longitude = longitude;
		this.regionAddress = getRegionAddress(getJSONData(getApiAddress()));
	}

	private String getApiAddress() {
		String apiURL = "https://maps.googleapis.com/maps/api/geocode/json?latlng="
				+ latitude + "," + longitude + "&key=AIzaSyDKXjpw17bGnWOSfo2CVAiiLrisd_o-Ftc"+ "&language=ko ";
		System.out.println(apiURL);
		return apiURL;
	}

	private String getJSONData(String apiURL) throws Exception {
		String jsonString = new String();
		String buf;
		URL url = new URL(apiURL);
		URLConnection conn = url.openConnection();
		BufferedReader br = new BufferedReader(new InputStreamReader(
				conn.getInputStream(), "UTF-8"));
		while ((buf = br.readLine()) != null) {
			jsonString += buf;
		}
		return jsonString;
	}

	private String getRegionAddress(String jsonString) {
		JSONObject jObj = (JSONObject) JSONValue.parse(jsonString);
		JSONArray jArray = (JSONArray) jObj.get("results");
		jObj = (JSONObject) jArray.get(0);
		return (String) jObj.get("formatted_address");
	}

	public String getAddress() {
		return regionAddress;
	}
}



