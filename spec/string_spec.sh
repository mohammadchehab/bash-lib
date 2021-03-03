

Describe 'string replace'
Include ./core/init.sh
import string;
 It "Run String Replace"

    When run string.replace mary cathy "How are you mary?"
    The output should equal "How are you cathy?"
 End
End