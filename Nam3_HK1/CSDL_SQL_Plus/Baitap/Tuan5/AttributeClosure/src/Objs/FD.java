package Objs;

import java.util.HashSet;

// Functional Dependency
public class FD{
    public HashSet<Character> lhs;
    public HashSet<Character> rhs;

    public FD(HashSet<Character> l, HashSet<Character> r){
        this.lhs = l;
        this.rhs = r;
    }
};
