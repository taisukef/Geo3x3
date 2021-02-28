mod geo3x3;

fn main() {
    let res = geo3x3::encode(35.65858, 139.745433, 14);
    println!("{}", res);

    let pos = geo3x3::decode("E9139659937288".to_string());
    println!("{} {} {} {}", pos.0, pos.1, pos.2, pos.3);

