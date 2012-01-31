// Script definition
import fedreg.core.*
import tuakiri.fr.ffoi.*

optinStatusService   = ctx.getBean("optinStatusService")
workflowTaskService = ctx.getBean("workflowTaskService")
mailService = ctx.getBean("mailService")
messageSource = ctx.getBean("messageSource")

def optinStat= OptinStatus.read(env.optinStatus.toLong())
if(optinStat) {
  
  //def creator = Contact.read(env.creator.toLong())
  //def args = new Object[1]
  //args[0] = sp.displayName
  //mailService.sendMail {            
 //   to creator.email.uri
 //   from ctx.grailsApplication.config.nimble.messaging.mail.from
//    subject messageSource.getMessage("fedreg.templates.mail.workflow.sp.rejected.subject", args, "fedreg.templates.mail.workflow.sp.rejected.subject", new Locale(env.locale))
 //   body view:"/templates/mail/workflows/default/_rejected_sp", model:[serviceProvider:sp, locale:env.locale]
 // }
  
  log.warn "Deleting optin to $optinStat.foreignFederation.displayName Workflow indicates it is invalid and no longer needed."
  

  optinStatusService.delete(optinStat.id)
  workflowTaskService.complete(env.taskInstanceID.toLong(), 'optindetailsdeleted')
}
else {
  throw new RuntimeException("Attempt to process delete in script optin_delete. Failed because referenced optin-details do not exist")
}