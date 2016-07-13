class AddReportcountToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :report_count, :integer, default: 0
  end
end
