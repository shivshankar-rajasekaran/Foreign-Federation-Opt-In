<!DOCTYPE html>

<html>
	<head>
		<title><g:message code="fedreg.title.${grailsApplication.config.fedreg.deployment.environment}" /> | <g:layoutTitle /></title>
		<r:use modules="html5, jquery-ui, blockui, tiptip, jgrowl, datatables, validate, alphanumeric, formwizard, zenbox, app, protvis, tipsy"/>
		<r:layoutResources/>
		<g:layoutHead />
	</head>

	<body>
	    <header>
			<g:render template='/templates/frheader' />
	    </header>
    
		<nav>
			<n:isLoggedIn>
				<g:render template='/templates/frtopnavigation'/>

				<ul class="level2">
					<li class="${controllerName == 'organization' ? 'active':''}">
						<g:link controller="organization" action="list"><g:message code="label.organizations" /></g:link>
					</li>
                                       
					<n:hasPermission target="saml:advanced">
						<li class="${controllerName == 'entityDescriptor' ? 'active':''}">
							<g:link controller="entityDescriptor" action="list"><g:message code="label.entitydescriptors" /></g:link>
						</li>
					</n:hasPermission>
					<li class="${controllerName == 'IDPSSODescriptor' ? 'active':''}">
						<g:link controller="IDPSSODescriptor" action="list" ><g:message code="label.identityproviders" /></g:link>
					</li>
					<li class="${controllerName == 'SPSSODescriptor' ? 'active':''}">
						<g:link controller="SPSSODescriptor" action="list" ><g:message code="label.serviceproviders" /></g:link>
					</li>
					<li class="${controllerName == 'contacts' ? 'active':''}">
						<g:link controller="contacts" action="list"><g:message code="label.contacts" /></g:link>
					</li>
                                       <!-- Foreign Federation Optin
                                         Abhinav Chopra <13:01:2012> :: Code change for foreignfederationoptin :: Starts -->
                                         <li class="${controllerName == 'foreignFederation' ? 'active':''}">
						<g:link controller="foreignFederation" action="list"><g:message code="label.foreignfederation" /></g:link>
					 </li>
                                        <!-- Abhinav Chopra <13:01:2012> :: Code change for foreignfederationoptin :: Ends -->
				</ul>	
			
				<g:if test="${controllerName == 'organization'}">
					<ul class="level3a">
						<li class="${actionName == 'list' ? 'active':''}"><g:link controller="organization" action="list"><g:message code="label.list"/></g:link></li>
						<n:hasPermission target="saml:advanced">
						<li class="${actionName == 'listarchived' ? 'active':''}"><g:link controller="organization" action="listarchived"><g:message code="label.listarchived"/></g:link></li>
						</n:hasPermission>
						<li class="${actionName in ['create', 'save'] ? 'active':''}"><g:link controller="organization" action="create"><g:message code="label.create"/></g:link></li>
						<g:if test="${actionName in ['show', 'edit']}">
						<li> | </li>
						<li><g:message code="fedreg.view.members.organization.show.heading" args="[organization.displayName]"/>: </li>
						<li class="${actionName == 'show' ? 'active':''}"><g:link controller="organization" action="show" id="${organization.id}"><g:message code="label.view"/></g:link></li>
						<n:hasPermission target="organization:${organization.id}:update">
							<li class="${actionName == 'edit' ? 'active':''}"><g:link controller="organization" action="edit" id="${organization.id}" class="${actionName == 'edit' ? 'active':''}"><g:message code="label.edit"/></g:link></li>
						</n:hasPermission>
						</g:if>
					</ul>
				</g:if>
                                <!-- Foreign Federation Optin
                                     ShivShankar Rajasekaran <13:01:2012 :: 12:12> :: Code change for foreignfederationoptin :: Starts -->
                                <g:if test="${controllerName == 'foreignFederation'}">
                                <ul class="level3a">
						<li class="${actionName == 'list' ? 'active':''}"><g:link controller="foreignFederation" action="list"><g:message code="label.list"/></g:link></li>
                                                			<n:isAdministrator>

                                               <li class="${actionName in ['create', 'save'] ? 'active':''}"><g:link controller="foreignFederation" action="create"><g:message code="label.create"/></g:link></li>
                                               			</n:isAdministrator>

                                                                        <g:if test="${actionName in ['show', 'edit']}">
						<li> | </li>
						<li><g:message code="fedreg.view.members.foreignfederation.show.heading" args="[foreignFederation.displayName]"/>: </li>
						<li class="${actionName == 'show' ? 'active':''}"><g:link controller="foreignFederation" action="show" id="${foreignFederation.id}"><g:message code="label.view"/></g:link></li>
                                                <n:hasPermission target="foreignFederation:${foreignFederation.id}:update">
							<li class="${actionName == 'edit' ? 'active':''}"><g:link controller="foreignFederation" action="edit" id="${foreignFederation.id}" class="${actionName == 'edit' ? 'active':''}"><g:message code="label.edit"/></g:link></li>
						</n:hasPermission>
						</g:if>
                                </ul>
                                </g:if>
                                <!-- ShivShankar Rajasekaran <13:01:2012 :: 12:12> :: Code change for foreignfederationoptin :: Ends -->
				<n:hasPermission target="saml:advanced">
					<g:if test="${controllerName == 'entityDescriptor'}">
						<ul class="level3a">
							<li class="${actionName == 'list' ? 'active':''}"><g:link controller="entityDescriptor" action="list"><g:message code="label.list"/></g:link></li>
							<n:hasPermission target="saml:advanced">
							<li class="${actionName == 'listarchived' ? 'active':''}"><g:link controller="entityDescriptor" action="listarchived"><g:message code="label.listarchived"/></g:link></li>
							</n:hasPermission>
							<li class="${actionName in ['create', 'save'] ? 'active':''}"><g:link controller="entityDescriptor" action="create"><g:message code="label.create"/></g:link></li>
							<g:if test="${actionName in ['show', 'edit']}">
								<li> | </li>
								<li><g:message code="fedreg.view.members.entity.show.heading" args="[entity.entityID]"/>: </li>
								<li class="${actionName == 'show' ? 'active':''}"><g:link controller="entityDescriptor" action="show" id="${entity.id}"><g:message code="label.view"/></g:link></li>
								<n:hasPermission target="descriptor:${entity.id}:update">
									<li class="${actionName == 'edit' ? 'active':''}"><g:link controller="entityDescriptor" action="edit" id="${entity.id}" class="${actionName == 'edit' ? 'active':''}"><g:message code="label.edit"/></g:link></li>
								</n:hasPermission>
								<n:hasPermission target="descriptor:${entity.id}:archive">
									<g:if test="${(entity.holdsIDPOnly() || entity.holdsSPOnly() || entity.empty()) && !entity.archived}">
										<li>
											<n:confirmaction action="\$('#edarchive').submit();" title="${message(code: 'fedreg.templates.entitydescriptor.archive.confirm.title')}" msg="${message(code: 'fedreg.templates.entitydescriptor.archive.confirm.descriptive')}" accept="${message(code: 'label.accept')}" cancel="${message(code: 'label.cancel')}" label="${message(code: 'label.archive')}" plain="true"/>
										</li>
									</g:if>
								</n:hasPermission>
							</g:if>
						</ul>
						<g:if test="${actionName in ['show', 'edit']}">
							<g:form controller="entityDescriptor" action="archive" id="${entity.id}" name="edarchive">
								<input name="_method" type="hidden" value="delete" />
							</g:form>
						</g:if>
					</g:if>
				</n:hasPermission>
			
				<g:if test="${controllerName == 'IDPSSODescriptor'}">
					<ul class="level3a">
						<li class="${actionName == 'list' ? 'active':''}"><g:link controller="IDPSSODescriptor" action="list"><g:message code="label.list"/></g:link></li>
						<n:hasPermission target="saml:advanced">
						<li class="${actionName == 'listarchived' ? 'active':''}"><g:link controller="IDPSSODescriptor" action="listarchived"><g:message code="label.listarchived"/></g:link></li>
						</n:hasPermission>
						<li class="${actionName in ['create', 'save'] ? 'active':''}"><g:link controller="IDPSSODescriptor" action="create"><g:message code="label.create"/></g:link></li>
						<g:if test="${actionName in ['show', 'edit']}">
						<li> | </li>
						<li><g:message code="fedreg.view.members.identityprovider.show.heading" args="[identityProvider.displayName]"/>: </li>
						<li class="${actionName == 'show' ? 'active':''}"><g:link controller="IDPSSODescriptor" action="show" id="${identityProvider.id}"><g:message code="label.view"/></g:link></li>
						<n:hasPermission target="descriptor:${identityProvider.id}:update">
							<li class="${actionName == 'edit' ? 'active':''}"><g:link controller="IDPSSODescriptor" action="edit" id="${identityProvider.id}" class="${actionName == 'edit' ? 'active':''}"><g:message code="label.edit"/></g:link></li>
						</n:hasPermission>
						</g:if>
					</ul>
				</g:if>
			
				<g:if test="${controllerName == 'SPSSODescriptor'}">
					<ul class="level3a">
						<li class="${actionName == 'list' ? 'active':''}"><g:link controller="SPSSODescriptor" action="list"><g:message code="label.list"/></g:link></li>
						<n:hasPermission target="saml:advanced">
						<li class="${actionName == 'listarchived' ? 'active':''}"><g:link controller="SPSSODescriptor" action="listarchived"><g:message code="label.listarchived"/></g:link></li>
						</n:hasPermission>
						<li class="${actionName in ['create', 'save'] ? 'active':''}"><g:link controller="SPSSODescriptor" action="create"><g:message code="label.create"/></g:link></li>
						<g:if test="${actionName in ['show', 'edit']}">
							<li> | </li>
							<li><g:message code="fedreg.view.members.serviceprovider.show.heading" args="[serviceProvider.displayName]"/>: </li>
							<li class="${actionName == 'show' ? 'active':''}"><g:link controller="SPSSODescriptor" action="show" id="${serviceProvider.id}"><g:message code="label.view"/></g:link></li>
							<n:hasPermission target="descriptor:${serviceProvider.id}:update">
								<li class="${actionName == 'edit' ? 'active':''}"><g:link controller="SPSSODescriptor" action="edit" id="${serviceProvider.id}" class="${actionName == 'edit' ? 'active':''}"><g:message code="label.edit"/></g:link></li>
							</n:hasPermission>
						</g:if>
					</ul>
				</g:if>
			
				<g:if test="${controllerName == 'contacts'}">
					<ul class="level3a">
						<li class="${actionName == 'list' ? 'active':''}"><g:link controller="contacts" action="list"><g:message code="label.list"/></g:link></li>
						<li class="${actionName == 'create' ? 'active':''}"><g:link controller="contacts" action="create"><g:message code="label.create"/></g:link></li>
						<g:if test="${actionName in ['show', 'edit']}">
							<li> | </li>
							<li><g:message code="fedreg.view.members.contacts.show.heading" args="[contact.givenName, contact.surname]"/>: </li>
							<li class="${actionName == 'show' ? 'active':''}"><g:link controller="contacts" action="show" id="${contact.id}"><g:message code="label.view"/></g:link>
							<n:hasPermission target="contact:${contact.id}:update">
								<li class="${actionName == 'edit' ? 'active':''}"><g:link controller="contacts" action="edit" id="${contact.id}"><g:message code="label.edit"/></g:link></li>
							</n:hasPermission>
						</g:if>
					</ul>
				</g:if>
			</n:isLoggedIn>
		</nav>
	
		<section>
			<g:layoutBody/>
	    </section>

		<footer>
			<g:render template='/templates/frfooter' />
		</footer>
	
		<r:layoutResources/>
	</body>

</html>
