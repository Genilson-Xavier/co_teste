<cfparam name="url.uuid" type="string" default="" >
<cfparam name="url.tracker" type="string" default="" >
<cfparam name="url.email" type="string" default="" >
<cfparam name="url.attempt" type="numeric" default="0" >
<cfsilent />
<cfset oLayout=createobject("component","mxmclinic.public.layout")>
<cfset pageSettings=oLayout.getPageSettings()>
<cfset aSocialNetworks=oLayout.getSocialNetworks()>
<cfset writeoutput(oLayout.getHeader(title='Mídia - Clínica Online', keywords="Mídia, Folha, Estadão, Uol, Sem INSTALAR nada, acessível a qualquer tempo e em qualquer lugar, clinica online grátis, consultório grátis", description="Clínica Online na Mídia", omitHeader=true, omitLogin=true))>
<div class="main-content">
	<cfset writeoutput(oLayout.htmlMidia())>
</div>
<cfset writeoutput(oLayout.getFooter())>
<!--- Write for Rewrite from /login --->