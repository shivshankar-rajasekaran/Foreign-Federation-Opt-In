
<!--
          Plugin developed for Summer of eResearch(SoeR) 2011-12,New Zealand
          Authors: ShivShankar Rajasekaran & Abhinav R.Chopra

          Template for creating a  foreign federation.
-->

<r:script disposition:'head'>

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
</r:script>

<g:hasErrors>
    <div class="warning">
       <g:message code="fedreg.templates.foreignFederation.create.errors" />
    </div>

	<n:errors bean="${foreignFederation}" />
</g:hasErrors>

<g:form action="${saveAction}">
  
	<div class="step" id="overview">
		<h3><g:message code="fedreg.templates.foreignfederation.create.overview.heading" /></h3>
		<g:message code="fedreg.templates.foreignfederation.create.overview.details" />
	</div>

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
					<fr:tooltip code='fedreg.help.foreignfederation.websiteurl' />
				</td>
                       </tr>
                        <tr>
                                <td>
					<label for="foreignFederation.metadataURL"><g:message code="label.metadataurl" /></label>
				</td>
				<td>
					<g:textField name="foreignFederation.metadataURL"  size="50" class="required url"  value="${foreignFederation?.metadataURL?.uri}"/>
					<fr:tooltip code='fedreg.help.foreignfederation.metadataurl' />
				</td>
                        </tr>
                         <tr>
                                <td>
					<label for="foreignFederation.registrationInfo"><g:message code="label.registrationinfo" /></label>
				</td>
                                <td>
					<g:textField name="foreignFederation.registrationInfo"  size="50" class="required url"  value="${foreignFederation?.registrationInfo?.uri}"/>
					<fr:tooltip code='fedreg.help.foreignfederation.registrationinfo' />
				</td>

			</tr>			
		</table>
	</div>

	<div class="step submit_step" id="creationsummary">
		<h3><g:message code="fedreg.templates.foreignfederation.create.summary.heading" /></h3>
		<p>
			<g:message code="fedreg.templates.foreignfederation.create.summary.details" />
		</p>
	</div>

	<nav>
		<input id="back" value="${g.message(code:'label.back')}" type="reset" />
		<input id="next" value="${g.message(code:'label.next')}" type="submit" />
	</nav>

</g:form>