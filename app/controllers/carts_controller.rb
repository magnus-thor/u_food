class CartsController < ApplicationController

  before_action :find_cart

  def add
    dish = Dish.find(params[:id])
    if an_integer?(params[:amount])
      @cart.add(dish, dish.price, params[:amount].to_i)
      flash[:notice] = "#{dish.name} added to cart: #{params[:amount]}"
    else
      flash[:warning] = 'Please enter a number'
    end
    redirect_back(fallback_location: (request.referer || restaurant_path(params[:restaurant_id])))
  end


  def remove_item
    dish = Dish.find(params[:dish_id])
    if an_integer?(params[:remove_amount])
      @cart.remove(dish, params[:remove_amount].to_i)
      flash[:notice] = "#{params[:remove_amount]} #{dish.name} was removed from your cart"
    else
      flash[:warning] = 'Please enter a number'
    end
    redirect_back(fallback_location: (request.referer || restaurant_path(params[:restaurant_id])))
  end

  def clear_cart
    @cart.clear
    redirect_to restaurant_path(params[:restaurant_id])
  end

  def show
    if params[:delivery] == 'delivery'
      @shipping_cost = 5
      @total_cost = @cart.total.to_i + @shipping_cost
      @delivery_method = 'delivery'
    else
      @total_cost = @cart.total.to_i
      @delivery_method = 'pickup'
    end
    @cart = Cart.find(session[:cart_id])
    if !@cart.cart_items.empty?
      @restaurant = Restaurant.find(@cart.cart_items.last.item.menus.first.restaurant.id)
    else
      redirect_to root_path
    end
  end

  def an_integer?(item)
    /(\D+)/.match(item).nil?
  end
end
