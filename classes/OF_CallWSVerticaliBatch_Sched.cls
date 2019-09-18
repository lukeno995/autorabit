global class OF_CallWSVerticaliBatch_Sched implements Schedulable {

	private Integer firstIndex;
	private Integer lastIndex;

	public OF_CallWSVerticaliBatch_Sched(Integer f, Integer l) {
		firstIndex = f;
		lastIndex = l;
	}

	global void execute(SchedulableContext sc) {
		// We now call the batch class to be scheduled
		OF_CallWSVerticaliBatch b = new OF_CallWSVerticaliBatch(firstIndex, lastIndex);

		//Parameters of ExecuteBatch(context, BatchSize)
		Database.executeBatch(b, 1);
	}
}