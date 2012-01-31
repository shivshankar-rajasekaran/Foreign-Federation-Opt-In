process(name:'optin_create1', description: 'Workflow defining creation and approval of Opt in of an entity into a Foreign federation  process') {
  
  task(name: 'Send confirmation message', description: 'Invokes a script to confirm optin of entity.') {
    execute(script: 'optin_confirm')
    outcome(name: 'confirmedoptin', description:'User registering the entity for optin has been advised of creation') {
      start ('Check for valid approvers')
    }
  }
  
  task(name: 'Check for valid approvers', description: 'Ensures that organization-{organization}-administrators is a') {
    execute(script: 'organization_administrators_populated')
    outcome(name: 'organization_hasadministrators', description:'The Organization has administrators and they will be asked to approve.') {
      start ('Request organization approval')
    }
    outcome(name: 'organization_noadministrators', description:'The Organization has no locally registered administrators.') {
      start ('Request executive federation approval')
    }
  }
  
  task(name: 'Request organization approval', description: 'Requests that a user who is an administrative member') {
    approver(role: 'organization-{organization}-administrators') {
      reject(name: 'Not Associated', description:'Not an Entity associated with this organization') {
        start ('Delete Opted-in Entity entry')
      }
      reject(name: 'Not Accepted', description:'The organization will not let this entity to Optin (Optin Approval denied)') {
        start ('Delete Opted-in Entity entry')
      }
    }
    outcome(name: 'optinapproved', description:'The organization has accepted responsibility for this entity optin') {
      start ('Request Federation approval')
    }
  }
  
  task(name: 'Request Federation approval', description: 'Requests that a user who is an administrative member of the federation') {
    approver(role: 'federation-administrators') {
      reject(name: 'Not Accepted', description:'The federation will not accept ownership for this optin (Optin Approval denied)') {
        start ('Delete Opted-in Entity entry')
      }
    }
    outcome(name: 'federationapproved', description:'The organization has accepted responsibility for this optin of entity') {
      start ('Activate optin')
    }
  }
  
  task(name: 'Request executive federation approval', description: 'Requests that a user who is an administrative member of the federation approves') {
    approver(role: 'federation-administrators') {
      reject(name: 'Not Accepted', description:'The federation will not accept ownership for this optin (Optin Approval denied)') {
        start ('Delete Opted-in Entity entry')
      }
      reject(name: 'Organization Not Accepted', description:'The organization will not let this entity to Optin (Optin Approval denied).') {
        start ('Delete Opted-in Entity entry')
      }
    }
    outcome(name: 'executivelyapproved', description:'The organization and federation combined have accepted responsibility for this entity to Optin') {
      start ('Activate optin')
    }
  }
  
  task(name: 'Activate optin', description: 'Activates the optin for the entity so it can be rendered into Metadata for foreign federation.') {
    execute(script: 'optin_activate')
    outcome(name: 'optinactivated', description:'The Entity is now active and being populated into Metadata for foreign federation.') {
      start ('finish')
    }
  }
  
  task(name: 'Delete Opted-in Entity entry', description: 'Deletes the optin entry of the entity after it has been rejected.') {
    execute(script: 'optin_delete')
    outcome(name: 'optindetailsdeleted', description:'The optin entry of the entity  has been deleted') {
      start ('finish')
    }
  }
  task(name: 'finish', description: 'Completes the optin_create workflow') {
    finish()
  }
  
}