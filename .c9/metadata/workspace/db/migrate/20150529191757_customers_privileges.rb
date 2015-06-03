{"filter":false,"title":"20150529191757_customers_privileges.rb","tooltip":"/db/migrate/20150529191757_customers_privileges.rb","undoManager":{"mark":16,"position":16,"stack":[[{"start":{"row":1,"column":12},"end":{"row":2,"column":0},"action":"insert","lines":["",""],"id":2},{"start":{"row":2,"column":0},"end":{"row":2,"column":4},"action":"insert","lines":["    "]}],[{"start":{"row":2,"column":4},"end":{"row":2,"column":24},"action":"insert","lines":["customers_privileges"],"id":3}],[{"start":{"row":1,"column":12},"end":{"row":2,"column":0},"action":"insert","lines":["",""],"id":4},{"start":{"row":2,"column":0},"end":{"row":2,"column":4},"action":"insert","lines":["    "]}],[{"start":{"row":2,"column":4},"end":{"row":8,"column":68},"action":"insert","lines":["create_table :customers_daycare_departments do |t|","      t.belongs_to :customer","      t.belongs_to :daycare_department","    end","    ","    add_index :customers_daycare_departments, :customer_id","    add_index :customers_daycare_departments, :daycare_department_id"],"id":5}],[{"start":{"row":9,"column":4},"end":{"row":9,"column":24},"action":"remove","lines":["customers_privileges"],"id":6}],[{"start":{"row":9,"column":2},"end":{"row":9,"column":4},"action":"remove","lines":["  "],"id":7}],[{"start":{"row":9,"column":0},"end":{"row":9,"column":2},"action":"remove","lines":["  "],"id":8}],[{"start":{"row":8,"column":68},"end":{"row":9,"column":0},"action":"remove","lines":["",""],"id":9}],[{"start":{"row":2,"column":18},"end":{"row":2,"column":47},"action":"remove","lines":["customers_daycare_departments"],"id":10},{"start":{"row":2,"column":18},"end":{"row":2,"column":38},"action":"insert","lines":["customers_privileges"]}],[{"start":{"row":4,"column":20},"end":{"row":4,"column":38},"action":"remove","lines":["daycare_department"],"id":14},{"start":{"row":4,"column":20},"end":{"row":4,"column":30},"action":"insert","lines":["privileges"]}],[{"start":{"row":4,"column":29},"end":{"row":4,"column":30},"action":"remove","lines":["s"],"id":15}],[{"start":{"row":7,"column":15},"end":{"row":7,"column":44},"action":"remove","lines":["customers_daycare_departments"],"id":16},{"start":{"row":7,"column":15},"end":{"row":7,"column":35},"action":"insert","lines":["customers_privileges"]}],[{"start":{"row":8,"column":15},"end":{"row":8,"column":44},"action":"remove","lines":["customers_daycare_departments"],"id":17},{"start":{"row":8,"column":15},"end":{"row":8,"column":35},"action":"insert","lines":["customers_privileges"]}],[{"start":{"row":8,"column":38},"end":{"row":8,"column":59},"action":"remove","lines":["daycare_department_id"],"id":18},{"start":{"row":8,"column":38},"end":{"row":8,"column":47},"action":"insert","lines":["privilege"]}],[{"start":{"row":8,"column":47},"end":{"row":8,"column":48},"action":"insert","lines":["_"],"id":19}],[{"start":{"row":8,"column":48},"end":{"row":8,"column":49},"action":"insert","lines":["i"],"id":20}],[{"start":{"row":8,"column":49},"end":{"row":8,"column":50},"action":"insert","lines":["d"],"id":21}]]},"ace":{"folds":[],"scrolltop":0,"scrollleft":0,"selection":{"start":{"row":7,"column":4},"end":{"row":8,"column":50},"isBackwards":false},"options":{"guessTabSize":true,"useWrapMode":false,"wrapToView":true},"firstLineState":0},"timestamp":1432927233701,"hash":"9ac04275eecc086ccab971f623ed7f735dae35bb"}