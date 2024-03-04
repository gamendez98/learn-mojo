#spacy_test.mojo
from python import Python

fn 

fn attribute_accesor[chain_len: Int, *attr_chain: StringLiteral](owned obj :PythonObject) raises -> PythonObject:
    let py = Python.import_module('builtins')
    for i in range(chain_len):
        obj = obj.__getattr__(attr_chain[i])
    return obj



fn main() raises:
    let spacy = Python.import_module('spacy')
    let py = Python.import_module('builtins')
    let nlp = spacy.load('en_core_web_trf')
    let doc = nlp("This is a test.")
    print(attribute_accesor[2, "morph", "key"](doc[1]))