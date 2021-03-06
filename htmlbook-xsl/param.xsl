<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:l="http://docbook.sourceforge.net/xmlns/l10n/1.0"
		xmlns:h="http://www.w3.org/1999/xhtml"
		xmlns="http://www.w3.org/1999/xhtml"
		exclude-result-prefixes="h l">

  <!-- Stylesheet containing all htmlbook-xsl params, and their default values -->

  <xsl:output method="xml"
              encoding="UTF-8"/>
  <xsl:preserve-space elements="*"/>

  <xsl:param name="book-language">
    <xsl:choose>
      <xsl:when test="//h:html[@lang != '']|//h:body[@lang != '']">
	<xsl:value-of select="(//h:html[@lang != '']|//h:body[@lang != ''])[1]/@lang"/>
      </xsl:when>
      <xsl:otherwise>
	<xsl:text>en</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:param>

  <xsl:param name="localizations-dir" select="'localizations/'"/>

  <xsl:param name="localizations">
    <xsl:variable name="localizations-file">
      <xsl:value-of select="concat($localizations-dir, $book-language, '.xml')"/>
    </xsl:variable>
    <xsl:choose>
      <!-- If $localizations-file is valid, use it... -->
      <xsl:when test="document($localizations-file)//l:l10n">
	<xsl:copy-of select="document($localizations-file)"/>
      </xsl:when>
      <!-- Otherwise default to "en" (English) -->
      <xsl:otherwise>
	<xsl:copy-of select="document(concat($localizations-dir, 'en', '.xml'))"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:param>

  <!-- Titling and labeling params -->

  <!-- Separator to be used between label and title -->
  <xsl:param name="label.and.title.separator" select="'. '"/>

  <!-- Separator to be used between parts of a label -->
  <xsl:param name="intralabel.separator" select="'.'"/>

<!-- For any book division that you want to have numeration, specify the @data-type, followed by colon, 
     and then a valid @format value for <xsl:number/>. If there is no entry in this list, or "none" is specified, corresponding division
     will not get labeled -->
  <xsl:param name="label.numeration.by.data-type">
appendix:A
chapter:1
part:I
sect1:none
sect2:none
sect3:none
sect4:none
sect5:none
  </xsl:param>

  <!-- When labeling sections, also label their ancestors, e.g., 3.1, 3.2.1 -->
  <xsl:param name="label.section.with.ancestors" select="0"/>

  <!-- When labeling formal objects (figures, tables, examples), also label the chapter-level ancestor, e.g., 3-1 -->
  <xsl:param name="label.formal.with.ancestor" select="1"/>

  <!-- Index-specific params -->
  <xsl:param name="autogenerate-index" select="1"/>

  <xsl:param name="index.on.role" select="0"/>

  <xsl:param name="index.on.type" select="0"/>

  <xsl:param name="index.links.to.section" select="0"/>

  <xsl:param name="index.term.separator"/>

  <xsl:param name="index.number.separator"/>

  <xsl:param name="index.range.separator"/>

  <!-- Specify whether or not to overwrite any content in the index placeholder element -->
  <xsl:param name="index-placeholder-overwrite-contents" select="0"/>

  <!-- TOC-specific params -->
  <xsl:param name="autogenerate-toc" select="1"/>

  <!-- Specify whether or not to overwrite any content in the TOC placeholder element -->
  <xsl:param name="toc-placeholder-overwrite-contents" select="0"/>

  <!-- Specify whether or not to include book title in autogenerated TOC -->
  <xsl:param name="toc-include-title" select="0"/>

  <!-- Specify whether to include number labels in TOC entries -->
  <xsl:param name="toc-include-labels" select="0"/>

  <!-- Specify how many levels of sections to include in TOC. 
       A $toc.section.depth of 0 indicates only chapter-level headings and above to be included in TOC
       A $toc.section depth of 1 indicates only sect1-level headings and above to be included in TOC
       And so on...
    -->
  <xsl:param name="toc.section.depth" select="2"/>

  <!-- XREF-specific params -->
  <xsl:param name="autogenerate-xrefs" select="1"/>
  
  <!-- Specify whether or not to overwrite any content in XREF <a> elements when doing XREF gentext -->
  <xsl:param name="xref-placeholder-overwrite-contents" select="0"/>

  <!-- Specifies type of XREF to use for different kinds of sections -->
  <!-- Choices are:
       * xref-number-and-title
       * xref-number
       * xref
    -->
  <xsl:param name="xref.type.for.section.by.data-type">
appendix:xref-number
chapter:xref-number
part:xref-number
sect1:xref
sect2:xref
sect3:xref
sect4:xref
sect5:xref
  </xsl:param>

</xsl:stylesheet> 
