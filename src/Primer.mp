main() { 
int a, b; 
bool result; 
result = a < b;
loop (a < b) { a = b; redo (b > a); result = a; }
}