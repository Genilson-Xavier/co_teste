<cfquery name="qEstabelecimento" datasource="local">
	select top 100 * from grabber_cnes_links
</cfquery>
<cfset sTotal="">
<cfoutput query="qEstabelecimento">
	<cfset sTotal=sTotal&getConjunto(qEstabelecimento.codEstabelecimento)&"|">
</cfoutput>
<cfloop list="#sTotal#" index="sItem" delimiters="|">
	<cfset aItem=listtoarray(sItem,";")>
	<cfdump var="#aItem#">
</cfloop>
<cfflush interval="4096" />
<cffunction name="getConjunto" access="public" returntype="string" output="false">
	<cfargument name="codEstabelecimento" type="string">
	<cfhttp timeout="60" charset="iso-8859-1" url="http://cnes.datasus.gov.br/Mod_Conjunto.asp?VCo_Unidade=#codEstabelecimento#" />
	<cfset sContent=stripHtml(mid(ucase(CFHTTP.FileContent),6975,len(CFHTTP.FileContent)),'hr,tag,true;a,tag,true;input,tag,true;font,tag,true;b,tag,true;p,tag,true;table,tag,true;html,tag,true;')>	
	<cfset sContent.strippedtext = rereplaceNoCase(sContent.strippedtext, "<!--[^>]*-->", "", "all")>
	<cfset sContent.strippedtext = rereplaceNoCase(sContent.strippedtext, "<IMG[^>]*>", "", "all")>
	<cfset sContent.strippedtext = rereplaceNoCase(sContent.strippedtext, "<A[^>]*>", "", "all")>
	<cfset sContent.strippedtext = rereplaceNoCase(sContent.strippedtext, "<FONT[^>]*>", "", "all")>
	<cfset sContent.strippedtext = rereplaceNoCase(sContent.strippedtext, "<INPUT[^>]*>", "", "all")>
	<cfset sContent.strippedtext = rereplaceNoCase(sContent.strippedtext, "<TD[^>]*>", "<TD>", "all")>

	<cfset sContent.strippedtext = rereplaceNoCase(sContent.strippedtext, "<TD[^>]*>", "<COLUMN>", "all")>
	<cfset sContent.strippedtext = rereplaceNoCase(sContent.strippedtext, "</TD[^>]*>", "</COLUMN>", "all")>
	
	<cfset sContent.strippedtext = rereplaceNoCase(sContent.strippedtext, "<P[^>]*>", "", "all")>
	<cfset sContent.strippedtext = rereplaceNoCase(sContent.strippedtext, "<TABLE[^>]*>", "", "all")>
	<cfset sContent.strippedtext = rereplaceNoCase(sContent.strippedtext, "</HTML[^>]*>", "", "all")>
	<cfset sContent.strippedtext = rereplaceNoCase(sContent.strippedtext, "</BODY[^>]*>", "", "all")>
	<cfset sContent.strippedtext = rereplaceNoCase(sContent.strippedtext, "<TR[^>]*>", "<ROW>", "all")>
	<cfset sContent.strippedtext = rereplaceNoCase(sContent.strippedtext, "</tr>", "</ROW>", "all")>
	<cfset sContent.strippedtext = rereplaceNoCase(sContent.strippedtext, "<BR[^>]*>", "", "all")>
	<cfset sContent.strippedtext = replaceNoCase(sContent.strippedtext, "&NBSP;", " ", "all")>
	<cfset sContent.strippedtext = rereplaceNoCase(sContent.strippedtext, "<!--[^>]*>", "", "all")>
	<cfset sContent.strippedtext = rereplaceNoCase(sContent.strippedtext, "#chr(13)#|#chr(9)#|\n|\r", "", "all")>
	

	<cfset sContent.strippedtext = trim(sContent.strippedtext)>
	<cfset sContent.strippedtext = replaceNoCase(sContent.strippedtext, "#chr(32)#", "|", "all")>
	<cfset sContent.strippedtext = replaceNoCase(sContent.strippedtext, "<ROW>|||||<COLUMN>||||||||VEJA|ONDE|SE|LOCALIZA:|||||</COLUMN>|||||<COLUMN>|||||||||||||</COLUMN>|||||<COLUMN>||||||</COLUMN>|||</ROW>|||||||||</ROW>|||||||", "", "all")>
	<cfset sContent.strippedtext = replaceNoCase(sContent.strippedtext, "</COLUMN></COLUMN>", "</COLUMN>", "all")>
	<cfset sContent.strippedtext = replaceNoCase(sContent.strippedtext, "<ROW>||||<COLUMN>NATUREZA|DA|ORGANIZAÇÃO:</COLUMN>||||<COLUMN>DEPENDÊNCIA:</COLUMN>||</ROW>||", "", "all")>
	<cfset sContent.strippedtext = replaceNoCase(sContent.strippedtext, "<ROW>|||||<COLUMN>NOME:</COLUMN>|||||||||||||||||||<COLUMN>CNES:</COLUMN>|||||<COLUMN>CNPJ:</COLUMN>|||</ROW>", "", "all")>
	<cfset sContent.strippedtext = replaceNoCase(sContent.strippedtext, "<ROW>|||<COLUMN>LOGRADOURO:</COLUMN>|||<COLUMN>NÚMERO:</COLUMN>|||<COLUMN>TELEFONE:</COLUMN>|</ROW>", "", "all")>
	<cfset sContent.strippedtext = replaceNoCase(sContent.strippedtext, "<ROW>||||||<COLUMN>COMPLEMENTO:</COLUMN>|||<COLUMN>BAIRRO:</COLUMN>|||<COLUMN>CEP:</COLUMN>|||<COLUMN>MUNICÍPIO:</COLUMN>|||<COLUMN>UF:</COLUMN>||</ROW>", "", "all")>
	<cfset sContent.strippedtext = replaceNoCase(sContent.strippedtext, "<ROW>||||<COLUMN>TIPO|UNIDADE:</COLUMN>||||<COLUMN>SUB|TIPO|UNIDADE:</COLUMN>||||<COLUMN>ESFERA|ADMINISTRATIVA:</COLUMN>||||<COLUMN>GESTÃO:</COLUMN>||</ROW>", "", "all")>
	<cfset sContent.strippedtext = replaceNoCase(sContent.strippedtext, "<ROW>|||||<COLUMN>SUB-MÓDULOS:</COLUMN>|||</ROW>", "", "all")>
	<cfset sContent.strippedtext = replaceNoCase(sContent.strippedtext, "<ROW>||||<COLUMN>RAZÃO|SOCIAL:</COLUMN>||||<COLUMN>CPF:</COLUMN>||||<COLUMN>PERSONALIDADE:</COLUMN>", "", "all")>
	<cfset sContent.strippedtext = replaceNoCase(sContent.strippedtext, "-->", "", "all")>
	<cfset sContent.strippedtext = replaceNoCase(sContent.strippedtext, "|", " ", "all")>
	
	<cfset sContent.strippedtext = rereplaceNoCase(sContent.strippedtext, "</COLUMN>(.*?)</COLUMN>", "", "all")>
	<cfset sContent.strippedtext = rereplaceNoCase(sContent.strippedtext, "<COLUMN>", ";", "all")>
	<cfset sContent.strippedtext = rereplaceNoCase(sContent.strippedtext, "<ROW>", "", "all")>
	<cfset sContent.strippedtext = rereplaceNoCase(sContent.strippedtext, "</ROW[^>]*>", "", "all")>
	<cfset sContent.strippedtext = rereplaceNoCase(sContent.strippedtext, "</COLUMN[^>]*>", "", "all")>
	<cfreturn sContent.strippedtext>
