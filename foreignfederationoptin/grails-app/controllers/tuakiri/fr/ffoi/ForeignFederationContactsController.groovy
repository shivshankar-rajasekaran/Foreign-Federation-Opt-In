package tuakiri.fr.ffoi

import org.apache.shiro.SecurityUtils
import fedreg.core.*

/**
 * Provides views for searching,adding & deleting contacts of a foreign federation
 *
 * @author ShivShankar Rajasekaran & Abhinav R.Chopra
 * Plugin developed for Summer of eResearch(SoeR) 2011-12,New Zealand
 */
class ForeignFederationContactsController {

   def allowedMethods = [create:'POST', delete:'DELETE']

	def search = {
		def contacts

		if(!params.givenName && !params.surname && !params.email)
			contacts = Contact.list()
		else {
			def emails
			if(params.email)
				emails = MailURI.findAllByUriLike("%${params.email}%")
			def c = Contact.createCriteria()
			contacts = c.list {
				or {
					ilike("givenName", params.givenName)
					ilike("surname", params.surname)
					if(emails)
						'in'("email", emails)
				}
			}
		}
		render template:"/templates/foreignFederationContacts/results", contextPath: pluginContextPath, model:[contacts:contacts]
	}
        def create = {
		if(!params.id || !params.contactID || !params.contactType) {
			log.warn "All name/value pairs required for this call were not present"
			render message(code: 'fedreg.controllers.namevalue.missing')
			response.setStatus(500)
			return
		}

		def foreignFederation = ForeignFederation.get(params.id)
		if(!foreignFederation) {
			log.warn "RoleDescriptor identified by id $params.id was not located"
			render message(code: 'fedreg.roledescriptor.nonexistant', args: [params.id])
			response.setStatus(500)
			return
		}

		if(SecurityUtils.subject.isPermitted("foreignFederation:${foreignFederation.id}:contact:add")) {
			def contact = Contact.get(params.contactID)
			if(!contact) {
				log.warn "Contact identified by id $params.contactID was not located"
				render message(code: 'fedreg.contact.nonexistant', args: [params.contactID])
				response.setStatus(500)
				return
			}

			def contactType = ContactType.findByName(params.contactType)
			if(!contactType) {
				log.warn "ContactType identified by id $params.contactType was not located"
				render message(code: 'fedreg.contacttype.nonexistant', args: [params.contactID])
				response.setStatus(500)
				return
			}

			def contactPerson = new ContactPerson(contact:contact, type:contactType)



			foreignFederation?.addToContacts(contactPerson)
                        contactPerson.save()
			if(contactPerson.hasErrors()) {
				log.debug "$authenticatedUser failed to create $contactPerson linked to $contact for $foreignFederation"
				contactPerson.errors.each {
					log.error it
				}
				render message(code: 'fedreg.contactperson.create.error')
				response.setStatus(500)
				return
			}

			log.debug "$authenticatedUser created $contactPerson linked to $contact for $foreignFederation"
			render message(code: 'fedreg.contactperson.create.success')
		}
		else {
			log.warn("Attempt to link contact to $foreignFederation by $authenticatedUser was denied, incorrect permission set")
			response.sendError(403)
		}
	}
        def list = {
		if(!params.id) {
			log.warn "All name/value pairs required for this call were not present"
			render message(code: 'fedreg.controllers.namevalue.missing')
			response.setStatus(500)
			return
		}

		def foreignFederation = ForeignFederation.get(params.id)
		if(!foreignFederation) {
			log.warn "RoleDescriptor identified by id $params.id was not located"
			render message(code: 'fedreg.roledescriptor.nonexistant', args: [params.id])
			response.sendError(500)
			return
		}

		render template:"/templates/foreignFederationContacts/list", contextPath: pluginContextPath, model:[foreignFederation:foreignFederation]
	}

    	def delete = {
		if(!params.id) {
			log.warn "All name/value pairs required for this call were not present"
			render message(code: 'fedreg.controllers.namevalue.missing')
			response.setStatus(500)
			return
		}

		def contactPerson = ContactPerson.get(params.id)
		if(!contactPerson) {
			log.warn "ContactPerson identified by id $params.id was not located"
			render message(code: 'fedreg.contactperson.nonexistant', args: [params.id])
			response.setStatus(500)
			return
		}
                def foreignFederation = ForeignFederation.get(params.foreignFedId)
		foreignFederation?.removeFromContacts(contactPerson)

                contactPerson.save()
		log.debug "$authenticatedUser deleted $contactPerson"
		render message(code: 'fedreg.contactperson.delete.success')

	
}
}