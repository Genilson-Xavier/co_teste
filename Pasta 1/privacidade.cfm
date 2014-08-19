
<cfparam name="url.uuid" type="string" default="" >
<cfparam name="url.tracker" type="string" default="" >
<cfparam name="url.email" type="string" default="" >
<cfparam name="url.attempt" type="numeric" default="0" >
<cfsilent />
<cfset oLayout=createobject("component","mxmclinic.public.layout")>
<cfset pageSettings=oLayout.getPageSettings()>
<cfset aSocialNetworks=oLayout.getSocialNetworks()>
<cfset writeoutput(oLayout.getHeader(title='Pol�tica de Privacidade - Cl�nica Online', keywords="pol�tica de privacidade, clinica online gr�tis, consult�rio gr�tis", description="Pol�tica de Privacidade", omitHeader=true, omitLogin=true))>

	<div id="top-image" class="top-image1">
		<div class="container">
			<div id="top-image-caption">
				<h2>POLITICA DE PRIVACIDADE</h2>
			</div>
		</div>
	</div>

	<div class="main-content">
		<div class="title-center">
			<h1>Pol�tica de Privacidade</h1>
			<p>(�ltima Atualiza��o 14/06/2012 15:00)</p>
		</div>
		<div class="container">
			<div style="width:99%; height:500px; overflow-y:auto; border:1px solid #ccc; padding:5px;">
				<strong>POL�TICA DE PRIVACIDADE DA PLATAFORMA clinicaonline</strong>
				<br/><br/>
				A Matias e Martins Desenvolvimento de Softwares LTDA. (�MXMSoftwares�) CNPJ 04.585.184/0001-50 respons�vel pela <strong>Plataforma clinicaonline</strong> leva a s�rio a sua privacidade. Por favor, leia as informa��es a seguir e saiba mais sobre nossa pol�tica de privacidade.
				<br/><br/>
				Quando voc� se cadastra, solicitamos informa��es tais como seu nome, endere�o de e-mail, data de nascimento, telefone para contato, sexo, CEP, dentre outras.  Ao se cadastrar na <strong>Plataforma clinicaonline</strong> e utilizar nossos servi�os, voc� deixa de ser an�nimo para n�s.
				<br/><br/>
				A MXMSoftwares usa essas informa��es para as seguintes finalidades gerais: personalizar o conte�do que voc� visualiza, atender suas solicita��es de produtos e servi�os, aprimorar os servi�os prestados, entrar em contato com voc�, orientar pesquisas e proporcionar relat�rios de informa��es n�o identific�veis para clientes internos e externos.
				<br/><br/>
				<strong>COMPARTILHAMENTO E DIVULGA��O DE INFORMA��ES</strong>
				<br/><br/>
				A MXMSoftwares n�o aluga, n�o vende e n�o compartilha as informa��es cadastradas na <strong>Plataforma clinicaonline</strong> sobre pacientes, m�dicos, cl�nicas e operadoras com outras pessoas ou empresas.
				<br/><br/>
				<strong>Generalidades</strong>
				<br/><br/>
				Voc� tem a possibilidade de editar, a qualquer momento, suas informa��es de cadastro na <strong>Plataforma clinicaonline</strong>.
				<br/><br/>
				Reservamo-nos o direito de enviar a voc� determinados comunicados referentes ao servi�o MXMSoftwares � tais como an�ncios sobre servi�os, mensagens administrativas e novidades sobre a <strong>Plataforma clinicaonline</strong>, que s�o considerados partes integrantes de seu cadastro.
				<br/><br/>
				<strong>CONFIDENCIALIDADE E SEGURAN�A</strong>
				<br/><br/>
				Limitamos o acesso �s informa��es pessoais que temos sobre voc� a nossos empregados que, conforme acreditamos, possam ter necessidade delas para exercer suas fun��es que visam fornecer a voc� nossos produtos e servi�os.
				Todos os dados informados ao nosso site s�o armazenados em um banco de dados reservado e com acesso restrito � pessoas habilitadas, que s�o obrigadas, por contrato, a manter a confidencialidade das informa��es e n�o utiliz�-las inadequadamente.
				Contamos com recursos de prote��o f�sica, eletr�nica e procedimental, que atendem a padr�es internacionais de prote��o a informa��es pessoais.
				<br/><br/>
				<strong>MUDAN�AS NESTA POL�TICA DE PRIVACIDADE</strong>
				<br/><br/>
				A MXMSoftwares pode atualizar esta pol�tica. Enviaremos aviso sobre mudan�as significativas introduzidas na forma como tratamos as informa��es de car�ter pessoal ao seu endere�o de e-mail, especificado em seu cadastro ou colocando o referido aviso em local destacado de nosso site.
			</div>
		</div>
	</div>
<cfset writeoutput(oLayout.getFooter())>
<!--- Write for Rewrite from /login --->