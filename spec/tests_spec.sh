Describe 'console'
Include ./core/init.sh
It "Run console log"
    When call console.log hello
    The output should equal ""
 End
End