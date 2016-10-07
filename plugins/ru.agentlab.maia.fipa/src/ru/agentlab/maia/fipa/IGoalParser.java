package ru.agentlab.maia.fipa;

import ru.agentlab.maia.goal.IGoal;

@FunctionalInterface
public interface IGoalParser {

	OWLIndividualAxiom parse(String content);

}
