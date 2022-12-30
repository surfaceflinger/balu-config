{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    (pkgs.writeScriptBin "youtube-dl" ''exec yt-dlp "$@"'')
    nixpkgs-fmt
    deadnix
    ncdu
    p7zip
    tree
    file
    magic-wormhole-rs
    pciutils
    psmisc
    usbutils
    bind
    nload
    nano
    wget
    git
    pfetch
    zsh-fast-syntax-highlighting
    lm_sensors
    aria
    htop
    screen
    rclone
    yt-dlp
  ];

  programs.nano.nanorc = ''
    set autoindent
    set tabsize 2
    set tabstospaces
  '';

  programs.htop.settings = ''
    htop_version=3.2.1
    config_reader_min_version=3
    fields=0 48 17 18 38 2 46 47 49 1
    hide_kernel_threads=1
    hide_userland_threads=1
    shadow_other_users=0
    show_thread_names=0
    show_program_path=1
    highlight_base_name=1
    highlight_deleted_exe=1
    highlight_megabytes=1
    highlight_threads=1
    highlight_changes=0
    highlight_changes_delay_secs=5
    find_comm_in_cmdline=1
    strip_exe_from_cmdline=1
    show_merged_command=0
    header_margin=1
    screen_tabs=1
    detailed_cpu_time=0
    cpu_count_from_one=0
    show_cpu_usage=1
    show_cpu_frequency=1
    show_cpu_temperature=1
    degree_fahrenheit=0
    update_process_names=0
    account_guest_in_cpu_meter=0
    color_scheme=6
    enable_mouse=1
    delay=15
    hide_function_bar=0
    header_layout=two_50_50
    column_meters_0=AllCPUs Memory Swap
    column_meter_modes_0=1 1 1
    column_meters_1=Hostname DateTime Tasks LoadAverage Uptime Systemd
    column_meter_modes_1=2 2 2 2 2 2
    tree_view=0
    sort_key=1
    tree_sort_key=0
    sort_direction=1
    tree_sort_direction=1
    tree_view_always_by_pid=0
    all_branches_collapsed=0
    screen:Main=PID USER PRIORITY NICE M_VIRT STATE PERCENT_CPU PERCENT_MEM TIME Command
    .sort_key=Command
    .tree_sort_key=PID
    .tree_view=0
    .tree_view_always_by_pid=0
    .sort_direction=1
    .tree_sort_direction=1
    .all_branches_collapsed=0
    screen:I/O=PID USER IO_PRIORITY IO_RATE IO_READ_RATE IO_WRITE_RATE
    .sort_key=IO_RATE
    .tree_sort_key=PID
    .tree_view=0
    .tree_view_always_by_pid=0
    .sort_direction=-1
    .tree_sort_direction=1
    .all_branches_collapsed=0
  '';
}
