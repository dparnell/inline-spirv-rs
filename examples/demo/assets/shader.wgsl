struct VertexOutput {
    [[location(0)]] tex_coord: vec2<f32>;
    [[builtin(position)]] position: vec4<f32>;
};

struct Locals {
    transform: mat4x4<f32>;
    prs: vec4<f32>;
};

[[group(0), binding(0)]]
var <uniform> r_locals: Locals;

[[stage(vertex)]]
fn vs_main([[location(0)]] position: vec2<f32>, [[location(1)]] tex_coord: vec2<f32>) -> VertexOutput {
    var out: VertexOutput;
    out.tex_coord = tex_coord;

    let s_th = sin(r_locals.prs.z);
    let c_th = cos(r_locals.prs.z);
    let scale = r_locals.prs.w;

    let tx = (position.x * c_th - position.y * s_th) * scale + r_locals.prs.x;
    let ty = (position.x * s_th + position.y * c_th) * scale + r_locals.prs.y;

    out.position = r_locals.transform * (vec4<f32>(tx, ty, 0.0, 1.0));
    return out;
}

[[group(0), binding(1)]]
var r_color: texture_2d<f32>;

[[stage(fragment)]]
fn fs_main(in: VertexOutput) -> [[location(0)]] vec4<f32> {
    return textureLoad(r_color, vec2<i32>(in.tex_coord), 0);
}