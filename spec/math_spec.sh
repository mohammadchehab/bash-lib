
Describe 'Math'
Include ./core/init.sh
import math
    It "Add 1 + 2 = 3"
        When call math.add 1 2
        The output should equal 3
    End

    It "Add 10 + 15 = 25 Numbers"
        When call math.add 10 15
        The output should equal 25
    End
End