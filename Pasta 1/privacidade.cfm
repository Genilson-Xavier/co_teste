
<cfparam name="url.uuid" type="string" default="" >
<cfparam name="url.tracker" type="string" default="" >
<cfparam name="url.email" type="string" default="" >
<cfparam name="url.attempt" type="numeric" default="0" >
<cfsilent />
<cfset oLayout=createobject("component","mxmclinic.public.layout")>
<cfset pageSettings=oLayout.getPageSettings()>
<cfset aSocialNetworks=oLayout.getSocialNetworks()>
<cfset writeoutput(oLayout.getHeader(title='Política de Privacidade - Clínica Online', keywords="política de privacidade, clinica online grátis, consultório grátis", description="Política de Privacidade", omitHeader=true, omitLogin=true))>

	<div id="top-image" class="top-image1">
		<div class="container">
			<div id="top-image-caption">
				<h2>POLITICA DE PRIVACIDADE</h2>
			</div>
		</div>
	</div>

	<div class="main-content">
		<div class="title-center">
			<h1>Política de Privacidade</h1>
			<p>(Última Atualização 14/06/2012 15:00)</p>
		</div>
		<div class="container">
			<div style="width:99%; height:500px; overflow-y:auto; border:1px solid #ccc; padding:5px;">
				<strong>POLÍTICA DE PRIVACIDADE DA PLATAFORMA clinicaonline</strong>
				<br/><br/>
				A Matias e Martins Desenvolvimento de Softwares LTDA. (“MXMSoftwares”) CNPJ 04.585.184/0001-50 responsável pela <strong>Plataforma clinicaonline</strong> leva a sério a sua privacidade. Por favor, leia as informações a seguir e saiba mais sobre nossa política de privacidade.
				<br/><br/>
				Quando você se cadastra, solicitamos informações tais como seu nome, endereço de e-mail, data de nascimento, telefone para contato, sexo, CEP, dentre outras.  Ao se cadastrar na <strong>Plataforma clinicaonline</strong> e utilizar nossos serviços, você deixa de ser anônimo para nós.
				<br/><br/>
				A MXMSoftwares usa essas informações para as seguintes finalidades gerais: personalizar o conteúdo que você visualiza, atender suas solicitações de produtos e serviços, aprimorar os serviços prestados, entrar em contato com você, orientar pesquisas e proporcionar relatórios de informações não identificáveis para clientes internos e externos.
				<br/><br/>
				<strong>COMPARTILHAMENTO E DIVULGAÇÃO DE INFORMAÇÕES</strong>
				<br/><br/>
				A MXMSoftwares não aluga, não vende e não compartilha as informações cadastradas na <strong>Plataforma clinicaonline</strong> sobre pacientes, médicos, clínicas e operadoras com outras pessoas ou empresas.
				<br/><br/>
				<strong>Generalidades</strong>
				<br/><br/>
				Você tem a possibilidade de editar, a qualquer momento, suas informações de cadastro na <strong>Plataforma clinicaonline</strong>.
				<br/><br/>
				Reservamo-nos o direito de enviar a você determinados comunicados referentes ao serviço MXMSoftwares – tais como anúncios sobre serviços, mensagens administrativas e novidades sobre a <strong>Plataforma clinicaonline</strong>, que são considerados partes integrantes de seu cadastro.
				<br/><br/>
				<strong>CONFIDENCIALIDADE E SEGURANÇA</strong>
				<br/><br/>
				Limitamos o acesso às informações pessoais que temos sobre você a nossos empregados que, conforme acreditamos, possam ter necessidade delas para exercer suas funções que visam fornecer a você nossos produtos e serviços.
				Todos os dados informados ao nosso site são armazenados em um banco de dados reservado e com acesso restrito à pessoas habilitadas, que são obrigadas, por contrato, a manter a confidencialidade das informações e não utilizá-las inadequadamente.
				Contamos com recursos de proteção física, eletrônica e procedimental, que atendem a padrões internacionais de proteção a informações pessoais.
				<br/><br/>
				<strong>MUDANÇAS NESTA POLÍTICA DE PRIVACIDADE</strong>
				<br/><br/>
				A MXMSoftwares pode atualizar esta política. Enviaremos aviso sobre mudanças significativas introduzidas na forma como tratamos as informações de caráter pessoal ao seu endereço de e-mail, especificado em seu cadastro ou colocando o referido aviso em local destacado de nosso site.
			</div>
		</div>
	</div>
<cfset writeoutput(oLayout.getFooter())>
<!--- Write for Rewrite from /login --->