package tuakiri.fr.ffoi
import fedreg.core.*
class OptinStatusController {

        def allowedMethods = [create:'POST', delete:'DELETE']
        def existing=false
        def OptinStatusService

        def list = {
       		def roleDescriptor = RoleDescriptor.get(params.id)
               	if (!roleDescriptor) {
			flash.type="error"
			flash.message = message(code: 'fedreg.foreignfederation.roledescriptor.nonexistant')
			response.sendError(500)
			return
		}
		render template: '/templates/optinStatus/list', contextPath: pluginContextPath, model:[roleDescriptor:roleDescriptor]
	}
	def create = {
                def optinEntityType
                def idpDescriptor
		def roleDescriptor = RoleDescriptor.get(params.id)

		if (!roleDescriptor) {
			flash.type="error"
			flash.message = message(code: 'fedreg.foreignfederation.roledescriptor.nonexistant')
			response.sendError(500)
			return
		}
                def organization = roleDescriptor.organization
		def selectedForeignFed = ForeignFederation.get(params.type)

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

                 if(!existing){
                       idpDescriptor=IDPSSODescriptor.findWhere(id:roleDescriptor.id)
                       if(idpDescriptor!=null)
                       {
                           optinEntityType="IDPSSODescriptor"
                       }else{
                           optinEntityType="SPSSODescriptor"
                       }

                       def optinStatus = new OptinStatus(foreignFederation:selectedForeignFed, approved:false, applied:true,optInEntity:roleDescriptor,optinEntityType:optinEntityType)

                       if(!optinStatus.save()) {
				log.info "$authenticatedUser was unable to optin to $selectedForeignFed"
				optinStatus.errors.each {
					log.error it
				}

				render message(code: 'fedreg.optinstatus.create.error')
				response.setStatus(500)
				return
		       }
                       OptinStatusService.optinApproval(roleDescriptor,optinStatus,organization,authenticatedUser)
                       render message(code: 'fedreg.foreignfederation.optin.success')
                  }else{
                       log.warn "${selectedForeignFed.displayName} is already opted in by ${roleDescriptor.displayName}"
                       response.setStatus(500)
                       render message(code: 'fedreg.foreignfederation.optin.alreadyexists', args:[selectedForeignFed.displayName])
                       return
                  }
	}
        def delete = {
		def optinStatus = OptinStatus.get(params.id)
		if (!optinStatus) {
			flash.type="error"
			flash.message = message(code: 'fedreg.optinstatus.nonexistant')
			response.sendError(500)
			return
		}
                
                optinStatus.delete()
		log.info "$authenticatedUser deleted $optinStatus"
		render message(code: 'fedreg.foreignfederation.optout.success')
	}
}
