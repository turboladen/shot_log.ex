defmodule ShotLog.CameraView do
  use ShotLog.Web, :view

  def brand_names do
    ShotLog.Brand.names
  end
end
