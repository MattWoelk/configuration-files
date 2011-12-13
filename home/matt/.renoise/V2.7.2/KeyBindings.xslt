<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes" />

<!--
     Renoise - Keyboard Shortcuts XSL

       This file contains the XSLT for KeyBindings.xml.
       Together with the CSS file, the configuration data in the XML-file
       will be translated into a more comfortable list. It's just a matter
       of dropping KeyBindings.xml into your browser.

     Created by Bantai
     marvin@renoise.com

     Changelog

        Version: 18-07-2006
            Initial public version, shipped with Renoise 1.8.
            
            - Merged XSLT and CSS: now both transformation and formatting in one file
            - Changed .xsl to .xslt extension, to emphasize difference with .xml
            - Added Opera 9-exclusive page-breaks
            - Edited lay-out; resizing and zooming won't break design
            - Added contact information and version date


        Version: 06-06-2007
            - Fixed duplicate anchors. Anchors are now in the form "#Category[Topic]" 
              instead of "#Topic".
            - Removed sorting to keep the original, logical grouping of the xml file.

//-->
<xsl:variable name="XSLTversion">070606</xsl:variable>
<xsl:key name="Category-key" match="Category" use="Identifier"   />
<xsl:key name="Topic-key" match="KeyBinding" use="Topic"   />
<xsl:key name="Topic2-key" match="KeyBinding" use="concat(../../Identifier,'::',Topic)"   />
<!--
   Calls to this global variable are replaced with local variables. Opera 9 did not recognize this global variable.
   Probably a problem with resolving the path. This looks fishy: key('Category-key',Identifier)
//-->

<xsl:template match="/">


