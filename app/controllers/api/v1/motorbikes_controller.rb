class Api::V1::MotorbikesController < ApplicationController
  # before_action :logged_in

  def index
    motorbikes = Motorbike.all.order(created_at: :desc)
    if motorbikes
      render json: motorbikes, include: [:reservations]
    else
      render json: { error: 'There is no motorbikes' }
    end
  end

  def show
    motorbike = Motorbike.find_by_id(params[:id])
    if motorbike
      render json: motorbike, include: [:reservations]
    else
      render json: { error: 'Unable to find motorbike' }
    end
  end

  def create
    motorbike = Motorbike.new(motorbike_params)
    if motorbike.save
      render json: { message: 'Motorbike created successfully' }
    else
      render json: { message: 'Error creating motorbike', errors: motorbike.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def destroy
    motorbike = Motorbike.find_by_id(params[:id])
    if motorbike.destroy
      render json: { message: 'Motorbike deleted successfully' }
    else
      render json: { error: 'Error deleting motorbike' }
    end
  end

  def update
    motorbike = Motorbike.find_by_id(params[:id])
    if motorbike.update(reserved_params)
      render json: { message: 'Motorbike updated successfully' }
    else
      render json: { error: 'Error updating motorbike' }
    end
  end
end
