class ShiftsController < ApplicationController
  def index
    @shifts = current_user.organization.shifts.order(:start).reverse
    @shift  = ShiftForm.new
  end

  def create
    @shift = ShiftForm.new(shift_params)
    if @shift.save
      redirect_to shifts_path
    end
  end

  def edit
    @shift = ShiftForm.new(shift: shift)
  end

  def update
    @shift = ShiftForm.new(shift_params.merge(shift: shift))
    if @shift.update
      redirect_to shifts_path
    else
      render :edit
    end
  end

  def destroy
    if shift.destroy
      redirect_to shifts_path
    end
  end

  private

  def shift_params
    params.require(:shift)
      .permit(:shift_date, :start, :finish, :break_length)
      .merge(user_id: current_user.id)
  end 

  def shift
    Shift.find(params[:id])
  end
end
