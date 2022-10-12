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

    public boolean equals(Object obj){
        FD fd2 = (FD)obj;
        return lhs.equals(fd2.lhs) && rhs == fd2.rhs;
    }
};
