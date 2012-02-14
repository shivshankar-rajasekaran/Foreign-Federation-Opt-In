package tuakiri.fr.ffoi

import fedreg.core.ContactPerson
import fedreg.core.Uri
class ForeignFederation {
    String name
    String displayName
    String description
    Uri websiteURL
    Uri metadataURL
    Uri registrationInfo
    Date dateCreated
    Date lastUpdated
    boolean archived=false
    boolean active=true

    static hasMany = [contacts: ContactPerson]

    static constraints = {
                              name(nullable: false,blank:false,unique :true)

                              displayName(nullable: false, blank:false)

                              description(nullable:true, blank: false, maxSize:2000)

                              contacts(nullable: true)

                              registrationInfo(nullable:false, blank:false, url: true)

                              dateCreated(nullable:true)

                              lastUpdated(nullable:true)

                              websiteURL(nullable:false, blank:false, url: true)

                              metadataURL(nullable:false, blank:false, url: true)
    }
    public String toString() {	"foreignFederation:[name: $name, displayName: $displayName]" }

    static mapping = {
                              websiteURL cascade:'save-update'
                              metadataURL cascade: 'save-update'
                              registrationInfo cascade: 'save-update'
                              autoImport false
                              sort "name"

    }
}
