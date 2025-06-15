import subprocess
import tempfile
import sys
import os

if len(sys.argv) < 3:
    print("Error: need size and name")
    sys.exit(1)

arg = sys.argv[1]

if not arg.isdigit():
    print("Error: need positive digit")
    sys.exit(2)

border = int(arg)
c_filename = sys.argv[2]

with open(c_filename, "r", encoding="utf-8") as f:
    code = f.read()

new_code = 'asm("nop");'

for i in range(border):
    mod_code = code.replace("int nop_count = 1;", f"int nop_count = {i+1};")
    fin_mod_code = mod_code.replace('asm("nop");', new_code)

    with tempfile.NamedTemporaryFile(suffix=".c", delete=False) as temp_c_file:
        temp_c_file.write(fin_mod_code.encode("utf-8"))
        temp_c_name = temp_c_file.name

    output_exe = temp_c_name.replace(".c", "")
    comp_res = subprocess.run(["gcc", temp_c_name, "-o", output_exe, "-lm"], capture_output=True, text=True)

    if comp_res.returncode != 0:
        print("Error of compile:", comp_res.stderr)
    else:
        run_res = subprocess.run([output_exe], capture_output=True, text=True)
        print(f"Id {i+1}:", "Output of prog:", run_res.stdout)

    os.remove(temp_c_name)

    if os.path.exists(output_exe):
        os.remove(output_exe)

    new_code = new_code+'asm("nop");'
