package tuakiri.fr.ffoi
import fedreg.core.*

/**
 * Domain class for maintaining foreign federation opt-in details
 *
 * @author ShivShankar Rajasekaran & Abhinav R.Chopra
 * Plugin developed for Summer of eResearch(SoeR) 2011-12, New Zealand
 */

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
