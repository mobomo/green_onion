#!/usr/bin/env ruby
require 'sinatra'

class SampleApp < Sinatra::Base
  set :root, File.dirname(__FILE__)
  set :static, true
  set :logging, false

  get '/' do
    "<div style='height:200px; width:200px; background-color:rgb(#{rand(266)}, #{rand(266)}, #{rand(266)})'><!-- Big blue box --></div>"
  end

  get "/fake_uri" do
    "<h2>foo</h2>"
  end

  get "/onion_face" do
    "<img src='onion_face_#{rand(2)}.jpg' />"
  end

end