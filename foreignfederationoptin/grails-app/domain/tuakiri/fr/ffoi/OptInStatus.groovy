package tuakiri.fr.ffoi
import fedreg.core.*
class OptInStatus {
    
    ForeignFederation foreignFederation
    boolean applied
    boolean approved
    EntityDescriptor optInEntity

    static constraints = {
        foreignFederation (nullable:false)
        applied (nullable:false)
        approved (nullable:false)
        optInEntity (nullable :false)
    }
}
