 require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/classrooms", type: :request do
  
  # Classroom. As you add validations to Classroom, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    { name: "valid name" }
  }

  let(:invalid_attributes) {
    { name: nil }
  }

  let(:user) { User.create(email: "user@test.com",
                        password: "test_pass",
                        password_confirmation: "test_pass")
  }

  before(:each) do
    sign_in user
  end

  describe "GET /index" do
    it "renders a successful response" do
      Classroom.create! valid_attributes
      get classrooms_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      classroom = Classroom.create! valid_attributes
      get classroom_url(classroom)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_classroom_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      classroom = Classroom.create! valid_attributes
      get edit_classroom_url(classroom)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Classroom" do
        expect {
          post classrooms_url, params: { classroom: valid_attributes }
        }.to change(Classroom, :count).by(1)
      end

      it "redirects to the created classroom" do
        post classrooms_url, params: { classroom: valid_attributes }
        expect(response).to redirect_to(classroom_url(Classroom.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Classroom" do
        expect {
          post classrooms_url, params: { classroom: invalid_attributes }
        }.to change(Classroom, :count).by(0)
      end

      it "renders a response with 422 status - unporcessable entity" do
        post classrooms_url, params: { classroom: invalid_attributes }
        expect(response.status).to eq(422)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        { name: "new valid name" }
      }

      it "updates the requested classroom" do
        classroom = Classroom.create! valid_attributes
        patch classroom_url(classroom), params: { classroom: new_attributes }
        classroom.reload
        expect(classroom.name).to eq(new_attributes[:name])
      end

      it "redirects to the classroom" do
        classroom = Classroom.create! valid_attributes
        patch classroom_url(classroom), params: { classroom: new_attributes }
        classroom.reload
        expect(response).to redirect_to(classroom_url(classroom))
      end
    end

    context "with invalid parameters" do
      it "renders a response with 422 status - unporcessable entity" do
        classroom = Classroom.create! valid_attributes
        patch classroom_url(classroom), params: { classroom: invalid_attributes }
        expect(response.status).to eq(422)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested classroom" do
      classroom = Classroom.create! valid_attributes
      expect {
        delete classroom_url(classroom)
      }.to change(Classroom, :count).by(-1)
    end

    it "redirects to the classrooms list" do
      classroom = Classroom.create! valid_attributes
      delete classroom_url(classroom)
      expect(response).to redirect_to(classrooms_url)
    end
  end
end
