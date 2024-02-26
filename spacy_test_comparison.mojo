from python import Python


def cosim(a: PythonObject, b: PythonObject) -> Float64:
    np = Python.import_module('numpy')
    return (np.dot(a, b) / (np.linalg.norm(a) * np.linalg.norm(a))).to_float64()


def match_score(key_doc: PythonObject, query_doc: PythonObject) -> Float64:
    var score: Float64 = 0
    l = 0
    for k in key_doc:
        var partial: Float64 = 0
        l+=1
        for q in query_doc:
            s = cosim(k.vector, q.vector)
            partial = partial if partial >= s else s
        score += partial
    return score/l

def search(entries: DynamicVector[PythonObject], query: PythonObject):
    best_score = 0
    best = None
    for e in entries:
        score = match_score(e, query)
        if score > best_score:
            best_score = score
            best = e
    return best, best_score

fn main():
    let nlp = Python.import_module("nlp")  # Assuming nlp is a module you've imported
    let query = nlp("boss analyst")
    let bn = Python.import_module("builtins")
    let f_hand = bn.open("examples.txt", "r")
    let lines = f_hand.readlines()
    let entries = DynamicVector[PythonObject]()
    for line in lines:
        let processed_line = line.strip().lower()
        let nlp_result = nlp(processed_line)
        entries.append(nlp_result)
    f_hand.close()
    r, score = search(entries, query)
    print(r)
