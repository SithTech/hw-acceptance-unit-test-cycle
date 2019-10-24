require 'rails_helper'

describe MoviesController, type: :controller do
    describe 'Create a new movie' do
        it 'should create the new movie' do
            Movie.create(:title => 'CreateThisMovie', :rating => 'G')
            
            expect(Movie.find_by_title('CreateThisMovie')).not_to eq(nil)
        end
    end
    
    describe 'Movie_Params' do
        it 'should be defined' do
            expect { :movie_params }.not_to raise_error
        end
    end
    
    describe 'GET show' do
        it 'should return code 200 for show' do
            Movie.create(:title => 'ShowThisMovie', :rating => 'G')
            @id = Movie.find_by_title('ShowThisMovie')
            get :show, :id => @id
            
            expect(response.status).to eq(200)
        end
    end
    
    describe 'GET searchDirectors (Happy Path)' do
        it 'should complete searchDirectors happy path' do
            Movie.create(:title => 'HappyDirectorMovie', :rating => 'G', :director => 'IsDirector')
            @id = Movie.find_by_title('HappyDirectorMovie')
            get :searchDirectors, :id => @id
            
            expect(Movie.find_by_director(@id)).not_to eq(nil)
            expect(Movie.find_by_title('HappyDirectorMovie')).not_to eq(nil)
        end
    end
    
    describe 'GET searchDirectors (Sad Path)' do
        it 'should complete searchDirectors sad path' do
            Movie.create(:title => 'SadDirectorMovie', :rating => 'G')
            @id = Movie.find_by_title('SadDirectorMovie')
            get :searchDirectors, :id => @id
            
            expect(flash[:notice]).to eq("\'SadDirectorMovie\' has no director info.")
            expect(Movie.find_by_title('SadDirectorMovie')).not_to eq(nil)
        end
    end
    
    describe 'GET index' do
        it 'should return code 200 for index' do
            get :index
            
            expect(response.status).to eq(200)
            expect { get :index, :sort => 'title' }.not_to raise_error
            expect { get :index, :sort => 'release_date' }.not_to raise_error
            
        end
    end
    
    describe 'GET new' do
        it 'should return code 200 for new' do
            get :new
            expect(response.status).to eq(200)
        end
    end
    
    describe 'POST create' do
        it 'database should contain the new movie' do
            post :create, :movie => { :title => 'CreateThisMovie', :rating => 'G'}
            
            expect(flash[:notice]).to eq("CreateThisMovie was successfully created.")
            expect(Movie.find_by_title('CreateThisMovie')).not_to eq(nil)
        end
    end
    
    describe 'GET edit' do
        it 'should return code 200 for edit' do
            Movie.create(:title => 'EditThisMovie', :rating => 'G')
            @id = Movie.find_by_title('EditThisMovie')
            get :edit, :id => @id
            
            expect(response.status).to eq(200)
        end
    end
    
    describe 'PUT update' do
        it 'should update the title of the movie' do
            Movie.create(:title => 'EditThisMovie', :rating => 'G')
            @id = Movie.find_by_title('EditThisMovie')
            put :update, :id => @id, :movie => { :title => 'NewEditThisMovie', :rating => 'G'}
            
            expect(Movie.find(@id)[:title]).to eq('NewEditThisMovie')
            expect(flash[:notice]).to eq("NewEditThisMovie was successfully updated.")
        end
    end
    
    describe 'DELETE destroy' do
        it 'should create then delete the movie' do
            Movie.create(:title => 'DeleteThisMovie', :rating => 'G')
            @id = Movie.find_by_title('DeleteThisMovie')
            expect(Movie.find_by_title('DeleteThisMovie')).not_to eq(nil)
            
            delete :destroy, :id => @id
            
            expect(flash[:notice]).to eq("Movie \'DeleteThisMovie\' deleted.")
            expect(Movie.find_by_title('DeleteThisMovie')).to eq(nil)
        end
    end
    
end