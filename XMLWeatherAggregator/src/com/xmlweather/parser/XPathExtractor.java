package com.xmlweather.parser;

import org.w3c.dom.Document;
import javax.xml.xpath.*;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import java.io.File;

public class XPathExtractor {

    public static void extractWeatherData(String xmlFilePath) {
        try {
            // Load the XML file from the provided path
            File xmlFile = new File(xmlFilePath);

            // Create a DocumentBuilderFactory instance to parse the XML
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();

            // Create a DocumentBuilder to build a Document object from the XML file
            DocumentBuilder builder = factory.newDocumentBuilder();

            // Parse the XML file into a Document object representing the DOM tree
            Document doc = builder.parse(xmlFile);

            // Create an XPathFactory to build XPath objects
            XPathFactory xPathFactory = XPathFactory.newInstance();

            // Create an XPath object to compile and evaluate XPath expressions
            XPath xpath = xPathFactory.newXPath();

            // Extract the temperature value using XPath expression targeting the attribute "value"
            String temperature = xpath.evaluate("/current/temperature/@value", doc);

            // Extract the temperature unit attribute (e.g., Celsius)
            String temperatureUnit = xpath.evaluate("/current/temperature/@unit", doc);

            // Extract the "feels like" temperature value
            String feelsLike = xpath.evaluate("/current/feels_like/@value", doc);

            // Extract the unit of the "feels like" temperature
            String feelsLikeUnit = xpath.evaluate("/current/feels_like/@unit", doc);

            // Extract the humidity value
            String humidity = xpath.evaluate("/current/humidity/@value", doc);

            // Extract the humidity unit attribute (usually '%')
            String humidityUnit = xpath.evaluate("/current/humidity/@unit", doc);

            // Extract the wind speed value
            String windSpeed = xpath.evaluate("/current/wind/speed/@value", doc);

            // Extract the unit of wind speed (e.g., meter/sec)
            String windUnit = xpath.evaluate("/current/wind/speed/@unit", doc);

            // Extract the textual weather description (e.g., Clear, Cloudy)
            String weatherDesc = xpath.evaluate("/current/weather/@value", doc);

            // Print the extracted weather data in a readable format
            System.out.println("🌡️ Temperature: " + temperature + " " + temperatureUnit);
            System.out.println("🤗 Feels Like: " + feelsLike + " " + feelsLikeUnit);
            System.out.println("💧 Humidity: " + humidity + " " + humidityUnit);
            System.out.println("💨 Wind Speed: " + windSpeed + " " + windUnit);
            System.out.println("☀️ Weather: " + weatherDesc);

        } catch (Exception e) {
            // Catch and report any errors during parsing or XPath evaluation
            System.out.println("❌ XPath extraction error: " + e.getMessage());
        }
    }
}
