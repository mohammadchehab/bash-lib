Describe 'http'
Include ./core/init.sh
import http
    It "http.get will return a json"
        doWork(){
            http.get http://stash.compciv.org/congress-twitter/json/joni-ernst.json | jq '.name.first'
        }
        When call doWork
        The output should equal "\"Joni\""
    End
End