
<!--# Shivshankar rajasekaran(19-01-2012)  :: Code change for foreignfederationoptin :: Starts-->
<html>
	<head>

		<meta name="layout" content="members" />
		<title><g:message code="fedreg.view.members.organization.show.title" /></title>



	</head>
	<body>
		<section>
			<h2><g:message code="fedreg.view.members.foreignfederation.show.heading"/></h2>

			<table>
				<tbody>
					<tr>
						<th><g:message code="label.name"/></th>
						<td>${fieldValue(bean: foreignFederation, field: "name")}</td>
					</tr>
					<tr>
						<th><g:message code="label.displayname" /></th>
						<td>${fieldValue(bean: foreignFederation, field: "displayName")}</td>
					</tr>
					<tr>
						<th><g:message code="label.description" /></th>
						<td>${fieldValue(bean: foreignFederation, field: "description")}</td>
					</tr>

					<tr>
						<th><g:message code="label.foreignfederationurl" /></th>
						<td><a href="${foreignFederation.websiteURL.uri}">${foreignFederation.websiteURL.uri}</a></td>
					</tr>
                                        <tr>
						<th><g:message code="label.metadataurl" /></th>
						<td><a href="${foreignFederation.metadataURL.uri}">${foreignFederation. metadataURL.uri}</a></td>
					</tr>
					<tr>
						<th><g:message code="label.status"/></th>
						<td>
							<g:if test="${foreignFederation.active}">
								<g:message code="label.active" />
							</g:if>
							<g:else>
								<g:message code="label.inactive" /> <div class="error"><g:message code="label.warningmetadata" /></div>
							</g:else>
						</td>
					</tr>
					<tr>
						<th><g:message code="label.archived"/></th>
						<td>
							<g:if test="${foreignFederation.archived}">
								<g:message code="label.yes" /> <div class="warning"><g:message code="label.warningmetadataarchived" /></div>
							</g:if>
							<g:else>
								<g:message code="label.no" />
							</g:else>
						</td>
					</tr>
				
					<tr>
						<th><g:message code="label.datecreated" /></th>
						<td>${fieldValue(bean: foreignFederation, field: "dateCreated")}</td>
					</tr>
				</tbody>
			</table>


		</section>
	</body>
</html>
<!--# Shivshankar rajasekaran(19-01-2012)  :: Code change for foreignfederationoptin :: Ends-->