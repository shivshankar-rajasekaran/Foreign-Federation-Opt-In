<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
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

			<g:render template="/templates/foreignfederation/create" plugin="foreignfederationoptin" model="[saveAction:'save', requiresContactDetails:false]"/>

		</section>
	</body>
</html>
