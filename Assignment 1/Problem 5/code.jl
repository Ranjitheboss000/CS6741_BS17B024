all_characters = ["0","1","2","3","4","5","6","7","8","9",
            "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z",
            "A","B",  "C",  "D" ,"E",  "F",  "G",  "H","I","J","K","L","M","N","O","P","Q","R","S","T",  "U" , "V",  "W" , "X",  "Y" , "Z",
            "~", "!","@","#", " ","%","^","&","*","(",")","_","+","=","-","`" ];

using Random
Random.seed!(0);

password = [rand(all_characters) for _ = 1:8]
coun = 0
hacker_attempts = []
N = 10^6

for _ = 1:N
    guess = [rand(all_characters) for _ = 1:8]
    # Simulating Hacker's attempts wherein he won't make any repeating attempts
    while guess in hacker_attempts
        guess = [rand(all_characters) for _ = 1:8]
    end
    if sum([password[i]==guess[i] for i = 1:8]) >= 3
        coun += 1 
    end
end
println("\n$coun passwords out of million attempts got stored in the database for the new rule\n")
