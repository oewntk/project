# pip install hunspell

import hunspell

hunspeller = hunspell.HunSpell('/usr/share/hunspell/en_US.dic', '/usr/share/hunspell/en_US.aff')


def spell_check(sentence, id):
    correct = hunspeller.spell(sentence)
    if not correct:
        correct = hunspeller.suggest(sentence)
        print(f"{id}\t{sentence}\t{correct}")


if __name__ == '__main__':
    spell_check("misspeld", 0)
    spell_check("I love to code in Pyhton.", 0)
    spell_check("Ths sentence has some misspeld words.", 0)
    spell_check("Screw you kuys, I am going home.", 1)
    spell_check("on one side of the island was a hugh rock, almost detached", 11595)
    spell_check("The glass was opacified more greater privacy", 11682)
    spell_check("in collee she minored in mathematics", 12111)
    spell_check("The scientists had to accommodate the new results with the existing theories", 10184)
