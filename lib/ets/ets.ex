defmodule Ets.Ets do
    def create_table(table_name) do
      :ets.new(table_name, [:set, :public, :named_table])
    end
  
    def insert(table_name, key, value) do
      :ets.insert(table_name, {key, value})
    end
  
    def look_up(table_name, key) do
      :ets.lookup(table_name, key)
    end
  end