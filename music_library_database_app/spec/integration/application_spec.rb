require "spec_helper"
require "rack/test"
require_relative "../../app"

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  context "GET /albums" do
    it "returns list of albums in the database" do
      response = get("/albums")

      expect(response.status).to eq(200)
      expect(response.body).to include("Baltimore")
    end

    xit "contains a link for each album listed" do
      response = get("/albums")

      expect(response.status).to eq(200)
      expect(response.body).to include(
        "<a href='/albums/2'>
          <Surfer Rosa>
        </a><br />")
    end
  end

  context "GET /albums/:id" do
    it "returns info about ablum 2" do
      response = get("/albums/2")

      expect(response.status).to eq(200)
      expect(response.body).to include("<h1>Surfer Rosa</h1>")
      expect(response.body).to include("Artist: Pixies")
      expect(response.body).to include("Release year: 1988")
      expect(response.body).to include("Genre: Rock")
    end
  end

  context "GET /albums/new" do
    it "returns a form for adding new albums" do
      response = get("/albums/new")

      expect(response.status).to eq(200)
      expect(response.body).to include("<h1>Add an Album!</h1>")
      expect(response.body).to include("<form action='/posts' method='POST'>")
      expect(response.body).to include("<input type='text' name='title'>")
      expect(response.body).to include("<input type='text' name='release_year'>")
      expect(response.body).to include("<input type='text' name='artist_id'>")
    end
  end

  context "POST /albums" do
    it "adds user inputed album to the database andreturns success page" do
      response = post("/albums", title: "Voyage", 
        release_year: "2022", 
        artist_id: "2")

      expect(response.status).to eq(200)
      expect(response.body).to eq("<h1>Your Album has been added!</h1>")

      response = get("/albums")

      expect(response.body).to include("Voyage")
    end
  end

  context "GET /artists" do
    it "returns list of artists in the database" do
      response = get("/artists")

      expected_response = "Pixies, ABBA, Taylor Swift, Nina Simone, Kiasmos"

      expect(response.status).to eq(200)
      expect(response.body).to eq(expected_response)
    end
  end

  context "POST /artists" do
    xit "adds user inputed album to the database" do
      response = post("/artists")

      expect(response.status).to eq(200)
      expect(response.body).to eq("")

      response = get("/artists")
      expect(response.body).to include("ABBA")
    end
  end
end
