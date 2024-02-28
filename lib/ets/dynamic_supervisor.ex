defmodule Ets.MyDynamicSupervisor do
    use DynamicSupervisor
  
    def start_link(init_arg) do
      DynamicSupervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
      start_multiple(4,4)
    end
    def start_child(child_worker_count)  do
       
      # If MyWorker is not using the new child specs, we need to pass a map:
      # spec = %{id: MyWorker, start: {MyWorker, :start_link, [foo, bar, baz]}}
      spec = {Ets.MySupervisor, child_worker_count: child_worker_count}
      DynamicSupervisor.start_child(__MODULE__, spec)
    
    end
  
    
    def start_multiple(child_sup_count, child_worker_count) when child_sup_count == 1, do:
    start_child(child_worker_count)
    
    def start_multiple(child_sup_count, child_worker_count) when child_sup_count > 0 do
     start_child(child_worker_count)
     start_multiple(child_sup_count - 1, child_worker_count)
    end
    @impl true
    def init(_init_arg) do
      DynamicSupervisor.init(
        strategy: :one_for_one
      )
    end

   
  end