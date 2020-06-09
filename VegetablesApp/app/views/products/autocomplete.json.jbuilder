json.products do
  json.array!(@products) do |p|
    json.name p.name
    json.url product_path(p)
  end
end