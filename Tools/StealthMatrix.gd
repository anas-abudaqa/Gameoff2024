extends Node2D

var max_charges: int
var available_charges: int
var equipped_tool
@onready var pulse_scanner = $PulseScanner
@onready var hacking_tool = $HackingTool

#key is an int, value is tool scene
#need to make this onready because our tool nodes will only be available on ready
@onready var available_tools = {
	1: pulse_scanner,
	2: hacking_tool
}


func _ready():
	change_equipped_tool(2)
	print(equipped_tool)

func change_equipped_tool(desired_tool: int):
	equipped_tool = available_tools[desired_tool]



func recharge_matrix(recharge_amount: int):
	available_charges += recharge_amount
	available_charges = clampi(available_charges, 0, max_charges)


func activate_equipped_tool():
	equipped_tool.activate()
