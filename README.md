🌤️ Weather XML Processor – Usage Guide
📑 Description
This project fetches live weather data from the OpenWeatherMap API, validates it against an XSD schema, extracts key data using XPath, and transforms the XML into a styled HTML weather report using XSLT.

🚀 How to Use
Clone the repository

git clone https://github.com/yourusername/weather-xml-processor.git
cd weather-xml-processor

Add your OpenWeatherMap API key

Open WeatherHttpClient.java

Replace API_KEY with your valid OpenWeatherMap API key.

Build and run the project

You can run the project from your IDE (IntelliJ / Eclipse)

Or compile and run using terminal:

javac -d out src/**/*.java
java -cp out Main
Check outputs

✅ The XML weather data will be saved under the output/ folder.

✅ The validated and transformed HTML weather report will be generated in the same folder (e.g. kars-weather.html).

🔧 Project Structure
src/: Java source files

resources/: Contains weather.xsd schema and report.xslt transform file

output/: Generated XML and HTML files

📝 Requirements
Java 11 or higher

Internet connection to access the OpenWeatherMap API

💡 Features
Fetch real-time weather data as XML

Validate XML against XSD schema

Extract data using XPath expressions

Generate responsive HTML reports with XSLT styling

🙌 Contributions
Feel free to fork the repository, create issues, and submit pull requests to improve validation, styling, or multi-city support.