</cffunction>
	
<cffunction name="stripHtml" displayname="Strip HTML" description="Strips out specified HTML tags." access="public" output="false" returntype="struct">

    <!--- ARGUMENTS --->
    <cfargument name="text" displayName="Text" type="string" hint="Text to strip out html tags from." required="true" />
    <cfargument name="tags" displayName="Tags" type="string" hint="Tags to be striped from the text.  Ex. '[string:tag name],[what to remove - {string:tag | string:content}],[is it a wrapping tag? {boolean}]'. Tags are delimited with semi-colons." required="true" />

    <!--- SET SOME LOCAL VARS --->
    <cfset var textbytes = "">
    <cfset var counter = 1>
    <cfset var delete = false>
    <cfset var temp = "">
    <cfset var tagtoberemoved = "">
    <cfset var whatgetsremoved = "">
    <cfset var wrappingtag = "">

    <!--- BUILD STRUCT --->
    <cfset var data = structNew()>
    <cfset data.success = true>
    <cfset data.message = "">
    <cfset data.orginaltext = ARGUMENTS.text>
    <cfset data.strippedtext = ARGUMENTS.text>

    <!--- CHECK IF ALL CONTENT SHOULD BE REMOVED --->
    <cfif ARGUMENTS.tags eq "all">
        <!--- REMOVE HTML TAGS --->
        <cfset data.strippedtext = rereplaceNoCase(ARGUMENTS.text, "<[^>]*>", "", "all")>
    <cfelse>
        <!--- LOOP OVER THE LIST OF TAGS TO BE REMOVED --->
        <cfloop list="#ARGUMENTS.tags#" index="VARIABLES.i" delimiters=";">
            <!--- SET ATTRIBUTES OF TAG TO BE DELETED --->
            <cfset tagtoberemoved = listFirst(VARIABLES.i, ",")>
            <cfset whatgetsremoved = listGetAt(VARIABLES.i, 2, ",")>
            <cfset wrappingtag = listLast(VARIABLES.i, ",")>

            <!--- IF REMOVING JUST THE TAG --->
            <cfif whatgetsremoved eq "tag">
                <!--- CHECK IF IT IS A WRAPPING TAG --->
                <cfif wrappingtag eq true>
                    <!--- REMOVE WRAPPING TAG, BUT NOT THE CONTENT --->
                    <cfset data.strippedtext = rereplaceNoCase(data.strippedtext, "<#tagtoberemoved#>", "", "all")>
                    <cfset data.strippedtext = rereplaceNoCase(data.strippedtext, "</#tagtoberemoved#>", "", "all")>
                <cfelse>
                    <!--- REMOVE CONTAINED TAG --->
                    <cfset data.strippedtext = rereplaceNoCase(data.strippedtext, "<#tagtoberemoved# />", "", "all")>
                </cfif>

            <!--- IF REMOVING TAG AND CONTENT --->
            <cfelseif whatgetsremoved eq "content">
                <!--- CHECK IF IT IS A WRAPPING TAG --->
                <cfif wrappingtag eq true>
                    <!--- REMOVE THE TAG AND CONTENT --->
                    <cfset data.strippedtext = rereplaceNoCase(data.strippedtext, "<#tagtoberemoved#>.*</#tagtoberemoved#>", "", "all")>
                <cfelse>
                    <!--- REMOVE CONTAINED TAG --->
                    <cfset data.strippedtext = rereplaceNoCase(data.strippedtext, "<#tagtoberemoved# />", "", "all")>
                </cfif>
            </cfif>
        </cfloop>
    </cfif>

    <!--- RETURN STRUCT --->
    <cfreturn data>

</cffunction>