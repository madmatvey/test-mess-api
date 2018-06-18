# spec/requests/chats_spec.rb
require 'rails_helper'

describe "Chats API" do
  it 'can register user with nickname and device ID' do

    get '/chats.json', params: {nickname: "testuser1"}, headers: { 'Authorization' => '12345678901234567890123456789012' }

    expect(response).to be_successful

    expect(json).to eq("chats"=>[], "users"=>[{"id"=>1, "nickname"=>"testuser1"}], "current_user"=>{"id"=>1, "nickname"=>"testuser1"})
  end

  it 'send new users device ID and get respose to add nickname' do
    get '/chats.json', params: {}, headers: { 'Authorization' => '12345678901234567890123456789012' }
    expect(response.body).to eq("{\"success\":false,\"errors\":\"Need user nickname at params\"}")
  end

  # it 'cant auth without device id' do
  #
  #   get '/chats.json', params: {nickname: "testuser1"}
  #   expect(object).to receive(:save).and_raise("Failure/Error: request.headers.fetch('Authorization')") # expect(response).to_not be_success
  # end

  it 'can auth another user' do
    get '/chats.json', params: {nickname: "testuser2"}, headers: { 'Authorization' => '12345678901234567890123456789021' }

    expect(response).to be_successful

    expect(json).to eq("chats"=>[], "users"=>[{"id"=>2, "nickname"=>"testuser2"}], "current_user"=>{"id"=>2, "nickname"=>"testuser2"})
  end

  it 'user1 can send to user 2 message with starting chat' do
    get '/chats.json', params: {nickname: "testuser1"}, headers: { 'Authorization' => '12345678901234567890123456789012' }
    expect(response).to be_successful
    get '/chats.json', params: {nickname: "testuser2"}, headers: { 'Authorization' => '12345678901234567890123456789021' }
    post '/chats.json', params: {recipient_id: 3, message: 'Hi, there!'}, headers: {  'Authorization' => '12345678901234567890123456789012' }

    expect(json['chat']['id']).to eq(1)
  end
end
