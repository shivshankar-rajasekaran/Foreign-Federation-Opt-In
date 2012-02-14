
<!--# Shivshankar rajasekaran(19-01-2012)  :: Code change for foreignfederationoptin :: Starts-->
<html>
	<head>

		<meta name="layout" content="members" />
		<title><g:message code="fedreg.view.members.organization.show.title" />
               
                </title>

                 <r:script>
                        var activeContact
                        var foreignMetadataEndpoint = "${createLink(controller:'foreignFederation', action:'metadata', id:foreignFederation.id )}";
                        var contactCreateEndpoint = "${createLink(controller:'foreignFederationContacts', action:'create', id:foreignFederation.id )}";
			var contactDeleteEndpoint = "${createLink(controller:'foreignFederationContacts', action:'delete' )}";
			var contactListEndpoint = "${createLink(controller:'foreignFederationContacts', action:'list', id:foreignFederation.id ) }";
			var contactSearchEndpoint = "${createLink(controller:'foreignFederationContacts', action:'search')}";


                 </r:script>

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
						<td><a href="${foreignFederation.metadataURL.uri}">${foreignFederation.metadataURL.uri}</a></td>
					</tr>
                                         <tr>
                                                <th><g:message code="label.foreignFederation.registrationInfo" /></th>
                                                <td><a href="${foreignFederation.registrationInfo.uri}">${foreignFederation.registrationInfo.uri}</a></td>
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
                                        <tr>
						
                                                </tr>
                                               
				</tbody>
			</table>
 	<div class="tabs">
				<ul>
					<li><a href="#tab-foreignFederation-statistics"><g:message code="label.optinstatistics" /></a></li>
					<li><a href="#tab-contacts"><g:message code="label.contacts" /></a></li>
                                        <li><a href="#tab-foreignFederation-metadata" ><g:message code="label.metadata" /></a></li>
					<li><a href="#tab-optedin"><g:message code="label.optedinentities" /></a></li>

					
                                </ul>
                         <div id="tab-foreignFederation-statistics">
					<h3><g:message code="label.optinstatistics" /></h3>
					<table>
						<thead>
							<tr>
								<th></th>
								<th><g:message code="label.total" /></th>
								<th><g:message code="label.approved" /></th>
								<th><g:message code="label.unapproved" /></th>
							</tr>
						</thead>
						<tbody>
                                                        <tr class="odd">
								<th><g:message code="label.entitydescriptors" /></th>
								<td>${statistics.optinEntityDescriptors.total.encodeAsHTML()}</td>
								<td>${statistics.optinEntityDescriptors.approvedOptinEntityDescriptors.encodeAsHTML()}</td>
								<td>${statistics.optinEntityDescriptors.unapprovedOptinEntityDescriptors.encodeAsHTML()}</td>
							</tr>
							<tr>
								<th><g:message code="label.identityproviders" /></th>
								<td>${statistics.optinIDPSSODescriptors.total.encodeAsHTML()}</td>
								<td>${statistics.optinIDPSSODescriptors.approvedOptinIDPSSODescriptors.encodeAsHTML()}</td>
								<td>${statistics.optinIDPSSODescriptors.unapprovedOptinIDPSSODescriptors.encodeAsHTML()}</td>
							</tr>
							<tr>
								<th><g:message code="label.serviceproviders" /></th>
								<td>${statistics.optinSPSSODescriptors.total.encodeAsHTML()}</td>
								<td>${statistics.optinSPSSODescriptors.approvedOptinSPSSODescriptors.encodeAsHTML()}</td>
								<td>${statistics.optinSPSSODescriptors.unapprovedOptinSPSSODescriptors.encodeAsHTML()}</td>
							</tr>
						</tbody>
					</table>

				</div>
                      <div id="tab-foreignFederation-metadata" >

					<h3><g:message code="label.metadata" /></h3>
					<p><g:message code="fedreg.view.members.foreignFederation.show.metadata.details" />
					<a href="#" onClick="fedreg.foreign_metadata(); nimble.growl('success', '${g.message(code:'label.metadatareload')}'); false;" style="float:right;" class="redo-button"><g:message code="label.reload" /></a>
					</p>
                                        <p><g:message code="fedreg.view.members.foreignFederation.show.metadata.configurationurl" /> <strong><g:link controller="foreignFederation" action="generate" id="${foreignFederation.id}">${createLink(controller:'foreignFederation', action:'generate', id:foreignFederation.id, absolute:true)}</g:link></strong></p>
					<div id="foreignmetadata"></div>
                                       
		     </div>
                     <div id="tab-contacts" class="tabcontent">
					<h3><g:message code="label.contacts" /></h3>
					<div id="contacts">
						<g:render template="/templates/foreignFederationContacts/list" plugin="foreignfederationoptin" model="[foreignFederation:foreignFederation]" />
					</div>

					<g:render template="/templates/foreignFederationContacts/create" plugin="foreignfederationoptin" model="[foreignFederation:foreignFederation, contactTypes:contactTypes]"/>
		     </div>
                     <div id="tab-optedin" class="tabcontent">
					<h3><g:message code="label.optedinentities" /></h3>
					<div id="optedin">
                                         <table>
								<thead>
									<tr>
										<th><g:message code="label.name" /></th>
										<th><g:message code="label.description" /></th>
										<th/>
									</tr>
								</thead>
								<tbody>
								<g:each in="${optinStatus}" var="optin" status="i">
									<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
										<td>${optin.optInEntity.displayName}</td>
                                                                                <td>${optin.optInEntity.description}</td>
                                                                        <g:if test="${optin.optinEntityType=='IDPSSODescriptor'}">
										<td><n:button href="${createLink(controller:'IDPSSODescriptor', action:'show', id:optin.optInEntity.id)}" label="label.view" class="view-button" /></td>
                                                                        </g:if>
                                                                        <g:else>
                                                                          <td><n:button href="${createLink(controller:'SPSSODescriptor', action:'show', id:optin.optInEntity.id)}" label="label.view" class="view-button" /></td>
                                                                        </g:else>
                                                                                
                                                                        </tr>

								</g:each>
								</tbody>
							</table>

					</div>

					
		     </div>
        </div>

		</section>
	</body>
</html>
<!--# Shivshankar rajasekaran(19-01-2012)  :: Code change for foreignfederationoptin :: Ends-->