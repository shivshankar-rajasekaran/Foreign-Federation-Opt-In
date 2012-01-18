package tuakiri.fr.ffoi
import fedreg.core.*
class ForeignFederationService {

    static transactional = true

    def create(def params) {

        
                log.info "$params.foreignFederation"
		def foreignFederation = new ForeignFederation(name:params.foreignFederation?.name, displayName:params.foreignFederation?.displayName, description: params.foreignFederation?.description, metadataURL: new Uri(uri:params.foreignFederation?.metadataURL),websiteURL:new Uri(uri:params.foreignFederation?.websiteURL))

//                if(!foreignFederation.validate()) {
//			log.info "$authenticatedUser attempted to create $foreignFederation but failed Organization validation"
//			foreignFederation?.errors.each { log.error it }
//			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly()
//			return [ false, foreignFederation ]
// 		}
//                else{
                //log.info "$params.foreignFederation?.name"
                def savedForeignFed = foreignFederation.save(flush:true)

                return [ true, foreignFederation ]
 		
//		def contact = Contact.get(params.contact?.id)
//		if(!contact) {
//			contact = MailURI.findByUri(params.contact?.email)?.contact		// We may already have them referenced by email address and user doesn't realize
//			if(!contact)
//				contact = new Contact(givenName: params.contact?.givenName, surname: params.contact?.surname, email: new MailURI(uri:params.contact?.email))
//		}

//		if(!foreignFederation.validate()) {
//			log.info "$authenticatedUser attempted to create $foreignFederation but failed Organization validation"
//			foreignFederation?.errors.each { log.error it }
//			//TransactionAspectSupport.currentTransactionStatus().setRollbackOnly()
//			return [ false, foreignFederation ]
//		}
//                else
//                {
//                    render "hi"
//                }

//		def savedForeignFed = foreignFederation.save(flush:true)
//                print "$savedForeignFed"
//		if(!savedForeignFed) {
//			foreignFederation?.errors.each { log.error it }
//			throw new ErronousStateException("Unable to save when creating ${foreignFederation}")
//		}
////
//		if(contact.organization == null)
//			contact.organization = savedOrg
//
//		if(!contact.validate()) {
//			log.info "$authenticatedUser attempted to create $organization but failed Contact validation"
//			contact?.errors.each { log.error it }
//			savedOrg.discard()
//			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly()
//			return [ false, organization, contact ]
//		}
//
//		if(!contact.save(flush:true)) {
//			contact?.errors.each { log.error it }
//			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly()
//			throw new ErronousStateException("Unable to save when creating ${contact}")
//		}
//
//		def workflowParams = [ creator:contact?.id?.toString(), organization:organization?.id?.toString(), locale:LCH.getLocale().getLanguage() ]
//		def (initiated, processInstance) = workflowProcessService.initiate( "organization_create", "Approval for creation of Organization ${organization.displayName}", ProcessPriority.MEDIUM, workflowParams)
//
//		if(initiated)
//			workflowProcessService.run(processInstance)
//		else
//			throw new ErronousStateException("Unable to execute workflow when creating ${organization}")

//		log.info "$authenticatedUser created foreignFederation"
//		return [ true, foreignFederation ]
	}
}
