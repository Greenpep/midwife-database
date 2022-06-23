import java.sql.*;
import java.util.*;
import java.util.Calendar;
import java.util.Formatter;

public class GoBabbyApp {

    private static String getUserInput(String askedValue){
        // Ask for user input
        Scanner userInput = new Scanner(System.in);
        System.out.println(askedValue);
        return String.valueOf(userInput.nextLine());
    }

    private static boolean checkValidNumber(String s){
        if (s == null){
            return false;
        }
        try{
            int n = Integer.parseInt(s);
        }
        catch (NumberFormatException nfe){
            return false;
        }
        return true;
    }

    private static void printNotes(Statement s, int code, String state, int parentID){
        try {
            ResultSet rs = s.executeQuery("SELECT appointmentdate, appointmenttime, info " +
                    "FROM appointment, notes " +
                    "WHERE parentid = " + parentID + " AND notes.appointmentid = appointment.appointmentid " +
                    "ORDER BY appointmentdate DESC, appointmenttime DESC;");

            while (rs.next()) {
                String date = rs.getString(1);
                String time = rs.getString(2);
                String noteInfo = rs.getString(3);

                System.out.println(date + " " + time + " " + noteInfo);
            }
        } catch (SQLException e) {
            code = e.getErrorCode(); // Get SQLCODE
            state = e.getSQLState(); // Get SQLSTATE

            // Your code to handle errors comes here;
            // something more meaningful than a print would be good
            System.out.println("Code: " + code + "  sqlState: " + state);
            System.out.println(e);
        }
    }

    private static void printTests(Statement s, int code, String state, int parentID){
        try {
            ResultSet rs = s.executeQuery("SELECT dateprescribed, medicaltestsample.type, result " +
                    "FROM appointment, medicaltestsample " +
                    "WHERE appointment.parentid = " + parentID + " AND appointment.appointmentid = medicaltestsample.appointmentid " +
                    "ORDER BY dateprescribed DESC;");

            while (rs.next()) {
                String date = rs.getString(1);
                String testType = rs.getString(2);
                String testResult = rs.getString(3);

                if (Objects.equals(testResult, null)){
                    System.out.println(date + " [" + testType + "] PENDING");
                }
                else{
                    System.out.println(date + " [" + testType + "] " + testResult);
                }
            }
        } catch (SQLException e) {
            code = e.getErrorCode(); // Get SQLCODE
            state = e.getSQLState(); // Get SQLSTATE

            // Your code to handle errors comes here;
            // something more meaningful than a print would be good
            System.out.println("Code: " + code + "  sqlState: " + state);
            System.out.println(e);
        }
    }

    private static void addNote(Statement s, int code, String state, int noteID, String midwife, int parentid, int appointmentNumber){
        String observation = getUserInput("Please enter your observation: ");
        String date = String.valueOf(java.time.LocalDate.now());

        // Get current time
        Formatter format = new Formatter();
        Calendar gfg_calender = Calendar.getInstance();
        format = new Formatter();
        format.format("%tl:%tM", gfg_calender, gfg_calender);
        String time = String.valueOf(format);

        try {
            String appointmentSQL = "INSERT INTO appointment(appointmentid, appointmentdate, appointmenttime, midwife, parentid) VALUES" +
                    "(" + appointmentNumber + ", DATE'" + date + "', TIME'" + time + "', '" + midwife + "', " + parentid + ");";
            s.executeUpdate(appointmentSQL);

            String noteSQL = "INSERT INTO notes (notedate, notetime, noteid, info, appointmentid) VALUES" +
                    "(DATE'" + date + "', TIME'" + time + "', " + noteID + ", '" + observation + "', " + appointmentNumber + ");";
            s.executeUpdate(noteSQL);

        } catch (SQLException e) {
            code = e.getErrorCode(); // Get SQLCODE
            state = e.getSQLState(); // Get SQLSTATE

            // Your code to handle errors comes here;
            // something more meaningful than a print would be good
            System.out.println("Code: " + code + "  sqlState: " + state);
            System.out.println(e);
        }
    }

    private static void prescribeTest(Statement s, int code, String state, int testNumber, String midwife, int parentid, int appointmentNumber){
        String type = getUserInput("Please enter the type of test: ");
        String date = String.valueOf(java.time.LocalDate.now());
        String testKey = "test" + testNumber;

        // Get current time
        Formatter format = new Formatter();
        Calendar gfg_calender = Calendar.getInstance();
        format = new Formatter();
        format.format("%tl:%tM", gfg_calender, gfg_calender);
        String time = String.valueOf(format);

        try {
            String appointmentSQL = "INSERT INTO appointment(appointmentid, appointmentdate, appointmenttime, midwife, parentid) VALUES" +
                    "(" + appointmentNumber + ", DATE'" + date + "', TIME'" + time + "', '" + midwife + "', " + parentid + ");";
            s.executeUpdate(appointmentSQL);

            String testSQL = "INSERT INTO medicaltestsample (testkey, dateprescribed, datesample, type, appointmentid) VALUES" +
                    "('" + testKey + "', DATE'" + date + "', DATE'" + date + "', '" + type + "', " + appointmentNumber + ");";
            s.executeUpdate(testSQL);

        } catch (SQLException e) {
            code = e.getErrorCode(); // Get SQLCODE
            state = e.getSQLState(); // Get SQLSTATE

            // Your code to handle errors comes here;
            // something more meaningful than a print would be good
            System.out.println("Code: " + code + "  sqlState: " + state);
            System.out.println(e);
        }
    }

