namespace Geo3x3{



template<size_t PREC=20>
struct Encoder{
    Encoder(double lat, double lng){
        if(lng < 0.0){
            *m_code = 'W';
            encode(90.0-lat, lng+180.0, 180.0/3, m_code+1, PREC-1);
        }else{
            *m_code = 'E';
            encode(90.0-lat, lng,       180.0/3, m_code+1, PREC-1);
        }
    }

    operator const char*(){ return m_code; }

private:
    char m_code[PREC+1];

    void encode(double lat, double lng, double prec, char* code, size_t remain){
        if(remain){
            int x = lng / prec;
            int y = lat / prec;
            *code = '1' + (3*y) + x;
            encode(lat-prec*y, lng-prec*x, prec/3, code+1, remain-1);
        }else{
            *code = '\0';
        }
    }
};



struct Decoder{
    Decoder(const char* code){
        if(*code){
            m_lat = 90.0;
            m_lng = (*code == 'W') ? -180.0 : 0.0;
            m_level = 1;
            decode(code+1, 180.0/3);
        }else{
            m_lat = 0.0;
            m_lng = 0.0;
            m_level = 0;
        }
    }

    double lat(){ return m_lat; }
    double lng(){ return m_lng; }
    unsigned level(){ return m_level; }

private:
    double m_lat;
    double m_lng;
    unsigned m_level;

    void decode(const char* code, double prec){
        unsigned n = *code - '1';
        if(n < 9){
            m_lng += n % 3 * prec;
            m_lat -= n / 3 * prec;
            ++m_level;
            decode(code+1, prec/3);
        }else{
            m_lng += prec / 2;
            m_lat -= prec / 2;
        }
    }
};



}
