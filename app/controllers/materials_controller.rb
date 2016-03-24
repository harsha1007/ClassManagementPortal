class MaterialsController < ApplicationController
  
  # GET /materials
  # GET /materials.json
  def index
    @materials = Material.all
  end

  # GET /materials/1
  # GET /materials/1.json
  def show
    @materials = Material.find_by_sql("select * from materials where course_id = #{params[:id]}")
    @course = params[:id]
    return @materials, @course
  end

  # GET /materials/new
  def new
    @course_id = params[:course_id]
    @material = Material.new
    return @course_id, @material
  end

  # GET /materials/1/edit
  def edit
    @material = Material.find(params[:id])
  end

  # POST /materials
  # POST /materials.json
  def create
    @material = Material.new(material_params)
      if @material.save
        redirect_to material_path(id: material_params[:course_id]), notice: 'Material was successfully created.'
      else
        redirect_to :back, notice: 'There was an error in creating the announcement.'
    end
  end

  # PATCH/PUT /materials/1
  # PATCH/PUT /materials/1.json
  def update
    @material = Material.find(params[:id])
    respond_to do |format|
      if @material.update(material_params)
        format.html { redirect_to @material, notice: 'Material was successfully updated.' }
        format.json { render :show, status: :ok, location: @material }
      else
        format.html { render :edit }
        format.json { render json: @material.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /materials/1
  # DELETE /materials/1.json
  def destroy
    @material = Material.find(params[:id])
    @material.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Material was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_material
      @material = Material.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def material_params
      params.require(:material).permit(:course_id, :information)
    end
end
