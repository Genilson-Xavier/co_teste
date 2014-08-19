<!--- Genilson Teste --->

<cfparam name="url.profileType" default="" >
<cfif len(url.profileType)>
	<cfset cookie.perfilPortal=url.profileType>
</cfif>
<cfset oLayout=createobject("component","mxmclinic.public.layout")>
<cfset oUserLayout=createobject("component","usuario.userlayout")>
<cfset isUserLogon=structKeyExists(cookie,'userID')>
<cfif isUserLogon and structKeyExists(cookie,'perfilPortal') and !len(cookie.perfilPortal)>
	<cflocation url="/usuario/primeiroAcesso" >
</cfif>
<cfset writeoutput(oLayout.getHeader(title='Usuário - Clínica Online', keywords="portal de saúde, profissionais de saúde, médicos, pacientes, prontuário online", description="Cadastre-se e faça parte do maior portal para profissionais de saúde e pacientes!", omitHeader=true, omitLogin=true, userNavBar=isUserLogon))>
	<cfsavecontent variable="sHTML">
			<div class="posts">
		            <div class="post col-md-4">
		            	
							<div class="thumbnail post-media">
								<a href="/usuario/perfil?ref=dtq_portal"><img src='/layout/images/usuario/pesoaltura.png' alt="Calculo de IMC - Peso e Altura" /></a>
							</div>
							<div class="post-content">
			                    <div class="post-title">
			                        <h4><i class="fa fa-bar-chart-o post-title-icon"></i>Sua saúde!</h4>
			                    </div>
								
								<div class="post-info clearfix">
			                        <div class="post-date">
			                            <i class="fa fa-user"></i>
										<cfif isUserLogon>
			                            	<p><a href="/usuario/perfil?ref=portal">Acessar seu perfil</a></p>
										<cfelse>
											<p><a href="/cadastrar">Clique aqui e cadastre-se</a></p>
										</cfif>
			                        </div>
								</div>
								<div style="clear: both"></div>
		
		                    	<div class="post-excerpt">
									<p><span class="glyphicon glyphicon-arrow-right"></span>Saiba qual o peso ideal para sua altura</p>
									<cfif !isUserLogon>
			                    		<p><span class="glyphicon glyphicon-arrow-right"></span>Saiba qual o peso ideal para sua altura</p>
										<p><span class="glyphicon glyphicon-arrow-right"></span>Confirme suas consultas pela internet</p>
										<p><span class="glyphicon glyphicon-arrow-right"></span>Veja os seus atendimentos</p>
										<p style="margin-top:5px;"><cfset writeoutput(oLayout.getLoginSocial())></p>
									</cfif>
		                    	</div>
							</div>
						</div>
						<div class="post col-md-4">
		            	<cfif isUserLogon>
							<cfhttp method="POST" url="#request.system.urlunsafe#/rest/api/Appointment/UserAppointments">
								<cfhttpparam type="header" name="ExternalApplicationToken" value="#request.system.api.ExternalApplicationToken#">
								<cfhttpparam type="formfield" name="userID" value="#cookie.userID#">
								<cfhttpparam type="formfield" name="quantity" value="1">
							</cfhttp>
							
							<cfset uAppointments=deserializeJSON(cfhttp.filecontent)>
							
							<cfif structKeyExists(uAppointments,'rowcount') and uAppointments.rowcount>
								<div class="thumbnail post-media">
									<div id="map_canvas" style="width: 100%; height: 100%"></div>
			                	</div>
							<cfelse>
								<div class="thumbnail post-media">
									<img src='/layout/images/usuario/calendario.png' />
								</div>	
							</cfif>
			
			                <div class="post-content">
			                    <div class="post-title">
			                        <h4><i class="fa fa-calendar post-title-icon"></i>Próxima Consulta</h4>
			                    </div>
								<cfif structKeyExists(uAppointments,'rowcount') and uAppointments.rowcount>
			                    <div class="post-info clearfix">
			                        <div class="post-date">
			                            <i class="fa fa-calendar"></i>
			                            <p><cfset writeoutput(lsdateformat(uAppointments.data.dataHora[1],"dd/mm/yyyy"))></p>
			                        </div>
									
									<div class="post-date">
			                            <i class="fa fa-time"></i>
			                            <p><cfset writeoutput(lstimeformat(uAppointments.data.dataHora[1],"HH:mm"))></p>
			                        </div>
			
			                        <div class="post-category confirmAppointment">
			                        	<cfif uAppointments.data.stt_confirmacao[1]>
			                          		<i class="fa fa-check" style="color:green;"></i> Confirmado!
										<cfelse>
											<i class="fa fa-check "></i><a href="javascript:void(0)" onClick="setAppointmentConfirmed('<cfset writeoutput(cookie.userID)>','<cfset writeoutput(uAppointments.data.uuidEvent[1])>','<cfset writeoutput(uAppointments.data.dateStart[1])>')"> Confirmar</a>
										</cfif>
			                        </div>
			                    </div>
								
			
			                    <div style="clear: both"></div>
			
			                    <div class="post-excerpt">
			                    	<p>
			                    		<cfset writeoutput(uAppointments.data.nomeClinica[1])>
									</p>
									<p>
										<cfset writeoutput(uAppointments.data.endereco[1])>
									</p>
			                        <p>
			                            Fique atento e não se atrase, procure sempre chegar com 15 minutos de antecedência!
			                        </p>
			                    </div>
			
			                    <!---<div class="stylish-button">
			                        <a href="#">Ver Mais</a>
			                    </div>--->
								
								<cfset sEnderecoGoogle=uAppointments.data.endereco[1]>
				            	<cfset uMarker=structNew()>
								<cfset uMarker.id=1>
								<cfset uMarker.endereco=sEnderecoGoogle>
								<cfset uMarker.html='#sEnderecoGoogle#'>
								<cfset uMarker.title=uAppointments.data.nomeClinica[1]>
								<script type="text/javascript">
									i=0;
									aEnderecos=[];
									aEnderecos[i]=<cfset writeoutput(serializejson(uMarker))>;
									i++;
								</script>
								
								<cfelse>
									<div class="post-info clearfix">
										<i class="fa fa-calendar"></i>
										<p>Sem Agendamento!</p>								
									</div>
									
			                        <div style="clear: both"></div>
			
			                        <div class="post-excerpt">
			                        	<p>
			                        		Você não possuí nenhuma consulta agendada ainda.
										</p>
			                        </div>
									
								</cfif>
							</cfif>
			        	</div>
		            </div>
					
					<!--- Noticias - Yahoo! --->
					<cftry>
					<cfset rssUrl = "http://br.noticias.yahoo.com/rss/saude">
					<cffeed action="read" source="#rssUrl#" query="entries" properties="info">
					
		            <div class="post col-md-4">
		                
	                    <div class="thumbnail post-media">
							<img src='/layout/images/usuario/noticias.png' />
						</div>
		
		                <div class="post-content">
		                    <div class="post-title">
		                        <h4><i class="fa fa-file-text post-title-icon"></i>Notícias</h4>
		                    </div>
							
		                    <div class="post-excerpt">
		                    	<ul class="list-unstyled">
								<cfoutput query="entries" maxrows="4">
									<cfset dataPublicacao=DateConvert( "Local2UTC", entries.publisheddate )>
					    			<li><span class="glyphicon glyphicon-arrow-right"></span>
					    				<a href="#rsslink#" style="color:##000;">#title#</a> 
								    </li>
								</cfoutput>
								</ul>
		                    </div>

		                </div>
		            </div>
		            	<cfcatch type="any">
			            	<div></div>
		            	</cfcatch>
					</cftry>
					<!--- Bem Estar e Saúde - Uol --->
					<cfset rssUrl = "http://rss.uol.com.br/feed/saude.xml">
					<cffeed action="read" source="#rssUrl#" query="entries" properties="info">
					
		            <div class="post col-md-4">
		                <div class="thumbnail post-media">
							<img src='/layout/images/usuario/bemestar.png' />
						</div>
		
		                <div class="post-content">
		                    <div class="post-title">
		                        <h4><i class="fa fa-file-text post-title-icon"></i>Bem estar</h4>
		                    </div>
		                    <div class="post-excerpt">
		                    	<ul class="list-unstyled">
								<cfoutput query="entries" maxrows="5">
									<!---<cfset dataPublicacao=DateConvert( "Local2UTC", entries.publisheddate )>--->
					    			<li><span class="glyphicon glyphicon-arrow-right"></span>
					    				<a href="#rsslink#" style="color:##000;">#title#</a> 
										<!---<span style="font-size:9px;" target="_blank">(#lsdateformat(dataPublicacao,'dd/mm/yyyy')# #lstimeformat(dataPublicacao,'hh:mm')#)</span>--->
								    </li>
								</cfoutput>
								</ul>
		                    </div>

		                </div>
		            </div>

					<!--- Saúde - R7 --->
					<cfset rssUrl = "http://noticias.r7.com/saude/feed.xml">
					<cffeed action="read" source="#rssUrl#" query="entries" properties="info">
					
		            <div class="post col-md-4">
		                <div class="thumbnail post-media">
							<img src='/layout/images/usuario/saude.png' />
						</div>
		
		                <div class="post-content">
		                    <div class="post-title">
		                        <h4><i class="fa fa-file-text post-title-icon"></i>Saúde</h4>
		                    </div>
							
							
		                    <div class="post-excerpt">
		                    	<ul class="list-unstyled">
								<cfoutput query="entries" maxrows="4">
									<!---<cfset dataPublicacao=DateConvert( "Local2UTC", entries.publisheddate )>--->
					    			<li>
					    				<span class="glyphicon glyphicon-arrow-right"></span><a href="#rsslink#" style="color:##000;">#title#</a> 
										<!---<span style="font-size:9px;" target="_blank">(#lsdateformat(dataPublicacao,'dd/mm/yyyy')# #lstimeformat(dataPublicacao,'hh:mm')#)</span>--->
								    </li>
								</cfoutput>
								</ul>
		                    </div>
		                </div>
		            </div>
					<!---
		            <div class="post col-md-4">
		                <div class="post-media">
							<iframe height="220" src="//www.youtube.com/embed/zKFBLO9-jLc" frameborder="0" allowfullscreen></iframe>
		                </div>
		
		                <div class="post-content">
		                    <div class="post-title">
		                        <h4><i class="fa fa-film post-title-icon"></i>DICAS DE SAÚDE</h4>
		                    </div>
		
		                    <div class="post-excerpt">
		                        <p>
		                            Confira as principais dicas para você se cuidar nesse verão.
		                        </p>
		                    </div>
		
		                    <!---<div class="stylish-button">
		                        <a href="#">Ver Mais</a>
		                    </div>--->
		                </div>
		            </div>
					--->

		            <div class="post col-md-4">
		                
						<script async src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
						<!-- arrobaNewsPortal250x250 -->
						<ins class="adsbygoogle"
						     style="display:inline-block;width:250px;height:250px"
						     data-ad-client="ca-pub-4020635578844038"
						     data-ad-slot="9053814915"></ins>
						<script>
						(adsbygoogle = window.adsbygoogle || []).push({});
						</script>
		
		                <div class="post-content">
		                    
		                </div>
		            </div>
			    </div>

	</cfsavecontent>
	<cfset writeoutput(oUserLayout.render(html=sHTML))>
	
<cfset writeoutput(oLayout.getFooter())>
<script type="text/javascript" src="/layout/vendors/isotope/imagesloaded.pkgd.min.js"></script>
<script src="/layout/vendors/quote-rotator/js/jquery.quoterotator.min.js" type="text/javascript"></script>
<script type="text/javascript" src="/layout/vendors/inview/jquery.inview.js"></script>
<script type="text/javascript" src="/layout/vendors/magnific-popup/jquery.magnific-popup.min.js"></script>
<script type="text/javascript" src="https://maps.google.com/maps/api/js?sensor=true"></script>
<script src="/lib/js/busca.js"></script>
<script>
	jQuery(function(){
		initGMapsUsuario();
	})
</script>