    public static void main(String[] args) throws SQLException{
        // Unique table names.  Either the user supplies a unique identifier as a command line argument, or the program makes one up.
        String tableName = "";
        int sqlCode=0;      // Variable to hold SQLCODE
        String sqlState="00000";  // Variable to hold SQLSTATE

        if ( args.length > 0 )
            tableName += args [ 0 ];
        else
            tableName += "exampletbl";

        // Register the driver.  You must register the driver before you can use it.
        try { DriverManager.registerDriver ( new com.ibm.db2.jcc.DB2Driver() ) ; }
        catch (Exception cnfe){ System.out.println("Class not found"); }

        // This is the url you must use for DB2.
        //Note: This url may not valid now ! Check for the correct year and semester and server name.
        String url = "jdbc:db2://winter2022-comp421.cs.mcgill.ca:50000/cs421";

        //REMEMBER to remove your user id and password before submitting your code!!
        String your_userid = "dzhang68";
        String your_password = "Zhanda!001124";
        //AS AN ALTERNATIVE, you can just set your password in the shell environment in the Unix (as shown below) and read it from there.
        //$  export SOCSPASSWD=yoursocspasswd
        if(your_userid == null && (your_userid = System.getenv("SOCSUSER")) == null)
        {
            System.err.println("Error!! do not have a password to connect to the database!");
            System.exit(1);
        }
        if(your_password == null && (your_password = System.getenv("SOCSPASSWD")) == null)
        {
            System.err.println("Error!! do not have a password to connect to the database!");
            System.exit(1);
        }
        Connection con = DriverManager.getConnection (url,your_userid,your_password) ;
        Statement statement = con.createStatement (ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY) ;

        ResultSet getAppointments = statement.executeQuery("SELECT appointmentid FROM appointment ORDER BY appointmentid DESC;");
        int appointmentCounter = 0;
        if (getAppointments.next()){
            appointmentCounter = Integer.parseInt(getAppointments.getString("appointmentid")) + 1;
        }

        ResultSet getNotes = statement.executeQuery("SELECT noteid FROM notes ORDER BY noteid DESC;");
        int noteCounter = 0;
        if (getNotes.next()){
            noteCounter = Integer.parseInt(getNotes.getString("noteid")) + 1;
        }

        ResultSet getTests = statement.executeQuery("SELECT testkey FROM medicaltestsample ORDER BY testkey DESC;");
        int testCounter = 0;
        if (getTests.next()){
            String maxTestKey = getTests.getString("testkey");
            String maxValue = maxTestKey.substring(4).replaceAll("\\s+","");
            testCounter = Integer.parseInt(maxValue) + 1;
        }

        // Prompt the program
        boolean validPID = false;
        String enteredPID = "";
        while(!validPID){
            // Ask for user input
            String pid = getUserInput("Please enter your practitioner id [E] to exit: ");

            // If user wants to quit the program
            if (Objects.equals(pid.toLowerCase(), "e")){
                // Close the statement and connection
                statement.close () ;
                con.close () ;
                return;
            }

            try
            {
                ResultSet rs = statement.executeQuery("SELECT practitionerid FROM midwife WHERE '" + pid + "' = practitionerid");
                if(rs.next()){
                    enteredPID = rs.getString("practitionerid");
                    validPID = true;
                }
                else{
                    System.out.println("Practitioner id does not exist. Please enter a valid practitioner id");
                }
            }
            catch (SQLException e)
            {
                sqlCode = e.getErrorCode(); // Get SQLCODE
                sqlState = e.getSQLState(); // Get SQLSTATE

                // Your code to handle errors comes here;
                // something more meaningful than a print would be good
                System.out.println("Code: " + sqlCode + "  sqlState: " + sqlState);
                System.out.println(e);
            }
        }

        while(true){
            // Ask for user input
            String date = getUserInput("Please enter the date(YYYY-MM-DD) for appointment list [E] to exit: ");

            // If user wants to quit the program
            if (Objects.equals(date.toLowerCase(), "e")){
                // Close the statement and connection
                statement.close () ;
                con.close () ;
                return;
            }

            try
            {
                ResultSet rs = statement.executeQuery
                        ("SELECT appointmenttime, primarymidwife, backupmidwife, mothername, mother.motherid, parent.parentid FROM parent, appointment, mother " +
                                "WHERE appointmentdate = DATE '" + date + "' AND " +
                                "appointment.parentid = parent.parentid AND " +
                                "mother.motherid = parent.motherid AND " +
                                "(primarymidwife = '" + enteredPID + "' OR " +
                                "backupmidwife = '" + enteredPID + "')" +
                                "ORDER BY appointmenttime;");

                // Display every appointment for given date
                ArrayList<ArrayList<String>> data = new ArrayList<>();
                while(rs.next()) {
                    String time = rs.getString(1);
                    String pMidwife = rs.getString(2);
                    String bMidwife = rs.getString(3);
                    String name = rs.getString(4);
                    String insuranceID = rs.getString(5);
                    String parentID = rs.getString(6);

                    ArrayList<String> column = new ArrayList<>();
                    column.add(time);
                    column.add(pMidwife);
                    column.add(bMidwife);
                    column.add(name);
                    column.add(insuranceID);
                    column.add(parentID);

                    data.add(column);
                }
                if (data.size() == 0){
                    System.out.println("No appointments on this date");
                    continue;
                }

                boolean validNumber = false;
                while(!validNumber){
                    int counter = 1;
                    for(ArrayList<String> record: data){
                        if (Objects.equals(record.get(1), enteredPID)){
                            System.out.println(counter + ":  " + record.get(0) + " P " + record.get(3) + " " + record.get(4));
                        }
                        else{
                            System.out.println(counter + ":  " + record.get(0) + " B " + record.get(3) + " " + record.get(4));
                        }
                        counter++;
                    }

                    // Ask for user input
                    String appointmentNumber = getUserInput("Enter the appointment number that you would like to work on. [E] to exit [D] to go back to another date: ");

                    // If user wants to go back
                    if (Objects.equals(appointmentNumber.toLowerCase(), "d")){
                        break;
                    }
                    // If user wants to exit
                    else if (Objects.equals(appointmentNumber.toLowerCase(), "e")){
                        statement.close () ;
                        con.close () ;
                        return;
                    }
                    // If entered an integer
                    if (checkValidNumber(appointmentNumber)){
                        int enteredNumber = Integer.parseInt(appointmentNumber);

                        // Check if it is a valid number
                        if (enteredNumber <= 0 || enteredNumber > counter - 1){
                            System.out.println("Entered an invalid value.");
                        }
                        else{
                            String enteredName = data.get(enteredNumber-1).get(3);
                            String enteredInsuranceID = data.get(enteredNumber-1).get(4);
                            int enteredParentID = Integer.parseInt(data.get(enteredNumber-1).get(5));

                            // Commands to do on the chosen query
                            boolean validValue = true;
                            while(validValue){
                                System.out.println("For " + enteredName + " " + enteredInsuranceID);
                                System.out.println("");
                                System.out.println("1. Review notes");
                                System.out.println("2. Review tests");
                                System.out.println("3. Add a note");
                                System.out.println("4. Prescribe a test");
                                System.out.println("5. Go back to the appointments");
                                System.out.println("");
                                String command = getUserInput("Enter your choice [E] to exit: ");

                                if(Objects.equals(command.toLowerCase(), "e")){
                                    statement.close () ;
                                    con.close () ;
                                    return;
                                }
                                if (checkValidNumber(command)){
                                    int enteredCommand = Integer.parseInt(command);
                                    if (enteredCommand <= 0 || enteredCommand > 5){
                                        System.out.println("Entered an invalid value.");
                                    }
                                    else{
                                        switch (enteredCommand) {
                                            case 1:
                                                printNotes(statement, sqlCode, sqlState, enteredParentID);
                                                break;
                                            case 2:
                                                printTests(statement, sqlCode, sqlState, enteredParentID);
                                                break;
                                            case 3 :
                                                addNote(statement, sqlCode, sqlState, noteCounter, enteredPID , enteredParentID, appointmentCounter);
                                                noteCounter++;
                                                appointmentCounter++;
                                                break;
                                            case 4:
                                                prescribeTest(statement, sqlCode, sqlState, testCounter, enteredPID, enteredParentID, appointmentCounter);
                                                appointmentCounter++;
                                                break;
                                            case 5:
                                                validValue = false;
                                                break;
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            catch (SQLException e)
            {
                sqlCode = e.getErrorCode(); // Get SQLCODE
                sqlState = e.getSQLState(); // Get SQLSTATE

                // Your code to handle errors comes here;
                // something more meaningful than a print would be good
                System.out.println("Code: " + sqlCode + "  sqlState: " + sqlState);
                System.out.println(e);
                break;
            }
        }
        statement.close () ;
        con.close () ;
    }
}
