package ru.agentlab.maia.context.modifier

import javax.annotation.PostConstruct
import javax.inject.Inject
import ru.agentlab.maia.behaviour.IBehaviour
import ru.agentlab.maia.context.IContext
import ru.agentlab.maia.context.IInjector
import ru.agentlab.maia.behaviour.sequential.BehaviourSchedulerSequential

class MaiaAgentContextModifier {

	@Inject
	IContext context

	@PostConstruct
	def void setup() {
		context => [
			put(IContext.KEY_TYPE, "agent")
			get(IInjector) => [
				deploy(BehaviourSchedulerSequential, IBehaviour)
			]
		]
	}

}