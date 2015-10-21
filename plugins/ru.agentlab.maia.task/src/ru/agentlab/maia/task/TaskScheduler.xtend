package ru.agentlab.maia.task

import org.eclipse.xtend.lib.annotations.Accessors

/**
 * <p>Abstract {@link ITaskScheduler} implementation.</p>
 * 
 * <p>Implementation guarantee:</p>
 * 
 * <ul>
 * <li>execution of {@code run()} method will be redirected to one of child 
 * nodes. What exactly child node should be chosen depends of concrete
 * implementation.</li>
 * <li>when child node will notify about state change then appropriate policy 
 * will be handled.</li>
 * <li>when all retries will be exhausted then appropriate policy 
 * will be handled.</li>
 * </ul>
 * 
 * <p>Concrete implementations must implement algorithm of retrieving next 
 * child node. Additionally concrete implementation can change policies for
 * satisfying behavior requirements.</p>
 * 
 * @author <a href='shishkindimon@gmail.com'>Shishkin Dmitriy</a> - Initial contribution.
 */
@Accessors
abstract class TaskScheduler extends Task implements ITaskScheduler {

	/**
	 * <p>The number of current retries to perform an action.</p>
	 */
	var protected long retries = 0L

	/**
	 * <p>The maximum number of retries to perform an action.</p>
	 */
	var protected long retriesLimit = RETRIES_ONE_TIME
	
	new(){
		super()
	}
	
	new(String uuid){
		super(uuid)
	}
	
	override final addSubtask(ITask node) {
		if (node == null) {
			throw new NullPointerException("Node can't be null")
		}
		val added = internalAddSubtask(node)
		if (added) {
			node.parent = this
			if (subtasks.size == 1) {
				state = TaskState.READY
			}
		}
		return added
	}

	override reset() {
		retries = 0
		if (subtasks.size > 0) {
			state = TaskState.READY
		}
		subtasks.forEach[reset]
	}

	override restart() {
		retries++
	}

	override final removeSubtask(ITask node) {
		if (node == null) {
			throw new NullPointerException("Node can't be null")
		}
		val removed = internalRemoveSubtask(node)
		if (removed && subtasks.empty) {
			state = TaskState.UNKNOWN
		}
		return removed
	}

	override clear() {
		internalClear()
		state = TaskState.UNKNOWN
	}

	def protected final void schedule() {
		internalSchedule()
		state = TaskState.WORKING
	}

	def protected final void idle() {
		state = TaskState.WORKING
	}

	def protected void internalSchedule()

	def protected boolean internalAddSubtask(ITask task)

	def protected boolean internalRemoveSubtask(ITask task)

	def protected void internalClear()

}