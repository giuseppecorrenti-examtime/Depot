class LineItemsController < ApplicationController
  # GET /line_items
  # GET /line_items.json
  def index
    @line_items = LineItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @line_items }
    end
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
    @line_item = LineItem.find(params[:product_id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @line_item }
    end
  end

  # GET /line_items/new
  # GET /line_items/new.json
  def new
    @line_item = LineItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @line_item }
    end
  end

  # GET /line_items/1/edit
  def edit
    @line_item = LineItem.find(params[:id])
    render :layout => false
  end

  # POST /line_items
  # POST /line_items.json
  def create
    puts "===================================   " + params[:product_id]
    @cart = current_cart
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product.id)
    @line_item.save
    reset_session_counter
    render :nothing => true
    
    # @line_item = LineItem.new(params[:line_item])
    # Not using respond_to because we are using Ajax to add items to the cart 
    
    # respond_to do |format|
      # if @line_item.save
        # format.html { redirect_to @line_item.cart, notice: 'Line item was successfully created.' }
        # format.json { render json: @line_item, status: :created, location: @line_item }
      # else
        # format.html { render action: "new" }
        # format.json { render json: @line_item.errors, status: :unprocessable_entity }
      # end
    #end
    
  end

  # PUT /line_items/1
  # PUT /line_items/1.json
  def update
    @line_item = LineItem.find(params[:id])

    respond_to do |format|
      if @line_item.update_attributes(params[:line_item])
        format.html { redirect_to @line_item, notice: 'Line item was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    @line_item = LineItem.find(params[:id])
    @line_item.destroy
    json = @line_item.id
    render :json => json
  end
end
