extends Panel

var p1ship
var p2ship

var p1shipDesc
var p2shipDesc

var ships
# Called when the node enters the scene tree for the first time.
func _ready():
	p1ship = get_node("P1Ship")
	p2ship = get_node("P2Ship")
	
	p1ship.connect("item_selected", self, "updateDescP1")
	p2ship.connect("item_selected", self, "updateDescP2")
	
	p1shipDesc = get_node("P1ShipDesc")
	p2shipDesc = get_node("P2ShipDesc")
		
	ships = get_node("ShipList").get_children()
	for ship in ships:
		p1ship.add_icon_item(ship.icon, "")
		p2ship.add_icon_item(ship.icon, "")

func updateDescP1(index):
	p1shipDesc.set_text(ships[index].description)
func updateDescP2(index):
	p2shipDesc.set_text(ships[index].description)
func startDuel():
	var sc = load("res://DuelStage.tscn").instance()
	var controlBase = load("res://BaseControls.gd")
	
	var p1 = ships[p1ship.selected].ship.instance()
	var p2 = ships[p2ship.selected].ship.instance()
	
	var p1con = Node.new()
	p1con.set_script(controlBase)
	p1con.conf = p1con.Config.p1
	var p2con = Node.new()
	p2con.set_script(controlBase)
	p2con.conf = p2con.Config.p2
	
	p1.add_child(p1con)
	p2.add_child(p2con)
	
	p1.transform.origin = Vector3(-5, 0, 0)
	p2.transform.origin = Vector3(5, 0, 0)
	p2.set_rotation_degrees(Vector3(0, 0, 180))
		
	sc.add_child(p1)
	sc.add_child(p2)
	
	var state = sc.get_node("GameState")
	state.shipSelect = self;
	
	p1.connect("tree_exited", state, "p2win")
	p2.connect("tree_exited", state, "p1win")
	
	var camera = sc.get_node("Camera")
	camera.playerLeft = p1
	camera.playerRight = p2
	
	var p = get_parent()
	p.remove_child(self)
	
	p.add_child(sc)
	
	pass
