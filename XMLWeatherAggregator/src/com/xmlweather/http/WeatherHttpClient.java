package com.xmlweather.http;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.file.Files;
import java.nio.file.Path;

public class WeatherHttpClient {

    private static final String API_KEY = "8c4e7fe7809880563fef915647c10e64";
    private static final String BASE_URL = "https://api.openweathermap.org/data/2.5/weather";

    public static String getWeatherXml(String city) throws IOException, InterruptedException {
        // Encode the city name to be URL-safe (e.g., spaces to %20)
        String encodedCity = URLEncoder.encode(city, StandardCharsets.UTF_8);

        // Build the complete API URL with city, XML response mode, and API key
        String url = BASE_URL + "?q=" + encodedCity + "&mode=xml&appid=" + API_KEY;

        // Create a new HTTP client instance
        HttpClient client = HttpClient.newHttpClient();

        // Build the HTTP GET request for the weather API
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(url))
                .GET()
                .build();

        // Send the request and retrieve the response body as a String
        HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());

        // Create the output directory if it does not exist
        Path outputDir = Path.of("output");
        if (!Files.exists(outputDir)) {
            Files.createDirectories(outputDir);
        }

        // Define the XML output file name based on the city name
        String fileName = "output/" + city.toLowerCase() + "-weather.xml";

        // Write the API response content to the XML file
        Files.writeString(Path.of(fileName), response.body());

        // Log the successful saving of the XML data
        System.out.println("✅ XML weather data saved to " + fileName);

        // Return the raw XML response as a String for further processing if needed
        return response.body();
    }
}
