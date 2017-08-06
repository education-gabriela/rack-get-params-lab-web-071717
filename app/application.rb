class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif req.path.match(/cart/)
      print_cart(resp)
    elsif req.path.match(/add/)
      add_to_cart(req.params["item"], resp)
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def add_to_cart(item, resp)
    if @@items.include?(item)
      @@cart << item
      resp.write "added #{item}"
    else
      resp.write "We don't have that item"
    end

  end

  def print_cart(resp)
    if @@cart.empty?
      resp.write "Your cart is empty."
    else
      @@cart.each do |item|
        resp.write "#{item}\n"
      end
    end
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end
