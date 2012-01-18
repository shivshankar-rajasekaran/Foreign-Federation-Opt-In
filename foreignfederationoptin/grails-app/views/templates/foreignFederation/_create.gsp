<!--<r:script disposition:'head'>
	
	var newCertificateValid = false;

	$(function() {
		$('form').validate({
				keyup: false
		});
		$('form').formwizard({
		 	formPluginEnabled: false,
		 	validationEnabled: true,
		 	focusFirstInput : true,
			disableUIStyles: true
		});
	});
</r:script>-->

<g:hasErrors>
    <div class="warning">
       <g:message code="fedreg.templates.foreignFederation.create.errors" />
    </div>

	<n:errors bean="${foreignFederation}" />
</g:hasErrors>

<g:form action="${saveAction}">
  
<!--	<g:hiddenField name="active" value="true"/>
	<g:if test="${!requiresContactDetails}">
		<g:hiddenField name="contact.id" value="${fr.contactID()}"/>
	</g:if>
	<g:hiddenField name="contact.type" value="administrative" />
	<g:hiddenField name="foreignfederation.lang" value="en" />-->

	<div class="step" id="overview">
		<h3><g:message code="fedreg.templates.foreignfederation.create.overview.heading" /></h3>
		<g:message code="fedreg.templates.foreignfederation.create.overview.details" />
	</div>

<!--	<g:if test="${requiresContactDetails}">
		<div class="step" id="contact">
			<h3><g:message code="fedreg.templates.foreignfederation.create.contact.heading" /></h3>
			<p>
				<g:message code="fedreg.templates.foreignfederation.create.contact.details" />
			</p>
			<g:hasErrors bean="${contact}">
				<div class="error"><g:renderErrors bean="${contact}" as="list"/></div>
			</g:hasErrors>
			<table>
				<tr>
					<td>
						<label for="contact.givenName"><g:message code="label.givenname" /></label>
					</td>
					<td>
						<g:textField name="contact.givenName"  size="50" class="required" value="${contact?.givenName}"/>
					</td>
				</tr>
				<tr>
					<td>
						<label for="contact.surname"><g:message code="label.surname" /></label>
					</td>
					<td>
						<g:textField name="contact.surname"  size="50" class="required" value="${contact?.surname}"/>
					</td>
				</tr>
				<tr>
					<td>
						<label for="contact.email"><g:message code="label.email" /></label>
					</td>
					<td>
						<g:textField name="contact.email"  size="50" class="required email" value="${contact?.email?.uri}"/>
					</td>
				</tr>
			</table>
		</div>
	</g:if>
-->
	<div class="step" id="basicinformation">
		<!--<h3><g:message code="fedreg.templates.foreignfederation.create.basicinformation.heading" /></h3>-->
		<p>
			<g:message code="fedreg.templates.foreignfederation.create.basicinformation.details" />
		</p>
		<g:hasErrors bean="${foreignFederation}">
			<div class="error"><g:renderErrors bean="${foreignFederation}" as="list"/></div>
		</g:hasErrors>
		<table>
			<tr>
				<td>
					<label for="foreignFederation.name"><g:message code="label.name" /></label>
				</td>
				<td>
					<g:textField name="foreignFederation.name"  size="50" class="required" value="${foreignFederation?.name}"/>
					<fr:tooltip code='fedreg.help.foreignfederation.name' />
				</td>
			</tr>
			<tr>
				<td>
					<label for="foreignFederation.displayName"><g:message code="label.displayname" /></label>
				</td>
				<td>
					<g:textField name="foreignFederation.displayName"  size="50" class="required" value="${foreignFederation?.displayName}"/>
					<fr:tooltip code='fedreg.help.foreignfederation.displayName' />
				</td>
                               
			</tr>  
                        <tr>
                                 <td>
					<label for="foreignFederation.description"><g:message code="label.description" /></label>
				</td>
                                <td>
                                        <g:textArea name="foreignFederation.description"  class="required" rows="8" cols="36" value="${foreignFederation?.description}"/>
					<fr:tooltip code='fedreg.help.foreignfederation.description' />
                                </td>
                        </tr>
			<tr>
				<td>
					<label for="foreignFederation.websiteURL"><g:message code="label.foreignfederationurl" /></label>
				</td>
				<td>
					<g:textField name="foreignFederation.websiteURL"  size="50" class="required url"  value="${foreignFederation?.websiteURL?.uri}"/>
					<fr:tooltip code='fedreg.help.foreignfederation.url' />
				</td>
                       </tr>
                        <tr>
                                <td>
					<label for="foreignFederation.metadataURL"><g:message code="label.metadataurl" /></label>
				</td>
				<td>
					<g:textField name="foreignFederation.metadataURL"  size="50" class="required url"  value="${foreignFederation?.metadataURL?.uri}"/>
					<fr:tooltip code='fedreg.help.foreignfederation.url' />
				</td>
                        </tr>
                         <tr>
                                <td>
					<label for="foreignFederation.registrationInfo"><g:message code="label.registrationinfo" /></label>
				</td>
                                <td>
					<g:textField name="foreignFederation.registrationInfo"  size="50" class="required url"  value="${foreignFederation?.registrationInfo?.uri}"/>
					<fr:tooltip code='fedreg.help.foreignfederation.url' />
				</td>

			</tr>			
		</table>
	</div>

	<div class="step submit_step" id="creationsummary">
		<h3><g:message code="fedreg.templates.foreignfederation.create.summary.heading" /></h3>
		<p>
			<g:message code="fedreg.templates.foreignfederation.create.summary.details" />
                        ${params.foreignFederation?.metadataURL?.uri}
		</p>
	</div>

	<nav>
		<input id="back" value="${g.message(code:'label.back')}" type="reset" />
		<input id="next" value="${g.message(code:'label.next')}" type="submit" />
	</nav>

</g:form>