<cfset oLayout=createobject("component","mxmclinic.public.layout")>
<cfset oUserLayout=createobject("component","usuario.userlayout")>
<cfset isUserLogon=structKeyExists(cookie,'userID')>
<cfif !isUserLogon>
	<cflocation url="/usuario/login" >
</cfif>
<cfset writeoutput(oLayout.getHeader(title='Perfil - Usuário - Clínica Online', keywords="portal de saúde, profissionais de saúde, médicos, pacientes, prontuário online", description="Veja suas informações e seu perfil!", omitHeader=true, omitLogin=true, userNavBar=isUserLogon))>
	<cfset qHistoricoPesoAltura=application.oModelAtendimento.getPesoAlturaHistorico(userID=cookie.userID)>
	<cfset pesoDefault="50">
	<cfset alturaDefault="1.67">
	<cfif qHistoricoPesoAltura.recordcount>
		<cfset pesoDefault=qHistoricoPesoAltura.peso>
		<cfset alturaDefault=qHistoricoPesoAltura.altura>
	</cfif>
	<cfquery name="qGetClinicas" datasource="#request.system.dataSource#" >
		select no_pessoa as nomeClinica, no_fantasia as nomeFantasia from paciente
		inner join empresa
		on paciente.cod_empr = empresa.cod_empr
		inner join pessoa
		on empresa.nrregistro_pes = pessoa.nrregistro_pes
		where paciente.nrregistro_pes = <cfset writeoutput(application.oSecurity.decrypt(cookie.codPessoa))>
	</cfquery>
	<cfset qAtendimentos=application.oModelProntuario.getAtendimentoPessoa({top:5,userID:cookie.userID})>
	<cfsavecontent variable="sHTML">
		<div class="title-center">
			<h3>PERFIL</h3>
			<div class="status alert col-md-offset-5 col-md-4 navbar-fixed-top hidden"></div>
		</div>
		<cfset pessoa=application.oViewPessoa.structPessoa(codPessoa=cookie.codPessoa)>
		<div class="row profile">
				<div class="col-md-11 col-md-offset-1">
					<!--BEGIN TABS-->
					<div class="tabbable tabbable-custom tabbable-full-width">
						<ul class="nav nav-tabs">
							<li class="active"><a href="#tab_1_1" data-toggle="tab">Sobre</a></li>
							<li class=""><a href="#tab_1_3" data-toggle="tab">Perfil</a></li>
							<!---<li><a href="#tab_1_4" data-toggle="tab">Saúde</a></li>
							<li><a href="#tab_1_6" data-toggle="tab">Ajuda</a></li>--->
						</ul>
						<div class="tab-content">
							<div class="tab-pane active" id="tab_1_1">
								<div class="row">
									<div class="col-md-3">
										<ul class="list-unstyled profile-nav">
											<li><img src='<cfset writeoutput(pessoa.foto.urlFoto)>' class="img-responsive">  
												<!--- <a href="#" class="profile-edit">editar</a>--->
											</li>
											<!---
											<li><a href="#">Mensagens <span>3</span></a></li>
											<li><a href="#">Amigos</a></li>
											<li><a href="#">Configurações</a></li>
											--->
										</ul>
									</div>
									<div class="col-md-9">
										<div class="row">
											<div class="col-md-8 profile-info">
												<h1> <i class="fa fa-user" <cfif pessoa.sexo eq "M">style="color:#169ef4"<cfelseif pessoa.sexo eq "F">style="color:#F416C8"</cfif>></i> <cfset writeoutput(pessoa.nome)></h1>
												<!---<p>"Teste"</p>
												<p><a href="#">www.mywebsite.com</a></p>--->
												<ul class="list-inline">
													<cfif len(pessoa.endereco[1].cidade)>
														<li><i class="fa fa-map-marker"></i> <cfset writeoutput(pessoa.endereco[1].cidade)></li>
													</cfif>
													<cfif len(pessoa.dataNascimento)>
														<li><i class="fa fa-calendar"></i> <cfset writeoutput(lsdateformat(pessoa.dataNascimento,'dd mmm yy'))></li>
													</cfif>
												</ul>
												
												<div class="col-md-12 text-center">
														<div style="background-image:url(<cfset writeoutput(request.system.urlunsafe)>mxmclinic/assets/themes/default/images/corpo-atendimento.png); width:293px; height:402px; margin:0 auto; background-repeat: no-repeat; background-position-x: 60px; margin-bottom:50px;" >
															
															<div class="pesoDisplay" style="position: absolute;width: 100%;top: 372px;left: 91px;"><cfset writeoutput(qHistoricoPesoAltura.peso)> kg</div>
															<div class="alturaDisplay" style="position: absolute;width: 80px;top: 24px;left: 60px;height: 100px;"><cfset writeoutput(qHistoricoPesoAltura.altura)> m</div>
															
															<div style="width:150px; position:absolute; margin-top: 150px; margin-left: 65px; height:55px; text-align:center;">
																<div class="calculoIMC-Mensagem">IMC não calculado</div>
																<div class="calculoIMC"></div>
																<div class="slideIMC sliderColor" style="width:158px;position:absolute"></div>
															</div>
															<div class="posSlidePeso" style="position: absolute;width: 60%;top: 393px;left: 80px;">
																<div class="slidePeso sliderColor"></div>
															</div>
															<div class="posSlideAltura" style="position: absolute;width: 20px;top: 24px;left: 60px;height: 100px;">
																<div class="slideAltura sliderColor" style="height: 200px;"></div>
															</div>
														</div>
												</div>
												
												<!---<div class="col-md-12">
													<h4> <span class="glyphicon glyphicon-globe"></span> Clínicas que podem ver seus dados</h4>
													
													<cfif qGetClinicas.recordcount>
														<cfoutput query="qGetClinicas">
															#qGetClinicas.nomeFantasia# (#qGetClinicas.nomeClinica#)<br/>
														</cfoutput>
													<cfelse>
														Atualmente nenhuma clínica visualiza suas informações.
													</cfif>
												</div>--->
											</div>
											<!--end col-md-8-->
											<div class="col-md-4">
												<div class="portlet sale-summary">

													<div class="portlet-title">
														<div class="caption"><i class="fa fa-arrow-down" style="font-size:12px"></i>Resumo</div>
														<div class="tools">
															<a class="reload" href="javascript:;"></a>
														</div>
													</div>
													
													
													<div class="portlet-body">
														<ul class="list-unstyled">
															<li>
																<span class="sale-info">Peso <i class="fa fa-img-up"></i></span> 
																<span class="sale-num pesoDisplay"><cfset writeoutput(qHistoricoPesoAltura.peso)> kg</span>
															</li>
															<li>
																<span class="sale-info">Altura <i class="fa fa-img-down"></i></span> 
																<span class="sale-num alturaDisplay"><cfset writeoutput(qHistoricoPesoAltura.altura)> m</span>
															</li>
															<li>
																<span class="sale-info">IMC</span> 
																<span class="sale-num calculoIMC"><cfset writeoutput(qHistoricoPesoAltura.imc)></span>
															</li>
															<li class="hidden btnUpdateMeasurement">
																<button type="button" class="btn btn-primary updateMeasurement">Salvar</button>
															</li>
														</ul>
													</div>
													
												</div>
											</div>
											<!--end col-md-4-->
										</div>
										<!--end row-->
										<div class="tabbable tabbable-custom tabbable-custom-profile">
											<ul class="nav nav-tabs">
												<li class="active"><a href="#tab_1_11" data-toggle="tab">Últimas Consultas</a></li>
											</ul>
											
											
											<!--- List last consults --->
											<div class="tab-content">
												<div class="tab-pane active" id="tab_1_11">
													<div class="portlet-body">
														<table class="table table-striped table-bordered table-advance table-hover">
															<thead>
																<tr>
																	<th><i class="fa fa-hospital"></i> Clínica</th>
																	<th><i class="fa fa-calendar"></i> Data</th>
																	<th class="hidden-xs"><i class="fa fa-question"></i> Queixa</th>
																	<th>Prontuário</th>
																</tr>
															</thead>
															<tbody>
																<cfif qAtendimentos.recordcount>
																	<cfoutput query="qAtendimentos">
																	<tr>
																		<td><cfif len(qAtendimentos.nomeClinica)>#qAtendimentos.nomeClinica#<cfelse>#qAtendimentos.razaoSocial#</cfif></td>
																		<td>#lsdateformat(qAtendimentos.dt_atend,'dd/mm/yyyy')#</td>
																		<td class="hidden-xs">#qAtendimentos.queixa_principal#</td>
																		<td><a class="btn default btn-xs red-stripe" href="">Não Disponibilizado</a></td>
																	</tr>
																	</cfoutput>
																<cfelse>
																	<tr>
																		<td colspan="4">Não constam atendimentos para você neste momento...</td>
																	</tr>
																</cfif>
															</tbody>
														</table>
													</div>
												</div>
												<!--tab-pane-->
											</div>
										</div>
									</div>
								</div>
							</div>
							<!--tab_1_2-->
							<div class="tab-pane" id="tab_1_3">
								<div class="row profile-account">
									<div class="col-md-3">
										<ul class="ver-inline-menu tabbable margin-bottom-10">
											<li class="active"><a data-toggle="tab" href="#tab_1-1"><i class="fa fa-edit"></i>Dados</a><span class="after"></span></li>
											<li><a data-toggle="tab" href="#tab_2-2"><i class="fa fa-map-marker"></i> Endereço</a></li>
											<li><a data-toggle="tab" href="#tab_3-3"><i class="fa fa-phone"></i> Contato</a></li>
											<!---<li><a data-toggle="tab" href="#tab_4-4"><i class="fa fa-picture-o"></i> Alterar Foto</a></li>--->
											<li><a data-toggle="tab" href="#tab_5-5"><i class="fa fa-lock"></i> Alterar Senha</a></li>
											<li><a data-toggle="tab" href="#tab_6-6"><i class="fa fa-eye"></i> Privacidade</a></li>
										</ul>
									</div>
									<div class="col-md-9">
										<div class="tab-content">
											<div id="tab_1-1" class="tab-pane active">
												<form role="form" name="pessoa" data-userID='<cfset writeoutput(pessoa.userID)>'>
													<div class="form-group">
														<label class="control-label">Nome Completo</label>
														<input type="text" name="nome" value="<cfset writeoutput(pessoa.nome)>" placeholder="" class="form-control">
													</div>
													<div class="form-group">
														<label class="control-label">E-Mail</label>
														<input type="text" name="email"  value="<cfset writeoutput(pessoa.email)>" placeholder="Seu e-mail de acesso" class="form-control">
													</div>
													<div class="form-group">
														<label class="control-label">CPF</label>
														<input type="text" name="cpfCnpj" value="<cfset writeoutput(pessoa.cpfCnpj)>" placeholder="Por exemplo: 123.456.789-10" class="form-control">
													</div>
													<div class="form-group">
														<label class="control-label">Data de Nascimento</label>
														<input type="text" name="dataNascimento" value="<cfset writeoutput(pessoa.dataNascimento)>" placeholder="Por exemplo: DD/MM/AAAA" class="form-control">
													</div>
													<div class="form-group">
														<label class="control-label">Sexo</label>
														<select class="form-control" name="sexo">
														  <option <cfif pessoa.sexo eq "">selected</cfif> value="">Selecione</option>
														  <option <cfif pessoa.sexo eq "M">selected</cfif> value="M">Masculino</option>
														  <option <cfif pessoa.sexo eq "F">selected</cfif> value="F">Feminino</option>
														</select>
													</div>
													<div class="margiv-top-10">
														<a href="javascript:void(0);" class="btn green updatePessoa">Atualizar</a>
													</div>
												</form>
											</div>
											<div id="tab_2-2" class="tab-pane">
												<table class="table table-striped table-bordered table-advance table-hover">
													<thead>
														<tr>
															<th><i class="fa fa-map-marker"></i> Endereço</th>
															<th></th>
														</tr>
													</thead>
													<tbody>
														<cfset nTotalEndereco=0>
														<cfloop array="#pessoa.endereco#" index="uEndereco">
															<cfif len(uEndereco.logradouro)>
																<cfset nTotalEndereco++>
																<tr>
																	<td class="highlight">
																		<div class="important"></div>
																		<cfset writeoutput(uEndereco.tipoLogradouro)> <cfset writeoutput(uEndereco.logradouro)>, <cfset writeoutput(uEndereco.numero)> <cfset writeoutput(uEndereco.complemento)> - <cfset writeoutput(application.oTexto.formataCep(uEndereco.cep))><br/>
																		<cfset writeoutput(uEndereco.bairro)> - <cfset writeoutput(uEndereco.cidade)> - <cfset writeoutput(uEndereco.uf)>
																	</td>
																	<td>
																		<a href="#" class="btn default btn-xs blue" alt="Editar"><i class="fa fa-edit"></i></a>
																		<a href="#" class="btn default btn-xs red" alt="Excluir"><i class="fa fa-trash-o"></i></a>
																	</td>
																</tr>
															</cfif>
														</cfloop>
														<cfif !nTotalEndereco>
															<tr>
																<td colspan="2">Você ainda não tem endereço cadastrado, cadastre agora mesmo!</td>
															</tr>
														</cfif>
													</tbody>
												</table>
												<!---
												<div class="margiv-top-10">
													<a href="#" class="btn green">Adicionar Endereço</a>
												</div>
												--->
											</div>
											<div id="tab_3-3" class="tab-pane">
												
												<table class="table table-striped table-bordered table-advance table-hover">
													<thead>
														<tr>
															<th><i class="fa fa-phone"></i> Contato</th>
															<th></th>
														</tr>
													</thead>
													<tbody>
														<cfset nTotalContato=0>
														<cfloop array="#pessoa.contato#" index="uContato">
															<cfif uContato.codContato>
																<cfset nTotalContato++>
																<tr>
																	<td class="highlight">
																		<div class="important"></div>
																		(<cfset writeoutput(uContato.ddd)>) <cfset writeoutput(uContato.numero)>
																	</td>
																	<td>
																		<a href="#" class="btn default btn-xs blue" alt="Editar"><i class="fa fa-edit"></i></a>
																		<a href="#" class="btn default btn-xs red" alt="Excluir"><i class="fa fa-trash-o"></i></a>
																	</td>
																</tr>
															</cfif>
														</cfloop>
														<cfif !nTotalContato>
															<tr>
																<td colspan="2">Você ainda não tem contato cadastrado, cadastre agora mesmo!</td>
															</tr>
														</cfif>
													</tbody>
												</table>
												
												<form role="form" action="#">
													<!---
													<div class="margiv-top-10">
														<a href="#" class="btn green">Adicionar Contato</a>
													</div>
													--->
												</form>
											</div>
											<div id="tab_4-4" class="tab-pane">
												<p>Para atualizar sua foto de perfil, você pode tirar uma foto através da Webcam ou fazer o envio da sua foto.</p>
												<form action="#" role="form">
													<div class="form-group">
														<div class="thumbnail" style="width: 310px;">
															<img src="http://www.placehold.it/310x170/EFEFEF/AAAAAA&amp;text=no+image" alt="">
														</div>
														<div class="margin-top-10 fileupload fileupload-new" data-provides="fileupload">
															<div class="input-group input-group-fixed">
																<span class="input-group-btn">
																<span class="uneditable-input">
																<i class="fa fa-file fileupload-exists"></i> 
																<span class="fileupload-preview"></span>
																</span>
																</span>
																<span class="btn default btn-file">
																<span class="fileupload-new"><i class="fa fa-paper-clip"></i> Enviar uma foto</span>
																<!---<span class="fileupload-exists"><i class="fa fa-undo"></i> Alterar</span>--->
																<input type="file" class="default">
																</span>
																<a href="#" class="btn red fileupload-exists" data-dismiss="fileupload"><i class="fa fa-trash-o"></i> Remover</a>
															</div>
														</div>
													</div>
													<div class="margin-top-10">
														<a href="#" class="btn green">Enviar</a>
													</div>
												</form>
											</div>
											<div id="tab_5-5" class="tab-pane">
												<form name="password">
													<div class="form-group">
														<label class="control-label">Senha Atual</label>
														<input type="password" name="senhaAtual" class="form-control">
													</div>
													<div class="form-group">
														<label class="control-label">Nova senha</label>
														<input type="password" name="senhaNova" class="form-control">
													</div>
													<div class="form-group">
														<label class="control-label">Confirme a Nova senha</label>
														<input type="password" name="senhaNovaConfirma" class="form-control">
													</div>
													<div class="margin-top-10">
														<a href="javascript:void(0)" class="btn green updatePassword">Alterar Senha</a>
													</div>
												</form>
											</div>
											<div id="tab_6-6" class="tab-pane">
												<form action="#" class="">
													<h4> <span class="glyphicon glyphicon-globe"></span> Clínicas onde fui atendido</h4>
													<table class="table table-bordered table-striped">
														<tbody>
														<cfif qGetClinicas.recordcount>
															<cfoutput query="qGetClinicas">
															<tr>
																<td>
																	#qGetClinicas.nomeFantasia#  (#qGetClinicas.nomeClinica#)
																</td>
																<td>
																	<!---<label class="uniform-inline">
																	<div class="radio"><span><input type="radio" name="optionsRadios1" value="option1" checked=""></span></div>
																	Sim
																	</label>
																	<label class="uniform-inline">
																	<div class="radio"><span class="checked"><input type="radio" name="optionsRadios1" value="option2"></span></div>
																	Não
																	</label>--->
																</td>
															</tr>
															</cfoutput>
														<cfelse>
															<tr>
																<td colspan="2">
																	Atualmente nenhuma clínica visualiza suas informações.
																</td>
															</tr>
														</cfif>
													</tbody></table>
													<!--end profile-settings-->
													<!---
													<div class="margin-top-10">
														<a href="#" class="btn green">Salvar Alterações</a>
														<a href="#" class="btn default">Cancelar</a>
													</div>
													--->
												</form>
											</div>
										</div>
									</div>
									<!--end col-md-9-->                                   
								</div>
							</div>
						</div>
					</div>
					<!--END TABS-->
				</div>
			</div>
		
	</cfsavecontent>
	<cfset writeoutput(oUserLayout.render(html=sHTML))>
