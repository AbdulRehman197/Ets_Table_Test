defmodule Ets.MySupervisor do
    # Automatically defines child_spec/1
    use Supervisor
  
    def start_link(init_arg) do
        name =  Utils.random_string()
      Supervisor.start_link(__MODULE__, init_arg, name: :"SUP_#{name}")
    end
  
    @impl true
    def init(init_arg) do
        child_worker_count = Keyword.get(init_arg, :child_worker_count)
      children =
      Enum.map(1..child_worker_count, fn count ->
        %{id: "Ets.Worker_#{count}", start: {Ets.Worker, :start_link, [[]]}}
       
      end)
     
      Supervisor.init(children, strategy: :one_for_one)
    end
  end