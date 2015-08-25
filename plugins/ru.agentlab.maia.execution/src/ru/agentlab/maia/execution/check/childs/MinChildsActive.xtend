package ru.agentlab.maia.execution.check.childs

import ru.agentlab.maia.execution.tree.IExecutionNode
import ru.agentlab.maia.execution.check.IChildsCheck

class MinChildsActive implements IChildsCheck {

	int limit

	new(int limit) {
		this.limit = limit
	}

	override test(Iterable<IExecutionNode> childs) {
		return childs.length > limit
	}

}