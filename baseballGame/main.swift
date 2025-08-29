import Foundation

class baseballGame {
    private let answer: [Int]
    private var gameRecords: [Int] = []
    
    private var tryCount = 0
    init() {
        // func computerNumber에서 만든 3자리 숫자를 answer에 저장
        self.answer = baseballGame.computerNumber()
    }
    
    func instruction() {
        while true {
        print("환영합니다! 원하시는 번호를 입력해주세요")
        print("1. 게임 시작하기  2. 게임 기록 보기. 3. 종료하기")
        
        let instructionInput = readLine() ?? ""
            switch instructionInput {
            case "1":
                print("\n< 게임을 시작합니다 >")
                start()
            case "2":
                print("시도 횟수 - \(tryCount)\n")
            case "3":
                print("게임 종료\n")
            default:
                print("잘못된 숫자입니다. 1, 2, 3 중 하나를 입력해주세요!\n")
            }
        }
    }
        
    
    // 랜덤 숫자 생성
    static func computerNumber() -> [Int] {
        var shuffledNumbers = Array(0...9).shuffled()
        while shuffledNumbers[0] == 0 {
            shuffledNumbers = shuffledNumbers.shuffled()
        }
        return Array(shuffledNumbers.prefix(3))
    }
    
    // 사용자한테 입력값 받기
    private func input() -> [Int] {
        while true {
            print("숫자를 입력하세요")
            
            // nil이면 빈 문자열
            let userInput = readLine() ?? ""
            
            // ex) '5 7 8'이면 count가 5가 되니까 공백을 없애줘야함
            let remove = userInput.filter { $0 != " " }
            
            // 공백 제거한 값을 배열에 저장
            var userNumbers: [Int] = []
            for i in remove {
                if let number = Int(String(i)) {
                    userNumbers.append(number)
                } else {
                    break
                }
            }
            
            // 입력한 숫자가 3자리가 아니라면 오류
            if userNumbers.count != 3 {
                print("올바르지 않은 입력값입니다\n")
                continue
            }
            // 중복 숫자일 경우
             else if Set(userNumbers).count != 3 {
                print("올바르지 않은 입력값입니다\n")
                continue
            }
            
            return userNumbers
        }
    }
    
    // 스트라이크, 볼 판정
    private func checkResult(userNumbers: [Int]) -> Bool {
        var strike = 0
        var ball = 0
        
        // 각 숫자의 index와 값을 같이 가져옴
        for (i, num) in userNumbers.enumerated() {
            // 정답 배열(answer)에서 사용자가 입력한 숫자(num)랑 자리와 숫자가 같다면
            if answer[i] == num {
                strike += 1
            }
            // 정답 배열에 사용자가 입력한 숫자가 포함되어 있다면
            else if answer.contains(num) {
                ball += 1
            }
        }
        
        // 스트라이크, 볼, nothing 출력
        if strike == 3 {
            print("정답입니다!\n")
            return true
        } else if strike == 0 && ball == 0 {
            print("Nothing\n")
        } else {
            print("\(strike) 스트라이크, \(ball) 볼\n")
        }
        return false
    }
    
    // 게임 실행
    func start() {
        self.tryCount = 0
        
        while true {
            let userNumbers = input()
            tryCount += 1

            if checkResult(userNumbers: userNumbers) {
                break
            }
            
        }
    }
}

let game = baseballGame()
game.instruction()
