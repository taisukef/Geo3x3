#define i64_t long long
struct String;

typedef struct String
{
    char* string;
    i64_t size;
} String;

i64_t str_charCodeAt(String* s, i64_t idx) {
  return s->string[idx];
}
i64_t str_size(String* s) {
  return s->size;
}
