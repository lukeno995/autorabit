public class IllegalRequestException extends Exception {
    private String code;
    private String description;

    public IllegalRequestException(String code, String description) {
        this.description = description;
        this.code = code;
    }

    public String getCode() {
        return code;
    }

    public String getDescription() {
        return description;
    }
}