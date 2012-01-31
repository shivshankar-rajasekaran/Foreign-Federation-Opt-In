// Script definition

import grails.plugins.nimble.core.*
import fedreg.core.*
import tuakiri.fr.ffoi.*

workflowTaskService = ctx.getBean('workflowTaskService')
mailService = ctx.getBean('mailService')
invitationService = ctx.getBean('invitationService')
roleService = ctx.getBean('roleService')
permissionService = ctx.getBean('permissionService')
messageSource = ctx.getBean('messageSource')

def optinStat = OptinStatus.get(env.optinStatus.toLong())

if(optinStat) {

  log.info 'Activating optin to $optinStat.foreignFederation.displayName Workflow indicates it is valid and accepted for operation.'
  
  optinStat.approved = true
  optinStat.save()
  
  workflowTaskService.complete(env.taskInstanceID.toLong(), 'optinactivated')
}
else {
  throw new RuntimeException('Attempt to process activate in script optin_activate. Failed because referenced SP does not exist')
}

