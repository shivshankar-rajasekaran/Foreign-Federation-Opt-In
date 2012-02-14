package tuakiri.fr.ffoi
import fedreg.core.*
class ForeignFederationService {

    static transactional = true

    def create(def params) {

        
                log.info "$params.foreignFederation"
		def foreignFederation = new ForeignFederation(name:params.foreignFederation?.name, displayName:params.foreignFederation?.displayName, description: params.foreignFederation?.description, metadataURL: new Uri(uri:params.foreignFederation?.metadataURL),websiteURL:new Uri(uri:params.foreignFederation?.websiteURL),registrationInfo:new Uri(uri:params.foreignFederation?.registrationInfo))

                def savedForeignFed = foreignFederation.save(flush:true)
                if(!savedForeignFed) {
			foreignFederation?.errors.each { log.error it }
			throw new ErronousStateException("Unable to save when creating ${foreignFederation}")
		}
                return [ true, foreignFederation ]
 		
	}

     def update(def params) {
		def foreignFederation = ForeignFederation.get(params.id)
		if(!foreignFederation)
                {
		return [false, null]
                }else{


                foreignFederation.name = params.foreignFederation.displayName
		foreignFederation.displayName = params.foreignFederation.displayName
		foreignFederation.description = params.foreignFederation.description
		foreignFederation.metadataURL = new Uri(uri:params.foreignFederation.metadataURL)
                foreignFederation.websiteURL  =new Uri(uri:params.foreignFederation.websiteURL)
                foreignFederation.registrationInfo =new Uri(uri:params.foreignFederation.registrationInfo)

               	if(!foreignFederation.save(flush:true)) {
			foreignFederation.errors.each {log.warn it}
			throw new ErronousStateException("Unable to save when updating ${foreignFederation}")
		}

		log.info "$authenticatedUser updated $foreignFederation"
		return [true, foreignFederation]
                }
	}
}
