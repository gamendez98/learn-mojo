from python import Python

fn attribute_accesor[chain_len: Int, *attr_chain: String](owned obj :PythonObject) raises -> PythonObject:
    let py = Python.import_module('builtins')
    for i in range(chain_len):
        obj = py.getattr(obj, attr_chain[i], None)
    return obj



fn main() raises:
    let spacy = Python.import_module('spacy')
    let py = Python.import_module('builtins')
    let nlp = spacy.load('en_core_web_trf')
    let doc = nlp("This is a test.")
    print(attribute_accesor[2, "morph", "key"](doc[1]))