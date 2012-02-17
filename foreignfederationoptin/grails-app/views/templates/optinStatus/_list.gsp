
<!--
          Plugin developed for Summer of eResearch(SoeR) 2011-12,New Zealand
          Authors: ShivShankar Rajasekaran & Abhinav R.Chopra

          Template for listing the foreign federations that an IdP/SP has opted into.
-->

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
                                <g:if test="${m.applied}" >
                                  <td>Yes</td>
                               	</g:if>
                                <g:else>
                                  <td>No</td>
                                 </g:else>

                                 <g:if test="${m.approved}" >
                                  <td>Yes</td>
                               	</g:if>
                                <g:else>
                                  <td>Pending Approval</td>
                                 </g:else>
                                  
			          <td>
					<n:hasPermission target="descriptor:${roleDescriptor.id}:monitor:delete">
                                           <g:if test="${m.approved}" >
						<n:confirmaction action="fedreg.optout(${m.id});" title="${message(code: 'fedreg.templates.optout.confirm.title')}" msg="${message(code: 'fedreg.templates.optout.confirm.descriptive')}" accept="${message(code: 'label.accept')}" cancel="${message(code: 'label.cancel')}" class="delete-button" label="${message(code: 'label.optout')}" />
					   </g:if>
                                        </n:hasPermission>
                                  </td>
                         </tr>
			</g:each>
             			

		</tbody>
	</table>
