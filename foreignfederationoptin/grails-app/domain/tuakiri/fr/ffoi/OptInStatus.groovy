package tuakiri.fr.ffoi
import fedreg.core.*
class OptinStatus {
    
    ForeignFederation foreignFederation
    boolean applied
    boolean approved
    RoleDescriptor optInEntity
    String optinEntityType

    static constraints = {
        foreignFederation (nullable:false)
        applied (nullable:false)
        approved (nullable:false)
        optInEntity (nullable :false)
        optinEntityType(nullable :false,blank:false)
    }
      static mapping = {
                              foreignFederation cascade:'save-update'
                              optInEntity cascade:'save-update'
      }
}
