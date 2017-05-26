require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

	def setup
		@default_title = 'Sample App'
	end

	test 'should get root' do
		get root_url
		assert_response :success

	end

  test "should get help" do
    get static_pages_help_url
    assert_response :success
    assert_select 'title', "Help | #{@default_title}" 
  end

  test 'should get about' do
  	get static_pages_about_url
  	assert_response :success
  	# Espera que sea un status_code 200 para que sea success
  	assert_select 'title', "About | #{@default_title}"
  
  end

  test 'should get contact' do
  	get static_pages_contact_url
  	assert_response :success
  	assert_select 'title', "Contact | #{@default_title}"
  end

end
