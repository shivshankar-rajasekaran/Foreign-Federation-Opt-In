<%@page import="tuakiri.fr.ffoi.OptinStatus" %>
	<table>
		<thead>
			<tr>
				<th><g:message code="label.foreignfederation"/></th>
				<th><g:message code="label.optinstatus"/></th>
                                <th><g:message code="label.optinapproved"/></th>
				
				<th/>
			</tr>	
		</thead>
		<tbody>
               
			<g:each in="${OptinStatus.findAllWhere(optInEntity:roleDescriptor)}" var="m">
			<tr>
                        
				<td>${m.foreignFederation.displayName}</td>
				<td>${m.applied}</td>
			        <td>${m.approved}</td>
			        <td>
					<n:hasPermission target="descriptor:${roleDescriptor.id}:monitor:delete">
						<n:confirmaction action="fedreg.optout(${m.id});" title="${message(code: 'fedreg.templates.optout.confirm.title')}" msg="${message(code: 'fedreg.templates.optout.confirm.descriptive')}" accept="${message(code: 'label.accept')}" cancel="${message(code: 'label.cancel')}" class="delete-button" label="${message(code: 'label.optout')}" />
					</n:hasPermission>
				</td>
                         </tr>
			</g:each>

               			

		</tbody>
	</table>
