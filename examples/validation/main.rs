use inline_spirv::{inline_spirv};
use env_logger;
use log::error;

fn main() {
    env_logger::init();

    #[cfg(feature = "naga")]
        let hello_triangle: &[u32] = inline_spirv!(r#"
        [[stage(vertex)]]
        fn vs_main([[builtin(vertex_index)]] in_vertex_index: u32) -> [[builtin(position)]] vec4<f32> {
            let x = f32(i32(in_vertex_index) - 1);
            let y = f32(i32(in_vertex_index & 1u) * 2 - 1);
            return vec4<f32>(x, y, 0.0, 1.0);
        }

        [[stage(fragment)]]
        fn fs_main() -> [[location(0)]] vec3<f32> {
            return vec4<f32>(1.0, 0.0, 0.0, 1.0);
        }
    "#, wgsl);

    error!("It should not get here");
}
