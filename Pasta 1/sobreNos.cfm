<!---Genilson Xavier --->

<cfparam name="url.uuid" type="string" default="" >
<cfparam name="url.tracker" type="string" default="" >
<cfparam name="url.email" type="string" default="" >
<cfparam name="url.attempt" type="numeric" default="0" >
<cfsilent />
<cfset oLayout=createobject("component","mxmclinic.public.layout")>
<cfset pageSettings=oLayout.getPageSettings()>
<cfset aSocialNetworks=oLayout.getSocialNetworks()>
<cfset writeoutput(oLayout.getHeader(title='Sobre N�s - Cl�nica Online', keywords="Celso de Oliveira, Edson Matias, Fl�vio Martis, Equipe, membros, desenvolvimento, comercial, clinica online gr�tis, consult�rio gr�tis", description="Edson Matias, Fl�vio Martins, Celso Oliveira...", omitHeader=true, omitLogin=true))>

<div class="main-content">
	<cfset writeoutput(oLayout.htmlSobreNos())>
</div>

<cfset writeoutput(oLayout.getFooter())>
<!--- Write for Rewrite from /login --->