<html>
  <head>
    <title>
      Renoise - Keyboard Shortcuts
    </title>
    <style type="text/css">
        /* Renoise - Keyboard Shortcuts CSS */
        
        /* This section contains the formatting of the XSL Translated KeyBindings.xml */
        /* This stylesheet is divided into a screen and print media part.          */
        /* That means that the browser will choose and select the optimized        */
        /* lay-out for printing automatically.                                     */
        
        @media screen {
        
            body {
              font-family: Verdana, Arial, Helvetica, sans-serif;
              font-size: 100%;  
              background-color: #949283;
              margin: 0em;
              padding: 0em;  
            }
            
            h1 {
              margin-left: 1em;
              margin-top: 0em;
              padding-top: 1em;
              color: #993300;
              width: 20em;
            }
            
            h1:first-letter {
              padding-right: 2px;
              font-family: Garamond, Arial, Helvetica, sans-serif;
              font-style: italic;
              font-size: 2em;
            }
            
            h1 span {      
              color: #333333;      
              font-size: 0.7em;
            }  
            
            h2 {
              padding-top: 2px;
              color: #333333;
              border-top: 7px solid #4b4b4b;
              margin-top: 2em;  
              width: 28em;
            }
            
            h2:first-letter {
              padding-right: 3px;
              color: #aaaaa2;
              font-family: Garamond, Arial, Helvetica, sans-serif;
              font-style: italic;
              font-size: 2em;
            }

            h3 {
              font-size: 1em;
              background-color: #aaaaa2;
              color: #993300;
              margin-top: 2em;
              text-indent: 0.5em;
              padding: 0px;
              border-left: 2em solid #3a3a32;
              border-top: 2px solid #3a3a32;
              width: 35.3em;
            }
            
            h4 {
              border-top: 1px dashed #333333;
              border-bottom: 1px dashed #333333;
              font-weight: bold;
              font-size: 0.8em;
              color: #606060;
              margin: 0em;    
              margin-top: 1em;   
            }
            
            a {
              font-weight: bold;
              text-decoration: none;
              font-size: 1em;
              color: #9b300c; 
            }
            
            a:hover {
              background: #9b300c; 
              color: #dededb;
              }
            
            .c_Category {   
              background-color: transparent;
              border: none;
              color: black; 
            }
            
            .c_Topic {  
              background-color: transparent;
              margin-left: 50px;
              overflow: visible; 
              width: 40em;   
              padding-bottom: 0.5em;  
            }
            
            .c_Binding {
              padding-left: 0.75cm;
              line-height: 1.6em; 
              font-size: 0.8em;  
              width: 22em;
              color: black;  
            }
            
            .c_Key {
              line-height: 1.6em;
              font-size: 0.8em; 
              color: #9B300C;  
            }
            
            .c_CountTopics {
              font-size: 0.8em;
              color: #aaaaa2;
              margin:4mm;
              width: 15em;
            }
            
            .c_listTopics {
              position: relative;
              left: 10mm;
              font-size: 0.6em;
              margin:4mm;
              width: 10em;  
            }
            
            .c_TopLink {
              font-size: 0.8em;
              margin:4mm 4mm 1cm 4mm;
              width: 15em;  
            }
            
            #i_credits {
              font-size: 0.6em;
              color: #333333;               
              text-align: center;
            }
            
            #i_DropComment {  
              width: 30em;
              color: black;
              margin: 0em 0em 1em 1em;  
              padding: 1em;  
              background-color: #dadad2;
              border-left: 1px dashed #333333;
              border-right: 1px dashed #333333;  
              border-top: solid 14px #9b300c;
              border-bottom: solid 2px #333333;
            }
            
            #i_DropComment p {
              font-size: 0.8em;
              margin-bottom: 0em;
            }

            #i_main_content {
              width: 45em;
              background-color: #f7f7f3;
              margin-left:    0em;
              padding-left:   2em;
              margin-top:     0em;
              padding-top:    0em;
              padding-bottom: 2em;  
              border-right: 1px dashed #333333;
            }
            
            #i_selectCategories {      
              width: 15em;    
              margin: 0em 0em 1em 1em;  
              padding: 0.5em 1em 0.5em 1em;    
              background-color: #dadad2;
              border-left: 1px dashed #333333;  
              border-right: 1px dashed #333333;  
              border-bottom: solid 14px #9b300c;
              border-top: solid 2px #333333;
            }

            #i_selectCategories ul {  
              font-size: 0.8em; 
              line-height: 2em;    
            }
        
        } /* end media: screen */
        
        
        @media print {

            body {
              font-family: Helvetica, Arial, sans-serif;
              font-size: 100%;
              color:black;
              background: white;  
            }
            
            h1 { 
              /* Opera supports page-break */
              page-break-after: avoid;
              margin-top: 0em;
              color: black;
            }
            
            h1 span { 
              font-size: 0.7em;
            }
            
            h2 {
              page-break-after: avoid;
              padding-top: 2px;
              color: #333333;
              border-top: 5pt solid #4b4b4b;  
              width: 20cm;
            }
            
            h3 {
              font-size: 1em;
              color: black;
              margin-top: 2em;
              padding-left: 2pt;
              border-left: 20pt solid #3a3a32;
              border-top: 1pt solid #3a3a32;
              width: 12cm;
            }
            
            h4 {
              color: #333333;
              margin:1em;
            }
            
            .c_Category {  
              page-break-after: always; 
              background-color: transparent;
              border: none;
              color: black;
            }
            
            .c_Topic {   
              page-break-inside: avoid;
              background-color: transparent;
              border: none;
              margin-left: 10%;
              overflow: visible;
            }
            
            .c_Binding {  
              line-height: 1.4em;
              padding-left: 0.75cm;  
              font-size: 0.8em;  
              width: 20em;
              color: black;  
            }

            .c_Key {  
              line-height: 1.4em;
              font-size: 0.8em; 
              color: black;
            }
            
            .c_CountTopics {
              display: none;
            }
            
            .c_listTopics {
              display: none;
            }
            
            .c_TopLink {
              display: none;
            }
            
            #i_credits {
              display: none;
            }

            #i_DropComment {
              display: none;
            }
            
            #i_DropComment p {
              display: none;
            }
            
            #i_selectCategories {  
              display: none;
            }
        
        
        }  /* end media: print */
    </style>
  </head>
  <body>
    <div id="i_main_content">
       <h1>Renoise <span>Keyboard Shortcuts</span></h1>       
       <div id="i_DropComment">
         <h4>WHAT IS THIS DOCUMENT?</h4>
         <p>
            This document is actually the configuration file of your keyboard shortcuts in Renoise.
            Any changes you make in Renoise will be saved inside this file.
            An XSLT file then translates the configuration data into
            html code and puts it into a nice design, for a comfortable overview in your browser.
         </p>
   
         <h4>PRINTING</h4>
         <p>
            When you are going to print this file, an optimized design for paper media will be automatically selected. The 
            printed version is different from the current lay-out. To get an impression,
            activate <em>File &gt; Print Preview</em> in your browser. Depending on your browser and print 
            settings, the printed document takes approximately 20 pages.
         </p>
         <h4>QUESTIONS, PROBLEMS, SUGGESTIONS?</h4>
         <p>
           Do you have a question or a suggestion? Or does this page look wrong in your browser? Send me a screenshot and tell me in which browser the problem occurs.
           My e-mail address is: <a href="mailto:marvin@renoise.com?subject=Renoise%20Keyboard%20XSLT">marvin@renoise.com</a>
         </p>
        </div>
       <xsl:call-template name="selectCategories" />
       <xsl:call-template name="processIdentifiers" />
       <div id="i_credits">
          This page was succesfully tested in Mozilla Firefox 1.5+, Safari 1.3+, Opera 9 and Internet Explorer 6+.
          <br />
          XSLT and CSS written and designed by <a href="mailto:marvin@renoise.com?subject=Renoise%20Keyboard%20XSLT">Bantai</a> for Renoise.
          Version: <xsl:value-of select="$XSLTversion" />.
       </div>       
    </div>
    
  </body>
