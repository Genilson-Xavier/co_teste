<cfparam name="url.uuid" type="string" default="" >
<cfparam name="url.tracker" type="string" default="" >
<cfparam name="url.email" type="string" default="" >
<cfparam name="url.attempt" type="numeric" default="0" >
<cfsilent />
<cfset oLayout=createobject("component","mxmclinic.public.layout")>
<cfset pageSettings=oLayout.getPageSettings()>
<cfset aSocialNetworks=oLayout.getSocialNetworks()>
<cfset writeoutput(oLayout.getHeader(title='M�dia - Cl�nica Online', keywords="M�dia, Folha, Estad�o, Uol, Sem INSTALAR nada, acess�vel a qualquer tempo e em qualquer lugar, clinica online gr�tis, consult�rio gr�tis", description="Cl�nica Online na M�dia", omitHeader=true, omitLogin=true))>
<div class="main-content">
	<cfset writeoutput(oLayout.htmlMidia())>
</div>
<cfset writeoutput(oLayout.getFooter())>
<!--- Write for Rewrite from /login --->