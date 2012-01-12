package tuakiri.fr.ffoi

class ForeignFederationController {
    def list={
        //[foreignFederationList: ForeignFederation.findAllWhere(approved:true), foreignFederationTotal: ForeignFederation.count()]
        render (view:"list")
    }
//    def list = {
//		[foreignFederationList: ForeignFederation.findAllWhere(approved:true), foreignFederationTotal: ForeignFederation.count()]
//    }
}
