class SpacesController < ApplicationController

  def index
    @spaces = policy_scope(Space).order(created_at: :desc)
    @markers = @spaces.geocoded.map do |space|
      {
        lat: space.latitude,
        lng: space.longitude
      }
    end
  end

  def show
    @space = Space.find(params[:id])
  end

  def new
    @space = Space.new
    authorize @space
  end

  def create
    @space = Space.new(space_params)
    authorize @space
    @space.user = current_user
    if @space.save
      flash[:notice] = 'space added!'
      redirect_to space_path(@space)
    else
      render :new
    end
  end

  def edit
    @space = Space.find(params[:id])
  end

  def update
    @space = Space.find(params[:id])
    @space.update(space_params)
    redirect_to space_path(@space)
  end

  def destroy
    @space = Space.find(params[:id])
    @space.destroy
    redirect_to spaces_path
  end

  def space_params
    params.require(:space).permit(:location, :volume, :condition, :access, :price_per_month, :user, :description, :image)
  end
end
