<!--
          Plugin developed for Summer of eResearch(SoeR) 2011-12,New Zealand
          Authors: ShivShankar Rajasekaran & Abhinav R.Chopra

          View Page for creating a foreign federation
-->

<%@ page contentType="text/html;charset=UTF-8" %>


<html>
	<head>

		<meta name="layout" content="members" />
		<title><g:message code="fedreg.view.members.foreignfederation.create.title" /></title>
	</head>
	<body>
		<section>
			<h2><g:message code="fedreg.view.members.foreignfederation.create.heading" /></h2>

			<g:render template="/templates/foreignFederation/create" plugin="foreignfederationoptin" model="[saveAction:'save', requiresContactDetails:false]"/>

		</section>
	</body>
</html>
