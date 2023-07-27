package data.address;

import com.google.gson.annotations.SerializedName;

public class AddressDocument {

	@SerializedName("y")
	String lng; // 경도

	@SerializedName("x")
	String lat; // 위도

	@SerializedName("address_tpe")
	String type;

	@SerializedName("address_name")
	String name;

	public String getLng() {
		return lng;
	}

	public String getLat() {
		return lat;
	}

	public String getType() {
		return type;
	}

	public String getName() {
		return name;
	}

}
