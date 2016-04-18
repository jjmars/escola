class GuardiansController < ApplicationController
  before_action :set_guardian, only: [:show, :edit, :update, :destroy]

  # GET /guardians
  # GET /guardians.json
  def index
    @guardians = current_unit ? current_unit.guardians : current_school.guardians
  end

  # GET /guardians/1
  # GET /guardians/1.json
  def show
  end

  # GET /guardians/new
  def new
    @guardian = Guardian.new
  end

  # GET /guardians/1/edit
  def edit
  end

  # POST /guardians
  # POST /guardians.json
  def create
    @guardian = Guardian.new(guardian_params)
    @guardian.school = current_school

    respond_to do |format|
      if @guardian.save
        format.html { redirect_to @guardian, notice: 'Guardian was successfully created.' }
        format.json { render :show, status: :created, location: @guardian }
      else
        format.html { render :new }
        format.json { render json: @guardian.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /guardians/1
  # PATCH/PUT /guardians/1.json
  def update
    respond_to do |format|
      if @guardian.update(guardian_params)
        format.html { redirect_to @guardian, notice: 'Guardian was successfully updated.' }
        format.json { render :show, status: :ok, location: @guardian }
      else
        format.html { render :edit }
        format.json { render json: @guardian.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /guardians/1
  # DELETE /guardians/1.json
  def destroy
    @guardian.destroy
    respond_to do |format|
      format.html { redirect_to guardians_url, notice: 'Guardian was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    
    def set_guardian
      @guardian = Guardian.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def guardian_params
      params.require(:guardian).permit(:name, :cpf, :phone, :email, :address)
    end
end
