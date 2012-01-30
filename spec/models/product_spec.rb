require 'spec_helper'

describe Product do

  it "is valid with valid attributes" do
    ok = %w{ fred.gif fred.jpg fred.png FRED.JPG fred.Jpg http://a.b.c/x/y/z/fred.gif }
    ok.each do |name|
      product = Product.new(:title => 'foo', :description => 'dsadas', :image_url => name, :price => 1)
      product.should be_valid
    end
  end
  
  it "is not valid without a title" do
    product = Product.new :title => nil
    product.should_not be_valid
  end
  
  it "is not valid without a description" do
    product = Product.new :description => nil, :title => 'foo'
    product.should_not be_valid
  end
  
  it "is not valid without a image url" do
    product = Product.new :image_url => nil, :title => 'foo', :description => 'foo'
    product.should_not be_valid
  end
  
  it "is not valid with an image that is not jpg, png or gif" do
    product = Product.new :image_url => nil, :title => 'foo', :description => 'foo'
    product.should_not be_valid
  end
  
  it "is not valid with a price less than 0" do
    bad = %w{ fred.doc fred.gif/more fred.gif.more }
    bad.each do |name|
      product = Product.new :title => 'foo', :description => 'dsadas', :image_url => name, :price => 1
      product.should_not be_valid
    end
  end
  
  it "is not valid with a price less than 0" do
    product = Product.new :title => 'foo', :description => 'dsadas', :image_url => 'img.jpg', :price => 0
    product.should_not be_valid
  end
  
  it "is not valid with a price less than 0" do
    product = Product.new :image_url => 'foo.jpg', :title => 'foo', :description => 'foo', :price => -1
    product.should_not be_valid
  end
  
  it "is not valid without an unique title" do
    product = Product.create(:title => 'foo', :description => 'dsadas', :image_url => 'img.jpg', :price => 1)
    product_2 = Product.new(:title => 'foo', :description => 'd', :image_url => 'img2.jpg', :price => 1)
    product_2.should_not be_valid
  end
end