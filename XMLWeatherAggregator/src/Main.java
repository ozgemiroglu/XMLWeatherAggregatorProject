package com.xmlweather;

import com.xmlweather.http.WeatherHttpClient;
import com.xmlweather.parser.XPathExtractor;
import com.xmlweather.parser.XmlValidator;
import com.xmlweather.parser.XsltTransformer;

public class Main {
    public static void main(String[] args) {
        try {
            // Define the city name for weather data retrieval
            String city = "Kars";

            // Build the file paths for XML input/output, XSD schema, and XSLT transformation
            String xmlFile = "output/" + city.toLowerCase() + "-weather.xml";
            String xsdFile = "resources/weather.xsd";
            String xsltFile = "resources/report.xslt";
            String htmlOutput = "output/" + city.toLowerCase() + "-weather.html";

            // 1. Fetch weather data from API and generate the XML file
            WeatherHttpClient.getWeatherXml(city);
            System.out.println("✅ XML data successfully retrieved and saved");

            // 2. Validate the generated XML file against the XSD schema
            boolean isValid = XmlValidator.validateXMLSchema(xsdFile, xmlFile);
            if (!isValid) {
                System.out.println("❌ XML validation failed. Terminating process...");
                return;
            }
            System.out.println("✅ XML validation successful");

            // 3. Extract specific weather data using XPath expressions
            XPathExtractor.extractWeatherData(xmlFile);
            System.out.println("✅ XPath data extraction completed");

            // 4. Transform the validated XML file into an HTML report using XSLT
            XsltTransformer.transformXMLToHTML(xmlFile, xsltFile, htmlOutput);
            System.out.println("✅ HTML report generated: " + htmlOutput);

        } catch (Exception e) {
            // Print any unexpected errors that occur during execution
            System.err.println("❌ An error occurred:");
            e.printStackTrace();
        }
    }
}