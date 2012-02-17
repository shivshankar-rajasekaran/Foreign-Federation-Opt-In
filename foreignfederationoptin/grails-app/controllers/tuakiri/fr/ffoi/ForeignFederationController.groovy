package tuakiri.fr.ffoi

import groovy.xml.MarkupBuilder
import org.apache.shiro.SecurityUtils
import fedreg.core.*

/**
 * Provides views for creating & listing foreign federations
 *
 * @author ShivShankar Rajasekaran & Abhinav R.Chopra
 * Plugin developed for Summer of eResearch(SoeR) 2011-12,New Zealand
 */
class ForeignFederationController {

      static defaultAction = "index"
      def allowedMethods = [save: 'POST']
      def foreignFederationService
      def metadataGenerationService
      def entityList=[]
      def idpDescriptors
      def spDescriptors
      def entitiesDescriptor
      

       def list = {
               [foreignFederationList: ForeignFederation.list(), foreignFederationTotal: ForeignFederation.count()]
       }

       def create = {
        	def foreignFederation = new ForeignFederation()
		[foreignFederation:foreignFederation]
       }

       def show = {

                def optinStatus
		if(!params.id) {
			log.warn "Foreign Federation ID was not present"
			flash.type="error"
			flash.message = message(code: 'fedreg.controllers.namevalue.missing')
			redirect(action: "list")
			return
		}

 		def foreignFederation = ForeignFederation.get(params.id)


 		if (foreignFederation) {
                        optinStatus=OptinStatus.findAllWhere(foreignFederation:foreignFederation,approved:true)
                        def metadata = g.include(controller:"foreignFederation", action:"generate", id:foreignFederation.id)
			[foreignFederation: foreignFederation, contactTypes:ContactType.list(),optinStatus:optinStatus,statistics:buildStatistics(foreignFederation),metadata:metadata]
                }
		else {
			flash.type="error"
			flash.message = message(code: 'fedreg.foreignfederation.nonexistant')
			redirect(action: "list")
		}
	}
        def save = {

		def (created, foreignFederation) = foreignFederationService.create(params)

		if(created) {
			log.info "$authenticatedUser created $foreignFederation"
			redirect (action: "show", id: foreignFederation.id)
		}
		 else {
			log.info "$authenticatedUser failed to create $foreignFederation"
			flash.type="error"
			flash.message = message(code: 'fedreg.foreignfederation.nonexistant')
			render (view:'create', model:[foreignFederation:foreignFederation])
		}
	}

        def metadata ={
               def foreignFed=ForeignFederation.get(params.id)
               def md =currentPublishedMetadata(true,true,foreignFed)
               render template:"/templates/foreignFederation/metadata", contextPath: pluginContextPath, model:[md:md], contentType: "text/plain"
        }

        def generate ={
               def foreignFed=ForeignFederation.get(params.id)
               def xml =currentPublishedMetadata(true,true,foreignFed)
               render(text:"${xml}", contentType:"text/xml", encoding:"UTF-8")
        }

        def edit = {
		if(!params.id) {
			log.warn "Foreign Federation ID was not present"
			flash.type="error"
			flash.message = message(code: 'fedreg.controllers.namevalue.missing')
			redirect(action: "list")
			return
		}

		def foreignFederation = ForeignFederation.get(params.id)
		if (!foreignFederation) {
			flash.type="error"
			flash.message = message(code: 'fedreg.foreignfederation.nonexistant')
			redirect(action: "list")
			return
		}

		if(SecurityUtils.subject.isPermitted("foreignFederation:${foreignFederation.id}:update")) {
			[foreignFederation: foreignFederation]
		}
		else {
			log.warn("Attempt to edit $foreignFederation by $authenticatedUser was denied, incorrect permission set")
			response.sendError(403)
		}
        }

        def update = {
		if(!params.id) {
			log.warn "Foreign Federation ID was not present"
			flash.type="error"
			flash.message = message(code: 'fedreg.controllers.namevalue.missing')
			redirect(action: "list")
			return
		}

		def foreignFederation_ = ForeignFederation.get(params.id)

		if (!foreignFederation) {
			flash.type="error"
			flash.message = message(code: 'fedreg.foreignfederation.nonexistant')
			redirect(action: "list")
			return
		}
		if(SecurityUtils.subject.isPermitted("foreignFederation:${foreignFederation_.id}:foreignFederation")) {
			def (updated, foreignFederation) = foreignFederationService.update(params)
			if(updated) {
				log.info "$authenticatedUser updated $foreignFederation"
				redirect (action: "show", id: foreignFederation.id)
			}
			else {
				log.info "$authenticatedUser failed to update $foreignFederation"
				flash.type="error"
				flash.message = message(code: 'fedreg.foreignfederation.update.validation.error')
				render (view:'edit', model:[foreignFederation:foreignFederation])
			}
		}
		else {
			log.warn("Attempt to update $foreignFederation_ by $authenticatedUser was denied, incorrect permission set")
			response.sendError(403)
		}
	}

