
class StatController < ApplicationController
  def index
    @end_at = 100
    @start_at = 0
    @categories = [-3.0,-2.5,-2.0,-1.5,-1.0,-0.5,0.0,0.5,1.0,1.5,2.0,2.5,3.0]
    @data2 = []
    Pitching.where('pitcher_id = 506433').each do |p|
      x = p.px
      y = p.pz
      # @categories << x
      @data2 << [x,y]
      @name = p.pitcher.name_display_first_last
    end
    @data = [[-1.017,2.778],[-0.792,3.72],[1.169,0.598],[-1.455,2.2]]
    @hight = 0.upto(100).to_a
    @h = LazyHighCharts::HighChart.new("scatter") do |f|
      f.chart(
        width: 300,
        # rect: [150,100,100,0],
        # marginTop: 50,
        # marginBottom: 60,
        # marginLeft: 300,
        # marginRight: 300,
        :type => "scatter"
        )
      f.title(:text => @name)
      f.xAxis(
        # :plotLines => {
        #   color: '#FF0000',
        #   width: 2,
        #   value: 5.5
        # },
        tickmarkPlacement: 'on',
        max: 3,
        min: -3
        # :tickInterval => 0.2,
        # :gridLineWidth => 1
        )

      f.yAxis(
        gridLineWidth: 0,
        max: 5,
        min: 0,
        # :tickInterval => 0.5,
        :tickPosition => 'inside')
      f.series(:name => "sample",
               :data => @data2)
    end
  end
end
