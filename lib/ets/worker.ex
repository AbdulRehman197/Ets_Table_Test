  defmodule Ets.Worker do
    alias Ets.Ets
    use GenServer
    def start_link(_args) do
      name =  Utils.random_string()
      GenServer.start_link(__MODULE__,%{}, name: :"Worker_#{name}")
    end
  
    def insert(key, value) do
      GenServer.call(__MODULE__, {:insert_data, key, value})
    end
  
    def get(key) do
      GenServer.call(__MODULE__, {:get_data, key})
    end
  
  
    def init(_args) do
      name =  Utils.random_string()
      table_name =   Ets.create_table(:"Ets_#{name}")
      Ets.insert(table_name, :key1,  Utils.random_string())
      Ets.insert(table_name, :key2,  Utils.random_string())
      {:ok, %{"table_name" => table_name}}
    end
  
    def handle_call({:insert_data, key, value}, _from, %{"table_name" => table_name} = state) do
      Ets.insert(table_name, key, value)
      {:reply, state, state}
    end
  
    def handle_call({:get_data, key}, _from, %{"table_name" => table_name} = state) do
      data = Ets.look_up(table_name, key)
      IO.inspect(data)
      {:reply, state, state}
    end
  end