<!--
          Plugin developed for Summer of eResearch(SoeR) 2011-12,New Zealand
          Authors: ShivShankar Rajasekaran & Abhinav R.Chopra

          Template for listing contacts of a foreign federation.
-->

<g:if test="${foreignFederation.contacts}">
	<table>
		<thead>
			<tr>
				<th><g:message code="label.name" /></th>
				<th><g:message code="label.email" /></th>
				<th><g:message code="label.type" /></th>
				<th/>
			</tr>
		</thead>
		<tbody>
			<g:each in="${foreignFederation.contacts.sort{it.contact.surname}}" var="contactPerson" status="i">
				<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
					<td>${contactPerson.contact.givenName?.encodeAsHTML()} ${contactPerson.contact.surname?.encodeAsHTML()}</td>
					<td><a href="mailto:${contactPerson.contact.email?.uri.encodeAsHTML()}">${contactPerson.contact.email?.uri.encodeAsHTML()}</a></td>
					<td>${contactPerson.type.displayName.encodeAsHTML()}</td>
					<td>
						<n:button href="${createLink(controller:'contacts', action:'show', id: contactPerson.contact.id)}" label="${message(code:'label.view')}" class="view-button"/>
						<n:hasPermission target="foreignFederation:${foreignFederation.id}:contact:remove">
							<n:confirmaction action="fedreg.foreignfed_contact_delete(${contactPerson.id},${foreignFederation.id});" label="${message(code:'label.delete')}" class="delete-button" title="${message(code: 'fedreg.templates.contacts.remove.confirm.title')}" msg="${message(code: 'fedreg.templates.contacts.remove.confirm.descriptive')}" accept="${message(code: 'label.accept')}" cancel="${message(code: 'label.cancel')}"/>
						</n:hasPermission>
					</td>
				</tr>
			</g:each>
		</tbody>
	</table>
</g:if>
<g:else>
	<p><g:message code="fedreg.templates.contacts.noresults" /></p>
</g:else>