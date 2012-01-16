package tuakiri.fr.ffoi

import fedreg.core.ContactPerson
import fedreg.core.UrlURI
class ForeignFederation {
    String name
    String displayName
    String description
    UrlURI websiteURL
    UrlURI metadataURL
    UrlURI registrationInfo
    String metadataName
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

                              registrationInfo(nullable:true, blank:true, url: true)

                              dateCreated(nullable:true)

                              lastUpdated(nullable:true)

                              websiteURL(nullable:false, blank:false, url: true)

                              metadataURL(nullable:false, blank:false, url: true)
                              metadataName(nullable:true, blank:true)
    }
    public String toString() {	"foreignFederation:[name: $name, displayName: $displayName]" }

    static mapping = {

                              autoImport false
                              sort "name"

    }
}
