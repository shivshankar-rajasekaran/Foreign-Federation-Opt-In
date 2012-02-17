package tuakiri.fr.ffoi
import fedreg.workflow.*
import fedreg.core.*

/**
 * Domain class for maintaining foreign federation registration/creation details
 *
 * @author ShivShankar Rajasekaran & Abhinav R.Chopra
 * Plugin developed for Summer of eResearch(SoeR) 2011-12,New Zealand
 */
class OptinStatusService {

    static transactional = true
    def workflowProcessService

    def optinApproval(def roleDescriptor,def optinStatus,def organization,def creator) {

        def workflowParams = [  roleDescriptor:roleDescriptor?.id?.toString(),optinStatus:optinStatus?.id?.toString(),organization:organization.id?.toString(),creator:authenticatedUser.id?.toString()]
        def (initiated, processInstance) = workflowProcessService.initiate( "optin_create", "Approval for optin  ", ProcessPriority.MEDIUM, workflowParams)
        if(initiated)
        workflowProcessService.run(processInstance)
        else
        throw new ErronousStateException("Unable to execute workflow ")
        
        return [true]
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
