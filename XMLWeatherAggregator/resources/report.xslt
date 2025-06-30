<?xml version="1.0" encoding="UTF-8"?>

<!--
This XSLT file transforms an XML weather data document into a styled HTML report.
It defines a template to convert temperatures from Kelvin to Celsius and uses XPath
to extract weather details such as city name, temperature, and description for display
in a modern, responsive HTML layout with CSS styling.
-->


<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="html" indent="yes"/>
    <xsl:template name="kelvinToCelsius">
        <xsl:param name="kelvin"/>
        <xsl:value-of select="round(($kelvin - 273.15) * 10) div 10"/>
    </xsl:template>
    <xsl:template match="/current">
        <html lang="tr">
            <head>
                <title><xsl:value-of select="city/@name"/> Hava Durumu</title>
                <meta charset="UTF-8"/>
                <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
                <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&amp;display=swap" rel="stylesheet"/>
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"/>
                <style>
                    :root {
                    --primary: #4361ee;
                    --secondary: #3f37c9;
                    --light: #f8f9fa;
                    --dark: #212529;
                    --success: #4cc9f0;
                    --danger: #f72585;
                    --warning: #f8961e;
                    }

                    body {
                    font-family: 'Poppins', sans-serif;
                    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
                    min-height: 100vh;
                    margin: 0;
                    padding: 20px;
                    color: var(--dark);
                    }

                    .weather-container {
                    max-width: 600px;
                    margin: 30px auto;
                    background: white;
                    border-radius: 16px;
                    box-shadow: 0 30px 50px rgba(0, 0, 0, 0.1);
                    padding: 40px;
                    position: relative;
                    overflow: hidden;
                    }

                    .weather-container::before {
                    content: "";
                    position: absolute;
                    top: 0;
                    left: 0;
                    width: 100%;
                    height: 10px;
                    background: linear-gradient(90deg, var(--primary), var(--success));
                    }

                    .city-name {
                    font-size: 2.5rem;
                    font-weight: 600;
                    margin: 0 0 10px;
                    color: var(--secondary);
                    }

                    .weather-main {
                    display: flex;
                    align-items: center;
                    margin: 20px 0;
                    padding-bottom: 20px;
                    border-bottom: 1px solid rgba(0, 0, 0, 0.1);
                    }

                    .temperature {
                    font-size: 4rem;
                    font-weight: 300;
                    margin-right: 20px;
                    position: relative;
                    }

                    .weather-icon {
                    font-size: 3rem;
                    margin-right: 20px;
                    color: var(--primary);
                    }

                    .weather-description {
                    font-size: 1.2rem;
                    text-transform: capitalize;
                    }

                    .details-grid {
                    display: grid;
                    grid-template-columns: repeat(2, 1fr);
                    gap: 20px;
                    margin-top: 20px;
                    }

                    .detail-card {
                    background: rgba(67, 97, 238, 0.05);
                    border-radius: 10px;
                    padding: 15px;
                    display: flex;
                    align-items: center;
                    }

                    .detail-icon {
                    font-size: 1.5rem;
                    margin-right: 15px;
                    color: var(--primary);
                    }

                    .detail-value {
                    font-size: 1.2rem;
                    font-weight: 600;
                    }

                    .detail-label {
                    font-size: 0.8rem;
                    opacity: 0.7;
                    margin-top: 3px;
                    }

                    .update-time {
                    text-align: right;
                    font-size: 0.8rem;
                    color: rgba(0, 0, 0, 0.5);
                    margin-top: 30px;
                    }

                    @media (max-width: 600px) {
                    .weather-container {
                    padding: 30px 20px;
                    }

                    .details-grid {
                    grid-template-columns: 1fr;
                    }

                    .city-name {
                    font-size: 2rem;
                    }
                    }
                </style>
            </head>
            <body>
                <div class="weather-container">
                    <h1 class="city-name"><xsl:value-of select="city/@name"/></h1>

                    <div class="weather-main">
                        <div class="temperature-display">
                            <!-- Ana sıcaklık değeri (Celsius'a dönüştürülmüş) -->
                            <div class="temperature">
                                <xsl:call-template name="kelvinToCelsius">
                                    <xsl:with-param name="kelvin" select="temperature/@value"/>
                                </xsl:call-template>
                                <span class="temperature-unit">°C</span>
                            </div>

                            <!-- Weather icon-->
                            <div class="weather-icon-container">
                                <i class="weather-icon fas">
                                    <xsl:choose>
                                        <xsl:when test="weather/@value = 'Clear'">
                                            <xsl:attribute name="class">weather-icon fas fa-sun</xsl:attribute>
                                            <xsl:attribute name="style">color: #FDB813;</xsl:attribute>
                                        </xsl:when>
                                        <xsl:when test="weather/@value = 'Clouds'">
                                            <xsl:attribute name="class">weather-icon fas fa-cloud</xsl:attribute>
                                            <xsl:attribute name="style">color: #BDC3C7;</xsl:attribute>
                                        </xsl:when>
                                        <xsl:when test="weather/@value = 'Rain'">
                                            <xsl:attribute name="class">weather-icon fas fa-cloud-rain</xsl:attribute>
                                            <xsl:attribute name="style">color: #3498DB;</xsl:attribute>
                                        </xsl:when>
                                        <xsl:when test="weather/@value = 'Snow'">
                                            <xsl:attribute name="class">weather-icon fas fa-snowflake</xsl:attribute>
                                            <xsl:attribute name="style">color: #AED6F1;</xsl:attribute>
                                        </xsl:when>
                                        <xsl:when test="weather/@value = 'Thunderstorm'">
                                            <xsl:attribute name="class">weather-icon fas fa-bolt</xsl:attribute>
                                            <xsl:attribute name="style">color: #F1C40F;</xsl:attribute>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:attribute name="class">weather-icon fas fa-cloud-sun</xsl:attribute>
                                            <xsl:attribute name="style">color: #F39C12;</xsl:attribute>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </i>
                                <div class="weather-description">
                                    <xsl:value-of select="weather/@value"/>
                                    <!-- Hissedilen sıcaklık -->
                                    <div class="feels-like">
                                        Feels Like:
                                        <xsl:call-template name="kelvinToCelsius">
                                            <xsl:with-param name="kelvin" select="feels_like/@value"/>
                                        </xsl:call-template>°C
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="details-grid">
                        <div class="detail-card">
                            <i class="detail-icon fas fa-temperature-low"></i>
                            <div>
                                <div class="detail-value"><xsl:call-template name="kelvinToCelsius">
                                    <xsl:with-param name="kelvin" select="feels_like/@value"/>
                                </xsl:call-template>°C</div>
                                <div class="detail-label">Feels Like</div>
                            </div>
                        </div>

                        <div class="detail-card">
                            <i class="detail-icon fas fa-tint"></i>
                            <div>
                                <div class="detail-value"><xsl:value-of select="humidity/@value"/><xsl:value-of select="humidity/@unit"/></div>
                                <div class="detail-label">Humidity</div>
                            </div>
                        </div>

                        <div class="detail-card">
                            <i class="detail-icon fas fa-wind"></i>
                            <div>
                                <div class="detail-value"><xsl:value-of select="wind/speed/@value"/> <xsl:value-of select="wind/speed/@unit"/></div>
                                <div class="detail-label">Wind Speed</div>
                            </div>
                        </div>

                        <div class="detail-card">
                            <i class="detail-icon fas fa-compass"></i>
                            <div>
                                <div class="detail-value">
                                    <xsl:choose>
                                        <xsl:when test="wind/direction/@name = 'North'">North</xsl:when>
                                        <xsl:when test="wind/direction/@name = 'North-East'">North East</xsl:when>
                                        <xsl:when test="wind/direction/@name = 'East'">East</xsl:when>
                                        <xsl:when test="wind/direction/@name = 'South-East'">South East'</xsl:when>
                                        <xsl:when test="wind/direction/@name = 'South'">South</xsl:when>
                                        <xsl:when test="wind/direction/@name = 'South-West'">South West</xsl:when>
                                        <xsl:when test="wind/direction/@name = 'West'">West</xsl:when>
                                        <xsl:when test="wind/direction/@name = 'North-West'">North West</xsl:when>
                                        <xsl:otherwise><xsl:value-of select="wind/direction/@name"/></xsl:otherwise>
                                    </xsl:choose>
                                </div>
                                <div class="detail-label">Rüzgar Yönü</div>
                            </div>
                        </div>
                    </div>

                    <div class="update-time">
                        Son Güncelleme: <xsl:value-of select="substring(lastupdate/@value, 1, 10)"/> <xsl:value-of select="substring(lastupdate/@value, 12, 5)"/>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>