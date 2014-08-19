<!--- Genilson Teste --->

<cfset oLayout=createobject("component","mxmclinic.public.layout")>
<cfset oUserLayout=createobject("component","usuario.userlayout")>
<cfset isUserLogon=structKeyExists(cookie,'userID')>
<cfif isUserLogon>
	<cflocation url="/usuario" >
</cfif>
<cfset writeoutput(oLayout.getHeader(title='Acessar - Usuário - Clínica Online', keywords="portal de saúde, profissionais de saúde, médicos, pacientes, prontuário online", description="Veja suas informações e seu perfil!", omitHeader=true, omitLogin=true, userNavBar=isUserLogon))>
<cfsavecontent variable="sHTML">
<div class="page-element">
	<div class="container element-container standard-element">
		<cfif structKeyExists(url,'fail')>
			<div class="row">
				<div class="col-md-offset-4 col-md-4">
					<cfif url.fail eq 0>
						<div class="message-box warning-message-box clearfix">
							<div class="message-icon-box">
								<i class="fa fa-exclamation"></i>
							</div>
							
							<div class="message-container">
								<p>Não conseguimos completar o seu acesso.</p>
								<p>Confira seu e-mail e senha e tente novamente.</p>
								<p><a href="window.location='/usuario/recovery'">Esqueceu a sua senha? Clique aqui.</a></p>
							</div>
						</div>
					<cfelseif listfind('1,2,3',url.fail)>
						<div class="message-box info-message-box clearfix">
                            <div class="message-icon-box">
                                <i class="fa fa-info"></i>
                            </div>

                            <div class="message-container">
                                <p>Sua sessão expirou, por favor, efetue o acesso novamente.
                                </p>
                            </div>
                         </div>
					</cfif>
				</div>
			</div>
		</cfif>
	
		<!--- Login --->
		<div class="title-center">
			<h3><i class="li_key"></i> Acessar</h3>
			<p>Acesse com o seu e-mail e senha cadastrado no Portal Clínica Online</p>
			<p>Você também pode acessar através da sua conta do Facebook ou Google</p>
		</div>
		<cfset writeoutput(oLayout.getLogin())>
		
	</div>
</div>
	</cfsavecontent>
<cfset writeoutput(oUserLayout.render(html=sHTML,fullWidth=true))>
<cfset writeoutput(oLayout.getFooter())>