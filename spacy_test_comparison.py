from timeit import default_timer as timer
import numpy as np
import spacy

nlp = spacy.load('en_core_web_lg')

def cosim(a, b):
    return np.dot(a, b) / (np.linalg.norm(a) * np.linalg.norm(a))


def match_score(key_doc, query_doc):
    return sum(max(cosim(k.vector, q.vector) for k in key_doc) for q in query_doc) / len(query_doc)

def search(entries, query):
    best_score = 0
    best = None
    for e in entries:
        score = match_score(e, query)
        if score > best_score:
            best_score = score
            best = e
    return best, best_score

def main():
    entries = [nlp(e.strip().lower()) for e in open('examples.txt').readlines()]
    query = nlp("boss analyst")
    start = timer()
    for i in range(10000):
        _ = search(entries, query)
    end = timer()
    print(end - start)

if __name__ == '__main__':
    main()
