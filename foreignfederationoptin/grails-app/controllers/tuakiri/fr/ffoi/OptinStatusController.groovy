package tuakiri.fr.ffoi
import fedreg.core.*
class OptinStatusController {

        def allowedMethods = [create:'POST', delete:'DELETE']
        def existing=false
        def OptinStatusService
        def list = {
       		def roleDescriptor = RoleDescriptor.get(params.id)
                log.info "List.gsp Params ---------$params.id"
               	if (!roleDescriptor) {
			flash.type="error"
			flash.message = message(code: 'fedreg.foreignfederation.roledescriptor.nonexistant')
			response.sendError(500)
			return
		}
		render template: '/templates/optinStatus/list', contextPath: pluginContextPath, model:[roleDescriptor:roleDescriptor]
	}
	def create = {
		def roleDescriptor = RoleDescriptor.get(params.id)
                def organization = roleDescriptor.organization
		if (!roleDescriptor) {
			flash.type="error"
			flash.message = message(code: 'fedreg.foreignfederation.roledescriptor.nonexistant')
			response.sendError(500)
			return
		}
                log.info "Params ---------$params.id"
		def selectedForeignFed = ForeignFederation.get(params.type)
                log.info("Foreign Fed -----$selectedForeignFed")
		if (!selectedForeignFed) {
			flash.type="error"
			flash.message = message(code: 'fedreg.foreignfederation.selectedForeignFed.nonexistant')
			response.sendError(500)
			return
		}
                def optinStat=OptinStatus.findAllWhere(optInEntity:roleDescriptor)
                for(optin in optinStat){
                    if(selectedForeignFed.displayName==optin.foreignFederation.displayName){
                        existing=true
                    }
                }
                 log.info("existing-----$existing")
//		if(SecurityUtils.subject.isPermitted("descriptor:${roleDescriptor.id}:monitor:add")) {
                       if(!existing){
			def optinStatus = new OptinStatus(foreignFederation:selectedForeignFed, approved:false, applied:true,optInEntity:roleDescriptor)
			optinStatus.save()
                      
                       OptinStatusService.optinApproval(roleDescriptor,optinStatus,organization)
                       }else{
                            log.warn "${selectedForeignFed.displayName} is already opted in by ${roleDescriptor.displayName}"
                                        response.setStatus(500)
                                        render message(code: 'fedreg.foreignFederation.optin.alreadyexists', args:[selectedForeignFed.displayName])
                                        return
                       }
                      
                       
//			if(!optinStatus.save()) {
//				log.info "$authenticatedUser was unable to add $serviceMonitor to $roleDescriptor"
//				roleDescriptor.errors.each {
//					log.error it
//				}
//
//				render message(code: 'fedreg.core.monitor.create.error')
//				response.setStatus(500)
//				return
//			}
//
//			log.info "$authenticatedUser added $monitorType at ${params.url} to $roleDescriptor"
		render message(code: 'fedreg.foreignFederation.optin.success')
////		} else {
//			log.warn("Attempt to add monitor to $roleDescriptor by $authenticatedUser was denied, incorrect permission set")
//			response.sendError(403)
//		}
	}
        def delete = {
		def optinStatus = OptinStatus.get(params.id)
		if (!optinStatus) {
			flash.type="error"
			flash.message = message(code: 'fedreg.core.servicemonitor.nonexistant')
			response.sendError(500)
			return
		}
		//if(SecurityUtils.subject.isPermitted("descriptor:${serviceMonitor.roleDescriptor.id}:monitor:delete")) {
			optinStatus.delete()
			log.info "$authenticatedUser deleted $optinStatus"
			render message(code: 'fedreg.foreignFederation.optout.success')
//		} else {
//			log.warn("Attempt to delete monitor from ${serviceMonitor.roleDescriptor} by $authenticatedUser was denied, incorrect permission set")
//			response.sendError(403)
//		}
	}
}
