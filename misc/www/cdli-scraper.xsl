<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		version="1.0">

<xsl:template match="/*/*/table">
  <xsl:copy-of select="."/>
</xsl:template>

</xsl:stylesheet>
