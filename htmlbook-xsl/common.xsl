<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:exsl="http://exslt.org/common"
		xmlns:l="http://docbook.sourceforge.net/xmlns/l10n/1.0"
		xmlns:h="http://www.w3.org/1999/xhtml"
		xmlns="http://www.w3.org/1999/xhtml"
		extension-element-prefixes="exsl"
		exclude-result-prefixes="exsl h">
  <xsl:output method="xml"
              encoding="UTF-8"/>
  <xsl:preserve-space elements="*"/>

  <xsl:variable name="lowercase" select="'abcdefghijklmnopqrstuvwxyz'"/>
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>

  <!-- key for getting elements by id -->
  <xsl:key name="id" match="*" use="@id"/>

  <!-- Default Rule; when no other templates are specified, copy direct to output -->
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <!-- Stylesheet for utility templates common to other stylesheets -->

  <!-- Generate target @href value pointing to given node -->
  <!-- Borrowed and adapted from xhtml/html.xsl in docbook-xsl stylesheets -->
  <xsl:template name="href.target">
    <xsl:param name="context" select="."/>
    <xsl:param name="object" select="."/>
    <xsl:param name="source-link-node"/>
    <xsl:text>#</xsl:text>
    <xsl:call-template name="object.id">
      <xsl:with-param name="object" select="$object"/>
    </xsl:call-template>
  </xsl:template>

  <!-- Generate an id from a node -->
  <!-- Borrowed and adapted from common/common.xsl in the docbook-xsl stylesheets -->
  <xsl:template name="object.id">
    <xsl:param name="object" select="."/>
    <xsl:choose>
      <xsl:when test="$object/@id">
	<xsl:value-of select="$object/@id"/>
      </xsl:when>
      <xsl:when test="$object/@xml:id">
	<xsl:value-of select="$object/@xml:id"/>
      </xsl:when>
      <xsl:otherwise>
	<xsl:value-of select="generate-id($object)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Label handling -->
  <xsl:template match="h:div[contains(@data-type, part)]|h:section" mode="label.markup">
    <xsl:variable name="current-node" select="."/>
    <xsl:if test="$label.section.with.ancestors != 0">
      <xsl:for-each select="ancestor::h:section">
	<xsl:call-template name="get-label-from-data-type">
	  <xsl:with-param name="data-type" select="@data-type"/>
	</xsl:call-template>
	<xsl:apply-templates select="$current-node" mode="intralabel.punctuation"/>
      </xsl:for-each>
    </xsl:if>
    <xsl:call-template name="get-label-from-data-type">
      <xsl:with-param name="data-type" select="@data-type"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="h:table" mode="label.markup">
    <xsl:choose>
      <xsl:when test="$label.formal.with.ancestor != 0">
	<xsl:apply-templates select="ancestor::h:section[contains(@data-type, 'acknowledgments') or
				     contains(@data-type, 'afterword') or
				     contains(@data-type, 'appendix') or
				     contains(@data-type, 'bibliography') or
				     contains(@data-type, 'chapter') or
				     contains(@data-type, 'colophon') or
				     contains(@data-type, 'conclusion') or
				     contains(@data-type, 'copyright-page') or
				     contains(@data-type, 'dedication') or
				     contains(@data-type, 'foreword') or
				     contains(@data-type, 'glossary') or
				     contains(@data-type, 'halftitlepage') or
				     contains(@data-type, 'index') or
				     contains(@data-type, 'introduction') or
				     contains(@data-type, 'preface') or
				     contains(@data-type, 'titlepage') or
				     contains(@data-type, 'toc')][last()]" mode="label.markup"/>
	<xsl:apply-templates select="." mode="intralabel.punctuation"/>
	<xsl:number count="h:table" from="h:section[contains(@data-type, 'acknowledgments') or
					  contains(@data-type, 'afterword') or
					  contains(@data-type, 'appendix') or
					  contains(@data-type, 'bibliography') or
					  contains(@data-type, 'chapter') or
					  contains(@data-type, 'colophon') or
					  contains(@data-type, 'conclusion') or
					  contains(@data-type, 'copyright-page') or
					  contains(@data-type, 'dedication') or
					  contains(@data-type, 'foreword') or
					  contains(@data-type, 'glossary') or
					  contains(@data-type, 'halftitlepage') or
					  contains(@data-type, 'index') or
					  contains(@data-type, 'introduction') or
					  contains(@data-type, 'preface') or
					  contains(@data-type, 'titlepage') or
					  contains(@data-type, 'toc')]" level="any" format="1"/>
      </xsl:when>
      <xsl:otherwise>
	<xsl:number count="h:table" level="any" format="1"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="h:figure" mode="label.markup">
    <xsl:choose>
      <xsl:when test="$label.formal.with.ancestor != 0">
	<xsl:apply-templates select="ancestor::h:section[contains(@data-type, 'acknowledgments') or
				     contains(@data-type, 'afterword') or
				     contains(@data-type, 'appendix') or
				     contains(@data-type, 'bibliography') or
				     contains(@data-type, 'chapter') or
				     contains(@data-type, 'colophon') or
				     contains(@data-type, 'conclusion') or
				     contains(@data-type, 'copyright-page') or
				     contains(@data-type, 'dedication') or
				     contains(@data-type, 'foreword') or
				     contains(@data-type, 'glossary') or
				     contains(@data-type, 'halftitlepage') or
				     contains(@data-type, 'index') or
				     contains(@data-type, 'introduction') or
				     contains(@data-type, 'preface') or
				     contains(@data-type, 'titlepage') or
				     contains(@data-type, 'toc')][last()]" mode="label.markup"/>
	<xsl:apply-templates select="." mode="intralabel.punctuation"/>
	<xsl:number count="h:figure[not(contains(@data-type, 'cover'))]" from="h:section[contains(@data-type, 'acknowledgments') or
					   contains(@data-type, 'afterword') or
					   contains(@data-type, 'appendix') or
					   contains(@data-type, 'bibliography') or
					   contains(@data-type, 'chapter') or
					   contains(@data-type, 'colophon') or
					   contains(@data-type, 'conclusion') or
					   contains(@data-type, 'copyright-page') or
					   contains(@data-type, 'dedication') or
					   contains(@data-type, 'foreword') or
					   contains(@data-type, 'glossary') or
					   contains(@data-type, 'halftitlepage') or
					   contains(@data-type, 'index') or
					   contains(@data-type, 'introduction') or
					   contains(@data-type, 'preface') or
					   contains(@data-type, 'titlepage') or
					   contains(@data-type, 'toc')]" level="any" format="1"/>
      </xsl:when>
      <xsl:otherwise>
	<xsl:number count="h:figure[not(contains(@data-type, 'cover'))]" level="any" format="1"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="h:div[contains(@data-type, 'example')]" mode="label.markup">
    <xsl:choose>
      <xsl:when test="$label.formal.with.ancestor != 0">
	<xsl:apply-templates select="ancestor::h:section[contains(@data-type, 'acknowledgments') or
				     contains(@data-type, 'afterword') or
				     contains(@data-type, 'appendix') or
				     contains(@data-type, 'bibliography') or
				     contains(@data-type, 'chapter') or
				     contains(@data-type, 'colophon') or
				     contains(@data-type, 'conclusion') or
				     contains(@data-type, 'copyright-page') or
				     contains(@data-type, 'dedication') or
				     contains(@data-type, 'foreword') or
				     contains(@data-type, 'glossary') or
				     contains(@data-type, 'halftitlepage') or
				     contains(@data-type, 'index') or
				     contains(@data-type, 'introduction') or
				     contains(@data-type, 'preface') or
				     contains(@data-type, 'titlepage') or
				     contains(@data-type, 'toc')][last()]" mode="label.markup"/>
	<xsl:apply-templates select="." mode="intralabel.punctuation"/>
	<xsl:number count="h:div[contains(@data-type, 'example')]" from="h:section[contains(@data-type, 'acknowledgments') or
								     contains(@data-type, 'afterword') or
								     contains(@data-type, 'appendix') or
								     contains(@data-type, 'bibliography') or
								     contains(@data-type, 'chapter') or
								     contains(@data-type, 'colophon') or
								     contains(@data-type, 'conclusion') or
								     contains(@data-type, 'copyright-page') or
								     contains(@data-type, 'dedication') or
								     contains(@data-type, 'foreword') or
								     contains(@data-type, 'glossary') or
								     contains(@data-type, 'halftitlepage') or
								     contains(@data-type, 'index') or
								     contains(@data-type, 'introduction') or
								     contains(@data-type, 'preface') or
								     contains(@data-type, 'titlepage') or
								     contains(@data-type, 'toc')]" level="any" format="1"/>
      </xsl:when>
      <xsl:otherwise>
	<xsl:number count="h:div[contains(@data-type, 'example')]" level="any" format="1"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="*" mode="label.markup"/>

  <!-- Intralabel punctuation templates.
       NOTE: These templates are based on the element being labeled (i.e., the last number in the label
    -->
  
  <xsl:template match="*" mode="intralabel.punctuation">
    <xsl:text>.</xsl:text>
  </xsl:template>

  <xsl:template match="h:figure|h:table|h:div[@data-type='example']" mode="intralabel.punctuation">
    <xsl:text>-</xsl:text>
  </xsl:template>

  <!-- Template that pulls a value from a key/value list in an <xsl:param> that looks like this: 
       key1:value1
       key2:value2
    -->
  <xsl:template name="get-param-value-from-key">
    <xsl:param name="parameter"/>
    <xsl:param name="key"/>
    <xsl:variable name="entry-and-beyond-for-data-type">
      <!-- Gets the config line for numeration for the specified data-type...and everything beyond -->
      <xsl:value-of select="substring-after(normalize-space($parameter), concat($key, ':'))"/>
    </xsl:variable>
    <!-- Then we further narrow to the exact numeration format type -->
    <xsl:choose>
      <xsl:when test="contains($entry-and-beyond-for-data-type, ' ')">
	<xsl:value-of select="substring-before($entry-and-beyond-for-data-type, ' ')"/>
      </xsl:when>
      <xsl:otherwise>
	<xsl:value-of select="$entry-and-beyond-for-data-type"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="get-label-from-data-type">
    <xsl:param name="data-type"/>
    <xsl:param name="numeration-format"/>

    <!-- Calculate numeration format -->
    <xsl:variable name="calculated-numeration-format">
      <xsl:choose>
	<xsl:when test="$numeration-format != ''">
	  <xsl:value-of select="$numeration-format"/>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:call-template name="get-param-value-from-key">
	    <xsl:with-param name="parameter" select="$label.numeration.by.data-type"/>
	    <xsl:with-param name="key" select="$data-type"/>
	  </xsl:call-template>
	</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <!-- Now generate number using format -->
    <!-- ToDo: logic for section labeling with parent-element number in label (e.g., 1.8) -->
    <xsl:choose>
      <!-- I wish XSL allowed variables in @format attribute -->
      <xsl:when test="$calculated-numeration-format = '1'">
	<xsl:number count="*[@data-type = $data-type]" format="1"/>
      </xsl:when>
      <xsl:when test="$calculated-numeration-format = '01'">
	<xsl:number count="*[@data-type = $data-type]" format="01"/>
      </xsl:when>
      <xsl:when test="$calculated-numeration-format = 'a'">
	<xsl:number count="*[@data-type = $data-type]" format="a"/>
      </xsl:when>
      <xsl:when test="$calculated-numeration-format = 'A'">
	<xsl:number count="*[@data-type = $data-type]" format="A"/>
      </xsl:when>
      <xsl:when test="$calculated-numeration-format = 'i'">
	<xsl:number count="*[@data-type = $data-type]" format="i"/>
      </xsl:when>
      <xsl:when test="$calculated-numeration-format = 'I'">
	<xsl:number count="*[@data-type = $data-type]" format="I"/>
      </xsl:when>
      <xsl:when test="$calculated-numeration-format = 'none'"/>
      <xsl:otherwise>
	<!-- If $calculated-numeration-format doesn't match above values or is blank, no label can be generated -->
	<xsl:choose>
	  <xsl:when test="normalize-space($calculated-numeration-format) = ''">
	    <xsl:message>No label numeration format specified for <xsl:value-of select="$data-type"/>: skipping label</xsl:message>
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:message>Unable to generate label for <xsl:value-of select="$data-type"/> with numeration format <xsl:value-of select="$calculated-numeration-format"/>.</xsl:message>
	  </xsl:otherwise>
	</xsl:choose>
      </xsl:otherwise>
    </xsl:choose>    	
  </xsl:template>

  <!-- Logic for generating titles; default handling is to grab the first <h1>-<h6> content -->
  <xsl:template match="*" mode="title.markup">
    <xsl:choose>
      <xsl:when test="self::h:section[@data-type='index' and not(h:h1|h:h2|h:h3|h:h4|h:h5|h:h6)]">
	<xsl:call-template name="get-localization-value">
	  <xsl:with-param name="gentext-key" select="'index'"/>
	</xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
	<xsl:apply-templates select="(h:h1|h:h2|h:h3|h:h4|h:h5|h:h6)[1]//node()"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Get localization value for a language using localizations in $localizations -->
  <xsl:template name="get-localization-value">
    <xsl:param name="gentext-key"/>
    <xsl:param name="context"/>
    <!-- Find value within specific context, if specified -->
    <xsl:variable name="localizations-nodes" select="exsl:node-set($localizations)"/>
    <xsl:choose>
      <xsl:when test="$context != ''">
	<xsl:value-of select="$localizations-nodes//l:l10n/l:context[@name=$context]/l:template[@name = $gentext-key]/@text"/>
      </xsl:when>
      <xsl:otherwise>
	<xsl:value-of select="$localizations-nodes//l:l10n/l:gentext[@key = $gentext-key]/@text"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Get the "semantic" name for an HTML5 element (mirroring a DB element name, for mappings in the localizations),
       usually pulled from the @data-type value when the HTML5 element is not semantic enough -->
  <!-- Uses XPath contains() function instead of a straight = comparison, to try to be more flexible in case @data-type
       values are funky -->
  <xsl:template name="semantic-name">
    <xsl:param name="node" select="."/>
    <xsl:choose>
      <xsl:when test="$node[self::h:section and contains(@data-type, 'acknowledgments')]">acknowledgments</xsl:when>
      <xsl:when test="$node[self::h:section and contains(@data-type, 'afterword')]">appendix</xsl:when>
      <xsl:when test="$node[self::h:section and contains(@data-type, 'appendix')]">appendix</xsl:when>
      <xsl:when test="$node[self::h:section and contains(@data-type, 'bibliography')]">bibliography</xsl:when>
      <xsl:when test="$node[self::h:section and contains(@data-type, 'chapter')]">chapter</xsl:when>
      <xsl:when test="$node[self::h:section and contains(@data-type, 'colophon')]">colophon</xsl:when>
      <xsl:when test="$node[self::h:section and contains(@data-type, 'conclusion')]">appendix</xsl:when>
      <xsl:when test="$node[self::h:section and contains(@data-type, 'copyright-page')]">preface</xsl:when>
      <xsl:when test="$node[self::h:section and contains(@data-type, 'dedication')]">dedication</xsl:when>
      <xsl:when test="$node[self::h:section and contains(@data-type, 'foreword')]">preface</xsl:when>
      <xsl:when test="$node[self::h:section and contains(@data-type, 'glossary')]">glossary</xsl:when>
      <xsl:when test="$node[self::h:section and contains(@data-type, 'halftitlepage')]">preface</xsl:when>
      <xsl:when test="$node[self::h:section and contains(@data-type, 'index')]">index</xsl:when>
      <xsl:when test="$node[self::h:section and contains(@data-type, 'introduction')]">preface</xsl:when>
      <xsl:when test="$node[self::h:section and contains(@data-type, 'preface')]">preface</xsl:when>
      <xsl:when test="$node[self::h:section and contains(@data-type, 'titlepage')]">preface</xsl:when>
      <xsl:when test="$node[self::h:section and contains(@data-type, 'toc')]">toc</xsl:when>
      <xsl:when test="$node[self::h:section and contains(@data-type, 'sect1')]">sect1</xsl:when>
      <xsl:when test="$node[self::h:section and contains(@data-type, 'sect2')]">sect2</xsl:when>
      <xsl:when test="$node[self::h:section and contains(@data-type, 'sect3')]">sect3</xsl:when>
      <xsl:when test="$node[self::h:section and contains(@data-type, 'sect4')]">sect4</xsl:when>
      <xsl:when test="$node[self::h:section and contains(@data-type, 'sect5')]">sect5</xsl:when>
      <xsl:when test="$node[self::h:section]">section</xsl:when> <!-- for <section>, default to "section" -->
      <xsl:when test="$node[self::h:div and contains(@data-type, 'caution')]">caution</xsl:when>
      <xsl:when test="$node[self::h:div and contains(@data-type, 'equation')]">equation</xsl:when>
      <xsl:when test="$node[self::h:div and contains(@data-type, 'example')]">example</xsl:when>
      <xsl:when test="$node[self::h:div and contains(@data-type, 'footnote')]">footnote</xsl:when>
      <xsl:when test="$node[self::h:div and contains(@data-type, 'important')]">important</xsl:when>
      <xsl:when test="$node[self::h:div and contains(@data-type, 'note')]">note</xsl:when>
      <xsl:when test="$node[self::h:div and contains(@data-type, 'tip')]">tip</xsl:when>
      <xsl:when test="$node[self::h:div and contains(@data-type, 'part')]">part</xsl:when>
      <xsl:when test="$node[self::h:div and contains(@data-type, 'rearnote')]">footnote</xsl:when>
      <xsl:when test="$node[self::h:div and contains(@data-type, 'warning')]">warning</xsl:when>
      <xsl:when test="$node[self::h:div and @data-type]">
	<xsl:value-of select="$node/@data-type"/> <!-- for <div>, default to @data-type value -->
      </xsl:when>
      <xsl:otherwise>
	<!-- For all other elements besides <section> and <div>, just use the local-name -->
	<xsl:value-of select="local-name($node)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet> 
