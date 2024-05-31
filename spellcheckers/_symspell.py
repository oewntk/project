from symspellpy import SymSpell, Verbosity
from importlib.resources import files
import re

# pip install symspellpy

# Create a SymSpell object
sym_spell = SymSpell(max_dictionary_edit_distance=2, prefix_length=7)

# Load a dictionary
dictionary_path = str(files('symspellpy').joinpath('frequency_dictionary_en_82_765.txt'))
print(dictionary_path)
sym_spell.load_dictionary(dictionary_path, term_index=0, count_index=1)
separators = r"[,.;:!?'\- ]+"


def spell_check(sentence, id):
    corrected = spell_check_s(sentence)
    if corrected:
        print(f"{id}\t{sentence}\t{corrected}")


def spell_check_words(sentence, id):
    words = filter(lambda w: w != "", re.split(separators, sentence))
    corrected = [spell_check_w(word) for word in words]
    if corrected:
        print(f"{id}\t{sentence}\t{corrected[0]}")


def spell_check_word(word, id):
    corrected = spell_check_w(word)
    if corrected:
        print(f"{id}\t{word}\t{corrected}")
        return corrected
    return None


def spell_check_s(sentence):
    corrected = sym_spell.lookup_compound(sentence, max_edit_distance=2)
    if corrected:
        return list(map(lambda c: str(c.term), filter(lambda c: c.distance > 1, corrected)))
    return None


def spell_check_w(word):
    corrections = sym_spell.lookup(word, max_edit_distance=2, verbosity=Verbosity.CLOSEST)
    if corrections:
        corrected = [correction.term for correction in corrections]
        return corrected
    return None


if __name__ == '__main__':
    spell_check_word("misspell", 0)
    spell_check_word("misspeld", 0)
    spell_check("Ths sentence has some misspeld words.", 0)
    spell_check("I love to code in Pyhton.", 0)
    spell_check("Ths sentence has some misspeld words.", 0)
    spell_check("Screw you kuys, I am going home.", 1)
    spell_check("on one side of the island was a hugh rock, almost detached", 11595)
    spell_check("The glass was opacified more greater privacy", 11682)
    spell_check("in collee she minored in mathematics", 12111)
    spell_check("The scientists had to accommodate the new results with the existing theories", 10184)
