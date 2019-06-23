<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <xsl:output method="xhtml"  indent="yes" omit-xml-declaration="yes" encoding="US-ASCII"/>
 
 <xsl:template match="*">
  <xsl:message select="'###: ',name()"/>
  <xsl:copy>
   <xsl:copy-of select="@*"/>
   <xsl:apply-templates/>
  </xsl:copy>
 </xsl:template>

 <xsl:template match="@*">
  <xsl:message select="'@@@: ',name(..),'/@',name()"/>
 </xsl:template>

 <xsl:template match="@diff">
  <xsl:attribute name="data-diff" select="."/>
 </xsl:template>

 <xsl:template match="head"/>
 
 <xsl:template match="div1">
  <section> 
    <xsl:if test="starts-with(@role,'appendix')">
     <xsl:attribute name="class" select="'appendix'"/>
    </xsl:if>
   <h2>
    <xsl:copy-of  select="@id"/>
    <xsl:apply-templates select="head/node()"/>
   </h2>
   <xsl:apply-templates/>
  </section>
 </xsl:template>

 <xsl:template match="inform-div1">
  <section class="appendix">
   <h2>
    <xsl:copy-of  select="@id"/>
    <xsl:apply-templates select="head/node()"/>
   </h2>
   <xsl:apply-templates/>
  </section>
 </xsl:template>
 
 <xsl:template match="div2">
  <section>
   <h3>
    <xsl:copy-of  select="@id"/>
    <xsl:apply-templates select="head/node()"/>
   </h3>
   <xsl:apply-templates/>
  </section>
 </xsl:template>

  <xsl:template match="div3">
  <section>
   <h4>
    <xsl:copy-of  select="@id"/>
    <xsl:apply-templates select="head/node()"/>
   </h4>
   <xsl:apply-templates/>
  </section>
  </xsl:template>
  
  <xsl:template match="div4">
  <section>
   <h5>
    <xsl:copy-of  select="@id"/>
    <xsl:apply-templates select="head/node()"/>
   </h5>
    <xsl:apply-templates/>
  </section>
  </xsl:template>

    <xsl:template match="div5">
  <section>
   <h6>
    <xsl:copy-of  select="@id"/>
    <xsl:apply-templates select="head/node()"/>
   </h6>
    <xsl:apply-templates/>
  </section>
  </xsl:template>

  <xsl:template match="bibref">[[<xsl:value-of select="@ref"/>]]</xsl:template>

  <xsl:template match="emph">
   <em>
    <xsl:copy-of  select="@id"/>
    <xsl:apply-templates/>
   </em>
  </xsl:template>

  <xsl:template match="ulist">
   <ul>
    <xsl:apply-templates/>
   </ul>
  </xsl:template>
  <xsl:template match="olist">
   <ol>
    <xsl:apply-templates/>
   </ol>
  </xsl:template>

  <xsl:template match="item">
   <li>
    <xsl:apply-templates/>
   </li>
  </xsl:template>

  <xsl:template match="glist">
   <dl>
    <xsl:apply-templates/>
   </dl>
  </xsl:template>

  <xsl:template match="gitem">
   <dt><xsl:apply-templates select="label/node()"/></dt>
   <dd><xsl:apply-templates select="def/node()"/></dd>
  </xsl:template>


    <xsl:template match="blist">
   <dl>
    <xsl:apply-templates/>
   </dl>
  </xsl:template>

  <xsl:template match="bibl">
   <dt id="{@id}">[<xsl:value-of select="@id"/>]</dt>
   <dd><xsl:apply-templates/></dd>
  </xsl:template>

   <xsl:template match="loc">
    <a href="{@href}">
     <xsl:apply-templates/>
    </a>
  </xsl:template>

  
  <xsl:template match="p">
   <xsl:for-each-group select="node()" group-adjacent="self::ulist or self::olist or self::glist">
    <xsl:choose>
     <xsl:when test="current-grouping-key()">
      <xsl:apply-templates select="current-group()"/>
     </xsl:when>
     <xsl:otherwise>
      <p>
        <xsl:apply-templates select="current-group()"/>
      </p>
     </xsl:otherwise>
    </xsl:choose>
   </xsl:for-each-group>
  </xsl:template>


  <xsl:template match="graphic">
   <ing src="{@source}" alt="{@alt}"/>
  </xsl:template>

  <xsl:template match="eg">
   <pre>
    <xsl:if test="@role">
<xsl:attribute name="class" select="@role" />
    </xsl:if>
    <xsl:apply-templates/>
   </pre>
  </xsl:template>

  <xsl:template match="phrase">
   <span>
   <xsl:apply-templates select="@*"/>
   <xsl:apply-templates/>
   </span>
  </xsl:template>

  <xsl:template match="table|thead|tbody|tr|td|th|sub|sup|div">
   <xsl:copy>
    <xsl:apply-templates select="@*"/>
    <xsl:apply-templates/>
   </xsl:copy>
  </xsl:template>
  <xsl:template match="@rowspan|@colspan|@border|@id">
   <xsl:copy-of select="."/>
  </xsl:template>

  <xsl:template match="@role">
   <xsl:attribute name="class" select="."/>
  </xsl:template>
  
  <xsl:template match="intref">
   <a class="intref" href="#{@ref}">
    <xsl:apply-templates/>
   </a>
  </xsl:template>
  
  <xsl:template match="specref">
   <a href="#{@ref}"/>
  </xsl:template>

  <xsl:template match="att">
   <code class="attribute">
    <xsl:apply-templates select="@*,node()"/>
   </code>
  </xsl:template>
  
  <xsl:template match="attval">
   <code class="attributevalue">
    <xsl:apply-templates select="@*,node()"/>
   </code>
  </xsl:template>
  
  <xsl:template match="el">
   <code class="element">
    <xsl:apply-templates select="@*,node()"/>
   </code>
  </xsl:template>

    <xsl:template match="code">
   <code>
    <xsl:apply-templates select="@*,node()"/>
   </code>
    </xsl:template>

    <xsl:template match="quote">
     <span>&#x201c;<xsl:apply-templates/>&#x201d;</span>
    </xsl:template>

    <xsl:template match="issue">
     <div class="issue">
     <xsl:apply-templates select="@id"/>
      <span class="head"><xsl:apply-templates select="head/node()"/></span>
      <xsl:apply-templates/>
     </div>
    </xsl:template>

    <xsl:template match="issue/resolution">
     <div class="resolution">
      <xsl:apply-templates/>
     </div>
    </xsl:template>

 <!-- coreref: link to mathml core -->
<xsl:template match="coreref[@type='no']">
   <span class="coreno">core&#x2716;</span>
</xsl:template>
<xsl:template match="coreref[@type='yes']">
   <span class="coreyes">core&#x2714;</span>
</xsl:template>
<xsl:template match="coreref[@ref]">
   <a class="coreyes" href="../mathml-core/#{@ref}">core&#x2714;</a>
</xsl:template>

<xsl:template match="kw">
 <code>
  <xsl:apply-templates select="@*,node()"/>
 </code>
</xsl:template>

<xsl:template match="var">
 <i class="var"><xsl:apply-templates/></i>
</xsl:template>

<xsl:template match="termref">
 <a class="termref" href="#{@def}"><xsl:apply-templates/></a>
</xsl:template>

<xsl:template match="symbolref">
 <a class="omsymbol" href="{@cd}#{@name}"><xsl:value-of select="@name"/></a>
</xsl:template>


</xsl:stylesheet>
