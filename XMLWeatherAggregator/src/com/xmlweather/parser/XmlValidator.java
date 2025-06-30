package com.xmlweather.parser;

import java.io.File;
import javax.xml.XMLConstants;
import javax.xml.transform.stream.StreamSource;
import javax.xml.validation.SchemaFactory;
import javax.xml.validation.Schema;
import javax.xml.validation.Validator;

public class XmlValidator {

    public static boolean validateXMLSchema(String xsdPath, String xmlPath) {
        try {
            // Create a SchemaFactory capable of understanding W3C XML Schema (XSD)
            SchemaFactory factory = SchemaFactory.newInstance(XMLConstants.W3C_XML_SCHEMA_NS_URI);

            // Load the XSD file as a Schema object for validation
            Schema schema = factory.newSchema(new File(xsdPath));

            // Create a Validator instance from the loaded Schema
            Validator validator = schema.newValidator();

            // Validate the XML file against the loaded XSD schema
            // If the XML is not valid, this line will throw an exception
            validator.validate(new StreamSource(new File(xmlPath)));

            // If no exception is thrown, validation was successful
            System.out.println("✅ XML is valid against XSD.");
            return true;

        } catch (Exception e) {
            // Catch any exceptions during schema loading or validation
            // Print the error message for debugging purposes
            System.out.println("❌ XML validation error: " + e.getMessage());
            return false;
        }
    }

}
