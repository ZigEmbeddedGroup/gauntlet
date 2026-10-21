//! I am building off of kicad 10.0.6 for these bindings. I wish to build a
//! library where I can script things and generate kicad files, but I don't wish
//! to maintain python scripts.
//!
//! Eventually I'd like to look into writing an interactive autorouter, or
//! something that could extend kicad.
//!
//! These are the files generated when I create a new project using the default
//! template. The name of the project is "default":
//!
//! default.kicad_pro
//! =================
//! {}
//!
//! default.kicad_sch
//! =================
//! (kicad_sch
//!         (version 20260306)
//!         (generator "eeschema")
//!         (generator_version "10.0")
//!         (uuid b5f86754-8236-4ef2-8a43-759c42bea10b)
//!         (paper "A4")
//!         (lib_symbols)
//!         (sheet_instances
//!                 (path "/"
//!                         (page "1")
//!                 )
//!         )
//!         (embedded_fonts no)
//! )
//!
//! default.kicad_pcb
//! =================
//! (kicad_pcb (version 20260206) (generator "pcbnew") (generator_version "10.0")
//! )
