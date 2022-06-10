# Introduction

In this folder are located the **protein sequences** and the **category files** for the proteins in multiple species:

- Human
- Mouse
- Rat
- Pig
- Rabbit
- Zebrafish
- E.Coli

# Description files

For each species there are multiple files.

## Protein sequences

These files are the protein sequences in FASTA format. They depend on the type of database.

The file structure name is:

{species}_{date}_{database}.fasta

The type of database are the following:

- _pro-sw    =>  SwissProt for the UniProtKB Proteome
- _uni-sw    =>  SwissProt for the whole UniProtKB database
- _pro-sw-tr =>  SwissProt for the UniProtKB Proteome
- _uni-sw-tr =>  SwissProt for the whole UniProtKB database

## Target/Decoy files

There are target/decoy files for each type of Protein sequence files described above.

The decoy files have been created by the DecoyPYrat script from Sanger (https://www.sanger.ac.uk/science/tools/decoypyrat)

The file structure name is:

{species}_{date}_{database}.{target/decoy}.fasta

The type of target/decoy files are the following:

- target       =>  File with the protein sequences. In this file the peptides have been maked isobaric (replacing the I to L ).
- decoy        =>  File with the only the decoy sequences. In this file the decoys have been maked isobaric (replacing the I to L ).
- target-decoy =>  File that concatenate the target/decoy sequences (maked isobaric, replacing the I to L ).

## Category files

These files contains functional information that categorizes the proteins.

The file structure name is:

{species}_{date}.{type_cat}.tsv

The type of category files are:

- categories  => These files contain multiple columns with the following information:
    + Meta terms of Protein:
      * xref_UniProt_Name: UniProt Name
      * Protein
      * Gene: HUGO gene name
      * Species
      * Length: protein length
      * Description: UniProt protein description
      * Comment_Line: UniProt description that is within the FASTA file
      * prot_UniProt_Class:  If the entry belongs to the Swiss-Prot section of UniProtKB (reviewed) or to the computer-annotated TrEMBL section (unreviewed).
    + Xreferences terms of Protein
      * xref_Ensembl_protId: Ensembl Protein Id
      * xref_Ensembl_transcId: Ensembl Transcript Id
      * xref_Ensembl_GeneId: Ensembl Gene Id
      * xref_RefSeq_protId: RefSeq Protein Id
      * xref_RefSeq_transcId: RefSeq Trascript Id
      * xref_CCDS: CCDS Id
    + Category terms of Protein:
      * cat_GO_C: GO terms for Cellular component
      * cat_GO_F: GO terms for Molecular function
      * cat_GO_P: GO terms for Biological process
      * cat_KEGG: KEGG information
      * cat_PANTHER: PANTHER information
      * cat_Reactome: Reactome information
      * cat_CORUM: CORUM information

- pid2cat  =>  This file contains the following columns:
    + categories: They are the same categories than the large file 'categories.tsv'
    + UniProt Protein Accesion

- pdesc2cat  =>  This file contains the following columns:
    + categories: They are the same categories than the large file 'categories.tsv'
    + command line of protein

- cat  (DEPRECATED) =>  This file contains the following columns:
    + categories: They are the same categories than the large file 'categories.tsv'
    + command line of protein