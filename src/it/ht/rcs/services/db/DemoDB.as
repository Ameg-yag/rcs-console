package it.ht.rcs.services.db
{
  import mx.collections.ArrayCollection;
  import mx.rpc.events.ResultEvent;
  import it.ht.rcs.console.model.User;
  
  public class DemoDB implements IDB
  {
    
    private var demo_user:Object = {_id: '1', name: 'demo', contact:'demo@hackingteam.it', privs:new ArrayCollection(['ADMIN', 'TECH', 'VIEW']), locale:'en_US', group_ids:new ArrayCollection(['1']), timezone:0, enabled:true};

    public function DemoDB()
    {
      
    }
    
    public function login(params:Object, onResult:Function, onFault:Function):void
    {
      var result:Object = {cookie: 0, time: 0, user: demo_user};
      var event:ResultEvent = new ResultEvent("login", false, true, result);
      onResult(event);
    }
    
    public function logout():void
    {
      
    }
    
    public function user_index(onResult:Function = null, onFault:Function = null):void
    {
      var items:ArrayCollection = new ArrayCollection();
      items.addItem(demo_user);
      items.addItem({_id: '2', name: 'alor', locale:'en_US', group_ids:new ArrayCollection(['1','2']), enabled:true, privs:new ArrayCollection(['ADMIN', 'TECH', 'VIEW'])});
      items.addItem({_id: '3', name: 'daniel', locale:'it_IT', group_ids:new ArrayCollection(['1','2']), enabled:true, privs:new ArrayCollection(['ADMIN', 'TECH', 'VIEW'])});
      items.addItem({_id: '4', name: 'naga', group_ids:new ArrayCollection(['2']), enabled:true, privs:new ArrayCollection(['VIEW'])});
      items.addItem({_id: '5', name: 'que', group_ids:new ArrayCollection(['2']), enabled:false});
      items.addItem({_id: '6', name: 'zeno', group_ids:new ArrayCollection(['2']), enabled:true, privs:new ArrayCollection(['TECH', 'VIEW'])});
      items.addItem({_id: '7', name: 'rev', group_ids:new ArrayCollection(['2']), enabled:false});
      items.addItem({_id: '8', name: 'kiodo', group_ids:new ArrayCollection(['2']), enabled:false});
      items.addItem({_id: '9', name: 'fabio', group_ids:new ArrayCollection(['2']), enabled:false});
      items.addItem({_id: '10', name: 'br1', group_ids:new ArrayCollection(['3']), enabled:false});
      var event:ResultEvent = new ResultEvent("user.index", false, true, items);
      onResult(event);
    }
    
    public function user_create(params:Object, onResult:Function = null, onFault:Function = null):void
    {
      params._id = new Date().getTime().toString();
      params.privs = new ArrayCollection(params.privs);
      params.group_ids = new ArrayCollection(params.group_ids);
      var event:ResultEvent = new ResultEvent("user.create", false, true, params);
      onResult(event);
    }
    
    public function group_index(onResult:Function = null, onFault:Function = null):void
    {
      var items:ArrayCollection = new ArrayCollection();
      items.addItem({_id: '1', name: 'demo', user_ids:new ArrayCollection(['1','2','3'])});
      items.addItem({_id: '2', name: 'developers', user_ids:new ArrayCollection(['2','3','4','5','6','7','8','9'])});
      items.addItem({_id: '3', name: 'test', user_ids:new ArrayCollection(['10'])});
      var event:ResultEvent = new ResultEvent("group.index", false, true, items);
      onResult(event);
    }
  }
}
