<cfparam name="url.uuid" type="string" default="" >
<cfparam name="url.tracker" type="string" default="" >
<cfparam name="url.email" type="string" default="" >
<cfparam name="url.attempt" type="numeric" default="0" >
<cfsilent />
<cfset oLayout=createobject("component","mxmclinic.public.layout")>
<cfset pageSettings=oLayout.getPageSettings()>
<cfset aSocialNetworks=oLayout.getSocialNetworks()>
<cfset writeoutput(oLayout.getHeader(title='Saiba Mais - Cl�nica Online', keywords="Sem INSTALAR nada, acess�vel a qualquer tempo e em qualquer lugar, clinica online gr�tis, consult�rio gr�tis", description="Veja o que o sistema web Cl�nica Online pode oferecer a sua Cl�nica ou Consult�rio!", omitHeader=true, omitLogin=true))>

<cfset writeoutput(oLayout.htmlSaibaMais())>

<cfset writeoutput(oLayout.getFooter())>