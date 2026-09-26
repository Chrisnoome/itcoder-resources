import javax.swing.JFormattedTextField;
import javax.swing.text.MaskFormatter;

// Types keys one at a time into a real JFormattedTextField with a MaskFormatter
// (placeholder '_'), the way a person does, and prints a JavaScript table row
// for every case: mask, literals kept in the value?, keys, what the box
// shows, the value after commitEdit (or null when it throws).
public class MaskTable {
  static String row(String aMask, boolean aLiterals, String aKeys) throws Exception {
    MaskFormatter mask = new MaskFormatter(aMask);
    mask.setPlaceholderCharacter('_');
    mask.setValueContainsLiteralCharacters(aLiterals);
    JFormattedTextField field = new JFormattedTextField(mask);
    field.setFocusLostBehavior(JFormattedTextField.PERSIST);
    field.setCaretPosition(0);
    for (char key : aKeys.toCharArray()) {
      field.replaceSelection(String.valueOf(key));
    }
    String text = field.getText();
    String value;
    try {
      field.commitEdit();
      value = "'" + field.getValue() + "'";
    } catch (java.text.ParseException error) {
      value = "null";
    }
    return "  [" + js(aMask) + ", " + aLiterals + ", " + js(aKeys) + ", " + js(text) + ", " + value.replace("\\", "\\\\") + "],";
  }

  static String js(String aText) {
    return "'" + aText.replace("\\", "\\\\").replace("'", "\\'") + "'";
  }

  public static void main(String[] args) throws Exception {
    Object[][] cases = {
      {"### ### ####", false, "0821234567"}, {"### ### ####", true, "0821234567"}, {"### ### ####", false, "082123"},
      {"### ### ####", false, "082x1234567"}, {"### ### ####", false, "082 123 4567"}, {"### ### ####", false, "08212345678901"},
      {"###### #### ###", false, "0501015800088"}, {"###### #### ###", false, "050101"},
      {"####", true, "2196"}, {"####", true, "21"}, {"####", true, "21a96"},
      {"UU ## UU GP", true, "ab12cd"}, {"UU ## UU GP", true, "ab12cdgp"}, {"UU ## UU GP", true, "AB 12 CD"},
      {"##/##/####", true, "24092026"}, {"##/##/####", false, "24092026"}, {"##/##/####", true, "24/9/2026"},
      {"##:##", true, "0730"}, {"##:##", true, "7:30"},
      {"UU#-###", true, "gp1234"}, {"UU#-###", true, "g1p234"},
      {"LLLL", true, "THABO"}, {"????", true, "Ab1cD"}, {"AAAA", true, "a1-B2"}, {"****", true, "a b!"},
      {"HH HH HH", true, "1f3a5g5F"}, {"'#####", true, "12345"}, {"(###) ###-####", true, "0114567890"},
    };
    for (Object[] one : cases) {
      System.out.println(row((String) one[0], (Boolean) one[1], (String) one[2]));
    }
  }
}
