//
//  CollapsibleContent.swift
//  WWDC21
//
//  Created by mguegnol on 13/04/2021.
//

import SwiftUI

public class CollapsibleContent {
    public var labelStr: String
    public var contentStr: String
    public var highlightStart: Int
    public var highlightEnd: Int
    
    init(labelStr: String, contentStr: String, highlightStart: Int, highlightEnd: Int) {
        self.labelStr = labelStr
        self.contentStr = contentStr
        self.highlightStart = highlightStart
        self.highlightEnd = highlightEnd
    }
}


public var collapsibleContentArray: [CollapsibleContent]  {
    var arr: [CollapsibleContent] = []
    arr.append(CollapsibleContent(labelStr: "The five-prime cap (5’ cap)", contentStr: "The vaccine code begins with the two nucleotides: 'GA'.\nAs in computer programming, the biological operating system requires “headers”. These two characters are not executed in any way, but they provide crucial information. Of the four main functions of the cap, one is to mark the code as coming from the cell nucleus. Since the code comes from a vaccine dose, this is false, but it makes the code look legitimate, preventing its destruction.", highlightStart: 0, highlightEnd: 0))
    arr.append(CollapsibleContent(labelStr: "The five-prime untranslated region (5’ UTR)", contentStr: "The 5’ UTR is composed of 51 characters.\nWhen our cells need to translate mRNA into protein, it is done with the help of the ribosome. To do this, the ribosome needs to physically “sit” on the mRNA strand. It can therefore not read the parts on which it sits first. So one of the functions of the 5’ UTR is to be the “landing zone” for the ribosome. It also provides information about when and how much translation should take place.", highlightStart: 1, highlightEnd: 18))
    arr.append(CollapsibleContent(labelStr: "1-methyl-3’-pseudouridylyl (Ψ)", contentStr: "The normal RNA characters are A, C, G and U. But then what does Ψ mean? Cells are averse to foreign RNA and do everything they can to destroy it. But the vaccine has to pass our immune system. Experiments have shown that if the U is replaced by a slightly modified molecule, our immune system loses interest in it. Thus, each U was replaced by 1-methyl-3’-pseudouridylyl, designated Ψ, which appeases our immune system, but is accepted as a normal U by the cells.", highlightStart: 2, highlightEnd: 2))
    arr.append(CollapsibleContent(labelStr: "More G’s and C’s", contentStr: "3 RNA characters constitute a codon, and each codon codes for a specific amino acid. With 4 RNA characters, there are 64 combinations (4^3) of codons. However, there are only 20 different amino acids. This means that several codons code the same amino acid. Interestingly, it turns out that RNA with a higher amount of G’s and C’s is converted more efficiently into proteins. Thus many characters have been replaced by G’s and C’s whenever possible.", highlightStart: 19, highlightEnd: 1293))
    arr.append(CollapsibleContent(labelStr: "The Spike protein", contentStr: "The vaccine generates only Spike proteins, not mounted on a viral body. In this state, the free Spike proteins collapse into a different structure, and injected like this, our bodies would then develop immunity but only against the collapsed Spike protein. But it turns out that a double substitution of Proline (CCU) in the right place allows the Spike proteins to take on their classic configuration even without being part of the whole virus. Proline is a very rigid amino acid, which thus stabilizes the protein in the state we need to show the immune system.", highlightStart: 1004, highlightEnd: 1005))
    arr.append(CollapsibleContent(labelStr: "Stop & three-prime untranslated region (3’ UTR)", contentStr: "The next characters of the vaccine RNA are similarly 'codon optimized' to add a lot of C’s and G’s. But to indicate where the protein must end, it is necessary to have a 'stop' codon at the end. Here we find the 'ΨGA' stop codon, repeated twice.\nNext comes the 3’ UTR region, which plays a crucial role in gene expression by influencing the localization, stability, export and translation efficiency of an RNA strand.", highlightStart: 1292, highlightEnd: 1390))
    arr.append(CollapsibleContent(labelStr: "The poly-A tail", contentStr: "The mRNA can be reused several times, but in doing so it also loses some of the A’s that terminate it.\nOnce the A’s are used up, the mRNA is no longer functional and is discarded. Thus the 'poly-A' tail is a protection against degradation. In our case it is 30 A, then a linker of 10 nucleotides followed by 70 more A.", highlightStart: 1391, highlightEnd: 1428))
    return arr
}