<cfset writeoutput(oLayout.getFooter())>
<script type="text/javascript">
	jQuery(function(){
		jQuery("input[name=cpfCnpj]").setMask('999.999.999-99');
		jQuery("input[name=dataNascimento]").setMask('99/99/9999');
		validateFormPessoa();
		validateFormPassword();
		jQuery(".updatePessoa").on("click",function(){
			setUserData('<cfset writeoutput(cookie.userID)>');
		});
		jQuery(".updatePassword").on("click",function(){
			setPassword('<cfset writeoutput(cookie.userID)>');
		});
		jQuery(".updateMeasurement").on("click",function(){
			setUserMeasurement('<cfset writeoutput(cookie.userID)>',jQuery(".pesoDisplay").html().replace(' kg',''),jQuery(".alturaDisplay").html().replace(' m',''));
		});
		loadMeasurements();
	});
	
	function validateFormPessoa(){
			jQuery("form[name=pessoa]").validate({
		        rules: {
		            nome: {
		                minlength: 3,
		                maxlength: 128,
		                required: true
		            },
		            email: {
		                email:true,
						maxlength: 128,
		                required: true
		            },
					dataNascimento: {
						required: true,
						dateBR: true
					},
					cpfCnpj: {
		                required: true,
						cpf: 'valid'
		            },
					sexo: {
						required: true
					}
					
		        },
				messages: {
					nome: "Por favor, verifique o nome.",
					email: "Por favor, verifique o e-mail.",
					cpfCnpj: "Por favor, verifique o CPF.",
					dataNascimento: "Por favor, verifique a data de nascimento.",
					sexo: "Por favor, selecione uma opção para o campo sexo."
				},
		        highlight: function(element) {
		            jQuery(element).closest('.form-group').addClass('has-error');
		        },
		        unhighlight: function(element) {
		            jQuery(element).closest('.form-group').removeClass('has-error');
		        },
		        errorElement: 'span',
		        errorClass: 'help-block',
		        errorPlacement: function(error, element) {
		            if(element.parent('.input-group').length) {
		                error.insertAfter(element.parent());
		            } else {
		                error.insertAfter(element);
		            }
		        }
		    });
		}

	function validateFormPassword(){
			jQuery("form[name=password]").validate({
		        rules: {
		            senhaAtual: {

		                required: true
		            },
		            senhaNova: {
		                required: true
		            },
					senhaNovaConfirma: {
						required: true,
					}					
		        },
				messages: {
					senhaAtual: "Por favor, preencha a senha atual.",
					senhaNova: "Por favor, digite a sua nova senha.",
					senhaNovaConfirma: "Por favor, confirme sua nova senha."
				},
		        highlight: function(element) {
		            jQuery(element).closest('.form-group').addClass('has-error');
		        },
		        unhighlight: function(element) {
		            jQuery(element).closest('.form-group').removeClass('has-error');
		        },
		        errorElement: 'span',
		        errorClass: 'help-block',
		        errorPlacement: function(error, element) {
		            if(element.parent('.input-group').length) {
		                error.insertAfter(element.parent());
		            } else {
		                error.insertAfter(element);
		            }
		        }
		    });
		}
		
	function loadMeasurements(){
		jQuery( ".slideAltura" ).slider({
			orientation: "vertical",
			range: "min",
			min: 0.03,
			max: 2.50,
			value: <cfset writeoutput(alturaDefault)>,
			step: 0.01,
			slide: function( event, ui ) {
				jQuery( ".alturaDisplay" ).html( ui.value + ' m' );
				doCalculoIMC();
			},
			change: function(event, ui) {
				jQuery( ".alturaDisplay" ).html( ui.value + ' m' );
				jQuery(" .btnUpdateMeasurement ").removeClass("hidden");
				doCalculoIMC();
			}
			
		});

		jQuery( ".slidePeso" ).slider({
			//orientation: "vertical",
			range: "min",
			min: 0.300,
			max: 180.000,
			value: <cfset writeoutput(pesoDefault)>,
			step: 0.100,
			slide: function( event, ui ) {
				jQuery( ".pesoDisplay" ).html( ui.value + ' kg' );
				doCalculoIMC();
			},
			change: function(event, ui) {
				jQuery(" .btnUpdateMeasurement ").removeClass("hidden");
				doCalculoIMC();
			}
		});
		
		jQuery( ".slideIMC" ).slider({
			range: "min",
			min: 10,
			max: 58,
			value: 29,
			step: 1,
		});

	}
	
	function calcularIMC(peso,altura){
		var aResultado=new Array(1);
		aResultado[0]='';
		if (!altura && !peso) 
			aResultado[0] = 'Para o cálculo de IMC é necessário medir a Estatura e Peso do paciente';
		else if (!peso) 
			aResultado[0] = 'Para o cálculo de IMC é necessário medir o Peso do paciente';
		else if (!altura) 
			aResultado[0] = 'Para o cálculo de IMC é necessário medir a Estatura do pciente';
		else {
			fCalculo = (peso / (altura * altura));
			aResultado[1] = parseFloat(casasDecimais(fCalculo,2));
		}
		
		return aResultado;
	}
	
	function doCalculoIMC(){
		var fAltura=formatarParaFloat(jQuery(".alturaDisplay").html().replace(' m',''))
		,fPeso=formatarParaFloat(jQuery(".pesoDisplay").html().replace(' kg',''))
		,aResultado=calcularIMC(fPeso,fAltura)
		,sMensagem=''
		,sCor='';

		if(!aResultado[0].length){
			fResultado=aResultado[1];
			if (fResultado < 20) {
				sMensagem = "Abaixo do peso";
				sCor = "barAzulClaro";
			}else if (fResultado > 20 && fResultado < 24.99){ 
				sMensagem = "Peso normal";
				sCor = "barAzul";
			}else if(fResultado > 25 && fResultado < 29.99){
				sMensagem = "Excesso de peso";
				sCor = "barRoxo";
			}else if(fResultado > 30 && fResultado < 35){
				sMensagem = "Obesidade";
				sCor = "barAmarelo";
			}else if(fResultado > 35){
				sMensagem = "Super obesidade";
				sCor = "barVermelho";
			}	
		}else{
			sMensagem=aResultado[0];
			fResultado='';
		}
		
		jQuery(".calculoIMC-Mensagem").html(sMensagem);
		jQuery(".calculoIMC").html(fResultado);
		jQuery(".slideIMC .ui-slider-range").removeClass("barAzulClaro").removeClass("barAzul").removeClass("barRoxo").removeClass("barAmarelo").removeClass("barVermelho");
		jQuery(".slideIMC .ui-slider-range").addClass(sCor);
		jQuery(".slideIMC").slider("value",fResultado);
	}
	
	function formatarParaFloat(valor){
		if(valor.length && valor.length > 5)
			var valor=valor.replace(/\./g,"").replace(/\,/g,".");
		else
			var valor=valor.replace(/\,/g,".");
		return parseFloat(valor);
	}
	
	function limpaPontoVirgula(valor){
		if(valor.length)
			var valor=valor.replace(/\./g,"").replace(/\,/g,"");
		return valor;
	}
	
	function casasDecimais(num, dec) {
		var result = Math.round(num*Math.pow(10,dec))/Math.pow(10,dec);
		return result;
	}
</script>