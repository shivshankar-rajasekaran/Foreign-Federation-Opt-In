package tuakiri.fr.ffoi
import fedreg.workflow.*
import fedreg.core.*

class OptinStatusService {

    static transactional = true
    def workflowProcessService

    def optinApproval(def roleDescriptor,def optinStatus,def organization) {

        def workflowParams = [  roleDescriptor:roleDescriptor?.id?.toString(),optinStatus:optinStatus?.id?.toString(),organization:organization.id?.toString()]
        def (initiated, processInstance) = workflowProcessService.initiate( "optin_create1", "Approval for optin  ", ProcessPriority.MEDIUM, workflowParams)
        if(initiated)
        workflowProcessService.run(processInstance)
        else
       //  throw new ErronousStateException("Unable to execute workflow when creating ${serviceProvider}")
	
        log.info "$authenticatedUser"
        
        
    }
    def delete(long id) {
        def optinStatus = OptinStatus.get(id)
        if(!optinStatus)
        throw new ErronousStateException("Unable to delete optin entity entry, no such instance")

        log.info "Deleting opt-in details on request of $authenticatedUser"


        optinStatus.delete()

        log.info "$authenticatedUser deleted opt-in details"
    }
}
