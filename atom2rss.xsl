<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:atom="http://www.w3.org/2005/Atom"
    version="1.0"
    exclude-result-prefixes="atom">

    <xsl:template match="/">
        <xsl:apply-templates />
    </xsl:template>

    <xsl:template match="atom:feed">
        <rss version="2.0">
        <channel>
            <title><xsl:value-of select="atom:title"/></title>
            <link><xsl:value-of select="atom:link[@type='text/html']/@href"/></link>
            <description><xsl:value-of select="atom:title"/></description>
            <lastBuildDate><xsl:call-template name="format-date"><xsl:with-param name="date" select="atom:entry[1]/atom:updated/text()" /></xsl:call-template></lastBuildDate>
            <language>en-us</language>
            <xsl:apply-templates />
        </channel>
            </rss>
    </xsl:template>

    <xsl:template match="atom:entry">
        <item>
            <xsl:apply-templates />
        </item>
    </xsl:template>

    <xsl:template match="atom:entry/atom:title">
        <!-- backupify adds the Twitter user name and then a colon, remove that -->
        <title><xsl:value-of select="substring-after(text(), ': ')"/></title>
        <description><xsl:value-of select="substring-after(text(), ': ')"/></description>
    </xsl:template>

    <xsl:template match="atom:entry/atom:link">
        <link><xsl:value-of select="@href"/></link>
    </xsl:template>

    <xsl:template match="atom:entry/atom:id">
        <guid><xsl:value-of select="text()"/></guid>
    </xsl:template>
    
    <xsl:template match="atom:entry/atom:updated">
        <pubDate><xsl:call-template name="format-date"><xsl:with-param name="date" select="text()" /></xsl:call-template></pubDate>
    </xsl:template>
    
    <xsl:template match="text()">
    </xsl:template>
    
    <xsl:template name="format-date">
        <xsl:param name="date" />
        <!-- Turns ISO 8601 (e.g 2010-03-31 20:29:29 (+00:00)) dates 
              into the format used by RSS 2.0, e.g "Mon, 12 Sep 2005 18:37:00 GMT"
              Leaving out the day-of-the-week seems to work fine with WP
              The better way of doing this would be to use EXSLT date format extension, 
              but I wanted to keep this template as easy as possible -->
        <xsl:variable name="month" select="substring($date, 6, 2)" />
        
        <xsl:value-of select="substring($date, 9, 2)"/><xsl:text> </xsl:text><xsl:choose>
            <xsl:when test="$month='01'">Jan</xsl:when>
            <xsl:when test="$month='02'">Feb</xsl:when>
            <xsl:when test="$month='03'">Mar</xsl:when>
            <xsl:when test="$month='04'">Apr</xsl:when>
            <xsl:when test="$month='05'">May</xsl:when>
            <xsl:when test="$month='06'">Jun</xsl:when>
            <xsl:when test="$month='07'">Jul</xsl:when>
            <xsl:when test="$month='08'">Aug</xsl:when>
            <xsl:when test="$month='09'">Sep</xsl:when>
            <xsl:when test="$month='10'">Oct</xsl:when>
            <xsl:when test="$month='11'">Nov</xsl:when>
            <xsl:when test="$month='12'">Dec</xsl:when>
        </xsl:choose><xsl:text> </xsl:text>
        <xsl:value-of select="substring($date, 0, 5)"/><xsl:text> </xsl:text><xsl:value-of select="substring($date, 12, 8)"/> GMT</xsl:template>
    
</xsl:stylesheet>
