import textblob
from textblob import TextBlob

#pip install textblob

def spell_check(sentence, id):
    blob = TextBlob(sentence)
    corrected = str(blob.correct())
    print(f"{sentence} -> {corrected}")


if __name__ == '__main__':
    spell_check("I love to code in Pyhton.", 0)
    spell_check("I love to code in Python.", 0)
    spell_check("I love to code in Pyhton.", 0)
    spell_check("Ths sentence has some misspeld words.", 0)
    spell_check("Screw you kuys, I am going home.", 1)
    spell_check("on one side of the island was a hugh rock, almost detached", 11595)
    spell_check("The glass was opacified more greater privacy", 11682)
    spell_check("in collee she minored in mathematics", 12111)
    spell_check("The scientists had to accommodate the new results with the existing theories", 10184)
