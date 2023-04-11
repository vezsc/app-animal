package util;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.net.http.HttpResponse.BodyHandlers;

import com.google.gson.Gson;

import data.animal.AnimalResponse;
import data.animal.AnimalResponseResult;

public class AnimalAPI {

	// OPEN API 연동해서 데이터 받아와서 파싱해서 컨트롤로 던져주면 됨
	public static AnimalResponse getAnimals() {
		try {
			// API 요청을 보낼때 다른 방식으로도 처리할 수 있다.
			String target = "http://apis.data.go.kr/1543061/abandonmentPublicSrvc/abandonmentPublic";
			String queryString = "serviceKey=TT8ageplWrUZlpTAKWDAFtcnq5YyxBCi6RVOckgyry%2FNP0YPser9sZRuj2%2Bbx3wNI0wHk4pv5YJdw1bbcjPC9w%3D%3D&_type=json";
			URI uri = new URI(target + "?" + queryString);
			// HttpRequest 객체를 활용하는 방식

			HttpClient client = HttpClient.newHttpClient();

			HttpRequest request = HttpRequest.newBuilder().uri(uri).GET().build();
			HttpResponse<String> response = client.send(request, BodyHandlers.ofString());

			Gson gson = new Gson();
			AnimalResponseResult responseResult = gson.fromJson(response.body(), AnimalResponseResult.class);

			return responseResult.getResponse();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
}
