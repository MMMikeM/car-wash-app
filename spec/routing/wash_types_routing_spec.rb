require "rails_helper"

RSpec.describe WashTypesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/wash_types").to route_to("wash_types#index")
    end

    it "routes to #new" do
      expect(get: "/wash_types/new").to route_to("wash_types#new")
    end

    it "routes to #show" do
      expect(get: "/wash_types/1").to route_to("wash_types#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/wash_types/1/edit").to route_to("wash_types#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/wash_types").to route_to("wash_types#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/wash_types/1").to route_to("wash_types#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/wash_types/1").to route_to("wash_types#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/wash_types/1").to route_to("wash_types#destroy", id: "1")
    end
  end
end