        private def currentPublishedMetadata(def optin, def ext,def foreignFed) {

		def now = new Date();
		def validUntil = now + grailsApplication.config.fedreg.metadata.current.validForDays
		def federation = grailsApplication.config.fedreg.metadata.federation
		def certificateAuthorities = CAKeyInfo.list()

		def writer = new StringWriter()
		def builder = new MarkupBuilder(writer)
		builder.doubleQuotes = true

                def optinStatus=OptinStatus.findAllWhere(foreignFederation:foreignFed,approved:true)
                 for(optin1 in optinStatus){

                        idpDescriptors=IDPSSODescriptor.findWhere(id:optin1.optInEntity.id)
                        if(idpDescriptors!=null){
                           entityList.add(idpDescriptors.entityDescriptor)
                        }else{
                           spDescriptors=SPSSODescriptor.findWhere(id:optin1.optInEntity.id)
                           if(spDescriptors!=null){
                                 entityList.add(spDescriptors.entityDescriptor)
                           }
                        }

                }

		def entitiesDescriptor = EntitiesDescriptor.findWhere(name:federation)
		entitiesDescriptor.entityDescriptors = entityList

		metadataGenerationService.entitiesDescriptor(builder, false, optin, ext, entitiesDescriptor, validUntil, certificateAuthorities)

		return writer.toString()

	}

        private Map buildStatistics(def foreignFederation) {

                def optinStatus
                def idPAndSpCount
                def optinIdpTotal
                def optinSpTotal
                def optinEntityTotal

                def approvedOptinIDPSSODescriptors
                def approvedOptinSPSSODescriptors
                def approvedOptinEntityDescriptors
                def unapprovedOptinIDPSSODescriptors
                def unapprovedOptinSPSSODescriptors
                def unapprovedOptinEntityDescriptors
                def optinIDPSSODescriptors
                def optinSPSSODescriptors
                def optinEntityDescriptors

                optinStatus=OptinStatus.findAllWhere(foreignFederation:foreignFederation)
                if(optinStatus!=null){
                    idPAndSpCount=countIdpOrSp(optinStatus)
                    optinIdpTotal=idPAndSpCount.idpCount
                    optinSpTotal =idPAndSpCount.spCount
                }else{
                    optinIdpTotal=0
                    optinSpTotal=0
                }


                optinStatus=OptinStatus.findAllWhere(foreignFederation:foreignFederation,approved:true)
                if(optinStatus!=null){
                    idPAndSpCount=countIdpOrSp(optinStatus)
                    approvedOptinIDPSSODescriptors =idPAndSpCount.idpCount
                    approvedOptinSPSSODescriptors=idPAndSpCount.spCount
                }else{
                    approvedOptinIDPSSODescriptors=0
                    approvedOptinSPSSODescriptors=0
                }

                unapprovedOptinIDPSSODescriptors=optinIdpTotal-approvedOptinIDPSSODescriptors
                unapprovedOptinSPSSODescriptors=optinSpTotal-approvedOptinSPSSODescriptors

                optinEntityTotal=optinIdpTotal+optinSpTotal
                approvedOptinEntityDescriptors= approvedOptinIDPSSODescriptors+approvedOptinSPSSODescriptors
                unapprovedOptinEntityDescriptors=unapprovedOptinIDPSSODescriptors+unapprovedOptinSPSSODescriptors


                optinEntityDescriptors=[total:optinEntityTotal,approvedOptinEntityDescriptors:approvedOptinEntityDescriptors,unapprovedOptinEntityDescriptors:unapprovedOptinEntityDescriptors]
		optinIDPSSODescriptors = [total:optinIdpTotal, approvedOptinIDPSSODescriptors:approvedOptinIDPSSODescriptors, unapprovedOptinIDPSSODescriptors:unapprovedOptinIDPSSODescriptors]
		optinSPSSODescriptors = [total:optinSpTotal,approvedOptinSPSSODescriptors:approvedOptinSPSSODescriptors, unapprovedOptinSPSSODescriptors:unapprovedOptinSPSSODescriptors]

		[optinIDPSSODescriptors:optinIDPSSODescriptors, optinSPSSODescriptors:optinSPSSODescriptors,optinEntityDescriptors:optinEntityDescriptors]
	}

        private Map countIdpOrSp(def optinStatus){
             def idpList=[]
             def spList=[]
             for(optin in optinStatus){

                        idpDescriptors=IDPSSODescriptor.findWhere(id:optin.optInEntity.id)
                        if(idpDescriptors!=null){
                           idpList.add(idpDescriptors.entityDescriptor)
                        }else{
                           spDescriptors=SPSSODescriptor.findWhere(id:optin.optInEntity.id)
                           if(spDescriptors!=null){
                                 spList.add(spDescriptors.entityDescriptor)
                           }
                        }

                }

                [idpCount:idpList.size(),spCount:spList.size()]
         }

}
