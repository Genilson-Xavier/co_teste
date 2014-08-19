<cfparam name="url.uuid" type="string" default="" >
<cfparam name="url.tracker" type="string" default="" >
<cfparam name="url.email" type="string" default="" >
<cfparam name="url.attempt" type="numeric" default="0" >
<cftry>
	<cfparam name="url.e" type="boolean" default="true">
	<cfcatch type="any">
		<cfset url.e=true>
	</cfcatch>
</cftry>
<cfsilent />
<cfset oLayout=createobject("component","mxmclinic.public.layout")>
<cfset pageSettings=oLayout.getPageSettings()>
<cfset aSocialNetworks=oLayout.getSocialNetworks()>
<cfset writeoutput(oLayout.getHeader(title='Planos - Clínica Online', keywords="Sem INSTALAR nada, acessível a qualquer tempo e em qualquer lugar, clinica online grátis, consultório grátis", description="Diversos planos de acordo com necessidade da sua Clínica ou Consultório! Experimente!", omitHeader=true, omitLogin=true))>

<div class="main-content">
	<cfset writeoutput(oLayout.htmlPlanos(url=url))>
</div>

<cfset writeoutput(oLayout.getFooter())>
<!--- Write for Rewrite from /login --->

<!--- Testando Commit --->
