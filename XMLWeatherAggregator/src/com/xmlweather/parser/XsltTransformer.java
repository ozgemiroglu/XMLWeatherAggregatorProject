package com.xmlweather.parser;

import javax.xml.transform.*;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import java.io.File;

public class XsltTransformer {

    public static void transformXMLToHTML(String xmlInput, String xsltPath, String htmlOutput) {
        try {
            TransformerFactory factory = TransformerFactory.newInstance();
            Source xslt = new StreamSource(new File(xsltPath));
            Transformer transformer = factory.newTransformer(xslt);

            Source xml = new StreamSource(new File(xmlInput));
            transformer.transform(xml, new StreamResult(new File(htmlOutput)));

            System.out.println("✅ HTML report generated: " + htmlOutput);
        } catch (Exception e) {
            System.out.println("❌ XSLT Transformation error: " + e.getMessage());
        }
    }
}
