{"filter":false,"title":"customer_types_controller.rb","tooltip":"/app/controllers/customer_types_controller.rb","undoManager":{"mark":54,"position":54,"stack":[[{"start":{"row":16,"column":5},"end":{"row":17,"column":0},"action":"insert","lines":["",""],"id":2},{"start":{"row":17,"column":0},"end":{"row":17,"column":2},"action":"insert","lines":["  "]}],[{"start":{"row":17,"column":2},"end":{"row":18,"column":0},"action":"insert","lines":["",""],"id":3},{"start":{"row":18,"column":0},"end":{"row":18,"column":2},"action":"insert","lines":["  "]}],[{"start":{"row":18,"column":2},"end":{"row":49,"column":2},"action":"insert","lines":["def index","    @categories = DaycareDepartment.all","    @daycare_department = DaycareDepartment.new","  end","  ","  def destroy","    @category = DaycareDepartment.find(params[\"id\"])","    @category.destroy","    flash[:success] = \"Department deleted\"","    redirect_to request.referrer","  end","  ","  ","  def update","    @category = DaycareDepartment.find(params[:id])","        ","      if @category.update_attributes(department_params)","        flash[:success] = \"Department updated\"","        redirect_to request.referrer","      else","        flash[:danger] = \"Department not updated. \" + @category.errors.full_messages.to_s","        redirect_to request.referrer","      end","      ","  end","  ","  private","","    def department_params","      params.require(:daycare_department).permit(:department_name)","    end","  "],"id":4}],[{"start":{"row":49,"column":0},"end":{"row":49,"column":2},"action":"remove","lines":["  "],"id":5}],[{"start":{"row":48,"column":7},"end":{"row":49,"column":0},"action":"remove","lines":["",""],"id":6}],[{"start":{"row":19,"column":5},"end":{"row":19,"column":15},"action":"remove","lines":["categories"],"id":7},{"start":{"row":19,"column":5},"end":{"row":19,"column":6},"action":"insert","lines":["t"]}],[{"start":{"row":19,"column":6},"end":{"row":19,"column":7},"action":"insert","lines":["y"],"id":8}],[{"start":{"row":19,"column":7},"end":{"row":19,"column":8},"action":"insert","lines":["p"],"id":9}],[{"start":{"row":19,"column":8},"end":{"row":19,"column":9},"action":"insert","lines":["e"],"id":10}],[{"start":{"row":19,"column":9},"end":{"row":19,"column":10},"action":"insert","lines":["s"],"id":11}],[{"start":{"row":20,"column":5},"end":{"row":20,"column":23},"action":"remove","lines":["daycare_department"],"id":12},{"start":{"row":20,"column":5},"end":{"row":20,"column":6},"action":"insert","lines":["t"]}],[{"start":{"row":20,"column":6},"end":{"row":20,"column":7},"action":"insert","lines":["y"],"id":13}],[{"start":{"row":20,"column":7},"end":{"row":20,"column":8},"action":"insert","lines":["p"],"id":14}],[{"start":{"row":20,"column":8},"end":{"row":20,"column":9},"action":"insert","lines":["e"],"id":15}],[{"start":{"row":19,"column":5},"end":{"row":19,"column":10},"action":"remove","lines":["types"],"id":16},{"start":{"row":19,"column":5},"end":{"row":19,"column":18},"action":"insert","lines":["customer_type"]}],[{"start":{"row":19,"column":18},"end":{"row":19,"column":19},"action":"insert","lines":["s"],"id":17}],[{"start":{"row":20,"column":5},"end":{"row":20,"column":9},"action":"remove","lines":["type"],"id":18},{"start":{"row":20,"column":5},"end":{"row":20,"column":18},"action":"insert","lines":["customer_type"]}],[{"start":{"row":19,"column":22},"end":{"row":19,"column":39},"action":"remove","lines":["DaycareDepartment"],"id":19},{"start":{"row":19,"column":22},"end":{"row":19,"column":23},"action":"insert","lines":["C"]}],[{"start":{"row":19,"column":23},"end":{"row":19,"column":24},"action":"insert","lines":["u"],"id":20}],[{"start":{"row":19,"column":22},"end":{"row":19,"column":24},"action":"remove","lines":["Cu"],"id":21},{"start":{"row":19,"column":22},"end":{"row":19,"column":34},"action":"insert","lines":["CustomerType"]}],[{"start":{"row":20,"column":21},"end":{"row":20,"column":38},"action":"remove","lines":["DaycareDepartment"],"id":22},{"start":{"row":20,"column":21},"end":{"row":20,"column":22},"action":"insert","lines":["C"]}],[{"start":{"row":20,"column":22},"end":{"row":20,"column":23},"action":"insert","lines":["u"],"id":23}],[{"start":{"row":20,"column":23},"end":{"row":20,"column":24},"action":"insert","lines":["s"],"id":24}],[{"start":{"row":20,"column":21},"end":{"row":20,"column":24},"action":"remove","lines":["Cus"],"id":25},{"start":{"row":20,"column":21},"end":{"row":20,"column":33},"action":"insert","lines":["CustomerType"]}],[{"start":{"row":24,"column":5},"end":{"row":24,"column":13},"action":"remove","lines":["category"],"id":26},{"start":{"row":24,"column":5},"end":{"row":24,"column":18},"action":"insert","lines":["customer_type"]}],[{"start":{"row":24,"column":21},"end":{"row":24,"column":38},"action":"remove","lines":["DaycareDepartment"],"id":27},{"start":{"row":24,"column":21},"end":{"row":24,"column":33},"action":"insert","lines":["CustomerType"]}],[{"start":{"row":25,"column":5},"end":{"row":25,"column":13},"action":"remove","lines":["category"],"id":28},{"start":{"row":25,"column":5},"end":{"row":25,"column":18},"action":"insert","lines":["customer_type"]}],[{"start":{"row":26,"column":23},"end":{"row":26,"column":33},"action":"remove","lines":["Department"],"id":29},{"start":{"row":26,"column":23},"end":{"row":26,"column":36},"action":"insert","lines":["Customer type"]}],[{"start":{"row":32,"column":5},"end":{"row":32,"column":13},"action":"remove","lines":["category"],"id":30},{"start":{"row":32,"column":5},"end":{"row":32,"column":18},"action":"insert","lines":["customer_type"]}],[{"start":{"row":32,"column":21},"end":{"row":32,"column":38},"action":"remove","lines":["DaycareDepartment"],"id":31},{"start":{"row":32,"column":21},"end":{"row":32,"column":22},"action":"insert","lines":["C"]}],[{"start":{"row":32,"column":22},"end":{"row":32,"column":23},"action":"insert","lines":["u"],"id":32}],[{"start":{"row":32,"column":21},"end":{"row":32,"column":23},"action":"remove","lines":["Cu"],"id":33},{"start":{"row":32,"column":21},"end":{"row":32,"column":33},"action":"insert","lines":["CustomerType"]}],[{"start":{"row":34,"column":10},"end":{"row":34,"column":18},"action":"remove","lines":["category"],"id":34},{"start":{"row":34,"column":10},"end":{"row":34,"column":23},"action":"insert","lines":["customer_type"]}],[{"start":{"row":34,"column":42},"end":{"row":34,"column":52},"action":"remove","lines":["department"],"id":35},{"start":{"row":34,"column":42},"end":{"row":34,"column":43},"action":"insert","lines":["t"]}],[{"start":{"row":34,"column":43},"end":{"row":34,"column":44},"action":"insert","lines":["y"],"id":36}],[{"start":{"row":34,"column":44},"end":{"row":34,"column":45},"action":"insert","lines":["p"],"id":37}],[{"start":{"row":34,"column":45},"end":{"row":34,"column":46},"action":"insert","lines":["e"],"id":38}],[{"start":{"row":34,"column":46},"end":{"row":34,"column":47},"action":"insert","lines":["s"],"id":39}],[{"start":{"row":34,"column":46},"end":{"row":34,"column":47},"action":"remove","lines":["s"],"id":40}],[{"start":{"row":34,"column":45},"end":{"row":34,"column":46},"action":"remove","lines":["e"],"id":41}],[{"start":{"row":34,"column":44},"end":{"row":34,"column":45},"action":"remove","lines":["p"],"id":42}],[{"start":{"row":34,"column":43},"end":{"row":34,"column":44},"action":"remove","lines":["y"],"id":43}],[{"start":{"row":34,"column":42},"end":{"row":34,"column":43},"action":"remove","lines":["t"],"id":44}],[{"start":{"row":34,"column":42},"end":{"row":34,"column":55},"action":"insert","lines":["customer_type"],"id":45}],[{"start":{"row":46,"column":8},"end":{"row":46,"column":25},"action":"remove","lines":["department_params"],"id":46},{"start":{"row":46,"column":8},"end":{"row":46,"column":21},"action":"insert","lines":["customer_type"]}],[{"start":{"row":35,"column":27},"end":{"row":35,"column":37},"action":"remove","lines":["Department"],"id":47},{"start":{"row":35,"column":27},"end":{"row":35,"column":40},"action":"insert","lines":["Customer type"]}],[{"start":{"row":38,"column":26},"end":{"row":38,"column":36},"action":"remove","lines":["Department"],"id":48},{"start":{"row":38,"column":26},"end":{"row":38,"column":39},"action":"insert","lines":["Customer type"]}],[{"start":{"row":38,"column":58},"end":{"row":38,"column":66},"action":"remove","lines":["category"],"id":49},{"start":{"row":38,"column":58},"end":{"row":38,"column":71},"action":"insert","lines":["customer_type"]}],[{"start":{"row":47,"column":22},"end":{"row":47,"column":40},"action":"remove","lines":["daycare_department"],"id":50},{"start":{"row":47,"column":22},"end":{"row":47,"column":35},"action":"insert","lines":["customer_type"]}],[{"start":{"row":47,"column":45},"end":{"row":47,"column":60},"action":"remove","lines":["department_name"],"id":51},{"start":{"row":47,"column":45},"end":{"row":47,"column":46},"action":"insert","lines":["t"]}],[{"start":{"row":47,"column":46},"end":{"row":47,"column":47},"action":"insert","lines":["y"],"id":52}],[{"start":{"row":47,"column":47},"end":{"row":47,"column":48},"action":"insert","lines":["p"],"id":53}],[{"start":{"row":47,"column":48},"end":{"row":47,"column":49},"action":"insert","lines":["e"],"id":54}],[{"start":{"row":47,"column":45},"end":{"row":47,"column":49},"action":"remove","lines":["type"],"id":55},{"start":{"row":47,"column":45},"end":{"row":47,"column":54},"action":"insert","lines":["type_name"]}],[{"start":{"row":46,"column":8},"end":{"row":46,"column":21},"action":"remove","lines":["customer_type"],"id":56},{"start":{"row":46,"column":8},"end":{"row":46,"column":28},"action":"insert","lines":["customer_type_params"]}]]},"ace":{"folds":[],"scrolltop":0,"scrollleft":0,"selection":{"start":{"row":46,"column":28},"end":{"row":46,"column":28},"isBackwards":false},"options":{"guessTabSize":true,"useWrapMode":false,"wrapToView":true},"firstLineState":0},"timestamp":1433367746113,"hash":"cd833729fd6d6e4e806eaff526e5ea704c64ca56"}