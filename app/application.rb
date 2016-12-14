class Application

  @@items = [Item.new("Figs",3.42),Item.new("Pears",0.99)]

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)

      item = req.path.split("/items/")[1]

      if handle_search(item)
        resp.write "#{handle_search(item)}"
      else
        resp.status = 400
        resp.write "Item not found"
      end       

    else
      resp.status = 404
      resp.write "Route not found"
    end
    resp.finish
  end

  def handle_search(search_term)
    @@items.each do |item|
      if item.name == search_term
        return item.price
      end
    end
    return false
  end
end
