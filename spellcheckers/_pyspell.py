from spellchecker import SpellChecker
import re

# pip install pyspellchecker

spell = SpellChecker(language='en')  # English dictionary, change to other language if you prefer
separators = r"[,.;:!?\-\(\) ]+"


def spell_check(sentence, id):
    words = filter(lambda w: w != "", re.split(separators, sentence))
    unknown = spell.unknown(words)
    if len(unknown) > 0:
        corrected = [spell.correction(word) for word in unknown]
        print(f"{id}\t{sentence}\t{corrected}")
        return corrected
    return None


def spell_check_word(word, id):
    unknown = spell.unknown(word)
    if len(unknown) > 0:
        corrected = [spell.correction(word) for word in unknown]
        print(f"{id}\t{word}\t{corrected}")
        return corrected
    return None


if __name__ == '__main__':
    spell_check("I love to code in Pyhton.", 0)
    spell_check("Ths sentence has some misspeld words.", 0)
    spell_check("Screw you kuys, I am going home.", 1)
    spell_check("on one side of the island was a hugh rock, almost detached", 11595)
    spell_check("The glass was opacified more greater privacy", 11682)
    spell_check("in collee she minored in mathematics", 12111)
    spell_check("The scientists had to accommodate the new results with the existing theories", 10184)
