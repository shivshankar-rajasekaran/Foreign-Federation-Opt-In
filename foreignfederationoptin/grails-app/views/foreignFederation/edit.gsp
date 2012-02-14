
<html>
	<head>
		<meta name="layout" content="members" />
		<title><g:message code="fedreg.view.members.foreignFederation.edit.title" /></title>
	</head>
<body>
		<r:script>
			$(function() {
				$('form').validate({
						ignore: ":disabled",
						success: function(label) {
							if($(label).next())
								$(label).next().remove()	// fix annoying bug where success labels are left laying about if duplicate validations
							label.removeClass("error").addClass("icon icon_accept").html("&nbsp;");
						},
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

	<section>
	     <h2><g:message code="fedreg.view.members.foreignFederation.edit.heading" args="[foreignFederation.displayName]"/></h2>

	     <g:form action="update" id="${foreignFederation.id}" method="PUT">
	     <div class="step" id="basicinformation">
		<!--<h3><g:message code="fedreg.templates.foreignfederation.create.basicinformation.heading" /></h3>-->
		<p>
			<g:message code="fedreg.templates.foreignfederation.create.basicinformation.details" />
		</p>

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
                       
		</p>
          </div>

	  <nav>
	        <input id="back" value="${g.message(code:'label.back')}" type="reset" />
		<input id="next" value="${g.message(code:'label.next')}" type="submit" />
	  </nav>

	  </g:form>
	</section>
</body>


</html>