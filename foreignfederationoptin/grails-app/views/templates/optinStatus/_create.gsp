
<n:hasPermission target="descriptor:${descriptor.id}:monitor:create">
	
	<%@page import="tuakiri.fr.ffoi.ForeignFederation" %>

  
  <script type="text/javascript">
		$(function() {
               
			$("#selectForeignFed").hide();
			$("#newoptindata").validate();
		});
	</script>
	

	<hr>

	<div id="optinbutton" class="searcharea">
		<n:button onclick="\$('#optinbutton').fadeOut(); \$('#selectForeignFed').fadeIn();" label="label.foreignfedoptincall" class="add-button"/>
	</div>
	
	<div id="selectForeignFed" class="searcharea" >
		<h3><g:message code="label.foreignfedoptincall"/></h3>
		<form id="newoptindata">
			<g:hiddenField name="interval" value="0" />
		<table>
			<tbody>
				<tr>
					<th><g:message code="label.foreignfederation"/><th>
					<td>
						<g:select name="type" from="${ForeignFederation.list()}" optionKey="id" optionValue="name"/>
						<fr:tooltip code='fedreg.help.monitor.type' />
					</td>
				</tr>
				
			</tbody>
		</table>
		<n:button onclick="if(\$('#newoptindata').valid()) fedreg.optin_create();" label="Opt-in" class="add-button"/>
		<n:button onclick="\$('#selectForeignFed').fadeOut(); \$('#optinbutton').fadeIn();" label="${message(code:'label.close')}" class="close-button"/>
		</form>
	</div>
	
</n:hasPermission>