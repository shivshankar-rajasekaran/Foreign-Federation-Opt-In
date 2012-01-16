package tuakiri.fr.ffoi

class ForeignFederationController {

    static defaultAction = "index"
    def allowedMethods = [save: 'POST']
    def foreignFederationService
    def list={
        [foreignFederationList: ForeignFederation.list(), foreignFederationTotal: ForeignFederation.count()]
        //render (view:"list")
    }
    def create = {
		def foreignFederation = new ForeignFederation()
		[foreignFederation:foreignFederation]
               // render (view:"create")
    }
      def show = {

//		if(!params.id) {
//			log.warn "Organization ID was not present"
//			flash.type="error"
//			flash.message = message(code: 'fedreg.controllers.namevalue.missing')
//			redirect(action: "list")
//			return
//		}

//		def foreignFederation = ForeignFederation.get(params.id)
//		if (foreignFederation) {

			[foreignFederation: foreignFederation]
//                }
//		else {
//			flash.type="error"
//			flash.message = message(code: 'fedreg.core.organization.nonexistant')
//			redirect(action: "list")
//		}
	}
   def save = {
               log.info "$params.foreignFederation"
		def (created, foreignFederation) = foreignFederationService.create(params)

               // render "$created"
		if(created) {
			log.info "$authenticatedUser created $foreignFederation"
			redirect (action: "show", id: foreignFederation.id)
		}
//		 else {
//			log.info "$authenticatedUser failed to create $foreignFederation"
//
//			flash.type="error"
//			flash.message = message(code: 'fedreg.core.foreignFederation.nonexistant')
//			//render (view:'create', model:[organization:organization, contact:contact, organizationTypes: OrganizationType.list()])
//		}
	}


}
