package tuakiri.fr.ffoi
import fedreg.core.*
class OptinStatus {
    
    ForeignFederation foreignFederation
    boolean applied
    boolean approved
    RoleDescriptor optInEntity

    static constraints = {
        foreignFederation (nullable:false)
        applied (nullable:false)
        approved (nullable:false)
        optInEntity (nullable :false)
    }
      static mapping = {
                              foreignFederation cascade:'save-update'
                              optInEntity cascade:'save-update'
      }
}
