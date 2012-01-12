
<html>
	<head>

<!--		<meta name="layout" content="members" />-->
		<title><g:message code="fedreg.view.members.foreignfederation.list.title" /></title>
	</head>
	<body>
		<section>
			<h2><g:message code="fedreg.view.members.foreignfederation.list.heading" /></h2>

			<table class="sortable-table">
				<thead>
					<tr>

						<th>${message(code: 'label.foreignfederation')}</th>
						<th>${message(code: 'label.url')}</th>

					</tr>
				</thead>
				<tbody>
<!--				<g:each in="${foreignFederationList}" var="foreignFederation">
					<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
						<td>${fieldValue(bean: foreignFederation, field: "displayName")}</td>
						<td>${fieldValue(bean: foreignFederation, field: "url.uri")}</td>
					</tr>
				</g:each>-->
				</tbody>
			</table>

		</section>
	</body>
</html>
