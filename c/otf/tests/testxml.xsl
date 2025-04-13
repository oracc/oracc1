<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	       xmlns:g="http://oracc.org/ns/gdl/1.0"
	       xmlns:n="http://oracc.org/ns/norm/1.0"
	       xmlns:x="http://oracc.org/ns/xtf/1.0"
	       version="1.0"
	       exclude-result-prefixes="g x">

<xsl:template match="x:l">
  <xsl:choose>
    <xsl:when test="x:surro">
      <xsl:apply-templates select="x:surro"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:variable name="words" select=".//g:w|.//n:w"/>
      <xsl:apply-templates select="$words[1]"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="x:surro">
  <x:ns-wrapper g:attr="dummy">
    <x:surro>
      <xsl:apply-templates mode="copy-elements"/>
    </x:surro>
  </x:ns-wrapper>
</xsl:template>

<xsl:template match="g:w|n:w">
  <x:ns-wrapper g:attr="dummy">
    <xsl:copy>
      <xsl:call-template name="copy-attr"/>
      <xsl:apply-templates mode="copy-elements"/>
    </xsl:copy>
  </x:ns-wrapper>
</xsl:template>

<xsl:template match="text()"/>

<xsl:template match="*" mode="copy-elements">
  <xsl:copy>
    <xsl:call-template name="copy-attr"/>
    <xsl:apply-templates mode="copy-elements"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="text()" mode="copy-elements">
  <xsl:value-of select="."/>
</xsl:template>


<xsl:template name="copy-attr">
  <xsl:copy-of select="@form"/>
  <xsl:copy-of select="@type"/>
  <xsl:copy-of select="@g:break"/>
  <xsl:copy-of select="@g:breakStart"/>
  <xsl:copy-of select="@g:breakEnd"/>
  <xsl:copy-of select="@g:c"/>
  <xsl:copy-of select="@g:delim"/>
  <xsl:copy-of select="@g:em"/>
  <xsl:copy-of select="@g:hc"/>
  <xsl:copy-of select="@g:ho"/>
  <xsl:copy-of select="@g:logolang"/>
  <xsl:copy-of select="@g:o"/>
  <xsl:copy-of select="@g:pos"/>
  <xsl:copy-of select="@g:remarked"/>
  <xsl:copy-of select="@g:role"/>
  <xsl:if test="not(@g:status='ok')">
    <xsl:copy-of select="@g:status"/>
  </xsl:if>
  <xsl:copy-of select="@g:statusEnd"/>
  <xsl:copy-of select="@g:statusStart"/>
  <xsl:copy-of select="@g:surroEnd"/>
  <xsl:copy-of select="@g:surroStart"/>
  <xsl:copy-of select="@g:type"/>
  <xsl:copy-of select="@sexified"/>
  <xsl:copy-of select="@xml:lang"/>
</xsl:template>

</xsl:transform>
