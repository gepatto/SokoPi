package;

typedef Command = {
	execute:() -> Void,
	undo:() -> Void
}

class CommandManager {
	private var commands:Array<() -> Void> = [];

	@:isVar public var count(get, null):Int;

	public function new() {}

	static public function combine(cmds:Array<Command>):Command {
		function execute() {
			for (cmd in cmds) {
				cmd.execute();
			}
		}

		function undo() {
			for (cmd in cmds) {
				cmd.undo();
			}
		}

		return {
			execute: execute,
			undo: undo
		};
	}

	public function addCommand(cmd:Command) {
		cmd.execute();
		commands.push(cmd.undo);
	}

	public function undoCommand() {
		if (commands.length <= 0) {
			return;
		}

		var undo = commands.pop();
		undo();
	}

	function get_count() {
		return commands.length;
	}
}
