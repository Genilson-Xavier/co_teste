<cfparam name="url.uuid" type="string" default="" >
<cfparam name="url.tracker" type="string" default="" >
<cfparam name="url.email" type="string" default="" >
<cfparam name="url.attempt" type="numeric" default="0" >
<cfsilent />
<cfset oLayout=createobject("component","mxmclinic.public.layout")>
<cfset pageSettings=oLayout.getPageSettings()>
<cfset aSocialNetworks=oLayout.getSocialNetworks()>
<cfset writeoutput(oLayout.getHeader(title='Saiba Mais - Clínica Online', keywords="Sem INSTALAR nada, acessível a qualquer tempo e em qualquer lugar, clinica online grátis, consultório grátis", description="Veja o que o sistema web Clínica Online pode oferecer a sua Clínica ou Consultório!", omitHeader=true, omitLogin=true))>

<cfset writeoutput(oLayout.htmlSaibaMais())>

<cfset writeoutput(oLayout.getFooter())>