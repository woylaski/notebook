#!/usr/bin/env python

import sys

from sqlalchemy import create_engine, Column, Integer, String
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

Base = declarative_base()
session = None
debug = False

def createDb():
    global session
    engine = create_engine('sqlite:///dictionary.db', echo=debug)
    Base.metadata.create_all(engine)
    Session = sessionmaker(bind=engine)
    session = Session()

class Term(Base):
    __tablename__ = 'term'

    id = Column(Integer, primary_key=True)
    term = Column(String)
    explanation = Column(String)

    def __init__(self, term, explanation):
        self.term = term
        self.explanation = explanation

    def __repr__(self):
        return "<Term('%s','%s')>" % (self.term, self.explanation)


class TermVersions(Base):
    __tablename__ = 'termVersions'

    id = Column(Integer, primary_key=True)
    version = Column(Integer, primary_key=True)
    term = Column(String)
    explanation = Column(String)

    def __init__(self, id, version, term, explanation):
        self.id = id
        self.version = version
        self.term = term
        self.explanation = explanation

    def __repr__(self):
        return "<Term({'%s'}, {'%s'}, {'%s'},{'%s'})>".format(self.id, self.version, self.term, self.explanation)



def listTerms():
    terms = session.query(Term).all()
    return terms

def createAndSaveTerm(term, explanation):
    term = Term(term, explanation)
    session.add(term)
    session.commit()

def searchExact(keyword):
    searchWord = keyword
    exactMatch = session.query(Term).filter(Term.term.like(searchWord)).first()
    #print "\nexact:", exactMatch
    return exactMatch

def searchStartingWithOnly(keyword):
    searchWord = keyword + '%'
    startingMatch = session.query(Term).filter(Term.term.like(searchWord)).filter(~Term.term.like(keyword)).all()
    #print "\nstartingmatch", startingMatch
    return startingMatch

def searchPartialOnly(keyword):
    searchWord = '%' + keyword + '%'
    partialMatch = session.query(Term).filter(Term.term.like(searchWord)).filter(~Term.term.like(keyword+"%")).all()
    #print "\npartialmatch", partialMatch
    return partialMatch

def searchExplanationOnlyContains(keyword):
    searchWord = '%' + keyword + '%'
    match = session.query(Term).filter(Term.explanation.like(searchWord)).filter(~Term.term.like(searchWord)).all()
    return match

def deleteTerm(termObject):
    session.delete(termObject)
    saveAll()

def saveAll():
    session.commit()

createDb()

def run(args):
    pass

if __name__ == "__main__":
    run(sys.argv[1:])
