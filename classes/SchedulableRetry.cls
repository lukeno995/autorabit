public abstract class SchedulableRetry implements Schedulable {

    protected Integer currentAttempt;
    protected Integer maxAttempt;

    public SchedulableRetry(Integer currentAttempt, Integer maxAttempt) {
        this.currentAttempt = currentAttempt; 
        this.maxAttempt = maxAttempt;
    }

    public void execute(SchedulableContext ctx) {
        System.debug('##### Schedulable.execute - START');

        if(currentAttempt <= maxAttempt) {
            System.debug('##### Schedulable.execute - retry numero: ' + currentAttempt);
            executeJob(ctx);
        } else {
            System.debug('##### Schedulable.execute - numero massimo retry raggiunti' + currentAttempt);
        }
    }

    protected abstract void executeJob(SchedulableContext ctx);

}