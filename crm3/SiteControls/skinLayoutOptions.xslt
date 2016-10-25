<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">

	<xsl:param name="selectedSkin"/>
	<xsl:output method="html" indent="yes"/>

	<xsl:template match="xml">
		<xsl:apply-templates select="websiteConfigurationOptions/skinOptions"/>
	</xsl:template>

	<xsl:template match="websiteConfigurationOptions/skinOptions">
		<xsl:variable name="currentSkin">
			<xsl:choose>
				<xsl:when test="string-length($selectedSkin) = 0">
					<xsl:value-of select="/xml/websiteConfiguration/skin"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$selectedSkin"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="interiorSelected">
			<xsl:if test="string-length(/xml/websiteConfiguration/homepageUrl) > 0">
				<xsl:value-of select="' selected'"/>
			</xsl:if>
		</xsl:variable>

		<xsl:for-each select="skin">
			<xsl:if test="name = $currentSkin">
				<xsl:apply-templates select="wireframeOptions/wireframe"/>
			</xsl:if>
		</xsl:for-each>

		<a id="divInteriorPage" class="crm-site-builder-toggle{$interiorSelected}" data-interior="true">Interior Page</a>
	</xsl:template>

	<xsl:template match="wireframeOptions/wireframe">
		<xsl:variable name="selected">
			<xsl:if test="/xml/websiteConfiguration/wireframeConfiguration/@xsi:type = key and string-length(/xml/websiteConfiguration/homepageUrl) = 0">
				<xsl:value-of select="' selected'"/>
			</xsl:if>
		</xsl:variable>

		<a id="div{key}" class="crm-site-builder-toggle{$selected}" data-type="wireframe" data-key="{key}">
			<xsl:value-of select="label"/>
		</a>
	</xsl:template>
</xsl:stylesheet>