using Godot;
using System;

public class BaseControls : Node
{

	public enum Config {
		UI, P1, P2
	}
	[Export()]
	public Config conf;
	private Node thrustLeft, thrustRight, thrustMiddle, fireLeft, fireRight, fireMiddle;

	public override void _Ready() {
		foreach(Node children in GetParent().GetChildren()) {
			foreach(Node n in children.GetChildren()) {
				switch(n.Name) {
					case "ThrustLeft":
						thrustLeft = n;
						break;
					case "ThrustRight":
						thrustRight = n;
						break;
					case "ThrustMiddle":
						thrustMiddle = n;
						break;
					case "FireLeft":
						fireLeft = n;
						break;
					case "FireRight":
						fireRight = n;
						break;
					case "FireMiddle":
						fireMiddle = n;
						break;
				}
			}
		}
	}
	public override void _Process(float delta) {
		switch(conf) {
			case Config.P1:
				p1();
				break;
			case Config.P2:
				p2();
				break;
		}
	}
	public void ui() {
		controls("ui");
	}
	public void p2() {
		controls("p2");
	}
	public void p1() {
		controls("p1");
	}
	private void controls(string prefix) {
		if (Input.IsActionPressed($"{prefix}_left")) {
			((dynamic)thrustLeft)?.onPressed();
		}
		if (Input.IsActionPressed($"{prefix}_middle")) {
			((dynamic)thrustMiddle)?.onPressed();
		}
		if (Input.IsActionPressed($"{prefix}_right")) {
			((dynamic)thrustRight)?.onPressed();
		}
		if (Input.IsActionPressed($"{prefix}_fire_left")) {
			((dynamic)fireLeft)?.onPressed();
		}
		if (Input.IsActionPressed($"{prefix}_fire_middle")) {
			((dynamic)fireMiddle)?.onPressed();
		}
		if (Input.IsActionPressed($"{prefix}_fire_left")) {
			((dynamic)fireRight)?.onPressed();
		}
	}
}