</html>
</xsl:template>

<xsl:template name="listTopics">
<div class="c_listTopics">
  <p>
   <xsl:for-each select="../KeyBindings/KeyBinding[generate-id(.)=generate-id(key('Topic2-key', concat(../../Identifier,'::',Topic)))]">
    <!-- <xsl:sort select="Topic" /> -->
       <a href="#{../../Identifier}[{Topic}]"><xsl:value-of select="Topic" /></a>
       <br />
   </xsl:for-each>
  </p>
</div>
</xsl:template>


<xsl:template name="selectCategories">

<div id="i_selectCategories">
  <!-- The following local variable is a copy of the global version. //-->
  <xsl:variable name="uniqueIdentifiers"  select="KeyboardBindings/Categories/Category[generate-id(.)=generate-id(key('Category-key',Identifier))]/Identifier" />

  <h4 id="top">CATEGORIES</h4>
   <ul>
     <xsl:for-each select="$uniqueIdentifiers">
     <!-- <xsl:sort select="." /> -->
     <li>
         <a href="#{current()}"><xsl:value-of select="current()" /></a>
     </li>
     </xsl:for-each>
   </ul>  
  
</div>
</xsl:template>



<xsl:template name="processIdentifiers">
<!--
  Process each distinct Identifier
//-->
        <!-- The following local variable is a copy of the global version. //-->
        <xsl:variable name="uniqueIdentifiers"  select="KeyboardBindings/Categories/Category[generate-id(.)=generate-id(key('Category-key',Identifier))]/Identifier" />

  <xsl:for-each select="$uniqueIdentifiers">
    <!--
      Sort by Identifier
     //-->
    <!-- <xsl:sort select="." /> -->

      <!-- 
        Output the Identifier into first row
      //-->
      <div class="c_Category">
        <h2 id='{.}'>
           <xsl:value-of select="." />
        </h2>
      
        <xsl:variable name="topics" select="../KeyBindings/KeyBinding[generate-id(.)=generate-id(key('Topic2-key', concat(../../Identifier,'::',Topic)))]" />
        <!-- alternative
           <xsl:variable name="topics" select="key('Topic2-key', concat(.,'::',../KeyBindings/KeyBinding/Topic))" />
           <xsl:variable name="topics" select="//Category[Identifier=current()]/KeyBindings/KeyBinding/Topic" />
        //-->
        
        <!--
          Get Count of Topics
        //-->
        <div class="c_CountTopics"><xsl:value-of select="count($topics)" /> Topics in this Category</div>

        <div>
          <xsl:call-template name="listTopics" />
        </div>
        <!--
          Get Topics (by the current Identifier)
        //-->
        <xsl:variable name="uniqueTopics"  select="../KeyBindings/KeyBinding[generate-id(.)=generate-id(key('Topic2-key', concat(../../Identifier,'::',Topic)))]" />
        
        <xsl:for-each select="$uniqueTopics">

           <!-- <xsl:sort select="." /> -->

           <div class="c_Topic">
              <h3 id="{../../Identifier}[{Topic}]"><xsl:value-of select="current()/Topic" /></h3>

              <xsl:variable name="bindings" select="key('Topic-key', current()/Topic)[Topic=current()/Topic]" />
              <xsl:variable name="uniqueBindings" select="key('Topic2-key', concat(../../Identifier,'::',current()/Topic))[Topic=current()/Topic]" />

                 <table>
                   <xsl:for-each select="$uniqueBindings">
                      <tr>
                        <td class="c_Binding">
                           <xsl:value-of select="Binding" />
                        </td>
                        <td class="c_Key">
                           <xsl:value-of select="Key" />
                        </td>
                     </tr>
                   </xsl:for-each>
                </table>
             </div>
        </xsl:for-each>
      </div>
      
      <div class="c_TopLink">                                
        <a href="#top">--Show Categories--</a>
      </div>
                                

  </xsl:for-each>

</xsl:template>

</xsl:stylesheet>
