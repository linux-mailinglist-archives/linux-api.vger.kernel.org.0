Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1759C1416B6
	for <lists+linux-api@lfdr.de>; Sat, 18 Jan 2020 10:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgARJMq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 18 Jan 2020 04:12:46 -0500
Received: from mga11.intel.com ([192.55.52.93]:19795 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726602AbgARJMp (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sat, 18 Jan 2020 04:12:45 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jan 2020 01:12:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,333,1574150400"; 
   d="xz'?gz'50?scan'50,208,50";a="426265963"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 18 Jan 2020 01:12:39 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1isk9n-0004c1-9D; Sat, 18 Jan 2020 17:12:39 +0800
Date:   Sat, 18 Jan 2020 17:12:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     LKP <lkp@lists.01.org>, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, philip.li@intel.com
Subject: 942437c97f ("y2038: allow disabling time32 system calls"):  init: timer.c:289: Assertion failed in nih_timer_poll: clock_gettime (CLOCK_MONOTONIC, &now) == 0
Message-ID: <5e22cbe7.mgzkaskkJnhiujnX%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_5e22cbe7.jqse+xj267DXZmp2A+UOx+o1HTUjNHG8yHtNj1aIY2NNrqVh"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This is a multi-part message in MIME format.

--=_5e22cbe7.jqse+xj267DXZmp2A+UOx+o1HTUjNHG8yHtNj1aIY2NNrqVh
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Greetings,

0day kernel testing robot got the below dmesg and the first bad commit is

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

commit 942437c97fd9ff23a17c13118f50bd0490f6868c
Author:     Arnd Bergmann <arnd@arndb.de>
AuthorDate: Mon Jul 15 11:46:10 2019 +0200
Commit:     Arnd Bergmann <arnd@arndb.de>
CommitDate: Fri Nov 15 14:38:30 2019 +0100

    y2038: allow disabling time32 system calls
    
    At the moment, the compilation of the old time32 system calls depends
    purely on the architecture. As systems with new libc based on 64-bit
    time_t are getting deployed, even architectures that previously supported
    these (notably x86-32 and arm32 but also many others) no longer depend on
    them, and removing them from a kernel image results in a smaller kernel
    binary, the same way we can leave out many other optional system calls.
    
    More importantly, on an embedded system that needs to keep working
    beyond year 2038, any user space program calling these system calls
    is likely a bug, so removing them from the kernel image does provide
    an extra debugging help for finding broken applications.
    
    I've gone back and forth on hiding this option unless CONFIG_EXPERT
    is set. This version leaves it visible based on the logic that
    eventually it will be turned off indefinitely.
    
    Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

bd40a17576  y2038: itimer: change implementation to timespec64
942437c97f  y2038: allow disabling time32 system calls
13b2668d6f  Merge tag 'gpio-v5.5-4' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio
+-----------------------------------------------------------------------------+--------+--------+--------+
|                                                                             | error: | error: | error: |
+-----------------------------------------------------------------------------+--------+--------+--------+
| boot_successes                                                              | 31     | 0      | 0      |
| boot_failures                                                               | 0      | 11     | 11     |
| Assertion_failed                                                            | 0      | 10     | 11     |
| Kernel_panic-not_syncing:Attempted_to_kill_init!exitcode=                   | 0      | 10     | 11     |
| BUG:kernel_hang_in_early-boot_stage,last_printk:early_console_in_setup_code | 0      | 1      |        |
+-----------------------------------------------------------------------------+--------+--------+--------+

If you fix the issue, kindly add following tag
Reported-by: kernel test robot <lkp@intel.com>

[    4.539891] Freeing unused kernel image memory: 1116K
[    4.540350] Write protecting kernel text and read-only data: 18052k
[    4.540748] rodata_test: all tests were successful
[    4.541048] Run /init as init process
[    4.546755] random: init: uninitialized urandom read (12 bytes read)
[    4.547403] init: timer.c:289: Assertion failed in nih_timer_poll: clock_gettime (CLOCK_MONOTONIC, &now) == 0
[    4.548967] init: Caught abort, core dumped
[    4.549626] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000600
[    4.550113] CPU: 0 PID: 1 Comm: init Tainted: G                T 5.4.0-rc6-00023-g942437c97fd9f #1
[    4.550676] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[    4.551188] Call Trace:
[    4.551351]  ? dump_stack+0x16/0x20
[    4.551575]  ? panic+0xa5/0x246
[    4.551777]  ? do_exit+0xae4/0xaf0
[    4.551993]  ? do_group_exit+0x37/0xb0
[    4.552229]  ? sys_exit_group+0x16/0x20
[    4.552470]  ? do_int80_syscall_32+0x4f/0x190
[    4.552743]  ? entry_INT80_32+0x114/0x119
[    4.552998] Kernel Offset: disabled


                                                          # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start fd6988496e79a6a4bdb514a4655d2920209eb85d v5.4 --
git bisect  bad 4672c2f2026dbc46b20647803426561fe2d460ea  # 17:42  B      0    11   27   0  Merge tag 'rtc-5.5' of git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux
git bisect good 6a0e20cd8cddd70ae5c1211ebe102d738ff2069b  # 17:51  G     11     0   11  39  Merge tag 'riscv/for-v5.5-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux
git bisect  bad 99a0d9f5e87352c4bd8d01bc9b39f7091c12e4d4  # 17:51  B      0    13   33   4  Merge tag 'gpio-v5.5-1' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio
git bisect good 6a965666b7e7475c2f8c8e724703db58b8a8a445  # 17:56  G     11     0   11  22  Merge tag 'notifications-pipe-prep-20191115' of git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs
git bisect good 3b805ca177a24ff78b466ca73febe8466c67ea61  # 18:06  G     11     0   11  22  Merge tag 'audit-pr-20191126' of git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit
git bisect good ad0b314e003049292a23dd248d3c3ca4a3d75f55  # 12:36  G     10     0   10  10  Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace
git bisect good 0da522107e5d9c000a4871d52e570912aa1225a2  # 12:42  G     10     0   10  21  Merge tag 'compat-ioctl-5.5' of git://git.kernel.org:/pub/scm/linux/kernel/git/arnd/playground
git bisect  bad ceb307474506f888e8f16dab183405ff01dffa08  # 12:42  B      0    11   27   0  Merge tag 'y2038-cleanups-5.5' of git://git.kernel.org:/pub/scm/linux/kernel/git/arnd/playground
git bisect good 0309f98f2fdc3526317e9bac150ca690f1f94ce6  # 12:43  G     11     0    0   0  y2038: socket: remove timespec reference in timestamping
git bisect good 4c22ea2b91203564fdf392b3d3cae249b652a8ae  # 12:46  G     10     0    0   2  y2038: use compat_{get,set}_itimer on alpha
git bisect  bad 942437c97fd9ff23a17c13118f50bd0490f6868c  # 12:47  B      0    10   27   1  y2038: allow disabling time32 system calls
git bisect good bd40a175769d411b2a37e1c087082ac7ee2c15bb  # 12:47  G     11     0    0   0  y2038: itimer: change implementation to timespec64
# first bad commit: [942437c97fd9ff23a17c13118f50bd0490f6868c] y2038: allow disabling time32 system calls
git bisect good bd40a175769d411b2a37e1c087082ac7ee2c15bb  # 12:54  G     31     0    0   0  y2038: itimer: change implementation to timespec64
# extra tests with debug options
# extra tests on head commit of linus/master
git bisect  bad 13b2668d6fc95dcecd11e4f86f47be24fda7da1f  # 14:45  B      0     7   23   0  Merge tag 'gpio-v5.5-4' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio
# bad: [13b2668d6fc95dcecd11e4f86f47be24fda7da1f] Merge tag 'gpio-v5.5-4' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio
# extra tests on revert first bad commit
git bisect good 6f77755a5d8699bd81e2789512cea77914fadffd  # 16:39  G     10     0    1   1  Revert "y2038: allow disabling time32 system calls"
# good: [6f77755a5d8699bd81e2789512cea77914fadffd] Revert "y2038: allow disabling time32 system calls"
# extra tests on linus/master
# 119: [25e73aadf297d78cf528841795cd37bad8320642] Merge tag 'io_uring-5.5-2020-01-16' of git://git.kernel.dk/linux-block
# extra tests on linux-next/master
# 119: [de970dffa7d19eae1d703c3534825308ef8d5dec] Add linux-next specific files for 20200117

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation

--=_5e22cbe7.jqse+xj267DXZmp2A+UOx+o1HTUjNHG8yHtNj1aIY2NNrqVh
Content-Type: application/gzip
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dmesg-quantal-vm-quantal-ecb6c3357f03:20200109035804:i386-randconfig-e002-20200106:5.4.0-rc6-00023-g942437c97fd9f:1.gz"

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
4g+1ic8AAA==

--=_5e22cbe7.jqse+xj267DXZmp2A+UOx+o1HTUjNHG8yHtNj1aIY2NNrqVh
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="reproduce-quantal-vm-quantal-ecb6c3357f03:20200109035804:i386-randconfig-e002-20200106:5.4.0-rc6-00023-g942437c97fd9f:1"

#!/bin/bash

kernel=$1
initrd=quantal-trinity-i386.cgz

wget --no-clobber https://download.01.org/0day-ci/lkp-qemu/osimage/quantal/$initrd

kvm=(
	qemu-system-x86_64
	-enable-kvm
	-cpu kvm64
	-kernel $kernel
	-initrd $initrd
	-m 8192
	-smp 2
	-device e1000,netdev=net0
	-netdev user,id=net0,hostfwd=tcp::32032-:22
	-boot order=nc
	-no-reboot
	-watchdog i6300esb
	-watchdog-action debug
	-rtc base=localtime
	-serial stdio
	-display none
	-monitor null
)

append=(
	root=/dev/ram0
	hung_task_panic=1
	debug
	apic=debug
	sysrq_always_enabled
	rcupdate.rcu_cpu_stall_timeout=100
	net.ifnames=0
	printk.devkmsg=on
	panic=-1
	softlockup_panic=1
	nmi_watchdog=panic
	oops=panic
	load_ramdisk=2
	prompt_ramdisk=0
	drbd.minor_count=8
	systemd.log_level=err
	ignore_loglevel
	console=tty0
	earlyprintk=ttyS0,115200
	console=ttyS0,115200
	vga=normal
	rw
	rcuperf.shutdown=0
	watchdog_thresh=60
)

"${kvm[@]}" -append "${append[*]}"

--=_5e22cbe7.jqse+xj267DXZmp2A+UOx+o1HTUjNHG8yHtNj1aIY2NNrqVh
Content-Type: application/x-xz
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="9aeb8818b8b046909afe43fb54c0ca6f7d1372e0:gcc-7:i386-randconfig-e002-20200106:Kernel_panic-not_syncing:Attempted_to_kill_init_exitcode=.xz"

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
+68DAG8yTw+xxGf7AgAAAAAEWVo=

--=_5e22cbe7.jqse+xj267DXZmp2A+UOx+o1HTUjNHG8yHtNj1aIY2NNrqVh
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="config-5.4.0-rc6-00023-g942437c97fd9f"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 5.4.0-rc6 Kernel Configuration
#

#
# Compiler: gcc-7 (Debian 7.5.0-3) 7.5.0
#
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=70500
CONFIG_CLANG_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_WARN_MAYBE_UNINITIALIZED=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_HEADER_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
# CONFIG_KERNEL_GZIP is not set
CONFIG_KERNEL_BZIP2=y
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
# CONFIG_SYSVIPC is not set
# CONFIG_POSIX_MQUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_USELIB=y
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_DATA=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
# CONFIG_NO_HZ is not set
CONFIG_HIGH_RES_TIMERS=y
# end of Timers subsystem

# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
# CONFIG_TASK_IO_ACCOUNTING is not set
CONFIG_PSI=y
CONFIG_PSI_DEFAULT_DISABLED=y
# end of CPU/Task time and stats accounting

#
# RCU Subsystem
#
CONFIG_TINY_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TINY_SRCU=y
CONFIG_TASKS_RCU=y
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_IKHEADERS=m
CONFIG_LOG_BUF_SHIFT=20
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# end of Scheduler features

CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CGROUPS=y
# CONFIG_MEMCG is not set
# CONFIG_BLK_CGROUP is not set
# CONFIG_CGROUP_SCHED is not set
# CONFIG_CGROUP_PIDS is not set
# CONFIG_CGROUP_RDMA is not set
# CONFIG_CGROUP_FREEZER is not set
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_CGROUP_PERF is not set
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
# CONFIG_UTS_NS is not set
# CONFIG_USER_NS is not set
CONFIG_PID_NS=y
CONFIG_NET_NS=y
CONFIG_CHECKPOINT_RESTORE=y
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
# CONFIG_PCSPKR_PLATFORM is not set
# CONFIG_BASE_FULL is not set
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
# CONFIG_ADVISE_SYSCALLS is not set
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
# CONFIG_BPF_JIT_ALWAYS_ON is not set
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
CONFIG_DEBUG_PERF_USE_VMALLOC=y
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
CONFIG_SLAB_FREELIST_HARDENED=y
# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_X86_32=y
CONFIG_FORCE_DYNAMIC_FTRACE=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf32-i386"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/i386_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_BITS_MAX=16
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=2
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
# CONFIG_ZONE_DMA is not set
# CONFIG_SMP is not set
CONFIG_X86_FEATURE_NAMES=y
# CONFIG_X86_MPPARSE is not set
CONFIG_GOLDFISH=y
# CONFIG_RETPOLINE is not set
# CONFIG_X86_CPU_RESCTRL is not set
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_RDC321X=y
CONFIG_X86_32_IRIS=m
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
# CONFIG_KVM_DEBUG_FS is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_M486 is not set
# CONFIG_M586 is not set
CONFIG_M586TSC=y
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MELAN is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_MVIAC7 is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_X86_GENERIC=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_F00F_BUG=y
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_MINIMUM_CPU_FAMILY=5
CONFIG_PROCESSOR_SELECT=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_CYRIX_32=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
# CONFIG_CPU_SUP_CENTAUR is not set
CONFIG_CPU_SUP_TRANSMETA_32=y
# CONFIG_CPU_SUP_UMC_32 is not set
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_DMI=y
CONFIG_NR_CPUS_RANGE_BEGIN=1
CONFIG_NR_CPUS_RANGE_END=1
CONFIG_NR_CPUS_DEFAULT=1
CONFIG_NR_CPUS=1
CONFIG_UP_LATE_INIT=y
CONFIG_X86_UP_APIC=y
# CONFIG_X86_UP_IOAPIC is not set
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
# CONFIG_X86_MCE is not set

#
# Performance monitoring
#
# CONFIG_PERF_EVENTS_INTEL_UNCORE is not set
CONFIG_PERF_EVENTS_INTEL_RAPL=y
# CONFIG_PERF_EVENTS_INTEL_CSTATE is not set
CONFIG_PERF_EVENTS_AMD_POWER=m
# end of Performance monitoring

CONFIG_X86_LEGACY_VM86=y
CONFIG_VM86=y
CONFIG_TOSHIBA=y
CONFIG_I8K=m
CONFIG_X86_REBOOTFIXUPS=y
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_VMSPLIT_3G is not set
# CONFIG_VMSPLIT_3G_OPT is not set
# CONFIG_VMSPLIT_2G is not set
# CONFIG_VMSPLIT_2G_OPT is not set
CONFIG_VMSPLIT_1G=y
CONFIG_PAGE_OFFSET=0x40000000
# CONFIG_X86_PAE is not set
CONFIG_X86_CPA_STATISTICS=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
# CONFIG_ARCH_RANDOM is not set
# CONFIG_X86_SMAP is not set
CONFIG_X86_INTEL_UMIP=y
CONFIG_EFI=y
# CONFIG_EFI_STUB is not set
# CONFIG_SECCOMP is not set
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_300=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=300
CONFIG_SCHED_HRTICK=y
# CONFIG_KEXEC is not set
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_COMPAT_VDSO=y
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_MODIFY_LDT_SYSCALL is not set
# end of Processor type and features

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
# CONFIG_HIBERNATION is not set
# CONFIG_PM is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
# CONFIG_ACPI_CONTAINER is not set
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
# CONFIG_ACPI_HED is not set
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_BGRT is not set
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
# CONFIG_DPTF_POWER is not set
# CONFIG_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
# CONFIG_CPU_IDLE_GOV_MENU is not set
# CONFIG_CPU_IDLE_GOV_TEO is not set
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

# CONFIG_INTEL_IDLE is not set
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
# CONFIG_PCI_GOBIOS is not set
CONFIG_PCI_GOMMCONFIG=y
# CONFIG_PCI_GODIRECT is not set
# CONFIG_PCI_GOOLPC is not set
# CONFIG_PCI_GOANY is not set
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
CONFIG_ISA_BUS=y
CONFIG_ISA_DMA_API=y
CONFIG_ISA=y
CONFIG_SCx200=m
CONFIG_SCx200HR_TIMER=m
CONFIG_OLPC=y
# CONFIG_OLPC_XO15_SCI is not set
CONFIG_ALIX=y
CONFIG_NET5501=y
CONFIG_GEOS=y
CONFIG_AMD_NB=y
CONFIG_X86_SYSFB=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_COMPAT_32=y
# end of Binary Emulations

CONFIG_HAVE_ATOMIC_IOMAP=y

#
# Firmware Drivers
#
# CONFIG_EDD is not set
# CONFIG_FIRMWARE_MEMMAP is not set
# CONFIG_DMIID is not set
CONFIG_DMI_SYSFS=m
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_FW_CFG_SYSFS is not set
CONFIG_GOOGLE_FIRMWARE=y
# CONFIG_GOOGLE_SMI is not set
CONFIG_GOOGLE_COREBOOT_TABLE=y
# CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY is not set
CONFIG_GOOGLE_FRAMEBUFFER_COREBOOT=y
# CONFIG_GOOGLE_MEMCONSOLE_COREBOOT is not set
# CONFIG_GOOGLE_VPD is not set

#
# EFI (Extensible Firmware Interface) Support
#
# CONFIG_EFI_VARS is not set
CONFIG_EFI_ESRT=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_CAPSULE_LOADER=y
CONFIG_EFI_CAPSULE_QUIRK_QUARK_CSH=y
# CONFIG_EFI_TEST is not set
# CONFIG_EFI_RCI2_TABLE is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_EFI_EARLYCON=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
CONFIG_KVM_INTEL=m
CONFIG_KVM_AMD=m
# CONFIG_KVM_MMU_AUDIT is not set
# CONFIG_VHOST_NET is not set
CONFIG_VHOST_CROSS_ENDIAN_LEGACY=y

#
# General architecture-dependent options
#
# CONFIG_OPROFILE is not set
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
# CONFIG_KPROBES is not set
# CONFIG_JUMP_LABEL is not set
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_ARCH_32BIT_OFF_T=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_HAVE_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_REL=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=8
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_ISA_BUS_API=y
CONFIG_CLONE_BACKWARDS=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_OLD_SIGACTION=y
# CONFIG_COMPAT_32BIT_TIME is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_REFCOUNT=y
# CONFIG_REFCOUNT_FULL is not set
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_PLUGIN_HOSTCC="g++"
CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y

#
# GCC plugins
#
# CONFIG_GCC_PLUGIN_CYC_COMPLEXITY is not set
CONFIG_GCC_PLUGIN_LATENT_ENTROPY=y
CONFIG_GCC_PLUGIN_RANDSTRUCT=y
# CONFIG_GCC_PLUGIN_RANDSTRUCT_PERFORMANCE is not set
# end of GCC plugins
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=1
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
# CONFIG_MODULE_UNLOAD is not set
CONFIG_MODVERSIONS=y
CONFIG_ASM_MODVERSIONS=y
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS is not set
CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS=y
CONFIG_UNUSED_SYMBOLS=y
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
# CONFIG_BLK_DEV_BSGLIB is not set
# CONFIG_BLK_DEV_INTEGRITY is not set
# CONFIG_BLK_DEV_ZONED is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
# CONFIG_BLK_WBT is not set
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
# end of Partition Types

CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
# CONFIG_IOSCHED_BFQ is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
CONFIG_BINFMT_SCRIPT=y
# CONFIG_BINFMT_MISC is not set
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
# CONFIG_FLATMEM_MANUAL is not set
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
# CONFIG_COMPACTION is not set
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
# CONFIG_TRANSPARENT_HUGEPAGE is not set
CONFIG_NEED_PER_CPU_KM=y
CONFIG_CLEANCACHE=y
# CONFIG_FRONTSWAP is not set
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
CONFIG_CMA_DEBUGFS=y
CONFIG_CMA_AREAS=7
CONFIG_ZPOOL=m
# CONFIG_ZBUD is not set
# CONFIG_Z3FOLD is not set
# CONFIG_ZSMALLOC is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_FRAME_VECTOR=y
# CONFIG_PERCPU_STATS is not set
CONFIG_GUP_BENCHMARK=y
CONFIG_ARCH_HAS_PTE_SPECIAL=y
# end of Memory Management options

CONFIG_NET=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
# CONFIG_PACKET is not set
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_UNIX_DIAG=y
CONFIG_TLS=m
CONFIG_TLS_DEVICE=y
CONFIG_XFRM=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=m
# CONFIG_XFRM_SUB_POLICY is not set
# CONFIG_XFRM_MIGRATE is not set
# CONFIG_XFRM_STATISTICS is not set
CONFIG_XFRM_IPCOMP=y
CONFIG_NET_KEY=m
# CONFIG_NET_KEY_MIGRATE is not set
CONFIG_XDP_SOCKETS=y
CONFIG_XDP_SOCKETS_DIAG=m
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
# CONFIG_IP_FIB_TRIE_STATS is not set
CONFIG_IP_MULTIPLE_TABLES=y
# CONFIG_IP_ROUTE_MULTIPATH is not set
# CONFIG_IP_ROUTE_VERBOSE is not set
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
CONFIG_IP_PNP_RARP=y
CONFIG_NET_IPIP=m
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=y
# CONFIG_IP_MROUTE is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_NET_IPVTI is not set
CONFIG_NET_UDP_TUNNEL=y
CONFIG_NET_FOU=m
CONFIG_NET_FOU_IP_TUNNELS=y
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
CONFIG_INET_IPCOMP=y
CONFIG_INET_XFRM_TUNNEL=y
CONFIG_INET_TUNNEL=y
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
# CONFIG_INET_UDP_DIAG is not set
# CONFIG_INET_RAW_DIAG is not set
CONFIG_INET_DIAG_DESTROY=y
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=y
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=y
CONFIG_TCP_CONG_HSTCP=m
# CONFIG_TCP_CONG_HYBLA is not set
CONFIG_TCP_CONG_VEGAS=y
CONFIG_TCP_CONG_NV=m
# CONFIG_TCP_CONG_SCALABLE is not set
CONFIG_TCP_CONG_LP=y
# CONFIG_TCP_CONG_VENO is not set
CONFIG_TCP_CONG_YEAH=y
CONFIG_TCP_CONG_ILLINOIS=y
CONFIG_TCP_CONG_DCTCP=m
CONFIG_TCP_CONG_CDG=y
CONFIG_TCP_CONG_BBR=y
# CONFIG_DEFAULT_BIC is not set
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_HTCP is not set
# CONFIG_DEFAULT_VEGAS is not set
# CONFIG_DEFAULT_CDG is not set
# CONFIG_DEFAULT_BBR is not set
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
# CONFIG_IPV6 is not set
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
# CONFIG_NETFILTER is not set
# CONFIG_BPFILTER is not set
CONFIG_IP_DCCP=y
CONFIG_INET_DCCP_DIAG=m

#
# DCCP CCIDs Configuration
#
# CONFIG_IP_DCCP_CCID2_DEBUG is not set
# CONFIG_IP_DCCP_CCID3 is not set
# end of DCCP CCIDs Configuration

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
# end of DCCP Kernel Hacking

CONFIG_IP_SCTP=y
CONFIG_SCTP_DBG_OBJCNT=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
# CONFIG_SCTP_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
CONFIG_TIPC=y
# CONFIG_TIPC_MEDIA_UDP is not set
CONFIG_TIPC_DIAG=m
CONFIG_ATM=y
CONFIG_ATM_CLIP=y
CONFIG_ATM_CLIP_NO_ICMP=y
CONFIG_ATM_LANE=m
CONFIG_ATM_MPOA=y
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=y
# CONFIG_L2TP_DEBUGFS is not set
CONFIG_L2TP_V3=y
# CONFIG_L2TP_IP is not set
CONFIG_L2TP_ETH=m
CONFIG_MRP=y
# CONFIG_BRIDGE is not set
CONFIG_HAVE_NET_DSA=y
CONFIG_NET_DSA=m
# CONFIG_NET_DSA_TAG_8021Q is not set
CONFIG_NET_DSA_TAG_BRCM_COMMON=m
CONFIG_NET_DSA_TAG_BRCM=m
CONFIG_NET_DSA_TAG_BRCM_PREPEND=m
CONFIG_NET_DSA_TAG_GSWIP=m
CONFIG_NET_DSA_TAG_DSA=m
CONFIG_NET_DSA_TAG_EDSA=m
CONFIG_NET_DSA_TAG_MTK=m
CONFIG_NET_DSA_TAG_KSZ=m
CONFIG_NET_DSA_TAG_QCA=m
CONFIG_NET_DSA_TAG_LAN9303=m
# CONFIG_NET_DSA_TAG_SJA1105 is not set
CONFIG_NET_DSA_TAG_TRAILER=m
CONFIG_VLAN_8021Q=y
# CONFIG_VLAN_8021Q_GVRP is not set
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
CONFIG_LLC=y
CONFIG_LLC2=y
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
CONFIG_PHONET=y
CONFIG_IEEE802154=y
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
# CONFIG_IEEE802154_SOCKET is not set
# CONFIG_MAC802154 is not set
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
# CONFIG_NET_SCH_HTB is not set
# CONFIG_NET_SCH_HFSC is not set
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=y
CONFIG_NET_SCH_MULTIQ=m
# CONFIG_NET_SCH_RED is not set
CONFIG_NET_SCH_SFB=y
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=y
CONFIG_NET_SCH_TBF=y
CONFIG_NET_SCH_CBS=m
# CONFIG_NET_SCH_ETF is not set
# CONFIG_NET_SCH_TAPRIO is not set
# CONFIG_NET_SCH_GRED is not set
# CONFIG_NET_SCH_DSMARK is not set
CONFIG_NET_SCH_NETEM=y
CONFIG_NET_SCH_DRR=y
CONFIG_NET_SCH_MQPRIO=m
CONFIG_NET_SCH_SKBPRIO=y
CONFIG_NET_SCH_CHOKE=m
# CONFIG_NET_SCH_QFQ is not set
CONFIG_NET_SCH_CODEL=y
CONFIG_NET_SCH_FQ_CODEL=y
CONFIG_NET_SCH_CAKE=y
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=m
# CONFIG_NET_SCH_PIE is not set
CONFIG_NET_SCH_INGRESS=y
CONFIG_NET_SCH_PLUG=y
# CONFIG_NET_SCH_DEFAULT is not set

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=y
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=y
# CONFIG_NET_CLS_FW is not set
CONFIG_NET_CLS_U32=y
# CONFIG_CLS_U32_PERF is not set
# CONFIG_CLS_U32_MARK is not set
CONFIG_NET_CLS_RSVP=y
CONFIG_NET_CLS_RSVP6=y
CONFIG_NET_CLS_FLOW=y
# CONFIG_NET_CLS_CGROUP is not set
CONFIG_NET_CLS_BPF=m
# CONFIG_NET_CLS_FLOWER is not set
# CONFIG_NET_CLS_MATCHALL is not set
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
# CONFIG_NET_EMATCH_NBYTE is not set
CONFIG_NET_EMATCH_U32=y
# CONFIG_NET_EMATCH_META is not set
CONFIG_NET_EMATCH_TEXT=m
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=y
# CONFIG_NET_ACT_GACT is not set
# CONFIG_NET_ACT_MIRRED is not set
# CONFIG_NET_ACT_SAMPLE is not set
# CONFIG_NET_ACT_NAT is not set
# CONFIG_NET_ACT_PEDIT is not set
CONFIG_NET_ACT_SIMP=y
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=y
CONFIG_NET_ACT_MPLS=y
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=y
# CONFIG_NET_ACT_SKBMOD is not set
# CONFIG_NET_ACT_IFE is not set
# CONFIG_NET_ACT_TUNNEL_KEY is not set
CONFIG_NET_TC_SKB_EXT=y
CONFIG_NET_SCH_FIFO=y
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=y
CONFIG_BATMAN_ADV=y
# CONFIG_BATMAN_ADV_BATMAN_V is not set
# CONFIG_BATMAN_ADV_BLA is not set
CONFIG_BATMAN_ADV_DAT=y
CONFIG_BATMAN_ADV_NC=y
# CONFIG_BATMAN_ADV_MCAST is not set
# CONFIG_BATMAN_ADV_DEBUGFS is not set
CONFIG_BATMAN_ADV_DEBUG=y
# CONFIG_BATMAN_ADV_SYSFS is not set
# CONFIG_BATMAN_ADV_TRACING is not set
CONFIG_OPENVSWITCH=y
CONFIG_OPENVSWITCH_GENEVE=m
# CONFIG_VSOCKETS is not set
CONFIG_NETLINK_DIAG=y
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=y
CONFIG_HSR=m
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
CONFIG_NET_NCSI=y
# CONFIG_NCSI_OEM_CMD_GET_MAC is not set
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_STREAM_PARSER=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
CONFIG_BT=m
CONFIG_BT_BREDR=y
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
CONFIG_BT_CMTP=y
CONFIG_BT_HIDP=m
CONFIG_BT_HS=y
CONFIG_BT_LE=y
# CONFIG_BT_LEDS is not set
# CONFIG_BT_SELFTEST is not set
CONFIG_BT_DEBUGFS=y

#
# Bluetooth device drivers
#
# CONFIG_BT_HCIUART is not set
CONFIG_BT_HCIDTL1=m
# CONFIG_BT_HCIBT3C is not set
# CONFIG_BT_HCIBLUECARD is not set
CONFIG_BT_HCIVHCI=m
CONFIG_BT_MRVL=m
# end of Bluetooth device drivers

CONFIG_AF_RXRPC=y
# CONFIG_AF_RXRPC_INJECT_LOSS is not set
CONFIG_AF_RXRPC_DEBUG=y
CONFIG_RXKAD=y
CONFIG_AF_KCM=m
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WIRELESS_EXT=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_WEXT_SPY=y
CONFIG_WEXT_PRIV=y
# CONFIG_CFG80211 is not set
CONFIG_LIB80211=m
CONFIG_LIB80211_CRYPT_WEP=m
CONFIG_LIB80211_CRYPT_CCMP=m
CONFIG_LIB80211_CRYPT_TKIP=m
CONFIG_LIB80211_DEBUG=y

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_WIMAX=m
CONFIG_WIMAX_DEBUG_LEVEL=8
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
CONFIG_RFKILL_GPIO=m
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_DEBUG is not set
CONFIG_CAIF=m
# CONFIG_CAIF_DEBUG is not set
# CONFIG_CAIF_NETDEV is not set
CONFIG_CAIF_USB=m
CONFIG_CEPH_LIB=m
CONFIG_CEPH_LIB_PRETTYDEBUG=y
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
# CONFIG_NFC is not set
CONFIG_PSAMPLE=y
CONFIG_NET_IFE=m
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_SOCK_VALIDATE_XMIT=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_PAGE_POOL=y
CONFIG_FAILOVER=y
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
# CONFIG_PCI_STUB is not set
CONFIG_PCI_PF_STUB=m
CONFIG_PCI_ATS=y
CONFIG_PCI_ECAM=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
# CONFIG_HOTPLUG_PCI is not set

#
# PCI controller drivers
#

#
# Cadence PCIe controllers support
#
# CONFIG_PCIE_CADENCE_HOST is not set
# end of Cadence PCIe controllers support

CONFIG_PCI_FTPCI100=y
CONFIG_PCI_HOST_COMMON=y
CONFIG_PCI_HOST_GENERIC=y
# CONFIG_PCIE_XILINX is not set

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
CONFIG_PCI_SW_SWITCHTEC=m
# end of PCI switch controller drivers

CONFIG_PCCARD=y
CONFIG_PCMCIA=y
CONFIG_PCMCIA_LOAD_CIS=y
# CONFIG_CARDBUS is not set

#
# PC-card bridges
#
# CONFIG_YENTA is not set
# CONFIG_PD6729 is not set
# CONFIG_I82092 is not set
CONFIG_I82365=m
CONFIG_TCIC=m
CONFIG_PCMCIA_PROBE=y
CONFIG_PCCARD_NONSTATIC=y
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
# CONFIG_ALLOW_DEV_COREDUMP is not set
# CONFIG_DEBUG_DRIVER is not set
CONFIG_DEBUG_DEVRES=y
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_TEST_ASYNC_DRIVER_PROBE=m
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_SPMI=m
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_I3C=m
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
CONFIG_MOXTET=m
# end of Bus devices

# CONFIG_CONNECTOR is not set
CONFIG_GNSS=y
# CONFIG_MTD is not set
CONFIG_DTC=y
CONFIG_OF=y
CONFIG_OF_UNITTEST=y
CONFIG_OF_FLATTREE=y
CONFIG_OF_EARLY_FLATTREE=y
CONFIG_OF_PROMTREE=y
CONFIG_OF_KOBJ=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_NET=y
CONFIG_OF_MDIO=y
CONFIG_OF_RESERVED_MEM=y
CONFIG_OF_RESOLVE=y
CONFIG_OF_OVERLAY=y
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
# CONFIG_PARPORT_PC_PCMCIA is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
# CONFIG_ISAPNP is not set
# CONFIG_PNPBIOS is not set
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
# CONFIG_BLK_DEV_FD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_VIRTIO_BLK is not set
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
# CONFIG_BLK_DEV_NVME is not set
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TARGET is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
CONFIG_AD525X_DPOT=y
# CONFIG_AD525X_DPOT_I2C is not set
CONFIG_AD525X_DPOT_SPI=y
CONFIG_DUMMY_IRQ=y
# CONFIG_IBM_ASM is not set
CONFIG_PHANTOM=y
CONFIG_TIFM_CORE=y
# CONFIG_TIFM_7XX1 is not set
CONFIG_ICS932S401=y
CONFIG_ENCLOSURE_SERVICES=y
CONFIG_CS5535_MFGPT=m
CONFIG_CS5535_MFGPT_DEFAULT_IRQ=7
CONFIG_CS5535_CLOCK_EVENT_SRC=m
# CONFIG_HP_ILO is not set
CONFIG_APDS9802ALS=y
CONFIG_ISL29003=m
CONFIG_ISL29020=m
# CONFIG_SENSORS_TSL2550 is not set
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=y
# CONFIG_HMC6352 is not set
CONFIG_DS1682=y
CONFIG_PCH_PHUB=y
CONFIG_LATTICE_ECP3_CONFIG=y
CONFIG_SRAM=y
CONFIG_PCI_ENDPOINT_TEST=y
CONFIG_XILINX_SDFEC=m
CONFIG_MISC_RTSX=y
# CONFIG_PVPANIC is not set
CONFIG_C2PORT=m
CONFIG_C2PORT_DURAMAR_2150=m

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
CONFIG_EEPROM_AT25=m
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
CONFIG_EEPROM_93XX46=m
CONFIG_EEPROM_IDT_89HPESX=y
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

CONFIG_CB710_CORE=m
CONFIG_CB710_DEBUG=y
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m
# CONFIG_ALTERA_STAPL is not set
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
CONFIG_INTEL_MEI_TXE=m
CONFIG_INTEL_MEI_HDCP=m
# CONFIG_VMWARE_VMCI is not set

#
# Intel MIC & related support
#

#
# Intel MIC Bus Driver
#

#
# SCIF Bus Driver
#

#
# VOP Bus Driver
#
CONFIG_VOP_BUS=m

#
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#

#
# SCIF Driver
#

#
# Intel MIC Coprocessor State Management (COSM) Drivers
#

#
# VOP Driver
#
CONFIG_VOP=m
CONFIG_VHOST_RING=m
# end of Intel MIC & related support

CONFIG_ECHO=y
CONFIG_MISC_ALCOR_PCI=m
CONFIG_MISC_RTSX_PCI=y
CONFIG_HABANA_AI=m
# end of Misc devices

CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
# CONFIG_RAID_ATTRS is not set
# CONFIG_SCSI is not set
# end of SCSI device support

# CONFIG_ATA is not set
# CONFIG_MD is not set
# CONFIG_TARGET_CORE is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
CONFIG_FIREWIRE_NOSY=m
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
# CONFIG_MAC_EMUMOUSEBTN is not set
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
CONFIG_DUMMY=m
CONFIG_EQUALIZER=m
# CONFIG_IFB is not set
CONFIG_NET_TEAM=m
CONFIG_NET_TEAM_MODE_BROADCAST=m
CONFIG_NET_TEAM_MODE_ROUNDROBIN=m
CONFIG_NET_TEAM_MODE_RANDOM=m
# CONFIG_NET_TEAM_MODE_ACTIVEBACKUP is not set
CONFIG_NET_TEAM_MODE_LOADBALANCE=m
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
CONFIG_GENEVE=m
CONFIG_GTP=y
CONFIG_MACSEC=y
# CONFIG_NETCONSOLE is not set
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
CONFIG_VIRTIO_NET=m
CONFIG_NLMON=m
CONFIG_NET_VRF=y
CONFIG_ARCNET=m
# CONFIG_ARCNET_1201 is not set
CONFIG_ARCNET_1051=m
CONFIG_ARCNET_RAW=m
CONFIG_ARCNET_CAP=m
CONFIG_ARCNET_COM90xx=m
CONFIG_ARCNET_COM90xxIO=m
CONFIG_ARCNET_RIM_I=m
CONFIG_ARCNET_COM20020=m
CONFIG_ARCNET_COM20020_ISA=m
CONFIG_ARCNET_COM20020_PCI=m
CONFIG_ARCNET_COM20020_CS=m
CONFIG_ATM_DRIVERS=y
CONFIG_ATM_DUMMY=m
CONFIG_ATM_TCP=y
CONFIG_ATM_LANAI=y
# CONFIG_ATM_ENI is not set
# CONFIG_ATM_FIRESTREAM is not set
CONFIG_ATM_ZATM=m
CONFIG_ATM_ZATM_DEBUG=y
# CONFIG_ATM_NICSTAR is not set
CONFIG_ATM_IDT77252=m
# CONFIG_ATM_IDT77252_DEBUG is not set
# CONFIG_ATM_IDT77252_RCV_ALL is not set
CONFIG_ATM_IDT77252_USE_SUNI=y
CONFIG_ATM_AMBASSADOR=y
CONFIG_ATM_AMBASSADOR_DEBUG=y
# CONFIG_ATM_HORIZON is not set
# CONFIG_ATM_IA is not set
CONFIG_ATM_FORE200E=m
# CONFIG_ATM_FORE200E_USE_TASKLET is not set
CONFIG_ATM_FORE200E_TX_RETRY=16
CONFIG_ATM_FORE200E_DEBUG=0
CONFIG_ATM_HE=y
CONFIG_ATM_HE_USE_SUNI=y
CONFIG_ATM_SOLOS=m

#
# CAIF transport drivers
#
# CONFIG_CAIF_TTY is not set
# CONFIG_CAIF_SPI_SLAVE is not set
CONFIG_CAIF_HSI=m
# CONFIG_CAIF_VIRTIO is not set

#
# Distributed Switch Architecture drivers
#
CONFIG_B53=m
CONFIG_B53_SPI_DRIVER=m
CONFIG_B53_MDIO_DRIVER=m
CONFIG_B53_MMAP_DRIVER=m
CONFIG_B53_SRAB_DRIVER=m
CONFIG_B53_SERDES=m
CONFIG_NET_DSA_BCM_SF2=m
CONFIG_NET_DSA_LOOP=m
CONFIG_NET_DSA_LANTIQ_GSWIP=m
CONFIG_NET_DSA_MT7530=m
# CONFIG_NET_DSA_MV88E6060 is not set
CONFIG_NET_DSA_MICROCHIP_KSZ_COMMON=m
CONFIG_NET_DSA_MICROCHIP_KSZ9477=m
CONFIG_NET_DSA_MICROCHIP_KSZ9477_I2C=m
# CONFIG_NET_DSA_MICROCHIP_KSZ9477_SPI is not set
# CONFIG_NET_DSA_MICROCHIP_KSZ8795 is not set
CONFIG_NET_DSA_MV88E6XXX=m
CONFIG_NET_DSA_MV88E6XXX_GLOBAL2=y
# CONFIG_NET_DSA_MV88E6XXX_PTP is not set
# CONFIG_NET_DSA_SJA1105 is not set
CONFIG_NET_DSA_QCA8K=m
CONFIG_NET_DSA_REALTEK_SMI=m
CONFIG_NET_DSA_SMSC_LAN9303=m
CONFIG_NET_DSA_SMSC_LAN9303_I2C=m
CONFIG_NET_DSA_SMSC_LAN9303_MDIO=m
CONFIG_NET_DSA_VITESSE_VSC73XX=m
CONFIG_NET_DSA_VITESSE_VSC73XX_SPI=m
CONFIG_NET_DSA_VITESSE_VSC73XX_PLATFORM=m
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_VENDOR_ADAPTEC is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
# CONFIG_NET_VENDOR_ALACRITECH is not set
CONFIG_NET_VENDOR_ALTEON=y
CONFIG_ACENIC=m
CONFIG_ACENIC_OMIT_TIGON_I=y
CONFIG_ALTERA_TSE=y
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
CONFIG_NET_VENDOR_AMD=y
CONFIG_AMD8111_ETH=m
CONFIG_LANCE=y
# CONFIG_PCNET32 is not set
# CONFIG_PCMCIA_NMCLAN is not set
CONFIG_NI65=y
CONFIG_AMD_XGBE=y
CONFIG_AMD_XGBE_HAVE_ECC=y
CONFIG_NET_VENDOR_AQUANTIA=y
CONFIG_NET_VENDOR_ARC=y
# CONFIG_NET_VENDOR_ATHEROS is not set
CONFIG_NET_VENDOR_AURORA=y
# CONFIG_AURORA_NB8800 is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
CONFIG_BNX2=y
CONFIG_CNIC=y
CONFIG_TIGON3=y
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
CONFIG_BNXT=y
CONFIG_BNXT_SRIOV=y
# CONFIG_BNXT_FLOWER_OFFLOAD is not set
# CONFIG_NET_VENDOR_BROCADE is not set
# CONFIG_NET_VENDOR_CADENCE is not set
# CONFIG_NET_VENDOR_CAVIUM is not set
# CONFIG_NET_VENDOR_CHELSIO is not set
CONFIG_NET_VENDOR_CIRRUS=y
# CONFIG_CS89x0 is not set
# CONFIG_NET_VENDOR_CISCO is not set
# CONFIG_NET_VENDOR_CORTINA is not set
CONFIG_CX_ECAT=y
CONFIG_DNET=m
# CONFIG_NET_VENDOR_DEC is not set
# CONFIG_NET_VENDOR_DLINK is not set
CONFIG_NET_VENDOR_EMULEX=y
CONFIG_BE2NET=y
# CONFIG_BE2NET_BE2 is not set
CONFIG_BE2NET_BE3=y
# CONFIG_BE2NET_LANCER is not set
# CONFIG_BE2NET_SKYHAWK is not set
CONFIG_NET_VENDOR_EZCHIP=y
# CONFIG_EZCHIP_NPS_MANAGEMENT_ENET is not set
# CONFIG_NET_VENDOR_FUJITSU is not set
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
# CONFIG_NET_VENDOR_HP is not set
CONFIG_NET_VENDOR_HUAWEI=y
CONFIG_HINIC=y
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
CONFIG_E100=y
CONFIG_E1000=y
# CONFIG_E1000E is not set
CONFIG_IGB=y
CONFIG_IGBVF=y
CONFIG_IXGB=y
# CONFIG_IXGBE is not set
# CONFIG_IXGBEVF is not set
CONFIG_I40E=y
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
CONFIG_IGC=m
CONFIG_JME=m
# CONFIG_NET_VENDOR_MARVELL is not set
CONFIG_NET_VENDOR_MELLANOX=y
CONFIG_MLX4_EN=m
CONFIG_MLX4_CORE=m
CONFIG_MLX4_DEBUG=y
# CONFIG_MLX4_CORE_GEN2 is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
# CONFIG_NET_VENDOR_MICREL is not set
CONFIG_NET_VENDOR_MICROCHIP=y
CONFIG_ENC28J60=m
CONFIG_ENC28J60_WRITEVERIFY=y
# CONFIG_ENCX24J600 is not set
CONFIG_LAN743X=y
# CONFIG_NET_VENDOR_MICROSEMI is not set
CONFIG_NET_VENDOR_MYRI=y
CONFIG_MYRI10GE=y
CONFIG_FEALNX=y
CONFIG_NET_VENDOR_NATSEMI=y
CONFIG_NATSEMI=y
CONFIG_NS83820=y
CONFIG_NET_VENDOR_NETERION=y
CONFIG_S2IO=y
CONFIG_VXGE=y
# CONFIG_VXGE_DEBUG_TRACE_ALL is not set
# CONFIG_NET_VENDOR_NETRONOME is not set
CONFIG_NET_VENDOR_NI=y
CONFIG_NI_XGE_MANAGEMENT_ENET=m
# CONFIG_NET_VENDOR_8390 is not set
# CONFIG_NET_VENDOR_NVIDIA is not set
# CONFIG_NET_VENDOR_OKI is not set
CONFIG_ETHOC=m
# CONFIG_NET_VENDOR_PACKET_ENGINES is not set
CONFIG_NET_VENDOR_PENSANDO=y
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
CONFIG_QLCNIC=m
# CONFIG_QLCNIC_SRIOV is not set
# CONFIG_QLCNIC_HWMON is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
# CONFIG_NET_VENDOR_QUALCOMM is not set
# CONFIG_NET_VENDOR_RDC is not set
# CONFIG_NET_VENDOR_REALTEK is not set
# CONFIG_NET_VENDOR_RENESAS is not set
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
# CONFIG_NET_VENDOR_SEEQ is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
CONFIG_SFC=y
CONFIG_SFC_SRIOV=y
# CONFIG_SFC_MCDI_LOGGING is not set
# CONFIG_SFC_FALCON is not set
# CONFIG_NET_VENDOR_SILAN is not set
# CONFIG_NET_VENDOR_SIS is not set
# CONFIG_NET_VENDOR_SMSC is not set
# CONFIG_NET_VENDOR_SOCIONEXT is not set
# CONFIG_NET_VENDOR_STMICRO is not set
# CONFIG_NET_VENDOR_SUN is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
CONFIG_DWC_XLGMAC=m
# CONFIG_DWC_XLGMAC_PCI is not set
CONFIG_NET_VENDOR_TEHUTI=y
CONFIG_TEHUTI=m
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
CONFIG_TLAN=m
CONFIG_NET_VENDOR_VIA=y
CONFIG_VIA_RHINE=y
CONFIG_VIA_RHINE_MMIO=y
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
CONFIG_WIZNET_W5100=m
CONFIG_WIZNET_W5300=y
# CONFIG_WIZNET_BUS_DIRECT is not set
# CONFIG_WIZNET_BUS_INDIRECT is not set
CONFIG_WIZNET_BUS_ANY=y
CONFIG_WIZNET_W5100_SPI=m
CONFIG_NET_VENDOR_XILINX=y
CONFIG_XILINX_AXI_EMAC=m
CONFIG_XILINX_LL_TEMAC=m
CONFIG_NET_VENDOR_XIRCOM=y
# CONFIG_PCMCIA_XIRC2PS is not set
CONFIG_FDDI=y
CONFIG_DEFXX=y
CONFIG_DEFXX_MMIO=y
# CONFIG_SKFP is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_MDIO_BCM_UNIMAC=m
CONFIG_MDIO_BITBANG=y
CONFIG_MDIO_BUS_MUX=m
# CONFIG_MDIO_BUS_MUX_GPIO is not set
CONFIG_MDIO_BUS_MUX_MMIOREG=m
CONFIG_MDIO_BUS_MUX_MULTIPLEXER=m
CONFIG_MDIO_GPIO=y
# CONFIG_MDIO_HISI_FEMAC is not set
CONFIG_MDIO_MSCC_MIIM=m
CONFIG_PHYLINK=m
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
CONFIG_LED_TRIGGER_PHY=y

#
# MII PHY device drivers
#
# CONFIG_SFP is not set
CONFIG_ADIN_PHY=y
CONFIG_AMD_PHY=y
# CONFIG_AQUANTIA_PHY is not set
# CONFIG_AX88796B_PHY is not set
# CONFIG_AT803X_PHY is not set
CONFIG_BCM7XXX_PHY=m
# CONFIG_BCM87XX_PHY is not set
CONFIG_BCM_NET_PHYLIB=y
CONFIG_BROADCOM_PHY=y
CONFIG_CICADA_PHY=y
CONFIG_CORTINA_PHY=m
# CONFIG_DAVICOM_PHY is not set
# CONFIG_DP83822_PHY is not set
CONFIG_DP83TC811_PHY=y
CONFIG_DP83848_PHY=y
CONFIG_DP83867_PHY=y
CONFIG_FIXED_PHY=y
CONFIG_ICPLUS_PHY=m
CONFIG_INTEL_XWAY_PHY=y
CONFIG_LSI_ET1011C_PHY=m
# CONFIG_LXT_PHY is not set
# CONFIG_MARVELL_PHY is not set
CONFIG_MARVELL_10G_PHY=y
CONFIG_MICREL_PHY=m
CONFIG_MICROCHIP_PHY=m
CONFIG_MICROCHIP_T1_PHY=m
CONFIG_MICROSEMI_PHY=y
CONFIG_NATIONAL_PHY=y
# CONFIG_NXP_TJA11XX_PHY is not set
CONFIG_QSEMI_PHY=m
CONFIG_REALTEK_PHY=y
CONFIG_RENESAS_PHY=y
# CONFIG_ROCKCHIP_PHY is not set
CONFIG_SMSC_PHY=m
CONFIG_STE10XP=y
CONFIG_TERANETICS_PHY=y
CONFIG_VITESSE_PHY=y
# CONFIG_XILINX_GMII2RGMII is not set
CONFIG_MICREL_KS8995MA=y
CONFIG_PLIP=m
CONFIG_PPP=y
CONFIG_PPP_BSDCOMP=m
CONFIG_PPP_DEFLATE=m
# CONFIG_PPP_FILTER is not set
CONFIG_PPP_MPPE=y
# CONFIG_PPP_MULTILINK is not set
# CONFIG_PPPOATM is not set
CONFIG_PPPOE=y
CONFIG_PPPOL2TP=y
CONFIG_PPP_ASYNC=y
CONFIG_PPP_SYNC_TTY=y
CONFIG_SLIP=y
CONFIG_SLHC=y
# CONFIG_SLIP_COMPRESSED is not set
# CONFIG_SLIP_SMART is not set
CONFIG_SLIP_MODE_SLIP6=y

#
# Host-side USB support is needed for USB Network Adapter support
#
CONFIG_WLAN=y
# CONFIG_WIRELESS_WDS is not set
CONFIG_WLAN_VENDOR_ADMTEK=y
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K_PCI is not set
# CONFIG_WLAN_VENDOR_ATMEL is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_WLAN_VENDOR_CISCO is not set
# CONFIG_WLAN_VENDOR_INTEL is not set
CONFIG_WLAN_VENDOR_INTERSIL=y
CONFIG_HOSTAP=m
# CONFIG_HOSTAP_FIRMWARE is not set
CONFIG_HOSTAP_PLX=m
# CONFIG_HOSTAP_PCI is not set
CONFIG_HOSTAP_CS=m
# CONFIG_PRISM54 is not set
# CONFIG_WLAN_VENDOR_MARVELL is not set
# CONFIG_WLAN_VENDOR_MEDIATEK is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_WLAN_VENDOR_REALTEK is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_WLAN_VENDOR_ST is not set
# CONFIG_WLAN_VENDOR_TI is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_WLAN_VENDOR_QUANTENNA is not set
CONFIG_PCMCIA_RAYCS=m

#
# WiMAX Wireless Broadband devices
#

#
# Enable USB support to see WiMAX USB drivers
#
# end of WiMAX Wireless Broadband devices

# CONFIG_WAN is not set
# CONFIG_IEEE802154_DRIVERS is not set
CONFIG_VMXNET3=y
# CONFIG_FUJITSU_ES is not set
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=y
CONFIG_ISDN=y
CONFIG_ISDN_CAPI=y
CONFIG_CAPI_TRACE=y
# CONFIG_ISDN_CAPI_CAPI20 is not set
CONFIG_MISDN=m
# CONFIG_MISDN_DSP is not set
# CONFIG_MISDN_L1OIP is not set

#
# mISDN hardware drivers
#
CONFIG_MISDN_HFCPCI=m
CONFIG_MISDN_HFCMULTI=m
CONFIG_MISDN_AVMFRITZ=m
CONFIG_MISDN_SPEEDFAX=m
CONFIG_MISDN_INFINEON=m
# CONFIG_MISDN_W6692 is not set
CONFIG_MISDN_NETJET=m
CONFIG_MISDN_HDLC=m
CONFIG_MISDN_IPAC=m
CONFIG_MISDN_ISAR=m
CONFIG_NVM=y
# CONFIG_NVM_PBLK is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=m
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_POLLDEV=m
CONFIG_INPUT_SPARSEKMAP=m
CONFIG_INPUT_MATRIXKMAP=m

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=m
CONFIG_INPUT_EVBUG=m

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ADC=m
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_APPLESPI is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
CONFIG_KEYBOARD_DLINK_DIR685=m
CONFIG_KEYBOARD_LKKBD=m
# CONFIG_KEYBOARD_GPIO is not set
CONFIG_KEYBOARD_GPIO_POLLED=m
CONFIG_KEYBOARD_TCA6416=m
CONFIG_KEYBOARD_TCA8418=m
CONFIG_KEYBOARD_MATRIX=m
CONFIG_KEYBOARD_LM8323=m
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
CONFIG_KEYBOARD_MCS=m
CONFIG_KEYBOARD_MPR121=m
CONFIG_KEYBOARD_NEWTON=m
# CONFIG_KEYBOARD_OPENCORES is not set
CONFIG_KEYBOARD_SAMSUNG=m
# CONFIG_KEYBOARD_GOLDFISH_EVENTS is not set
CONFIG_KEYBOARD_STOWAWAY=m
CONFIG_KEYBOARD_SUNKBD=m
# CONFIG_KEYBOARD_OMAP4 is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
CONFIG_KEYBOARD_XTKBD=m
CONFIG_KEYBOARD_CROS_EC=m
CONFIG_KEYBOARD_CAP11XX=m
CONFIG_KEYBOARD_BCM=m
CONFIG_INPUT_MOUSE=y
# CONFIG_MOUSE_PS2 is not set
CONFIG_MOUSE_SERIAL=m
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=m
CONFIG_MOUSE_ELAN_I2C=m
CONFIG_MOUSE_ELAN_I2C_I2C=y
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
# CONFIG_MOUSE_INPORT is not set
CONFIG_MOUSE_LOGIBM=m
CONFIG_MOUSE_PC110PAD=m
CONFIG_MOUSE_VSXXXAA=m
CONFIG_MOUSE_GPIO=m
CONFIG_MOUSE_SYNAPTICS_I2C=m
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
CONFIG_INPUT_TABLET=y
# CONFIG_TABLET_USB_ACECAD is not set
# CONFIG_TABLET_USB_AIPTEK is not set
# CONFIG_TABLET_USB_HANWANG is not set
# CONFIG_TABLET_USB_KBTAB is not set
# CONFIG_TABLET_USB_PEGASUS is not set
CONFIG_TABLET_SERIAL_WACOM4=m
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_PROPERTIES=y
CONFIG_TOUCHSCREEN_88PM860X=m
CONFIG_TOUCHSCREEN_ADS7846=m
# CONFIG_TOUCHSCREEN_AD7877 is not set
CONFIG_TOUCHSCREEN_AD7879=m
CONFIG_TOUCHSCREEN_AD7879_I2C=m
# CONFIG_TOUCHSCREEN_AD7879_SPI is not set
CONFIG_TOUCHSCREEN_ADC=m
CONFIG_TOUCHSCREEN_AR1021_I2C=m
CONFIG_TOUCHSCREEN_ATMEL_MXT=m
# CONFIG_TOUCHSCREEN_AUO_PIXCIR is not set
CONFIG_TOUCHSCREEN_BU21013=m
CONFIG_TOUCHSCREEN_BU21029=m
CONFIG_TOUCHSCREEN_CHIPONE_ICN8318=m
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
CONFIG_TOUCHSCREEN_CY8CTMG110=m
CONFIG_TOUCHSCREEN_CYTTSP_CORE=m
CONFIG_TOUCHSCREEN_CYTTSP_I2C=m
CONFIG_TOUCHSCREEN_CYTTSP_SPI=m
CONFIG_TOUCHSCREEN_CYTTSP4_CORE=m
# CONFIG_TOUCHSCREEN_CYTTSP4_I2C is not set
CONFIG_TOUCHSCREEN_CYTTSP4_SPI=m
CONFIG_TOUCHSCREEN_DYNAPRO=m
CONFIG_TOUCHSCREEN_HAMPSHIRE=m
# CONFIG_TOUCHSCREEN_EETI is not set
CONFIG_TOUCHSCREEN_EGALAX=m
CONFIG_TOUCHSCREEN_EGALAX_SERIAL=m
CONFIG_TOUCHSCREEN_EXC3000=m
CONFIG_TOUCHSCREEN_FUJITSU=m
# CONFIG_TOUCHSCREEN_GOODIX is not set
CONFIG_TOUCHSCREEN_HIDEEP=m
CONFIG_TOUCHSCREEN_ILI210X=m
CONFIG_TOUCHSCREEN_S6SY761=m
# CONFIG_TOUCHSCREEN_GUNZE is not set
CONFIG_TOUCHSCREEN_EKTF2127=m
# CONFIG_TOUCHSCREEN_ELAN is not set
# CONFIG_TOUCHSCREEN_ELO is not set
CONFIG_TOUCHSCREEN_WACOM_W8001=m
# CONFIG_TOUCHSCREEN_WACOM_I2C is not set
CONFIG_TOUCHSCREEN_MAX11801=m
CONFIG_TOUCHSCREEN_MCS5000=m
CONFIG_TOUCHSCREEN_MMS114=m
# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
CONFIG_TOUCHSCREEN_MTOUCH=m
CONFIG_TOUCHSCREEN_IMX6UL_TSC=m
CONFIG_TOUCHSCREEN_INEXIO=m
CONFIG_TOUCHSCREEN_MK712=m
CONFIG_TOUCHSCREEN_HTCPEN=m
# CONFIG_TOUCHSCREEN_PENMOUNT is not set
# CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
CONFIG_TOUCHSCREEN_TOUCHRIGHT=m
# CONFIG_TOUCHSCREEN_TOUCHWIN is not set
# CONFIG_TOUCHSCREEN_TI_AM335X_TSC is not set
CONFIG_TOUCHSCREEN_PIXCIR=m
# CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set
CONFIG_TOUCHSCREEN_WM831X=m
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
# CONFIG_TOUCHSCREEN_MC13783 is not set
CONFIG_TOUCHSCREEN_TOUCHIT213=m
# CONFIG_TOUCHSCREEN_TSC_SERIO is not set
CONFIG_TOUCHSCREEN_TSC200X_CORE=m
CONFIG_TOUCHSCREEN_TSC2004=m
CONFIG_TOUCHSCREEN_TSC2005=m
# CONFIG_TOUCHSCREEN_TSC2007 is not set
# CONFIG_TOUCHSCREEN_RM_TS is not set
CONFIG_TOUCHSCREEN_SILEAD=m
CONFIG_TOUCHSCREEN_SIS_I2C=m
CONFIG_TOUCHSCREEN_ST1232=m
CONFIG_TOUCHSCREEN_STMFTS=m
CONFIG_TOUCHSCREEN_SURFACE3_SPI=m
CONFIG_TOUCHSCREEN_SX8654=m
CONFIG_TOUCHSCREEN_TPS6507X=m
CONFIG_TOUCHSCREEN_ZET6223=m
CONFIG_TOUCHSCREEN_ZFORCE=m
CONFIG_TOUCHSCREEN_ROHM_BU21023=m
# CONFIG_TOUCHSCREEN_IQS5XX is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_88PM860X_ONKEY is not set
CONFIG_INPUT_AD714X=m
CONFIG_INPUT_AD714X_I2C=m
CONFIG_INPUT_AD714X_SPI=m
# CONFIG_INPUT_ATMEL_CAPTOUCH is not set
CONFIG_INPUT_BMA150=m
CONFIG_INPUT_E3X0_BUTTON=m
CONFIG_INPUT_MSM_VIBRATOR=m
# CONFIG_INPUT_MAX77650_ONKEY is not set
CONFIG_INPUT_MAX8925_ONKEY=m
# CONFIG_INPUT_MC13783_PWRBUTTON is not set
# CONFIG_INPUT_MMA8450 is not set
# CONFIG_INPUT_APANEL is not set
CONFIG_INPUT_GP2A=m
CONFIG_INPUT_GPIO_BEEPER=m
CONFIG_INPUT_GPIO_DECODER=m
CONFIG_INPUT_GPIO_VIBRA=m
# CONFIG_INPUT_CPCAP_PWRBUTTON is not set
CONFIG_INPUT_WISTRON_BTNS=m
# CONFIG_INPUT_ATLAS_BTNS is not set
# CONFIG_INPUT_ATI_REMOTE2 is not set
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
CONFIG_INPUT_KXTJ9=m
# CONFIG_INPUT_KXTJ9_POLLED_MODE is not set
# CONFIG_INPUT_POWERMATE is not set
# CONFIG_INPUT_YEALINK is not set
# CONFIG_INPUT_CM109 is not set
# CONFIG_INPUT_REGULATOR_HAPTIC is not set
CONFIG_INPUT_TPS65218_PWRBUTTON=m
# CONFIG_INPUT_AXP20X_PEK is not set
# CONFIG_INPUT_TWL6040_VIBRA is not set
CONFIG_INPUT_UINPUT=m
CONFIG_INPUT_PALMAS_PWRBUTTON=m
# CONFIG_INPUT_PCF50633_PMU is not set
CONFIG_INPUT_PCF8574=m
# CONFIG_INPUT_RK805_PWRKEY is not set
CONFIG_INPUT_GPIO_ROTARY_ENCODER=m
# CONFIG_INPUT_DA9055_ONKEY is not set
# CONFIG_INPUT_DA9063_ONKEY is not set
# CONFIG_INPUT_WM831X_ON is not set
# CONFIG_INPUT_ADXL34X is not set
# CONFIG_INPUT_CMA3000 is not set
CONFIG_INPUT_IDEAPAD_SLIDEBAR=m
CONFIG_INPUT_DRV260X_HAPTICS=m
CONFIG_INPUT_DRV2665_HAPTICS=m
CONFIG_INPUT_DRV2667_HAPTICS=m
CONFIG_RMI4_CORE=m
# CONFIG_RMI4_I2C is not set
CONFIG_RMI4_SPI=m
# CONFIG_RMI4_SMB is not set
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
# CONFIG_RMI4_F34 is not set
# CONFIG_RMI4_F55 is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=m
CONFIG_SERIO_CT82C710=m
CONFIG_SERIO_PARKBD=m
CONFIG_SERIO_PCIPS2=y
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
# CONFIG_SERIO_ALTERA_PS2 is not set
CONFIG_SERIO_PS2MULT=y
# CONFIG_SERIO_ARC_PS2 is not set
CONFIG_SERIO_APBPS2=y
CONFIG_SERIO_GPIO_PS2=y
CONFIG_USERIO=y
CONFIG_GAMEPORT=y
CONFIG_GAMEPORT_NS558=m
CONFIG_GAMEPORT_L4=m
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_FM801 is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
CONFIG_CYCLADES=y
# CONFIG_CYZ_INTR is not set
CONFIG_MOXA_INTELLIO=y
CONFIG_MOXA_SMARTIO=y
# CONFIG_SYNCLINK is not set
CONFIG_SYNCLINKMP=y
# CONFIG_SYNCLINK_GT is not set
CONFIG_NOZOMI=m
CONFIG_ISI=y
CONFIG_N_HDLC=y
# CONFIG_N_GSM is not set
# CONFIG_TRACE_ROUTER is not set
CONFIG_TRACE_SINK=y
CONFIG_NULL_TTY=m
CONFIG_GOLDFISH_TTY=y
CONFIG_GOLDFISH_TTY_EARLY_CONSOLE=y
CONFIG_LDISC_AUTOLOAD=y
# CONFIG_DEVMEM is not set
CONFIG_DEVKMEM=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
CONFIG_SERIAL_8250_FINTEK=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=m
CONFIG_SERIAL_8250_EXAR=m
# CONFIG_SERIAL_8250_CS is not set
# CONFIG_SERIAL_8250_MEN_MCB is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
# CONFIG_SERIAL_8250_MANY_PORTS is not set
# CONFIG_SERIAL_8250_ASPEED_VUART is not set
# CONFIG_SERIAL_8250_SHARE_IRQ is not set
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
CONFIG_SERIAL_8250_RT288X=y
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_OF_PLATFORM=y

#
# Non-8250 serial port support
#
CONFIG_SERIAL_MAX3100=m
CONFIG_SERIAL_MAX310X=m
CONFIG_SERIAL_UARTLITE=m
CONFIG_SERIAL_UARTLITE_NR_UARTS=1
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=y
CONFIG_SERIAL_SIFIVE=y
# CONFIG_SERIAL_SIFIVE_CONSOLE is not set
CONFIG_SERIAL_SCCNXP=m
CONFIG_SERIAL_SC16IS7XX_CORE=m
CONFIG_SERIAL_SC16IS7XX=m
CONFIG_SERIAL_SC16IS7XX_I2C=y
CONFIG_SERIAL_SC16IS7XX_SPI=y
# CONFIG_SERIAL_TIMBERDALE is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
CONFIG_SERIAL_ALTERA_UART=y
CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
CONFIG_SERIAL_ALTERA_UART_CONSOLE=y
# CONFIG_SERIAL_IFX6X60 is not set
# CONFIG_SERIAL_PCH_UART is not set
# CONFIG_SERIAL_XILINX_PS_UART is not set
CONFIG_SERIAL_ARC=y
# CONFIG_SERIAL_ARC_CONSOLE is not set
CONFIG_SERIAL_ARC_NR_PORTS=1
CONFIG_SERIAL_RP2=y
CONFIG_SERIAL_RP2_NR_UARTS=32
CONFIG_SERIAL_FSL_LPUART=m
CONFIG_SERIAL_FSL_LINFLEXUART=y
# CONFIG_SERIAL_FSL_LINFLEXUART_CONSOLE is not set
# CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
CONFIG_SERIAL_MEN_Z135=y
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
# CONFIG_SERIAL_DEV_BUS is not set
CONFIG_TTY_PRINTK=y
CONFIG_TTY_PRINTK_LEVEL=6
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_HVC_DRIVER=y
CONFIG_VIRTIO_CONSOLE=m
# CONFIG_IPMI_HANDLER is not set
CONFIG_IPMB_DEVICE_INTERFACE=m
CONFIG_HW_RANDOM=m
CONFIG_HW_RANDOM_TIMERIOMEM=m
# CONFIG_HW_RANDOM_INTEL is not set
CONFIG_HW_RANDOM_AMD=m
CONFIG_HW_RANDOM_GEODE=m
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=m
CONFIG_NVRAM=y
# CONFIG_DTLK is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
CONFIG_CARDMAN_4000=m
CONFIG_CARDMAN_4040=y
CONFIG_SCR24X=m
CONFIG_IPWIRELESS=m
# end of PCMCIA character devices

CONFIG_MWAVE=y
# CONFIG_SCx200_GPIO is not set
CONFIG_PC8736x_GPIO=m
CONFIG_NSC_GPIO=m
# CONFIG_RAW_DRIVER is not set
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_TCG_TPM=m
# CONFIG_HW_RANDOM_TPM is not set
CONFIG_TCG_TIS_CORE=m
CONFIG_TCG_TIS=m
CONFIG_TCG_TIS_SPI=m
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
# CONFIG_TCG_INFINEON is not set
# CONFIG_TCG_CRB is not set
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=m
# CONFIG_TCG_TIS_ST33ZP24_I2C is not set
CONFIG_TCG_TIS_ST33ZP24_SPI=m
# CONFIG_TELCLOCK is not set
# CONFIG_DEVPORT is not set
# CONFIG_XILLYBUS is not set
# end of Character devices

CONFIG_RANDOM_TRUST_CPU=y
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
# CONFIG_I2C_CHARDEV is not set
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_ARB_GPIO_CHALLENGE=m
# CONFIG_I2C_MUX_GPIO is not set
CONFIG_I2C_MUX_GPMUX=m
# CONFIG_I2C_MUX_LTC4306 is not set
CONFIG_I2C_MUX_PCA9541=m
# CONFIG_I2C_MUX_PCA954x is not set
CONFIG_I2C_MUX_PINCTRL=m
CONFIG_I2C_MUX_REG=m
CONFIG_I2C_DEMUX_PINCTRL=m
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=m
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
CONFIG_I2C_ALI1535=m
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
CONFIG_I2C_AMD756=y
# CONFIG_I2C_AMD756_S4882 is not set
CONFIG_I2C_AMD8111=m
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=m
# CONFIG_I2C_ISCH is not set
CONFIG_I2C_ISMT=y
# CONFIG_I2C_PIIX4 is not set
CONFIG_I2C_NFORCE2=y
CONFIG_I2C_NFORCE2_S4985=y
CONFIG_I2C_NVIDIA_GPU=m
CONFIG_I2C_SIS5595=m
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=y
CONFIG_I2C_VIA=y
# CONFIG_I2C_VIAPRO is not set

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=m
CONFIG_I2C_DESIGNWARE_CORE=y
CONFIG_I2C_DESIGNWARE_PLATFORM=y
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PCI=m
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
# CONFIG_I2C_EG20T is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
# CONFIG_I2C_PCA_PLATFORM is not set
# CONFIG_I2C_PXA is not set
CONFIG_I2C_RK3X=m
# CONFIG_I2C_SIMTEC is not set
CONFIG_I2C_XILINX=m

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_PARPORT=m
# CONFIG_I2C_PARPORT_LIGHT is not set
CONFIG_I2C_TAOS_EVM=m

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_ELEKTOR is not set
CONFIG_I2C_PCA_ISA=m
CONFIG_I2C_CROS_EC_TUNNEL=y
CONFIG_SCx200_ACB=m
# CONFIG_I2C_FSI is not set
# end of I2C Hardware Bus support

# CONFIG_I2C_STUB is not set
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=m
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

CONFIG_I3C=y
CONFIG_CDNS_I3C_MASTER=y
# CONFIG_DW_I3C_MASTER is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
CONFIG_SPI_ALTERA=y
CONFIG_SPI_AXI_SPI_ENGINE=y
CONFIG_SPI_BITBANG=y
CONFIG_SPI_BUTTERFLY=m
CONFIG_SPI_CADENCE=y
CONFIG_SPI_DESIGNWARE=m
CONFIG_SPI_DW_PCI=m
CONFIG_SPI_DW_MID_DMA=y
CONFIG_SPI_DW_MMIO=m
CONFIG_SPI_NXP_FLEXSPI=m
CONFIG_SPI_GPIO=y
CONFIG_SPI_LM70_LLP=m
CONFIG_SPI_FSL_LIB=m
CONFIG_SPI_FSL_SPI=m
CONFIG_SPI_OC_TINY=m
CONFIG_SPI_PXA2XX=m
CONFIG_SPI_PXA2XX_PCI=m
# CONFIG_SPI_ROCKCHIP is not set
CONFIG_SPI_SC18IS602=y
# CONFIG_SPI_SIFIVE is not set
CONFIG_SPI_MXIC=y
CONFIG_SPI_TOPCLIFF_PCH=m
# CONFIG_SPI_XCOMM is not set
CONFIG_SPI_XILINX=y
CONFIG_SPI_ZYNQMP_GQSPI=m

#
# SPI Protocol Masters
#
CONFIG_SPI_SPIDEV=y
CONFIG_SPI_LOOPBACK_TEST=m
CONFIG_SPI_TLE62X0=y
CONFIG_SPI_SLAVE=y
CONFIG_SPI_SLAVE_TIME=y
# CONFIG_SPI_SLAVE_SYSTEM_CONTROL is not set
CONFIG_SPMI=y
CONFIG_HSI=y
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
# CONFIG_HSI_CHAR is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set
# CONFIG_NTP_PPS is not set

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=m
CONFIG_PPS_CLIENT_LDISC=y
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=y

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
# CONFIG_DP83640_PHY is not set
# CONFIG_PTP_1588_CLOCK_PCH is not set
CONFIG_PTP_1588_CLOCK_KVM=y
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_GENERIC_PINCTRL_GROUPS=y
CONFIG_PINMUX=y
CONFIG_GENERIC_PINMUX_FUNCTIONS=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AXP209 is not set
CONFIG_PINCTRL_AMD=m
# CONFIG_PINCTRL_MCP23S08 is not set
CONFIG_PINCTRL_SINGLE=m
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_STMFX=y
CONFIG_PINCTRL_MAX77620=m
CONFIG_PINCTRL_PALMAS=y
CONFIG_PINCTRL_RK805=m
# CONFIG_PINCTRL_OCELOT is not set
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
# CONFIG_PINCTRL_LOCHNAGAR is not set
CONFIG_PINCTRL_MADERA=y
CONFIG_PINCTRL_CS47L85=y
CONFIG_PINCTRL_CS47L92=y
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_74XX_MMIO=m
CONFIG_GPIO_ALTERA=y
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_CADENCE=y
# CONFIG_GPIO_DWAPB is not set
CONFIG_GPIO_EXAR=m
# CONFIG_GPIO_FTGPIO010 is not set
CONFIG_GPIO_GENERIC_PLATFORM=m
CONFIG_GPIO_GRGPIO=y
CONFIG_GPIO_HLWD=m
CONFIG_GPIO_ICH=y
# CONFIG_GPIO_LYNXPOINT is not set
CONFIG_GPIO_MB86S7X=m
# CONFIG_GPIO_MENZ127 is not set
# CONFIG_GPIO_SAMA5D2_PIOBU is not set
CONFIG_GPIO_SIOX=m
CONFIG_GPIO_SYSCON=m
CONFIG_GPIO_VX855=y
CONFIG_GPIO_XILINX=y
CONFIG_GPIO_AMD_FCH=m
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
CONFIG_GPIO_IT87=y
CONFIG_GPIO_SCH=m
CONFIG_GPIO_SCH311X=m
CONFIG_GPIO_WINBOND=y
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=m
CONFIG_GPIO_ADNP=m
CONFIG_GPIO_GW_PLD=y
CONFIG_GPIO_MAX7300=y
CONFIG_GPIO_MAX732X=y
CONFIG_GPIO_MAX732X_IRQ=y
CONFIG_GPIO_PCA953X=y
# CONFIG_GPIO_PCA953X_IRQ is not set
# CONFIG_GPIO_PCF857X is not set
CONFIG_GPIO_TPIC2810=m
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_ARIZONA=m
CONFIG_GPIO_BD70528=m
CONFIG_GPIO_BD9571MWV=m
CONFIG_GPIO_CS5535=y
# CONFIG_GPIO_DA9055 is not set
CONFIG_GPIO_JANZ_TTL=y
CONFIG_GPIO_LP3943=m
# CONFIG_GPIO_LP873X is not set
CONFIG_GPIO_LP87565=m
# CONFIG_GPIO_MADERA is not set
CONFIG_GPIO_MAX77620=y
CONFIG_GPIO_MAX77650=m
# CONFIG_GPIO_PALMAS is not set
# CONFIG_GPIO_TIMBERDALE is not set
# CONFIG_GPIO_TPS65086 is not set
# CONFIG_GPIO_TPS65218 is not set
CONFIG_GPIO_TPS65910=y
CONFIG_GPIO_TPS65912=y
# CONFIG_GPIO_TQMX86 is not set
# CONFIG_GPIO_TWL6040 is not set
# CONFIG_GPIO_WM831X is not set
CONFIG_GPIO_WM8350=m
CONFIG_GPIO_WM8994=m
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
CONFIG_GPIO_AMD8111=y
# CONFIG_GPIO_BT8XX is not set
CONFIG_GPIO_ML_IOH=m
CONFIG_GPIO_PCH=m
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
CONFIG_GPIO_RDC321X=y
CONFIG_GPIO_SODAVILLE=y
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_74X164 is not set
# CONFIG_GPIO_MAX3191X is not set
CONFIG_GPIO_MAX7301=y
# CONFIG_GPIO_MC33880 is not set
CONFIG_GPIO_PISOSR=m
CONFIG_GPIO_XRA1403=m
CONFIG_GPIO_MOXTET=m
# end of SPI GPIO expanders

CONFIG_GPIO_MOCKUP=y
CONFIG_W1=y

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_MATROX=m
CONFIG_W1_MASTER_DS2482=m
# CONFIG_W1_MASTER_DS1WM is not set
CONFIG_W1_MASTER_GPIO=m
CONFIG_W1_MASTER_SGI=y
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
CONFIG_W1_SLAVE_SMEM=m
CONFIG_W1_SLAVE_DS2405=y
CONFIG_W1_SLAVE_DS2408=y
# CONFIG_W1_SLAVE_DS2408_READBACK is not set
# CONFIG_W1_SLAVE_DS2413 is not set
# CONFIG_W1_SLAVE_DS2406 is not set
# CONFIG_W1_SLAVE_DS2423 is not set
CONFIG_W1_SLAVE_DS2805=m
CONFIG_W1_SLAVE_DS2431=y
CONFIG_W1_SLAVE_DS2433=m
# CONFIG_W1_SLAVE_DS2433_CRC is not set
# CONFIG_W1_SLAVE_DS2438 is not set
# CONFIG_W1_SLAVE_DS250X is not set
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
CONFIG_W1_SLAVE_DS28E04=m
# CONFIG_W1_SLAVE_DS28E17 is not set
# end of 1-wire Slaves

CONFIG_POWER_AVS=y
CONFIG_POWER_RESET=y
CONFIG_POWER_RESET_GPIO=y
CONFIG_POWER_RESET_GPIO_RESTART=y
# CONFIG_POWER_RESET_LTC2952 is not set
CONFIG_POWER_RESET_RESTART=y
CONFIG_POWER_RESET_SYSCON=y
CONFIG_POWER_RESET_SYSCON_POWEROFF=y
CONFIG_REBOOT_MODE=m
CONFIG_SYSCON_REBOOT_MODE=m
# CONFIG_NVMEM_REBOOT_MODE is not set
CONFIG_POWER_SUPPLY=y
CONFIG_POWER_SUPPLY_DEBUG=y
# CONFIG_PDA_POWER is not set
# CONFIG_GENERIC_ADC_BATTERY is not set
# CONFIG_MAX8925_POWER is not set
CONFIG_WM831X_BACKUP=y
CONFIG_WM831X_POWER=m
# CONFIG_WM8350_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_BATTERY_88PM860X is not set
CONFIG_CHARGER_ADP5061=m
CONFIG_BATTERY_CPCAP=m
CONFIG_BATTERY_DS2760=m
CONFIG_BATTERY_DS2780=y
CONFIG_BATTERY_DS2781=y
CONFIG_BATTERY_DS2782=m
# CONFIG_BATTERY_LEGO_EV3 is not set
# CONFIG_BATTERY_OLPC is not set
CONFIG_BATTERY_SBS=m
CONFIG_CHARGER_SBS=m
CONFIG_MANAGER_SBS=m
CONFIG_BATTERY_BQ27XXX=m
CONFIG_BATTERY_BQ27XXX_I2C=m
CONFIG_BATTERY_BQ27XXX_HDQ=m
# CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM is not set
CONFIG_CHARGER_DA9150=m
CONFIG_BATTERY_DA9150=m
CONFIG_CHARGER_AXP20X=m
# CONFIG_BATTERY_AXP20X is not set
# CONFIG_AXP20X_POWER is not set
# CONFIG_AXP288_FUEL_GAUGE is not set
# CONFIG_BATTERY_MAX17040 is not set
CONFIG_BATTERY_MAX17042=y
# CONFIG_BATTERY_MAX1721X is not set
# CONFIG_CHARGER_PCF50633 is not set
CONFIG_CHARGER_MAX8903=y
CONFIG_CHARGER_LP8727=y
# CONFIG_CHARGER_GPIO is not set
CONFIG_CHARGER_MANAGER=y
CONFIG_CHARGER_LT3651=m
CONFIG_CHARGER_MAX14577=m
CONFIG_CHARGER_DETECTOR_MAX14656=m
CONFIG_CHARGER_MAX77650=m
# CONFIG_CHARGER_BQ2415X is not set
CONFIG_CHARGER_BQ24190=m
CONFIG_CHARGER_BQ24257=m
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ25890 is not set
CONFIG_CHARGER_SMB347=y
CONFIG_CHARGER_TPS65217=y
CONFIG_BATTERY_GAUGE_LTC2941=y
CONFIG_BATTERY_GOLDFISH=y
CONFIG_BATTERY_RT5033=y
CONFIG_CHARGER_RT9455=y
CONFIG_CHARGER_CROS_USBPD=m
# CONFIG_CHARGER_UCS1002 is not set
CONFIG_CHARGER_BD70528=m
CONFIG_HWMON=m
CONFIG_HWMON_VID=m
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
# CONFIG_SENSORS_ABITUGURU is not set
# CONFIG_SENSORS_ABITUGURU3 is not set
CONFIG_SENSORS_AD7314=m
CONFIG_SENSORS_AD7414=m
# CONFIG_SENSORS_AD7418 is not set
CONFIG_SENSORS_ADM1021=m
# CONFIG_SENSORS_ADM1025 is not set
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
# CONFIG_SENSORS_ADM1031 is not set
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
CONFIG_SENSORS_ADT7310=m
# CONFIG_SENSORS_ADT7410 is not set
CONFIG_SENSORS_ADT7411=m
# CONFIG_SENSORS_ADT7462 is not set
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
CONFIG_SENSORS_AS370=m
# CONFIG_SENSORS_ASC7621 is not set
CONFIG_SENSORS_K8TEMP=m
# CONFIG_SENSORS_K10TEMP is not set
CONFIG_SENSORS_FAM15H_POWER=m
CONFIG_SENSORS_APPLESMC=m
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=m
# CONFIG_SENSORS_DS620 is not set
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=m
# CONFIG_SENSORS_DA9055 is not set
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_MC13783_ADC=m
# CONFIG_SENSORS_FSCHMD is not set
CONFIG_SENSORS_FTSTEUTATES=m
CONFIG_SENSORS_GL518SM=m
# CONFIG_SENSORS_GL520SM is not set
CONFIG_SENSORS_G760A=m
CONFIG_SENSORS_G762=m
CONFIG_SENSORS_GPIO_FAN=m
CONFIG_SENSORS_HIH6130=m
CONFIG_SENSORS_IIO_HWMON=m
# CONFIG_SENSORS_I5500 is not set
# CONFIG_SENSORS_CORETEMP is not set
CONFIG_SENSORS_IT87=m
# CONFIG_SENSORS_JC42 is not set
CONFIG_SENSORS_POWR1220=m
CONFIG_SENSORS_LINEAGE=m
CONFIG_SENSORS_LOCHNAGAR=m
CONFIG_SENSORS_LTC2945=m
CONFIG_SENSORS_LTC2990=m
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
CONFIG_SENSORS_LTC4222=m
CONFIG_SENSORS_LTC4245=m
CONFIG_SENSORS_LTC4260=m
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
# CONFIG_SENSORS_MAX1668 is not set
CONFIG_SENSORS_MAX197=m
CONFIG_SENSORS_MAX31722=m
CONFIG_SENSORS_MAX6621=m
# CONFIG_SENSORS_MAX6639 is not set
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
# CONFIG_SENSORS_MAX6697 is not set
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
CONFIG_SENSORS_TC654=m
CONFIG_SENSORS_ADCXX=m
CONFIG_SENSORS_LM63=m
CONFIG_SENSORS_LM70=m
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
# CONFIG_SENSORS_LM78 is not set
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
# CONFIG_SENSORS_LM85 is not set
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
# CONFIG_SENSORS_LM93 is not set
# CONFIG_SENSORS_LM95234 is not set
CONFIG_SENSORS_LM95241=m
# CONFIG_SENSORS_LM95245 is not set
CONFIG_SENSORS_PC87360=m
# CONFIG_SENSORS_PC87427 is not set
# CONFIG_SENSORS_NTC_THERMISTOR is not set
CONFIG_SENSORS_NCT6683=m
# CONFIG_SENSORS_NCT6775 is not set
CONFIG_SENSORS_NCT7802=m
# CONFIG_SENSORS_NCT7904 is not set
CONFIG_SENSORS_NPCM7XX=m
# CONFIG_SENSORS_PCF8591 is not set
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
# CONFIG_SENSORS_ADM1275 is not set
CONFIG_SENSORS_IBM_CFFPS=m
CONFIG_SENSORS_INSPUR_IPSPS=m
CONFIG_SENSORS_IR35221=m
CONFIG_SENSORS_IR38064=m
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
# CONFIG_SENSORS_LM25066 is not set
# CONFIG_SENSORS_LTC2978 is not set
CONFIG_SENSORS_LTC3815=m
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX20751 is not set
CONFIG_SENSORS_MAX31785=m
CONFIG_SENSORS_MAX34440=m
# CONFIG_SENSORS_MAX8688 is not set
CONFIG_SENSORS_PXE1610=m
CONFIG_SENSORS_TPS40422=m
CONFIG_SENSORS_TPS53679=m
CONFIG_SENSORS_UCD9000=m
# CONFIG_SENSORS_UCD9200 is not set
CONFIG_SENSORS_ZL6100=m
CONFIG_SENSORS_SHT15=m
# CONFIG_SENSORS_SHT21 is not set
CONFIG_SENSORS_SHT3x=m
CONFIG_SENSORS_SHTC1=m
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_DME1737 is not set
# CONFIG_SENSORS_EMC1403 is not set
CONFIG_SENSORS_EMC2103=m
# CONFIG_SENSORS_EMC6W201 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
# CONFIG_SENSORS_SCH5627 is not set
CONFIG_SENSORS_SCH5636=m
CONFIG_SENSORS_STTS751=m
CONFIG_SENSORS_SMM665=m
CONFIG_SENSORS_ADC128D818=m
CONFIG_SENSORS_ADS7828=m
CONFIG_SENSORS_ADS7871=m
# CONFIG_SENSORS_AMC6821 is not set
# CONFIG_SENSORS_INA209 is not set
# CONFIG_SENSORS_INA2XX is not set
CONFIG_SENSORS_INA3221=m
# CONFIG_SENSORS_TC74 is not set
# CONFIG_SENSORS_THMC50 is not set
# CONFIG_SENSORS_TMP102 is not set
# CONFIG_SENSORS_TMP103 is not set
CONFIG_SENSORS_TMP108=m
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
# CONFIG_SENSORS_VT1211 is not set
# CONFIG_SENSORS_VT8231 is not set
CONFIG_SENSORS_W83773G=m
CONFIG_SENSORS_W83781D=m
# CONFIG_SENSORS_W83791D is not set
# CONFIG_SENSORS_W83792D is not set
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
# CONFIG_SENSORS_W83L786NG is not set
CONFIG_SENSORS_W83627HF=m
# CONFIG_SENSORS_W83627EHF is not set
CONFIG_SENSORS_WM831X=m
# CONFIG_SENSORS_WM8350 is not set

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
# CONFIG_THERMAL_OF is not set
CONFIG_THERMAL_WRITABLE_TRIPS=y
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE=y
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_GOV_STEP_WISE=y
# CONFIG_THERMAL_GOV_BANG_BANG is not set
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
CONFIG_CLOCK_THERMAL=y
CONFIG_DEVFREQ_THERMAL=y
CONFIG_THERMAL_EMULATION=y
CONFIG_THERMAL_MMIO=y
# CONFIG_MAX77620_THERMAL is not set

#
# Intel thermal drivers
#
# CONFIG_INTEL_POWERCLAMP is not set
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=y
# end of Intel thermal drivers

# CONFIG_GENERIC_ADC_THERMAL is not set
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
CONFIG_WATCHDOG_NOWAYOUT=y
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
# CONFIG_WATCHDOG_SYSFS is not set

#
# Watchdog Pretimeout Governors
#
CONFIG_WATCHDOG_PRETIMEOUT_GOV=y
CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL=m
CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP=y
CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC=y
CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP=y
# CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC is not set

#
# Watchdog Device Drivers
#
# CONFIG_SOFT_WATCHDOG is not set
CONFIG_BD70528_WATCHDOG=m
# CONFIG_DA9055_WATCHDOG is not set
CONFIG_DA9063_WATCHDOG=y
CONFIG_GPIO_WATCHDOG=m
CONFIG_MENZ069_WATCHDOG=y
# CONFIG_WDAT_WDT is not set
CONFIG_WM831X_WATCHDOG=y
CONFIG_WM8350_WATCHDOG=m
CONFIG_XILINX_WATCHDOG=y
CONFIG_ZIIRAVE_WATCHDOG=m
CONFIG_CADENCE_WATCHDOG=m
# CONFIG_DW_WATCHDOG is not set
# CONFIG_RN5T618_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
CONFIG_MAX77620_WATCHDOG=m
CONFIG_ACQUIRE_WDT=m
CONFIG_ADVANTECH_WDT=y
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=y
CONFIG_EBC_C384_WDT=y
CONFIG_F71808E_WDT=y
CONFIG_SP5100_TCO=y
# CONFIG_GEODE_WDT is not set
# CONFIG_SBC_FITPC2_WATCHDOG is not set
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
# CONFIG_IBMASR is not set
CONFIG_WAFER_WDT=y
# CONFIG_I6300ESB_WDT is not set
CONFIG_IE6XX_WDT=m
# CONFIG_ITCO_WDT is not set
# CONFIG_IT8712F_WDT is not set
CONFIG_IT87_WDT=y
CONFIG_HP_WATCHDOG=y
CONFIG_HPWDT_NMI_DECODING=y
CONFIG_SC1200_WDT=m
# CONFIG_SCx200_WDT is not set
CONFIG_PC87413_WDT=m
CONFIG_NV_TCO=m
CONFIG_RDC321X_WDT=y
CONFIG_60XX_WDT=m
# CONFIG_SBC8360_WDT is not set
# CONFIG_SBC7240_WDT is not set
CONFIG_CPU5_WDT=m
CONFIG_SMSC_SCH311X_WDT=m
CONFIG_SMSC37B787_WDT=m
CONFIG_TQMX86_WDT=y
CONFIG_VIA_WDT=m
# CONFIG_W83627HF_WDT is not set
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=y
# CONFIG_MACHZ_WDT is not set
CONFIG_SBC_EPX_C3_WATCHDOG=m
# CONFIG_INTEL_MEI_WDT is not set
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
CONFIG_MEN_A21_WDT=y

#
# ISA-based Watchdog Cards
#
# CONFIG_PCWATCHDOG is not set
CONFIG_MIXCOMWD=m
# CONFIG_WDT is not set

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=y
# CONFIG_WDTPCI is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=m
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
# CONFIG_SSB_PCIHOST is not set
CONFIG_SSB_PCMCIAHOST_POSSIBLE=y
CONFIG_SSB_PCMCIAHOST=y
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
# CONFIG_BCMA_HOST_PCI is not set
# CONFIG_BCMA_HOST_SOC is not set
# CONFIG_BCMA_DRIVER_PCI is not set
# CONFIG_BCMA_DRIVER_GMAC_CMN is not set
CONFIG_BCMA_DRIVER_GPIO=y
CONFIG_BCMA_DEBUG=y

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_CS5535=y
# CONFIG_MFD_ACT8945A is not set
CONFIG_MFD_AS3711=y
# CONFIG_MFD_AS3722 is not set
# CONFIG_PMIC_ADP5520 is not set
CONFIG_MFD_AAT2870_CORE=y
CONFIG_MFD_ATMEL_FLEXCOM=y
# CONFIG_MFD_ATMEL_HLCDC is not set
CONFIG_MFD_BCM590XX=y
CONFIG_MFD_BD9571MWV=y
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
CONFIG_MFD_CROS_EC_DEV=m
CONFIG_MFD_MADERA=y
CONFIG_MFD_MADERA_I2C=y
# CONFIG_MFD_MADERA_SPI is not set
# CONFIG_MFD_CS47L15 is not set
# CONFIG_MFD_CS47L35 is not set
CONFIG_MFD_CS47L85=y
# CONFIG_MFD_CS47L90 is not set
CONFIG_MFD_CS47L92=y
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
CONFIG_MFD_DA9055=y
# CONFIG_MFD_DA9062 is not set
CONFIG_MFD_DA9063=y
CONFIG_MFD_DA9150=m
CONFIG_MFD_MC13XXX=m
CONFIG_MFD_MC13XXX_SPI=m
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_HI6421_PMIC is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
CONFIG_MFD_INTEL_QUARK_I2C_GPIO=y
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=m
# CONFIG_INTEL_SOC_PMIC is not set
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
CONFIG_MFD_INTEL_LPSS=y
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
CONFIG_MFD_INTEL_LPSS_PCI=y
CONFIG_MFD_JANZ_CMODIO=y
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
CONFIG_MFD_88PM805=y
CONFIG_MFD_88PM860X=y
CONFIG_MFD_MAX14577=y
CONFIG_MFD_MAX77620=y
CONFIG_MFD_MAX77650=m
# CONFIG_MFD_MAX77686 is not set
# CONFIG_MFD_MAX77693 is not set
CONFIG_MFD_MAX77843=y
# CONFIG_MFD_MAX8907 is not set
CONFIG_MFD_MAX8925=y
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
CONFIG_MFD_CPCAP=y
# CONFIG_MFD_RETU is not set
CONFIG_MFD_PCF50633=y
CONFIG_PCF50633_ADC=m
CONFIG_PCF50633_GPIO=m
CONFIG_MFD_RDC321X=y
CONFIG_MFD_RT5033=y
# CONFIG_MFD_RC5T583 is not set
CONFIG_MFD_RK808=y
CONFIG_MFD_RN5T618=y
CONFIG_MFD_SEC_CORE=m
CONFIG_MFD_SI476X_CORE=y
CONFIG_MFD_SM501=m
# CONFIG_MFD_SM501_GPIO is not set
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SMSC is not set
CONFIG_ABX500_CORE=y
CONFIG_AB3100_CORE=y
CONFIG_AB3100_OTP=y
# CONFIG_MFD_STMPE is not set
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
CONFIG_MFD_LP3943=y
CONFIG_MFD_LP8788=y
CONFIG_MFD_TI_LMU=m
CONFIG_MFD_PALMAS=y
CONFIG_TPS6105X=m
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
CONFIG_MFD_TPS65086=y
# CONFIG_MFD_TPS65090 is not set
CONFIG_MFD_TPS65217=y
# CONFIG_MFD_TPS68470 is not set
CONFIG_MFD_TI_LP873X=m
CONFIG_MFD_TI_LP87565=m
CONFIG_MFD_TPS65218=y
# CONFIG_MFD_TPS6586X is not set
CONFIG_MFD_TPS65910=y
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
CONFIG_MFD_TPS65912_SPI=m
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
CONFIG_TWL6040_CORE=y
CONFIG_MFD_WL1273_CORE=y
CONFIG_MFD_LM3533=m
CONFIG_MFD_TIMBERDALE=y
# CONFIG_MFD_TC3589X is not set
CONFIG_MFD_TQMX86=y
CONFIG_MFD_VX855=y
CONFIG_MFD_LOCHNAGAR=y
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
CONFIG_MFD_ARIZONA_SPI=m
CONFIG_MFD_CS47L24=y
CONFIG_MFD_WM5102=y
# CONFIG_MFD_WM5110 is not set
CONFIG_MFD_WM8997=y
# CONFIG_MFD_WM8998 is not set
# CONFIG_MFD_WM8400 is not set
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
CONFIG_MFD_WM831X_SPI=y
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
CONFIG_MFD_WM8994=m
# CONFIG_MFD_ROHM_BD718XX is not set
CONFIG_MFD_ROHM_BD70528=m
# CONFIG_MFD_STPMIC1 is not set
CONFIG_MFD_STMFX=y
# end of Multifunction device drivers

CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=m
CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
CONFIG_REGULATOR_88PG86X=m
# CONFIG_REGULATOR_88PM8607 is not set
CONFIG_REGULATOR_ACT8865=m
CONFIG_REGULATOR_AD5398=y
CONFIG_REGULATOR_ANATOP=y
# CONFIG_REGULATOR_AAT2870 is not set
# CONFIG_REGULATOR_AB3100 is not set
CONFIG_REGULATOR_AS3711=y
# CONFIG_REGULATOR_AXP20X is not set
CONFIG_REGULATOR_BCM590XX=y
CONFIG_REGULATOR_BD70528=m
CONFIG_REGULATOR_BD9571MWV=y
CONFIG_REGULATOR_CPCAP=y
# CONFIG_REGULATOR_DA9055 is not set
CONFIG_REGULATOR_DA9063=y
CONFIG_REGULATOR_DA9210=m
CONFIG_REGULATOR_DA9211=m
CONFIG_REGULATOR_FAN53555=y
CONFIG_REGULATOR_GPIO=y
CONFIG_REGULATOR_ISL9305=y
CONFIG_REGULATOR_ISL6271A=y
# CONFIG_REGULATOR_LM363X is not set
# CONFIG_REGULATOR_LOCHNAGAR is not set
CONFIG_REGULATOR_LP3971=y
CONFIG_REGULATOR_LP3972=m
# CONFIG_REGULATOR_LP872X is not set
# CONFIG_REGULATOR_LP873X is not set
# CONFIG_REGULATOR_LP8755 is not set
# CONFIG_REGULATOR_LP87565 is not set
# CONFIG_REGULATOR_LP8788 is not set
CONFIG_REGULATOR_LTC3589=y
CONFIG_REGULATOR_LTC3676=m
CONFIG_REGULATOR_MAX14577=m
# CONFIG_REGULATOR_MAX1586 is not set
CONFIG_REGULATOR_MAX77620=m
# CONFIG_REGULATOR_MAX77650 is not set
# CONFIG_REGULATOR_MAX8649 is not set
# CONFIG_REGULATOR_MAX8660 is not set
CONFIG_REGULATOR_MAX8925=m
CONFIG_REGULATOR_MAX8952=y
CONFIG_REGULATOR_MAX77693=m
CONFIG_REGULATOR_MC13XXX_CORE=m
CONFIG_REGULATOR_MC13783=m
# CONFIG_REGULATOR_MC13892 is not set
CONFIG_REGULATOR_MCP16502=y
CONFIG_REGULATOR_MT6311=m
CONFIG_REGULATOR_PALMAS=m
# CONFIG_REGULATOR_PCF50633 is not set
# CONFIG_REGULATOR_PFUZE100 is not set
CONFIG_REGULATOR_PV88060=y
# CONFIG_REGULATOR_PV88080 is not set
# CONFIG_REGULATOR_PV88090 is not set
CONFIG_REGULATOR_QCOM_SPMI=y
CONFIG_REGULATOR_RK808=y
CONFIG_REGULATOR_RN5T618=y
CONFIG_REGULATOR_RT5033=m
# CONFIG_REGULATOR_S2MPA01 is not set
CONFIG_REGULATOR_S2MPS11=m
# CONFIG_REGULATOR_S5M8767 is not set
CONFIG_REGULATOR_SLG51000=m
# CONFIG_REGULATOR_SY8106A is not set
CONFIG_REGULATOR_SY8824X=m
CONFIG_REGULATOR_TPS51632=m
CONFIG_REGULATOR_TPS6105X=m
CONFIG_REGULATOR_TPS62360=m
# CONFIG_REGULATOR_TPS65023 is not set
CONFIG_REGULATOR_TPS6507X=y
CONFIG_REGULATOR_TPS65086=m
# CONFIG_REGULATOR_TPS65132 is not set
CONFIG_REGULATOR_TPS65217=m
CONFIG_REGULATOR_TPS65218=m
# CONFIG_REGULATOR_TPS6524X is not set
# CONFIG_REGULATOR_TPS65910 is not set
CONFIG_REGULATOR_TPS65912=m
# CONFIG_REGULATOR_VCTRL is not set
# CONFIG_REGULATOR_WM831X is not set
CONFIG_REGULATOR_WM8350=y
CONFIG_REGULATOR_WM8994=m
CONFIG_CEC_CORE=y
CONFIG_CEC_NOTIFIER=y
CONFIG_RC_CORE=m
CONFIG_RC_MAP=m
CONFIG_LIRC=y
CONFIG_RC_DECODERS=y
# CONFIG_IR_NEC_DECODER is not set
# CONFIG_IR_RC5_DECODER is not set
# CONFIG_IR_RC6_DECODER is not set
# CONFIG_IR_JVC_DECODER is not set
# CONFIG_IR_SONY_DECODER is not set
# CONFIG_IR_SANYO_DECODER is not set
CONFIG_IR_SHARP_DECODER=m
# CONFIG_IR_MCE_KBD_DECODER is not set
# CONFIG_IR_XMP_DECODER is not set
CONFIG_IR_IMON_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_RC_DEVICES=y
# CONFIG_RC_ATI_REMOTE is not set
# CONFIG_IR_ENE is not set
# CONFIG_IR_HIX5HD2 is not set
# CONFIG_IR_IMON is not set
# CONFIG_IR_IMON_RAW is not set
# CONFIG_IR_MCEUSB is not set
# CONFIG_IR_ITE_CIR is not set
# CONFIG_IR_FINTEK is not set
# CONFIG_IR_NUVOTON is not set
# CONFIG_IR_REDRAT3 is not set
# CONFIG_IR_SPI is not set
# CONFIG_IR_STREAMZAP is not set
# CONFIG_IR_WINBOND_CIR is not set
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_TTUSBIR is not set
CONFIG_RC_LOOPBACK=m
# CONFIG_IR_GPIO_CIR is not set
# CONFIG_IR_GPIO_TX is not set
# CONFIG_IR_SERIAL is not set
# CONFIG_IR_SIR is not set
# CONFIG_RC_XBOX_DVD is not set
# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_INTEL_GTT=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=y
CONFIG_DRM_MIPI_DBI=y
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DEBUG_MM is not set
CONFIG_DRM_DEBUG_SELFTEST=m
CONFIG_DRM_KMS_HELPER=y
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM=y
# CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
CONFIG_DRM_DP_CEC=y
CONFIG_DRM_TTM=y
CONFIG_DRM_VRAM_HELPER=y
CONFIG_DRM_GEM_CMA_HELPER=y
CONFIG_DRM_KMS_CMA_HELPER=y
CONFIG_DRM_VM=y
CONFIG_DRM_SCHED=m

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=y
CONFIG_DRM_I2C_SIL164=m
CONFIG_DRM_I2C_NXP_TDA998X=y
CONFIG_DRM_I2C_NXP_TDA9950=y
# end of I2C encoder or helper chips

#
# ARM devices
#
CONFIG_DRM_KOMEDA=y
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set

#
# ACP (Audio CoProcessor) Configuration
#
# end of ACP (Audio CoProcessor) Configuration

# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=y
CONFIG_DRM_I915_ALPHA_SUPPORT=y
CONFIG_DRM_I915_FORCE_PROBE="*"
# CONFIG_DRM_I915_CAPTURE_ERROR is not set
# CONFIG_DRM_I915_USERPTR is not set

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
# CONFIG_DRM_I915_DEBUG is not set
# CONFIG_DRM_I915_DEBUG_MMIO is not set
# CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
CONFIG_DRM_I915_SW_FENCE_CHECK_DAG=y
CONFIG_DRM_I915_DEBUG_GUC=y
CONFIG_DRM_I915_SELFTEST=y
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
CONFIG_DRM_I915_DEBUG_VBLANK_EVADE=y
# CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
# end of drm/i915 Debugging

#
# drm/i915 Profile Guided Optimisation
#
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_SPIN_REQUEST=5
# end of drm/i915 Profile Guided Optimisation

CONFIG_DRM_VGEM=y
# CONFIG_DRM_VKMS is not set
CONFIG_DRM_ATI_PCIGART=y
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_GMA500 is not set
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=y
# CONFIG_DRM_MGAG200 is not set
# CONFIG_DRM_CIRRUS_QEMU is not set
CONFIG_DRM_RCAR_DW_HDMI=y
# CONFIG_DRM_RCAR_LVDS is not set
CONFIG_DRM_QXL=y
CONFIG_DRM_BOCHS=y
# CONFIG_DRM_VIRTIO_GPU is not set
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_ARM_VERSATILE is not set
CONFIG_DRM_PANEL_LVDS=y
CONFIG_DRM_PANEL_SIMPLE=y
CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D=m
# CONFIG_DRM_PANEL_ILITEK_IL9322 is not set
CONFIG_DRM_PANEL_ILITEK_ILI9881C=y
CONFIG_DRM_PANEL_INNOLUX_P079ZCA=m
CONFIG_DRM_PANEL_JDI_LT070ME05000=m
CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04=m
# CONFIG_DRM_PANEL_SAMSUNG_LD9040 is not set
# CONFIG_DRM_PANEL_LG_LB035Q02 is not set
CONFIG_DRM_PANEL_LG_LG4573=y
CONFIG_DRM_PANEL_NEC_NL8048HL11=y
CONFIG_DRM_PANEL_NOVATEK_NT39016=y
# CONFIG_DRM_PANEL_OLIMEX_LCD_OLINUXINO is not set
# CONFIG_DRM_PANEL_ORISETECH_OTM8009A is not set
CONFIG_DRM_PANEL_OSD_OSD101T2587_53TS=y
# CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00 is not set
CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN=y
# CONFIG_DRM_PANEL_RAYDIUM_RM67191 is not set
CONFIG_DRM_PANEL_RAYDIUM_RM68200=m
CONFIG_DRM_PANEL_ROCKTECH_JH057N00900=m
CONFIG_DRM_PANEL_RONBO_RB070D30=y
# CONFIG_DRM_PANEL_SAMSUNG_S6D16D0 is not set
CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2=m
CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=y
CONFIG_DRM_PANEL_SAMSUNG_S6E63M0=m
# CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0 is not set
CONFIG_DRM_PANEL_SEIKO_43WVF1G=y
CONFIG_DRM_PANEL_SHARP_LQ101R1SX01=m
CONFIG_DRM_PANEL_SHARP_LS037V7DW01=y
# CONFIG_DRM_PANEL_SHARP_LS043T1LE01 is not set
CONFIG_DRM_PANEL_SITRONIX_ST7701=m
# CONFIG_DRM_PANEL_SITRONIX_ST7789V is not set
CONFIG_DRM_PANEL_SONY_ACX565AKM=y
# CONFIG_DRM_PANEL_TPO_TD028TTEC1 is not set
# CONFIG_DRM_PANEL_TPO_TD043MTEA1 is not set
CONFIG_DRM_PANEL_TPO_TPG110=y
CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA=y
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
CONFIG_DRM_ANALOGIX_ANX78XX=y
CONFIG_DRM_CDNS_DSI=m
CONFIG_DRM_DUMB_VGA_DAC=y
CONFIG_DRM_LVDS_ENCODER=y
# CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW is not set
# CONFIG_DRM_NXP_PTN3460 is not set
CONFIG_DRM_PARADE_PS8622=y
CONFIG_DRM_SIL_SII8620=m
CONFIG_DRM_SII902X=m
CONFIG_DRM_SII9234=m
CONFIG_DRM_THINE_THC63LVD1024=m
CONFIG_DRM_TOSHIBA_TC358764=m
# CONFIG_DRM_TOSHIBA_TC358767 is not set
CONFIG_DRM_TI_TFP410=y
CONFIG_DRM_TI_SN65DSI86=y
# CONFIG_DRM_I2C_ADV7511 is not set
CONFIG_DRM_DW_HDMI=y
CONFIG_DRM_DW_HDMI_CEC=m
# end of Display Interface Bridges

CONFIG_DRM_ETNAVIV=m
CONFIG_DRM_ETNAVIV_THERMAL=y
# CONFIG_DRM_ARCPGU is not set
CONFIG_DRM_MXS=y
CONFIG_DRM_MXSFB=m
CONFIG_TINYDRM_HX8357D=m
# CONFIG_TINYDRM_ILI9225 is not set
CONFIG_TINYDRM_ILI9341=m
CONFIG_TINYDRM_MI0283QT=m
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
CONFIG_TINYDRM_ST7735R=y
CONFIG_DRM_VBOXVIDEO=y
CONFIG_DRM_LEGACY=y
CONFIG_DRM_TDFX=m
CONFIG_DRM_R128=m
CONFIG_DRM_MGA=m
# CONFIG_DRM_VIA is not set
CONFIG_DRM_SAVAGE=y
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_LIB_RANDOM=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_DDC=m
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_HECUBA=m
CONFIG_FB_SVGALIB=m
CONFIG_FB_BACKLIGHT=m
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
CONFIG_FB_CYBER2000=m
CONFIG_FB_CYBER2000_DDC=y
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
# CONFIG_FB_EFI is not set
CONFIG_FB_N411=m
CONFIG_FB_HGA=m
CONFIG_FB_OPENCORES=m
# CONFIG_FB_S1D13XXX is not set
CONFIG_FB_NVIDIA=m
# CONFIG_FB_NVIDIA_I2C is not set
CONFIG_FB_NVIDIA_DEBUG=y
CONFIG_FB_NVIDIA_BACKLIGHT=y
# CONFIG_FB_RIVA is not set
CONFIG_FB_I740=m
CONFIG_FB_LE80578=y
# CONFIG_FB_CARILLO_RANCH is not set
CONFIG_FB_MATROX=m
CONFIG_FB_MATROX_MILLENIUM=y
CONFIG_FB_MATROX_MYSTIQUE=y
# CONFIG_FB_MATROX_G is not set
CONFIG_FB_MATROX_I2C=m
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
CONFIG_FB_ATY=m
CONFIG_FB_ATY_CT=y
CONFIG_FB_ATY_GENERIC_LCD=y
# CONFIG_FB_ATY_GX is not set
# CONFIG_FB_ATY_BACKLIGHT is not set
CONFIG_FB_S3=m
# CONFIG_FB_S3_DDC is not set
# CONFIG_FB_SAVAGE is not set
CONFIG_FB_SIS=m
CONFIG_FB_SIS_300=y
# CONFIG_FB_SIS_315 is not set
CONFIG_FB_VIA=y
CONFIG_FB_VIA_DIRECT_PROCFS=y
CONFIG_FB_VIA_X_COMPATIBILITY=y
CONFIG_FB_NEOMAGIC=y
# CONFIG_FB_KYRO is not set
CONFIG_FB_3DFX=m
CONFIG_FB_3DFX_ACCEL=y
# CONFIG_FB_3DFX_I2C is not set
CONFIG_FB_VOODOO1=y
CONFIG_FB_VT8623=m
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
CONFIG_FB_PM3=y
CONFIG_FB_CARMINE=m
CONFIG_FB_CARMINE_DRAM_EVAL=y
# CONFIG_CARMINE_DRAM_CUSTOM is not set
CONFIG_FB_GEODE=y
# CONFIG_FB_GEODE_LX is not set
CONFIG_FB_GEODE_GX=y
# CONFIG_FB_GEODE_GX1 is not set
# CONFIG_FB_SM501 is not set
CONFIG_FB_IBM_GXT4500=m
CONFIG_FB_GOLDFISH=y
CONFIG_FB_VIRTUAL=m
# CONFIG_FB_METRONOME is not set
CONFIG_FB_MB862XX=y
CONFIG_FB_MB862XX_PCI_GDC=y
# CONFIG_FB_MB862XX_I2C is not set
CONFIG_FB_SIMPLE=y
# CONFIG_FB_SSD1307 is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
CONFIG_LCD_L4F00242T03=m
# CONFIG_LCD_LMS283GF05 is not set
CONFIG_LCD_LTV350QV=m
# CONFIG_LCD_ILI922X is not set
CONFIG_LCD_ILI9320=m
# CONFIG_LCD_TDO24M is not set
CONFIG_LCD_VGG2432A4=m
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
CONFIG_LCD_LMS501KF03=m
CONFIG_LCD_HX8357=m
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_GENERIC=y
CONFIG_BACKLIGHT_LM3533=m
# CONFIG_BACKLIGHT_CARILLO_RANCH is not set
# CONFIG_BACKLIGHT_MAX8925 is not set
# CONFIG_BACKLIGHT_APPLE is not set
# CONFIG_BACKLIGHT_PM8941_WLED is not set
CONFIG_BACKLIGHT_SAHARA=m
CONFIG_BACKLIGHT_WM831X=y
CONFIG_BACKLIGHT_ADP8860=y
CONFIG_BACKLIGHT_ADP8870=m
# CONFIG_BACKLIGHT_88PM860X is not set
# CONFIG_BACKLIGHT_PCF50633 is not set
# CONFIG_BACKLIGHT_AAT2870 is not set
CONFIG_BACKLIGHT_LM3639=m
# CONFIG_BACKLIGHT_OT200 is not set
# CONFIG_BACKLIGHT_TPS65217 is not set
# CONFIG_BACKLIGHT_AS3711 is not set
CONFIG_BACKLIGHT_GPIO=m
CONFIG_BACKLIGHT_LV5207LP=y
CONFIG_BACKLIGHT_BD6107=m
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_VGASTATE=y
CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y
CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
# CONFIG_LOGO_LINUX_CLUT224 is not set
# end of Graphics support

CONFIG_SOUND=m
# CONFIG_SND is not set

#
# HID support
#
CONFIG_HID=m
# CONFIG_HID_BATTERY_STRENGTH is not set
# CONFIG_HIDRAW is not set
CONFIG_UHID=m
CONFIG_HID_GENERIC=m

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=m
# CONFIG_HID_ASUS is not set
# CONFIG_HID_AUREAL is not set
CONFIG_HID_BELKIN=m
CONFIG_HID_CHERRY=m
CONFIG_HID_CHICONY=m
CONFIG_HID_COUGAR=m
CONFIG_HID_MACALLY=m
CONFIG_HID_CMEDIA=m
# CONFIG_HID_CYPRESS is not set
# CONFIG_HID_DRAGONRISE is not set
# CONFIG_HID_EMS_FF is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_EZKEY is not set
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
# CONFIG_HID_KEYTOUCH is not set
CONFIG_HID_KYE=m
CONFIG_HID_WALTOP=m
CONFIG_HID_VIEWSONIC=m
# CONFIG_HID_GYRATION is not set
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
# CONFIG_HID_JABRA is not set
# CONFIG_HID_TWINHAN is not set
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
CONFIG_HID_LOGITECH=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
CONFIG_LOGIRUMBLEPAD2_FF=y
CONFIG_LOGIG940_FF=y
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=m
CONFIG_HID_MALTRON=m
CONFIG_HID_MAYFLASH=m
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=m
# CONFIG_HID_MONTEREY is not set
# CONFIG_HID_MULTITOUCH is not set
CONFIG_HID_NTI=m
CONFIG_HID_ORTEK=m
# CONFIG_HID_PANTHERLORD is not set
CONFIG_HID_PETALYNX=m
# CONFIG_HID_PICOLCD is not set
CONFIG_HID_PLANTRONICS=m
CONFIG_HID_PRIMAX=m
# CONFIG_HID_SAITEK is not set
# CONFIG_HID_SAMSUNG is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
# CONFIG_HID_SMARTJOYPLUS is not set
CONFIG_HID_TIVO=m
# CONFIG_HID_TOPSEED is not set
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
CONFIG_HID_UDRAW_PS3=m
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
# CONFIG_HID_ZYDACRON is not set
# CONFIG_HID_SENSOR_HUB is not set
# CONFIG_HID_ALPS is not set
# end of Special HID drivers

#
# I2C HID support
#
# CONFIG_I2C_HID is not set
# end of I2C HID support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
# CONFIG_USB is not set
CONFIG_USB_PCI=y

#
# USB port drivers
#

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_ROLE_SWITCH is not set
# CONFIG_MMC is not set
CONFIG_MEMSTICK=m
CONFIG_MEMSTICK_DEBUG=y

#
# MemoryStick drivers
#
CONFIG_MEMSTICK_UNSAFE_RESUME=y
# CONFIG_MSPRO_BLOCK is not set
# CONFIG_MS_BLOCK is not set

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=m
CONFIG_MEMSTICK_JMICRON_38X=m
CONFIG_MEMSTICK_R592=m
# CONFIG_MEMSTICK_REALTEK_PCI is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
CONFIG_LEDS_88PM860X=m
CONFIG_LEDS_AAT1290=y
CONFIG_LEDS_AN30259A=m
CONFIG_LEDS_APU=m
# CONFIG_LEDS_AS3645A is not set
# CONFIG_LEDS_BCM6328 is not set
# CONFIG_LEDS_BCM6358 is not set
CONFIG_LEDS_CPCAP=m
CONFIG_LEDS_CR0014114=m
CONFIG_LEDS_LM3530=m
CONFIG_LEDS_LM3532=m
CONFIG_LEDS_LM3533=m
# CONFIG_LEDS_LM3642 is not set
CONFIG_LEDS_LM3692X=y
CONFIG_LEDS_LM3601X=y
# CONFIG_LEDS_PCA9532 is not set
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_LP3944=y
# CONFIG_LEDS_LP3952 is not set
CONFIG_LEDS_LP55XX_COMMON=y
# CONFIG_LEDS_LP5521 is not set
CONFIG_LEDS_LP5523=y
CONFIG_LEDS_LP5562=y
CONFIG_LEDS_LP8501=m
CONFIG_LEDS_LP8788=y
CONFIG_LEDS_LP8860=y
# CONFIG_LEDS_CLEVO_MAIL is not set
CONFIG_LEDS_PCA955X=m
CONFIG_LEDS_PCA955X_GPIO=y
CONFIG_LEDS_PCA963X=y
# CONFIG_LEDS_WM831X_STATUS is not set
# CONFIG_LEDS_WM8350 is not set
# CONFIG_LEDS_DAC124S085 is not set
CONFIG_LEDS_REGULATOR=y
CONFIG_LEDS_BD2802=m
CONFIG_LEDS_INTEL_SS4200=m
# CONFIG_LEDS_LT3593 is not set
CONFIG_LEDS_MC13783=m
CONFIG_LEDS_TCA6507=m
CONFIG_LEDS_TLC591XX=y
CONFIG_LEDS_MAX77650=m
CONFIG_LEDS_LM355x=y
CONFIG_LEDS_OT200=y
CONFIG_LEDS_KTD2692=m
CONFIG_LEDS_IS31FL319X=m
# CONFIG_LEDS_IS31FL32XX is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_SYSCON=y
CONFIG_LEDS_MLXCPLD=y
CONFIG_LEDS_MLXREG=y
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
CONFIG_LEDS_SPI_BYTE=y
CONFIG_LEDS_TI_LMU_COMMON=y
# CONFIG_LEDS_LM3697 is not set
# CONFIG_LEDS_LM36274 is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=y
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
CONFIG_LEDS_TRIGGER_CPU=y
CONFIG_LEDS_TRIGGER_ACTIVITY=m
CONFIG_LEDS_TRIGGER_GPIO=m
# CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=y
CONFIG_LEDS_TRIGGER_PANIC=y
CONFIG_LEDS_TRIGGER_NETDEV=m
CONFIG_LEDS_TRIGGER_PATTERN=y
CONFIG_LEDS_TRIGGER_AUDIO=m
CONFIG_ACCESSIBILITY=y
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
# CONFIG_EDAC is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
# CONFIG_RTC_CLASS is not set
CONFIG_DMADEVICES=y
CONFIG_DMADEVICES_DEBUG=y
CONFIG_DMADEVICES_VDEBUG=y

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
CONFIG_DMA_OF=y
CONFIG_ALTERA_MSGDMA=m
CONFIG_DW_AXI_DMAC=y
# CONFIG_FSL_EDMA is not set
CONFIG_INTEL_IDMA64=m
CONFIG_PCH_DMA=m
CONFIG_TIMB_DMA=m
CONFIG_QCOM_HIDMA_MGMT=y
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
# CONFIG_DW_DMAC is not set
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
# CONFIG_DW_EDMA_PCIE is not set
CONFIG_HSU_DMA=y

#
# DMA Clients
#
# CONFIG_ASYNC_TX_DMA is not set
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
CONFIG_UDMABUF=y
# CONFIG_DMABUF_SELFTESTS is not set
# end of DMABUF options

CONFIG_AUXDISPLAY=y
CONFIG_HD44780=y
CONFIG_KS0108=m
CONFIG_KS0108_PORT=0x378
CONFIG_KS0108_DELAY=2
CONFIG_CFAG12864B=m
CONFIG_CFAG12864B_RATE=20
# CONFIG_IMG_ASCII_LCD is not set
# CONFIG_HT16K33 is not set
CONFIG_PARPORT_PANEL=m
CONFIG_PANEL_PARPORT=0
CONFIG_PANEL_PROFILE=5
# CONFIG_PANEL_CHANGE_MESSAGE is not set
# CONFIG_CHARLCD_BL_OFF is not set
CONFIG_CHARLCD_BL_ON=y
# CONFIG_CHARLCD_BL_FLASH is not set
CONFIG_PANEL=m
CONFIG_CHARLCD=y
CONFIG_UIO=y
CONFIG_UIO_CIF=y
# CONFIG_UIO_PDRV_GENIRQ is not set
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=m
# CONFIG_UIO_SERCOS3 is not set
CONFIG_UIO_PCI_GENERIC=y
CONFIG_UIO_NETX=y
CONFIG_UIO_PRUSS=y
CONFIG_UIO_MF624=m
CONFIG_IRQ_BYPASS_MANAGER=m
CONFIG_VIRT_DRIVERS=y
# CONFIG_VBOXGUEST is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
# CONFIG_VIRTIO_PCI is not set
CONFIG_VIRTIO_BALLOON=m
# CONFIG_VIRTIO_INPUT is not set
CONFIG_VIRTIO_MMIO=m
# CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

CONFIG_GREYBUS=y
CONFIG_STAGING=y
# CONFIG_COMEDI is not set
# CONFIG_FB_OLPC_DCON is not set
CONFIG_RTLLIB=m
CONFIG_RTLLIB_CRYPTO_CCMP=m
CONFIG_RTLLIB_CRYPTO_TKIP=m
CONFIG_RTLLIB_CRYPTO_WEP=m
CONFIG_RTL8192E=m

#
# IIO staging drivers
#

#
# Accelerometers
#
# CONFIG_ADIS16203 is not set
# CONFIG_ADIS16240 is not set
# end of Accelerometers

#
# Analog to digital converters
#
CONFIG_AD7816=m
# CONFIG_AD7192 is not set
CONFIG_AD7280=m
# end of Analog to digital converters

#
# Analog digital bi-direction converters
#
CONFIG_ADT7316=m
CONFIG_ADT7316_SPI=m
# CONFIG_ADT7316_I2C is not set
# end of Analog digital bi-direction converters

#
# Capacitance to digital converters
#
CONFIG_AD7150=m
CONFIG_AD7746=m
# end of Capacitance to digital converters

#
# Direct Digital Synthesis
#
CONFIG_AD9832=m
CONFIG_AD9834=m
# end of Direct Digital Synthesis

#
# Network Analyzer, Impedance Converters
#
CONFIG_AD5933=m
# end of Network Analyzer, Impedance Converters

#
# Active energy metering IC
#
# CONFIG_ADE7854 is not set
# end of Active energy metering IC

#
# Resolver to digital converters
#
# CONFIG_AD2S1210 is not set
# end of Resolver to digital converters
# end of IIO staging drivers

CONFIG_FB_SM750=m

#
# Speakup console speech
#
# end of Speakup console speech

# CONFIG_STAGING_MEDIA is not set

#
# Android
#
# CONFIG_ASHMEM is not set
# CONFIG_ANDROID_VSOC is not set
CONFIG_ION=y
CONFIG_ION_SYSTEM_HEAP=y
# CONFIG_ION_CMA_HEAP is not set
# end of Android

# CONFIG_STAGING_BOARD is not set
# CONFIG_GOLDFISH_AUDIO is not set
# CONFIG_GS_FPGABOOT is not set
CONFIG_UNISYSSPAR=y
CONFIG_COMMON_CLK_XLNX_CLKWZRD=y
# CONFIG_FB_TFT is not set
CONFIG_MOST=m
# CONFIG_MOST_CDEV is not set
# CONFIG_MOST_NET is not set
# CONFIG_MOST_DIM2 is not set
CONFIG_MOST_I2C=m
# CONFIG_GREYBUS_AUDIO is not set
CONFIG_GREYBUS_BOOTROM=y
CONFIG_GREYBUS_FIRMWARE=y
CONFIG_GREYBUS_HID=m
# CONFIG_GREYBUS_LIGHT is not set
# CONFIG_GREYBUS_LOG is not set
CONFIG_GREYBUS_LOOPBACK=y
CONFIG_GREYBUS_POWER=y
# CONFIG_GREYBUS_RAW is not set
# CONFIG_GREYBUS_VIBRATOR is not set
CONFIG_GREYBUS_BRIDGED_PHY=y
CONFIG_GREYBUS_GPIO=y
# CONFIG_GREYBUS_I2C is not set
# CONFIG_GREYBUS_SPI is not set
CONFIG_GREYBUS_UART=m
CONFIG_PI433=m

#
# Gasket devices
#
# end of Gasket devices

CONFIG_XIL_AXIS_FIFO=y
# CONFIG_FIELDBUS_DEV is not set
# CONFIG_KPC2000 is not set

#
# ISDN CAPI drivers
#
# CONFIG_CAPI_AVM is not set
# CONFIG_ISDN_DRV_GIGASET is not set
# CONFIG_HYSDN is not set
# end of ISDN CAPI drivers

CONFIG_UWB=y
CONFIG_UWB_WHCI=y
# CONFIG_EXFAT_FS is not set
CONFIG_QLGE=m
CONFIG_X86_PLATFORM_DEVICES=y
# CONFIG_ACER_WIRELESS is not set
# CONFIG_ACERHDF is not set
# CONFIG_ASUS_LAPTOP is not set
CONFIG_DCDBAS=m
CONFIG_DELL_SMBIOS=m
CONFIG_DELL_SMBIOS_SMM=y
CONFIG_DELL_LAPTOP=m
# CONFIG_DELL_SMO8800 is not set
# CONFIG_DELL_RBTN is not set
# CONFIG_DELL_RBU is not set
# CONFIG_FUJITSU_LAPTOP is not set
# CONFIG_FUJITSU_TABLET is not set
# CONFIG_AMILO_RFKILL is not set
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_HP_ACCEL is not set
# CONFIG_HP_WIRELESS is not set
# CONFIG_MSI_LAPTOP is not set
# CONFIG_PANASONIC_LAPTOP is not set
# CONFIG_COMPAL_LAPTOP is not set
# CONFIG_SONY_LAPTOP is not set
# CONFIG_IDEAPAD_LAPTOP is not set
# CONFIG_THINKPAD_ACPI is not set
CONFIG_SENSORS_HDAPS=m
# CONFIG_INTEL_MENLOW is not set
# CONFIG_ASUS_WIRELESS is not set
# CONFIG_ACPI_WMI is not set
# CONFIG_TOPSTAR_LAPTOP is not set
# CONFIG_TOSHIBA_BT_RFKILL is not set
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_ACPI_CMPC is not set
# CONFIG_INTEL_INT0002_VGPIO is not set
# CONFIG_INTEL_HID_EVENT is not set
# CONFIG_INTEL_VBTN is not set
# CONFIG_INTEL_IPS is not set
CONFIG_INTEL_PMC_CORE=y
CONFIG_IBM_RTL=m
CONFIG_XO1_RFKILL=m
# CONFIG_XO15_EBOOK is not set
CONFIG_SAMSUNG_LAPTOP=m
# CONFIG_INTEL_OAKTRAIL is not set
# CONFIG_SAMSUNG_Q10 is not set
# CONFIG_APPLE_GMUX is not set
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_INTEL_PMC_IPC is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
# CONFIG_INTEL_PUNIT_IPC is not set
CONFIG_MLX_PLATFORM=y
# CONFIG_TOUCHSCREEN_DMI is not set
# CONFIG_I2C_MULTI_INSTANTIATE is not set
CONFIG_PCENGINES_APU2=m
CONFIG_PMC_ATOM=y
# CONFIG_GOLDFISH_PIPE is not set
CONFIG_MFD_CROS_EC=y
CONFIG_CHROME_PLATFORMS=y
# CONFIG_CHROMEOS_LAPTOP is not set
CONFIG_CHROMEOS_PSTORE=m
# CONFIG_CHROMEOS_TBMC is not set
CONFIG_CROS_EC=y
# CONFIG_CROS_EC_I2C is not set
CONFIG_CROS_EC_SPI=m
# CONFIG_CROS_EC_LPC is not set
CONFIG_CROS_EC_PROTO=y
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
CONFIG_CROS_EC_CHARDEV=m
CONFIG_CROS_EC_LIGHTBAR=m
CONFIG_CROS_EC_VBC=m
# CONFIG_CROS_EC_DEBUGFS is not set
CONFIG_CROS_EC_SYSFS=m
CONFIG_CROS_USBPD_LOGGER=m
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_OLPC_EC=y
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_COMMON_CLK_WM831X is not set
# CONFIG_CLK_HSDK is not set
CONFIG_COMMON_CLK_MAX77686=y
# CONFIG_COMMON_CLK_MAX9485 is not set
CONFIG_COMMON_CLK_RK808=y
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI514 is not set
# CONFIG_COMMON_CLK_SI544 is not set
CONFIG_COMMON_CLK_SI570=y
CONFIG_COMMON_CLK_CDCE706=y
CONFIG_COMMON_CLK_CDCE925=y
CONFIG_COMMON_CLK_CS2000_CP=m
CONFIG_COMMON_CLK_S2MPS11=m
CONFIG_CLK_TWL6040=y
# CONFIG_COMMON_CLK_LOCHNAGAR is not set
CONFIG_COMMON_CLK_PALMAS=m
# CONFIG_COMMON_CLK_VC5 is not set
# CONFIG_COMMON_CLK_BD718XX is not set
CONFIG_COMMON_CLK_FIXED_MMIO=y
# end of Common Clock Framework

CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

# CONFIG_MAILBOX is not set
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_INTEL_IOMMU is not set

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

CONFIG_SOUNDWIRE=m

#
# SoundWire Devices
#

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Aspeed SoC drivers
#
# end of Aspeed SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

CONFIG_SOC_TI=y

#
# Xilinx SoC drivers
#
CONFIG_XILINX_VCU=m
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=m
CONFIG_DEVFREQ_GOV_PERFORMANCE=y
CONFIG_DEVFREQ_GOV_POWERSAVE=y
# CONFIG_DEVFREQ_GOV_USERSPACE is not set
# CONFIG_DEVFREQ_GOV_PASSIVE is not set

#
# DEVFREQ Drivers
#
CONFIG_PM_DEVFREQ_EVENT=y
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
# CONFIG_EXTCON_ADC_JACK is not set
# CONFIG_EXTCON_AXP288 is not set
CONFIG_EXTCON_FSA9480=m
CONFIG_EXTCON_GPIO=y
# CONFIG_EXTCON_INTEL_INT3496 is not set
# CONFIG_EXTCON_MAX14577 is not set
CONFIG_EXTCON_MAX3355=m
CONFIG_EXTCON_MAX77843=m
# CONFIG_EXTCON_PALMAS is not set
CONFIG_EXTCON_PTN5150=m
CONFIG_EXTCON_RT8973A=m
CONFIG_EXTCON_SM5502=y
# CONFIG_EXTCON_USB_GPIO is not set
CONFIG_EXTCON_USBC_CROS_EC=y
# CONFIG_MEMORY is not set
CONFIG_IIO=m
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=m
CONFIG_IIO_BUFFER_HW_CONSUMER=m
CONFIG_IIO_KFIFO_BUF=m
CONFIG_IIO_TRIGGERED_BUFFER=m
CONFIG_IIO_CONFIGFS=m
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
CONFIG_IIO_SW_DEVICE=m
# CONFIG_IIO_SW_TRIGGER is not set

#
# Accelerometers
#
# CONFIG_ADIS16201 is not set
# CONFIG_ADIS16209 is not set
CONFIG_ADXL345=m
CONFIG_ADXL345_I2C=m
# CONFIG_ADXL345_SPI is not set
CONFIG_ADXL372=m
CONFIG_ADXL372_SPI=m
CONFIG_ADXL372_I2C=m
# CONFIG_BMA180 is not set
CONFIG_BMA220=m
CONFIG_BMC150_ACCEL=m
CONFIG_BMC150_ACCEL_I2C=m
CONFIG_BMC150_ACCEL_SPI=m
CONFIG_DA280=m
CONFIG_DA311=m
CONFIG_DMARD06=m
# CONFIG_DMARD09 is not set
CONFIG_DMARD10=m
CONFIG_IIO_CROS_EC_ACCEL_LEGACY=m
CONFIG_IIO_ST_ACCEL_3AXIS=m
CONFIG_IIO_ST_ACCEL_I2C_3AXIS=m
CONFIG_IIO_ST_ACCEL_SPI_3AXIS=m
# CONFIG_KXSD9 is not set
CONFIG_KXCJK1013=m
# CONFIG_MC3230 is not set
CONFIG_MMA7455=m
CONFIG_MMA7455_I2C=m
CONFIG_MMA7455_SPI=m
CONFIG_MMA7660=m
CONFIG_MMA8452=m
CONFIG_MMA9551_CORE=m
CONFIG_MMA9551=m
CONFIG_MMA9553=m
CONFIG_MXC4005=m
# CONFIG_MXC6255 is not set
# CONFIG_SCA3000 is not set
CONFIG_STK8312=m
CONFIG_STK8BA50=m
# end of Accelerometers

#
# Analog to digital converters
#
CONFIG_AD_SIGMA_DELTA=m
CONFIG_AD7124=m
# CONFIG_AD7266 is not set
# CONFIG_AD7291 is not set
# CONFIG_AD7298 is not set
CONFIG_AD7476=m
CONFIG_AD7606=m
# CONFIG_AD7606_IFACE_PARALLEL is not set
CONFIG_AD7606_IFACE_SPI=m
CONFIG_AD7766=m
# CONFIG_AD7768_1 is not set
CONFIG_AD7780=m
CONFIG_AD7791=m
# CONFIG_AD7793 is not set
# CONFIG_AD7887 is not set
CONFIG_AD7923=m
CONFIG_AD7949=m
# CONFIG_AD799X is not set
CONFIG_AXP20X_ADC=m
CONFIG_AXP288_ADC=m
# CONFIG_CC10001_ADC is not set
# CONFIG_CPCAP_ADC is not set
CONFIG_DA9150_GPADC=m
CONFIG_ENVELOPE_DETECTOR=m
# CONFIG_HI8435 is not set
CONFIG_HX711=m
CONFIG_INA2XX_ADC=m
# CONFIG_LP8788_ADC is not set
CONFIG_LTC2471=m
# CONFIG_LTC2485 is not set
CONFIG_LTC2497=m
CONFIG_MAX1027=m
CONFIG_MAX11100=m
CONFIG_MAX1118=m
CONFIG_MAX1363=m
CONFIG_MAX9611=m
CONFIG_MCP320X=m
CONFIG_MCP3422=m
CONFIG_MCP3911=m
# CONFIG_MEN_Z188_ADC is not set
# CONFIG_NAU7802 is not set
CONFIG_PALMAS_GPADC=m
CONFIG_QCOM_VADC_COMMON=m
# CONFIG_QCOM_SPMI_IADC is not set
CONFIG_QCOM_SPMI_VADC=m
CONFIG_QCOM_SPMI_ADC5=m
CONFIG_SD_ADC_MODULATOR=m
CONFIG_TI_ADC081C=m
# CONFIG_TI_ADC0832 is not set
CONFIG_TI_ADC084S021=m
CONFIG_TI_ADC12138=m
# CONFIG_TI_ADC108S102 is not set
# CONFIG_TI_ADC128S052 is not set
CONFIG_TI_ADC161S626=m
# CONFIG_TI_ADS1015 is not set
CONFIG_TI_ADS7950=m
CONFIG_TI_ADS8344=m
CONFIG_TI_ADS8688=m
# CONFIG_TI_ADS124S08 is not set
CONFIG_TI_AM335X_ADC=m
CONFIG_TI_TLC4541=m
# CONFIG_VF610_ADC is not set
CONFIG_XILINX_XADC=m
# end of Analog to digital converters

#
# Analog Front Ends
#
CONFIG_IIO_RESCALE=m
# end of Analog Front Ends

#
# Amplifiers
#
CONFIG_AD8366=m
# end of Amplifiers

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=m
CONFIG_BME680=m
CONFIG_BME680_I2C=m
CONFIG_BME680_SPI=m
# CONFIG_CCS811 is not set
CONFIG_IAQCORE=m
# CONFIG_SENSIRION_SGP30 is not set
CONFIG_SPS30=m
CONFIG_VZ89X=m
# end of Chemical Sensors

CONFIG_IIO_CROS_EC_SENSORS_CORE=m
# CONFIG_IIO_CROS_EC_SENSORS is not set
CONFIG_IIO_CROS_EC_SENSORS_LID_ANGLE=m

#
# Hid Sensor IIO Common
#
# end of Hid Sensor IIO Common

CONFIG_IIO_MS_SENSORS_I2C=m

#
# SSP Sensor Common
#
CONFIG_IIO_SSP_SENSORS_COMMONS=m
CONFIG_IIO_SSP_SENSORHUB=m
# end of SSP Sensor Common

CONFIG_IIO_ST_SENSORS_I2C=m
CONFIG_IIO_ST_SENSORS_SPI=m
CONFIG_IIO_ST_SENSORS_CORE=m

#
# Digital to analog converters
#
# CONFIG_AD5064 is not set
CONFIG_AD5360=m
# CONFIG_AD5380 is not set
CONFIG_AD5421=m
CONFIG_AD5446=m
CONFIG_AD5449=m
CONFIG_AD5592R_BASE=m
CONFIG_AD5592R=m
# CONFIG_AD5593R is not set
# CONFIG_AD5504 is not set
CONFIG_AD5624R_SPI=m
# CONFIG_LTC1660 is not set
CONFIG_LTC2632=m
CONFIG_AD5686=m
CONFIG_AD5686_SPI=m
CONFIG_AD5696_I2C=m
CONFIG_AD5755=m
# CONFIG_AD5758 is not set
CONFIG_AD5761=m
CONFIG_AD5764=m
# CONFIG_AD5791 is not set
CONFIG_AD7303=m
CONFIG_CIO_DAC=m
CONFIG_AD8801=m
# CONFIG_DPOT_DAC is not set
CONFIG_DS4424=m
CONFIG_M62332=m
# CONFIG_MAX517 is not set
# CONFIG_MAX5821 is not set
CONFIG_MCP4725=m
CONFIG_MCP4922=m
CONFIG_TI_DAC082S085=m
# CONFIG_TI_DAC5571 is not set
CONFIG_TI_DAC7311=m
CONFIG_TI_DAC7612=m
CONFIG_VF610_DAC=m
# end of Digital to analog converters

#
# IIO dummy driver
#
CONFIG_IIO_DUMMY_EVGEN=m
CONFIG_IIO_SIMPLE_DUMMY=m
CONFIG_IIO_SIMPLE_DUMMY_EVENTS=y
CONFIG_IIO_SIMPLE_DUMMY_BUFFER=y
# end of IIO dummy driver

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
CONFIG_AD9523=m
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
CONFIG_ADF4350=m
# CONFIG_ADF4371 is not set
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
# CONFIG_ADIS16080 is not set
# CONFIG_ADIS16130 is not set
CONFIG_ADIS16136=m
CONFIG_ADIS16260=m
CONFIG_ADXRS450=m
CONFIG_BMG160=m
CONFIG_BMG160_I2C=m
CONFIG_BMG160_SPI=m
CONFIG_FXAS21002C=m
CONFIG_FXAS21002C_I2C=m
CONFIG_FXAS21002C_SPI=m
# CONFIG_MPU3050_I2C is not set
CONFIG_IIO_ST_GYRO_3AXIS=m
CONFIG_IIO_ST_GYRO_I2C_3AXIS=m
CONFIG_IIO_ST_GYRO_SPI_3AXIS=m
# CONFIG_ITG3200 is not set
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
CONFIG_AFE4403=m
CONFIG_AFE4404=m
CONFIG_MAX30100=m
# CONFIG_MAX30102 is not set
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
CONFIG_AM2315=m
CONFIG_DHT11=m
# CONFIG_HDC100X is not set
CONFIG_HTS221=m
CONFIG_HTS221_I2C=m
CONFIG_HTS221_SPI=m
# CONFIG_HTU21 is not set
# CONFIG_SI7005 is not set
CONFIG_SI7020=m
# end of Humidity sensors

#
# Inertial measurement units
#
# CONFIG_ADIS16400 is not set
# CONFIG_ADIS16460 is not set
# CONFIG_ADIS16480 is not set
CONFIG_BMI160=m
CONFIG_BMI160_I2C=m
# CONFIG_BMI160_SPI is not set
CONFIG_KMX61=m
CONFIG_INV_MPU6050_IIO=m
# CONFIG_INV_MPU6050_I2C is not set
CONFIG_INV_MPU6050_SPI=m
CONFIG_IIO_ST_LSM6DSX=m
CONFIG_IIO_ST_LSM6DSX_I2C=m
CONFIG_IIO_ST_LSM6DSX_SPI=m
CONFIG_IIO_ST_LSM6DSX_I3C=m
# end of Inertial measurement units

CONFIG_IIO_ADIS_LIB=m
CONFIG_IIO_ADIS_LIB_BUFFER=y

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
CONFIG_ADJD_S311=m
CONFIG_AL3320A=m
CONFIG_APDS9300=m
# CONFIG_APDS9960 is not set
CONFIG_BH1750=m
CONFIG_BH1780=m
# CONFIG_CM32181 is not set
CONFIG_CM3232=m
CONFIG_CM3323=m
# CONFIG_CM3605 is not set
CONFIG_CM36651=m
# CONFIG_IIO_CROS_EC_LIGHT_PROX is not set
CONFIG_GP2AP020A00F=m
CONFIG_SENSORS_ISL29018=m
CONFIG_SENSORS_ISL29028=m
# CONFIG_ISL29125 is not set
CONFIG_JSA1212=m
CONFIG_RPR0521=m
CONFIG_SENSORS_LM3533=m
CONFIG_LTR501=m
# CONFIG_LV0104CS is not set
# CONFIG_MAX44000 is not set
CONFIG_MAX44009=m
CONFIG_NOA1305=m
CONFIG_OPT3001=m
CONFIG_PA12203001=m
# CONFIG_SI1133 is not set
# CONFIG_SI1145 is not set
# CONFIG_STK3310 is not set
CONFIG_ST_UVIS25=m
CONFIG_ST_UVIS25_I2C=m
CONFIG_ST_UVIS25_SPI=m
CONFIG_TCS3414=m
CONFIG_TCS3472=m
CONFIG_SENSORS_TSL2563=m
# CONFIG_TSL2583 is not set
CONFIG_TSL2772=m
# CONFIG_TSL4531 is not set
CONFIG_US5182D=m
CONFIG_VCNL4000=m
CONFIG_VCNL4035=m
# CONFIG_VEML6070 is not set
CONFIG_VL6180=m
# CONFIG_ZOPT2201 is not set
# end of Light sensors

#
# Magnetometer sensors
#
# CONFIG_AK8974 is not set
CONFIG_AK8975=m
CONFIG_AK09911=m
CONFIG_BMC150_MAGN=m
CONFIG_BMC150_MAGN_I2C=m
CONFIG_BMC150_MAGN_SPI=m
CONFIG_MAG3110=m
CONFIG_MMC35240=m
CONFIG_IIO_ST_MAGN_3AXIS=m
CONFIG_IIO_ST_MAGN_I2C_3AXIS=m
CONFIG_IIO_ST_MAGN_SPI_3AXIS=m
CONFIG_SENSORS_HMC5843=m
CONFIG_SENSORS_HMC5843_I2C=m
# CONFIG_SENSORS_HMC5843_SPI is not set
CONFIG_SENSORS_RM3100=m
CONFIG_SENSORS_RM3100_I2C=m
# CONFIG_SENSORS_RM3100_SPI is not set
# end of Magnetometer sensors

#
# Multiplexers
#
CONFIG_IIO_MUX=m
# end of Multiplexers

#
# Inclinometer sensors
#
# end of Inclinometer sensors

#
# Triggers - standalone
#
CONFIG_IIO_INTERRUPT_TRIGGER=m
CONFIG_IIO_SYSFS_TRIGGER=m
# end of Triggers - standalone

#
# Digital potentiometers
#
CONFIG_AD5272=m
CONFIG_DS1803=m
CONFIG_MAX5432=m
CONFIG_MAX5481=m
CONFIG_MAX5487=m
# CONFIG_MCP4018 is not set
# CONFIG_MCP4131 is not set
# CONFIG_MCP4531 is not set
CONFIG_MCP41010=m
# CONFIG_TPL0102 is not set
# end of Digital potentiometers

#
# Digital potentiostats
#
CONFIG_LMP91000=m
# end of Digital potentiostats

#
# Pressure sensors
#
# CONFIG_ABP060MG is not set
CONFIG_BMP280=m
CONFIG_BMP280_I2C=m
CONFIG_BMP280_SPI=m
# CONFIG_IIO_CROS_EC_BARO is not set
# CONFIG_DPS310 is not set
CONFIG_HP03=m
CONFIG_MPL115=m
CONFIG_MPL115_I2C=m
CONFIG_MPL115_SPI=m
# CONFIG_MPL3115 is not set
# CONFIG_MS5611 is not set
CONFIG_MS5637=m
CONFIG_IIO_ST_PRESS=m
CONFIG_IIO_ST_PRESS_I2C=m
CONFIG_IIO_ST_PRESS_SPI=m
CONFIG_T5403=m
CONFIG_HP206C=m
# CONFIG_ZPA2326 is not set
# end of Pressure sensors

#
# Lightning sensors
#
# CONFIG_AS3935 is not set
# end of Lightning sensors

#
# Proximity and distance sensors
#
CONFIG_ISL29501=m
# CONFIG_LIDAR_LITE_V2 is not set
# CONFIG_MB1232 is not set
# CONFIG_RFD77402 is not set
CONFIG_SRF04=m
CONFIG_SX9500=m
CONFIG_SRF08=m
CONFIG_VL53L0X_I2C=m
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
CONFIG_AD2S90=m
# CONFIG_AD2S1200 is not set
# end of Resolver to digital converters

#
# Temperature sensors
#
CONFIG_MAXIM_THERMOCOUPLE=m
CONFIG_MLX90614=m
# CONFIG_MLX90632 is not set
CONFIG_TMP006=m
CONFIG_TMP007=m
# CONFIG_TSYS01 is not set
# CONFIG_TSYS02D is not set
CONFIG_MAX31856=m
# end of Temperature sensors

CONFIG_NTB=y
# CONFIG_NTB_MSI is not set
# CONFIG_NTB_IDT is not set
CONFIG_NTB_SWITCHTEC=m
CONFIG_NTB_PINGPONG=y
# CONFIG_NTB_TOOL is not set
CONFIG_NTB_PERF=y
# CONFIG_NTB_TRANSPORT is not set
CONFIG_VME_BUS=y

#
# VME Bridge Drivers
#
CONFIG_VME_CA91CX42=m
CONFIG_VME_TSI148=m
# CONFIG_VME_FAKE is not set

#
# VME Board Drivers
#
CONFIG_VMIVME_7805=m

#
# VME Device Drivers
#
CONFIG_VME_USER=m
# CONFIG_PWM is not set

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
# CONFIG_AL_FIC is not set
CONFIG_MADERA_IRQ=y
# end of IRQ chip support

CONFIG_IPACK_BUS=y
CONFIG_BOARD_TPCI200=y
CONFIG_SERIAL_IPOCTAL=m
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_TI_SYSCON is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_GENERIC_PHY_MIPI_DPHY=y
CONFIG_BCM_KONA_USB2_PHY=y
# CONFIG_PHY_CADENCE_DP is not set
CONFIG_PHY_CADENCE_DPHY=m
CONFIG_PHY_CADENCE_SIERRA=y
CONFIG_PHY_FSL_IMX8MQ_USB=m
CONFIG_PHY_MIXEL_MIPI_DPHY=m
CONFIG_PHY_PXA_28NM_HSIC=y
CONFIG_PHY_PXA_28NM_USB2=y
# CONFIG_PHY_CPCAP_USB is not set
# CONFIG_PHY_MAPPHONE_MDM6600 is not set
CONFIG_PHY_OCELOT_SERDES=y
# end of PHY Subsystem

CONFIG_POWERCAP=y
# CONFIG_INTEL_RAPL is not set
# CONFIG_IDLE_INJECT is not set
CONFIG_MCB=y
# CONFIG_MCB_PCI is not set
CONFIG_MCB_LPC=m

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_THUNDERBOLT is not set

#
# Android
#
CONFIG_ANDROID=y
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

# CONFIG_DAX is not set
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y

#
# HW tracing support
#
# CONFIG_STM is not set
# CONFIG_INTEL_TH is not set
# end of HW tracing support

CONFIG_FPGA=y
CONFIG_ALTERA_PR_IP_CORE=y
CONFIG_ALTERA_PR_IP_CORE_PLAT=y
# CONFIG_FPGA_MGR_ALTERA_PS_SPI is not set
CONFIG_FPGA_MGR_ALTERA_CVP=y
# CONFIG_FPGA_MGR_XILINX_SPI is not set
CONFIG_FPGA_MGR_ICE40_SPI=y
# CONFIG_FPGA_MGR_MACHXO2_SPI is not set
CONFIG_FPGA_BRIDGE=y
CONFIG_ALTERA_FREEZE_BRIDGE=m
CONFIG_XILINX_PR_DECOUPLER=y
CONFIG_FPGA_REGION=y
CONFIG_OF_FPGA_REGION=y
CONFIG_FPGA_DFL=y
CONFIG_FPGA_DFL_FME=m
CONFIG_FPGA_DFL_FME_MGR=m
CONFIG_FPGA_DFL_FME_BRIDGE=m
# CONFIG_FPGA_DFL_FME_REGION is not set
# CONFIG_FPGA_DFL_AFU is not set
# CONFIG_FPGA_DFL_PCI is not set
CONFIG_FSI=m
# CONFIG_FSI_NEW_DEV_NODE is not set
CONFIG_FSI_MASTER_GPIO=m
CONFIG_FSI_MASTER_HUB=m
CONFIG_FSI_SCOM=m
# CONFIG_FSI_SBEFIFO is not set
CONFIG_MULTIPLEXER=m

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=m
CONFIG_MUX_ADGS1408=m
CONFIG_MUX_GPIO=m
CONFIG_MUX_MMIO=m
# end of Multiplexer drivers

CONFIG_PM_OPP=y
CONFIG_SIOX=m
CONFIG_SIOX_BUS_GPIO=m
CONFIG_SLIMBUS=m
# CONFIG_SLIM_QCOM_CTRL is not set
CONFIG_INTERCONNECT=y
# CONFIG_COUNTER is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_VALIDATE_FS_PARSER=y
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
# CONFIG_EXT4_FS is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
# CONFIG_XFS_QUOTA is not set
# CONFIG_XFS_POSIX_ACL is not set
# CONFIG_XFS_RT is not set
# CONFIG_XFS_ONLINE_SCRUB is not set
# CONFIG_XFS_WARN is not set
# CONFIG_XFS_DEBUG is not set
# CONFIG_GFS2_FS is not set
# CONFIG_OCFS2_FS is not set
CONFIG_BTRFS_FS=m
# CONFIG_BTRFS_FS_POSIX_ACL is not set
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
# CONFIG_F2FS_FS is not set
# CONFIG_FS_DAX is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
# CONFIG_MANDATORY_FILE_LOCKING is not set
# CONFIG_FS_ENCRYPTION is not set
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
CONFIG_QUOTA_DEBUG=y
CONFIG_QUOTA_TREE=y
CONFIG_QFMT_V1=m
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
# CONFIG_AUTOFS4_FS is not set
CONFIG_AUTOFS_FS=m
# CONFIG_FUSE_FS is not set
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
CONFIG_OVERLAY_FS_INDEX=y
# CONFIG_OVERLAY_FS_NFS_EXPORT is not set
CONFIG_OVERLAY_FS_XINO_AUTO=y
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
# CONFIG_FSCACHE is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
# CONFIG_UDF_FS is not set
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/NT Filesystems
#
# CONFIG_MSDOS_FS is not set
# CONFIG_VFAT_FS is not set
# CONFIG_NTFS_FS is not set
# end of DOS/FAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_HUGETLBFS is not set
CONFIG_MEMFD_CREATE=y
CONFIG_CONFIGFS_FS=m
CONFIG_EFIVAR_FS=m
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_SQUASHFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
# CONFIG_NFS_V4_1 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFSD=y
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
# CONFIG_NFSD_SCSILAYOUT is not set
CONFIG_NFSD_FLEXFILELAYOUT=y
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=y
# CONFIG_SUNRPC_DEBUG is not set
CONFIG_CEPH_FS=m
# CONFIG_CEPH_FS_POSIX_ACL is not set
CONFIG_CIFS=y
# CONFIG_CIFS_STATS2 is not set
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_WEAK_PW_HASH=y
# CONFIG_CIFS_UPCALL is not set
# CONFIG_CIFS_XATTR is not set
# CONFIG_CIFS_DEBUG is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_ROOT is not set
CONFIG_CODA_FS=y
CONFIG_AFS_FS=y
# CONFIG_AFS_DEBUG is not set
CONFIG_AFS_DEBUG_CURSOR=y
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
# CONFIG_NLS_CODEPAGE_850 is not set
CONFIG_NLS_CODEPAGE_852=y
# CONFIG_NLS_CODEPAGE_855 is not set
CONFIG_NLS_CODEPAGE_857=y
# CONFIG_NLS_CODEPAGE_860 is not set
CONFIG_NLS_CODEPAGE_861=y
# CONFIG_NLS_CODEPAGE_862 is not set
CONFIG_NLS_CODEPAGE_863=y
# CONFIG_NLS_CODEPAGE_864 is not set
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=y
CONFIG_NLS_CODEPAGE_869=m
# CONFIG_NLS_CODEPAGE_936 is not set
CONFIG_NLS_CODEPAGE_950=m
# CONFIG_NLS_CODEPAGE_932 is not set
CONFIG_NLS_CODEPAGE_949=y
CONFIG_NLS_CODEPAGE_874=y
CONFIG_NLS_ISO8859_8=y
# CONFIG_NLS_CODEPAGE_1250 is not set
CONFIG_NLS_CODEPAGE_1251=y
CONFIG_NLS_ASCII=y
# CONFIG_NLS_ISO8859_1 is not set
# CONFIG_NLS_ISO8859_2 is not set
CONFIG_NLS_ISO8859_3=y
CONFIG_NLS_ISO8859_4=y
# CONFIG_NLS_ISO8859_5 is not set
CONFIG_NLS_ISO8859_6=y
CONFIG_NLS_ISO8859_7=y
CONFIG_NLS_ISO8859_9=y
CONFIG_NLS_ISO8859_13=y
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
CONFIG_NLS_KOI8_R=y
CONFIG_NLS_KOI8_U=m
# CONFIG_NLS_MAC_ROMAN is not set
# CONFIG_NLS_MAC_CELTIC is not set
# CONFIG_NLS_MAC_CENTEURO is not set
# CONFIG_NLS_MAC_CROATIAN is not set
CONFIG_NLS_MAC_CYRILLIC=m
# CONFIG_NLS_MAC_GAELIC is not set
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
# CONFIG_NLS_MAC_INUIT is not set
# CONFIG_NLS_MAC_ROMANIAN is not set
# CONFIG_NLS_MAC_TURKISH is not set
# CONFIG_NLS_UTF8 is not set
CONFIG_DLM=m
CONFIG_DLM_DEBUG=y
# CONFIG_UNICODE is not set
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
# CONFIG_PERSISTENT_KEYRINGS is not set
# CONFIG_BIG_KEYS is not set
# CONFIG_TRUSTED_KEYS is not set
CONFIG_ENCRYPTED_KEYS=m
CONFIG_KEY_DH_OPERATIONS=y
CONFIG_SECURITY_DMESG_RESTRICT=y
# CONFIG_SECURITY is not set
# CONFIG_SECURITYFS is not set
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
# CONFIG_HARDENED_USERCOPY_FALLBACK is not set
CONFIG_HARDENED_USERCOPY_PAGESPAN=y
# CONFIG_FORTIFY_SOURCE is not set
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity"

#
# Kernel hardening options
#
CONFIG_GCC_PLUGIN_STRUCTLEAK=y

#
# Memory initialization
#
# CONFIG_INIT_STACK_NONE is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_USER is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF is not set
CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_VERBOSE is not set
CONFIG_GCC_PLUGIN_STACKLEAK=y
CONFIG_STACKLEAK_TRACK_MIN_SIZE=100
CONFIG_STACKLEAK_METRICS=y
CONFIG_STACKLEAK_RUNTIME_DISABLE=y
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
CONFIG_INIT_ON_FREE_DEFAULT_ON=y
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_BLKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=y
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_CRYPTD=m
CONFIG_CRYPTO_AUTHENC=y
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_ENGINE=m

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=m
CONFIG_CRYPTO_ECRDSA=y

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=m
CONFIG_CRYPTO_AEGIS128=m
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=m
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_LRW is not set
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_XTS=y
CONFIG_CRYPTO_KEYWRAP=y
CONFIG_CRYPTO_NHPOLY1305=y
CONFIG_CRYPTO_ADIANTUM=y
# CONFIG_CRYPTO_ESSIV is not set

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
# CONFIG_CRYPTO_CRC32C_INTEL is not set
CONFIG_CRYPTO_CRC32=m
# CONFIG_CRYPTO_CRC32_PCLMUL is not set
CONFIG_CRYPTO_XXHASH=m
# CONFIG_CRYPTO_CRCT10DIF is not set
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
CONFIG_CRYPTO_RMD128=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_RMD256=y
# CONFIG_CRYPTO_RMD320 is not set
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
# CONFIG_CRYPTO_SHA3 is not set
# CONFIG_CRYPTO_SM3 is not set
CONFIG_CRYPTO_STREEBOG=y
# CONFIG_CRYPTO_TGR192 is not set
CONFIG_CRYPTO_WP512=m

#
# Ciphers
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=m
# CONFIG_CRYPTO_AES_NI_INTEL is not set
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_LIB_ARC4=y
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_LIB_DES=y
# CONFIG_CRYPTO_DES is not set
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_KHAZAD=m
# CONFIG_CRYPTO_SALSA20 is not set
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=y
# CONFIG_CRYPTO_SERPENT_SSE2_586 is not set
# CONFIG_CRYPTO_SM4 is not set
# CONFIG_CRYPTO_TEA is not set
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_586=y

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
# CONFIG_CRYPTO_LZO is not set
CONFIG_CRYPTO_842=m
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
CONFIG_CRYPTO_USER_API_RNG=m
CONFIG_CRYPTO_USER_API_AEAD=m
CONFIG_CRYPTO_STATS=y
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
CONFIG_CRYPTO_DEV_GEODE=m
CONFIG_CRYPTO_DEV_HIFN_795X=m
CONFIG_CRYPTO_DEV_HIFN_795X_RNG=y
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_CCP_DD=y
# CONFIG_CRYPTO_DEV_SP_CCP is not set
CONFIG_CRYPTO_DEV_QAT=y
# CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
CONFIG_CRYPTO_DEV_QAT_C3XXX=m
# CONFIG_CRYPTO_DEV_QAT_C62X is not set
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=y
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=m
# CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
CONFIG_CRYPTO_DEV_VIRTIO=m
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
# CONFIG_CRYPTO_DEV_CCREE is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=m
CONFIG_X509_CERTIFICATE_PARSER=m
CONFIG_PKCS8_PRIVATE_KEY_PARSER=m
CONFIG_PKCS7_MESSAGE_PARSER=m

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
CONFIG_PACKING=y
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
# CONFIG_CORDIC is not set
CONFIG_PRIME_NUMBERS=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
# CONFIG_CRC_T10DIF is not set
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=y
# CONFIG_CRC32_SLICEBY8 is not set
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
CONFIG_CRC32_BIT=y
CONFIG_CRC64=y
CONFIG_CRC4=y
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=m
CONFIG_XXHASH=y
CONFIG_AUDIT_GENERIC=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_842_COMPRESS=m
CONFIG_842_DECOMPRESS=m
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=m
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=m
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
# CONFIG_XZ_DEC_POWERPC is not set
# CONFIG_XZ_DEC_IA64 is not set
# CONFIG_XZ_DEC_ARM is not set
# CONFIG_XZ_DEC_ARMTHUMB is not set
# CONFIG_XZ_DEC_SPARC is not set
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=y
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_INTERVAL_TREE=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_DMA_DECLARE_COHERENT=y
CONFIG_DMA_CMA=y

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=0
CONFIG_CMA_SIZE_PERCENTAGE=0
# CONFIG_CMA_SIZE_SEL_MBYTES is not set
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
CONFIG_CMA_SIZE_SEL_MIN=y
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_DIMLIB=y
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_32=y
CONFIG_FONT_SUPPORT=y
CONFIG_FONT_8x16=y
CONFIG_FONT_AUTOSELECT=y
CONFIG_ARCH_STACKWALK=y
CONFIG_SBITMAP=y
CONFIG_STRING_SELFTEST=y
# end of Library routines

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
# CONFIG_PRINTK_CALLER is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
CONFIG_DYNAMIC_DEBUG=y
# end of printk and dmesg options

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_BTF is not set
# CONFIG_GDB_SCRIPTS is not set
# CONFIG_ENABLE_MUST_CHECK is not set
CONFIG_FRAME_WARN=2048
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_READABLE_ASM is not set
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_INSTALL=y
CONFIG_HEADERS_CHECK=y
CONFIG_OPTIMIZE_INLINING=y
# CONFIG_DEBUG_SECTION_MISMATCH is not set
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_FRAME_POINTER=y
CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
# end of Compile-time checks and compiler options

CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_POISONING is not set
CONFIG_DEBUG_PAGE_REF=y
CONFIG_DEBUG_RODATA_TEST=y
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
# CONFIG_DEBUG_MEMORY_INIT is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_KASAN_STACK=1
# end of Memory Debugging

CONFIG_CC_HAS_SANCOV_TRACE_PC=y
CONFIG_DEBUG_SHIRQ=y

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=1
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
# CONFIG_DETECT_HUNG_TASK is not set
CONFIG_WQ_WATCHDOG=y
# end of Debug Lockups and Hangs

CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# CONFIG_SCHED_STACK_END_CHECK is not set
# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
CONFIG_LOCK_STAT=y
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
CONFIG_LOCK_TORTURE_TEST=y
CONFIG_WW_MUTEX_SELFTEST=m
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_STACKTRACE=y
CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PLIST=y
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
CONFIG_TORTURE_TEST=y
# CONFIG_RCU_PERF_TEST is not set
CONFIG_RCU_TORTURE_TEST=m
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
CONFIG_NOTIFIER_ERROR_INJECTION=m
CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
CONFIG_FAIL_PAGE_ALLOC=y
# CONFIG_FAIL_MAKE_REQUEST is not set
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
CONFIG_FAULT_INJECTION_STACKTRACE_FILTER=y
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
CONFIG_FUNCTION_TRACER=y
# CONFIG_FUNCTION_GRAPH_TRACER is not set
CONFIG_PREEMPTIRQ_EVENTS=y
CONFIG_IRQSOFF_TRACER=y
# CONFIG_SCHED_TRACER is not set
# CONFIG_HWLAT_TRACER is not set
# CONFIG_FTRACE_SYSCALLS is not set
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_PROFILE_ALL_BRANCHES is not set
CONFIG_STACK_TRACER=y
# CONFIG_BLK_DEV_IO_TRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
# CONFIG_FUNCTION_PROFILER is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
# CONFIG_FTRACE_STARTUP_TEST is not set
CONFIG_MMIOTRACE=y
CONFIG_TRACING_MAP=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_MMIOTRACE_TEST is not set
CONFIG_TRACEPOINT_BENCHMARK=y
CONFIG_RING_BUFFER_BENCHMARK=y
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
CONFIG_PREEMPTIRQ_DELAY_TEST=m
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_SORT is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
CONFIG_ATOMIC64_SELFTEST=m
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
CONFIG_TEST_STRSCPY=m
# CONFIG_TEST_KSTRTOX is not set
CONFIG_TEST_PRINTF=m
CONFIG_TEST_BITMAP=y
# CONFIG_TEST_BITFIELD is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_OVERFLOW is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_TEST_IDA is not set
CONFIG_TEST_LKM=m
CONFIG_TEST_VMALLOC=m
CONFIG_TEST_USER_COPY=m
CONFIG_TEST_BPF=m
CONFIG_TEST_BLACKHOLE_DEV=m
# CONFIG_FIND_BIT_BENCHMARK is not set
CONFIG_TEST_FIRMWARE=y
CONFIG_TEST_SYSCTL=m
# CONFIG_TEST_UDELAY is not set
CONFIG_TEST_STATIC_KEYS=m
CONFIG_TEST_KMOD=m
# CONFIG_TEST_MEMCAT_P is not set
CONFIG_TEST_STACKINIT=y
# CONFIG_TEST_MEMINIT is not set
# CONFIG_MEMTEST is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
# CONFIG_UBSAN_SANITIZE_ALL is not set
# CONFIG_UBSAN_NO_ALIGNMENT is not set
CONFIG_UBSAN_ALIGNMENT=y
CONFIG_TEST_UBSAN=m
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_X86_VERBOSE_BOOTUP=y
# CONFIG_EARLY_PRINTK is not set
CONFIG_X86_PTDUMP_CORE=y
# CONFIG_X86_PTDUMP is not set
# CONFIG_EFI_PGT_DUMP is not set
CONFIG_DEBUG_WX=y
CONFIG_DOUBLEFAULT=y
CONFIG_DEBUG_TLBFLUSH=y
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
# CONFIG_IO_DELAY_0X80 is not set
# CONFIG_IO_DELAY_0XED is not set
CONFIG_IO_DELAY_UDELAY=y
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_FRAME_POINTER=y
# CONFIG_UNWINDER_GUESS is not set
# end of Kernel hacking

--=_5e22cbe7.jqse+xj267DXZmp2A+UOx+o1HTUjNHG8yHtNj1aIY2NNrqVh--
