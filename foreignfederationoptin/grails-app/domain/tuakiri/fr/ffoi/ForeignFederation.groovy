package tuakiri.fr.ffoi
import fedreg.core.*
class ForeignFederation {
    String name
    String displayName
    String description
    URlURI websiteURL
    URlURI metadataURL
    String metadataName

    //static hasMany = [contacts: ContactPerson]

    static constraints = {
                              name(nullable: false,blank:false,unique :true)

                              displayName(nullable: false, blank:false)

                              description(nullable: true, blank:true)

                              contacts(nullable: true)

                              extensions(nullable: true)

                              registrationInfo(nullable:false)

                              dateCreated(nullable:false,blank:false)

                              dateUpdated(nullable:false,blank:false)

                              websiteURL(nullable:false)

                              metaDataURL(nullable:false)
    }

}
