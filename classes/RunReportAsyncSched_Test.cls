@isTest
public class RunReportAsyncSched_Test {
   	@isTest(SeeAllData=true)
    public static void method1()
    {
        RunReportAsyncSched syncReport = new RunReportAsyncSched();
        syncReport.execute(null);
    }
}