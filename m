Return-Path: <linux-api+bounces-3709-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D184AADE90
	for <lists+linux-api@lfdr.de>; Wed,  7 May 2025 14:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1A464A2013
	for <lists+linux-api@lfdr.de>; Wed,  7 May 2025 12:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEC325EF8C;
	Wed,  7 May 2025 12:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nF7dZI5g"
X-Original-To: linux-api@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A005F25EF81;
	Wed,  7 May 2025 12:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746619619; cv=none; b=C57Z+HenB12agRwYiJ4G4fJX4aPUdl7VW5LM45/AlBSu5/E6o0W8JWj0w5usL+7dAMHB+TK4BnpnGU/poYfGg7wIgiXWXc84PeWUc/dm0LohAHV+q0S7pp25h+VVu7nMmApCVgmUGmA/E4Yhe8LGNmx+cNs2xMCWV7wy+1wgsJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746619619; c=relaxed/simple;
	bh=eNITE1Df3jBSXcp/P9H+6TRCxV1Zrgo9Io0g8P/xrUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PFhTTVZHnVxVfhuYLwxrdeDvYR2t54oelbHlQ4YwH6RaE8+vhuGp51ESH2jP90yLknDK3gIXyjulonrdnpbFOgRqcpVYLJustXc0ZjpvrabRz0NsN/qebm2UgTiRI/avIiGW9VACB5Bzn+EZfETVUf2T9u+Ld1zvdwY8enHpxQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nF7dZI5g; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746619617; x=1778155617;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eNITE1Df3jBSXcp/P9H+6TRCxV1Zrgo9Io0g8P/xrUU=;
  b=nF7dZI5gJ4Y4u58m6MCZFgeHWFqAEdr0sleDe7fFtgyM6EfpI0qC8Rpj
   l6kmiQXHRcT7tR4ILs6JMbK3Hi1IPi/G/WmPmJfL4tPNWILb2ItRgkPDZ
   HdjW5idWRtGnH2loYEEk1l+vm/GnaA9YZ4JrD6cSuzrKh0PoN55eY7FRO
   lOvKiiEms7xbK/W0q3fAk9hz5LS01cy/IIQ0gks1wZO+KNmrgUff3q9Pl
   b4qwfNCCn0JDmFdqrTINZCSEITohAaSt/NyXE8M1r10i+Vsp4vVIe+x+C
   0BF/mY9VrTL7Ns84gZc7KUwiGA08JAcGX0jize36zcOuVRBuGs8yex2Do
   Q==;
X-CSE-ConnectionGUID: vlRwGz7xTDeJT6ve8iEWpA==
X-CSE-MsgGUID: JYjXNbvxRG6N1iJWt9gLBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="58541794"
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; 
   d="scan'208";a="58541794"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 05:06:55 -0700
X-CSE-ConnectionGUID: EAr9SIzASSi0E+AP82w6JQ==
X-CSE-MsgGUID: 3CTcvS5tS7uo4WDXTzSXpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; 
   d="scan'208";a="136450352"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 07 May 2025 05:05:34 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uCdWl-0007k9-25;
	Wed, 07 May 2025 12:05:31 +0000
Date: Wed, 7 May 2025 20:04:52 +0800
From: kernel test robot <lkp@intel.com>
To: Maxime =?iso-8859-1?Q?B=E9lair?= <maxime.belair@canonical.com>,
	linux-security-module@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, john.johansen@canonical.com,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	mic@digikod.net, kees@kernel.org, stephen.smalley.work@gmail.com,
	casey@schaufler-ca.com, takedakn@nttdata.co.jp,
	penguin-kernel@i-love.sakura.ne.jp, linux-api@vger.kernel.org,
	apparmor@lists.ubuntu.com, linux-kernel@vger.kernel.org,
	Maxime =?iso-8859-1?Q?B=E9lair?= <maxime.belair@canonical.com>
Subject: Re: [PATCH 2/3] lsm: introduce security_lsm_manage_policy hook
Message-ID: <202505071924.MeIKUbEX-lkp@intel.com>
References: <20250506143254.718647-3-maxime.belair@canonical.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506143254.718647-3-maxime.belair@canonical.com>

Hi Maxime,

kernel test robot noticed the following build errors:

[auto build test ERROR on 9c32cda43eb78f78c73aee4aa344b777714e259b]

url:    https://github.com/intel-lab-lkp/linux/commits/Maxime-B-lair/Wire-up-the-lsm_manage_policy-syscall/20250506-224212
base:   9c32cda43eb78f78c73aee4aa344b777714e259b
patch link:    https://lore.kernel.org/r/20250506143254.718647-3-maxime.belair%40canonical.com
patch subject: [PATCH 2/3] lsm: introduce security_lsm_manage_policy hook
config: riscv-allnoconfig (https://download.01.org/0day-ci/archive/20250507/202505071924.MeIKUbEX-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250507/202505071924.MeIKUbEX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505071924.MeIKUbEX-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   include/linux/perf_event.h:2034:1: note: in expansion of macro 'DECLARE_STATIC_CALL'
    2034 | DECLARE_STATIC_CALL(perf_snapshot_branch_stack, perf_snapshot_branch_stack_t);
         | ^~~~~~~~~~~~~~~~~~~
   include/linux/static_call_types.h:15:41: error: storage class specified for parameter '__SCT__perf_snapshot_branch_stack'
      15 | #define STATIC_CALL_TRAMP_PREFIX        __SCT__
         |                                         ^~~~~~~
   include/linux/compiler_types.h:83:23: note: in definition of macro '___PASTE'
      83 | #define ___PASTE(a,b) a##b
         |                       ^
   include/linux/static_call_types.h:18:41: note: in expansion of macro '__PASTE'
      18 | #define STATIC_CALL_TRAMP(name)         __PASTE(STATIC_CALL_TRAMP_PREFIX, name)
         |                                         ^~~~~~~
   include/linux/static_call_types.h:18:49: note: in expansion of macro 'STATIC_CALL_TRAMP_PREFIX'
      18 | #define STATIC_CALL_TRAMP(name)         __PASTE(STATIC_CALL_TRAMP_PREFIX, name)
         |                                                 ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/static_call_types.h:39:29: note: in expansion of macro 'STATIC_CALL_TRAMP'
      39 |         extern typeof(func) STATIC_CALL_TRAMP(name);
         |                             ^~~~~~~~~~~~~~~~~
   include/linux/perf_event.h:2034:1: note: in expansion of macro 'DECLARE_STATIC_CALL'
    2034 | DECLARE_STATIC_CALL(perf_snapshot_branch_stack, perf_snapshot_branch_stack_t);
         | ^~~~~~~~~~~~~~~~~~~
   include/linux/perf_event.h:2034:78: error: expected declaration specifiers before ';' token
    2034 | DECLARE_STATIC_CALL(perf_snapshot_branch_stack, perf_snapshot_branch_stack_t);
         |                                                                              ^
   include/linux/perf_event.h:2038:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    2038 | {
         | ^
   In file included from arch/riscv/include/asm/kvm_vcpu_pmu.h:14:
   arch/riscv/include/asm/sbi.h:15:1: warning: empty declaration
      15 | enum sbi_ext_id {
         | ^~~~
   arch/riscv/include/asm/sbi.h:48:1: warning: empty declaration
      48 | enum sbi_ext_base_fid {
         | ^~~~
   arch/riscv/include/asm/sbi.h:58:1: warning: empty declaration
      58 | enum sbi_ext_time_fid {
         | ^~~~
   arch/riscv/include/asm/sbi.h:62:1: warning: empty declaration
      62 | enum sbi_ext_ipi_fid {
         | ^~~~
   arch/riscv/include/asm/sbi.h:66:1: warning: empty declaration
      66 | enum sbi_ext_rfence_fid {
         | ^~~~
   arch/riscv/include/asm/sbi.h:76:1: warning: empty declaration
      76 | enum sbi_ext_hsm_fid {
         | ^~~~
   arch/riscv/include/asm/sbi.h:83:1: warning: empty declaration
      83 | enum sbi_hsm_hart_state {
         | ^~~~
   arch/riscv/include/asm/sbi.h:106:1: warning: empty declaration
     106 | enum sbi_ext_srst_fid {
         | ^~~~
   arch/riscv/include/asm/sbi.h:110:1: warning: empty declaration
     110 | enum sbi_srst_reset_type {
         | ^~~~
   arch/riscv/include/asm/sbi.h:116:1: warning: empty declaration
     116 | enum sbi_srst_reset_reason {
         | ^~~~
   arch/riscv/include/asm/sbi.h:121:1: warning: empty declaration
     121 | enum sbi_ext_susp_fid {
         | ^~~~
   arch/riscv/include/asm/sbi.h:125:1: warning: empty declaration
     125 | enum sbi_ext_susp_sleep_type {
         | ^~~~
   arch/riscv/include/asm/sbi.h:129:1: warning: empty declaration
     129 | enum sbi_ext_pmu_fid {
         | ^~~~
   arch/riscv/include/asm/sbi.h:140:1: warning: empty declaration
     140 | union sbi_pmu_ctr_info {
         | ^~~~~
   arch/riscv/include/asm/sbi.h:155:1: warning: empty declaration
     155 | struct riscv_pmu_snapshot_data {
         | ^~~~~~
   arch/riscv/include/asm/sbi.h:167:1: warning: empty declaration
     167 | enum sbi_pmu_hw_generic_events_t {
         | ^~~~
   arch/riscv/include/asm/sbi.h:188:1: warning: empty declaration
     188 | enum sbi_pmu_fw_generic_events_t {
         | ^~~~
   arch/riscv/include/asm/sbi.h:217:1: warning: empty declaration
     217 | enum sbi_pmu_event_type {
         | ^~~~
   arch/riscv/include/asm/sbi.h:225:1: warning: empty declaration
     225 | enum sbi_pmu_ctr_type {
         | ^~~~
   arch/riscv/include/asm/sbi.h:265:1: warning: empty declaration
     265 | enum sbi_ext_dbcn_fid {
         | ^~~~
   arch/riscv/include/asm/sbi.h:272:1: warning: empty declaration
     272 | enum sbi_ext_sta_fid {
         | ^~~~
   arch/riscv/include/asm/sbi.h:276:1: warning: empty declaration
     276 | struct sbi_sta_struct {
         | ^~~~~~
   arch/riscv/include/asm/sbi.h:286:1: warning: empty declaration
     286 | enum sbi_ext_nacl_fid {
         | ^~~~
   arch/riscv/include/asm/sbi.h:294:1: warning: empty declaration
     294 | enum sbi_ext_nacl_feature {
         | ^~~~
>> arch/riscv/include/asm/sbi.h:423:22: error: storage class specified for parameter 'sbi_spec_version'
     423 | extern unsigned long sbi_spec_version;
         |                      ^~~~~~~~~~~~~~~~
   arch/riscv/include/asm/sbi.h:424:1: warning: empty declaration
     424 | struct sbiret {
         | ^~~~~~
>> arch/riscv/include/asm/sbi.h:442:48: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     442 | static inline void sbi_console_putchar(int ch) { }
         |                                                ^
   arch/riscv/include/asm/sbi.h:443:45: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     443 | static inline int sbi_console_getchar(void) { return -ENOENT; }
         |                                             ^
   arch/riscv/include/asm/sbi.h:475:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     475 | {
         | ^
   arch/riscv/include/asm/sbi.h:481:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     481 | {
         | ^
   arch/riscv/include/asm/sbi.h:488:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     488 | {
         | ^
   arch/riscv/include/asm/sbi.h:495:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     495 | {
         | ^
   arch/riscv/include/asm/sbi.h:501:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     501 | {
         | ^
>> arch/riscv/include/asm/sbi.h:518:13: error: storage class specified for parameter 'sbi_debug_console_available'
     518 | extern bool sbi_debug_console_available;
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/sbi.h:539:51: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     539 | static inline bool riscv_use_sbi_for_rfence(void) { return false; }
         |                                                   ^
   arch/riscv/include/asm/sbi.h:540:39: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     540 | static inline void sbi_ipi_init(void) { }
         |                                       ^
   arch/riscv/include/asm/kvm_vcpu_pmu.h:105:1: warning: empty declaration
     105 | struct kvm_pmu {
         | ^~~~~~
>> arch/riscv/include/asm/kvm_vcpu_pmu.h:111:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     111 | {
         | ^
   arch/riscv/include/asm/kvm_vcpu_pmu.h:123:67: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     123 | static inline void kvm_riscv_vcpu_pmu_init(struct kvm_vcpu *vcpu) {}
         |                                                                   ^
   arch/riscv/include/asm/kvm_vcpu_pmu.h:125:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     125 | {
         | ^
   arch/riscv/include/asm/kvm_vcpu_pmu.h:129:69: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     129 | static inline void kvm_riscv_vcpu_pmu_deinit(struct kvm_vcpu *vcpu) {}
         |                                                                     ^
   arch/riscv/include/asm/kvm_vcpu_pmu.h:130:68: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     130 | static inline void kvm_riscv_vcpu_pmu_reset(struct kvm_vcpu *vcpu) {}
         |                                                                    ^
   arch/riscv/include/asm/kvm_host.h:57:1: warning: empty declaration
      57 | enum kvm_riscv_hfence_type {
         | ^~~~
   arch/riscv/include/asm/kvm_host.h:65:1: warning: empty declaration
      65 | struct kvm_riscv_hfence {
         | ^~~~~~
   arch/riscv/include/asm/kvm_host.h:75:1: warning: empty declaration
      75 | struct kvm_vm_stat {
         | ^~~~~~
   arch/riscv/include/asm/kvm_host.h:79:1: warning: empty declaration
      79 | struct kvm_vcpu_stat {
         | ^~~~~~
   arch/riscv/include/asm/kvm_host.h:97:1: warning: empty declaration
      97 | struct kvm_arch_memory_slot {
         | ^~~~~~
   arch/riscv/include/asm/kvm_host.h:100:1: warning: empty declaration
     100 | struct kvm_vmid {
         | ^~~~~~
   arch/riscv/include/asm/kvm_host.h:109:1: warning: empty declaration
     109 | struct kvm_arch {
         | ^~~~~~
   arch/riscv/include/asm/kvm_host.h:124:1: warning: empty declaration
     124 | struct kvm_cpu_trap {
         | ^~~~~~
   arch/riscv/include/asm/kvm_host.h:132:1: warning: empty declaration
     132 | struct kvm_cpu_context {
         | ^~~~~~
   arch/riscv/include/asm/kvm_host.h:172:1: warning: empty declaration
     172 | struct kvm_vcpu_csr {
         | ^~~~~~
   arch/riscv/include/asm/kvm_host.h:186:1: warning: empty declaration
     186 | struct kvm_vcpu_config {
         | ^~~~~~
   arch/riscv/include/asm/kvm_host.h:192:1: warning: empty declaration
     192 | struct kvm_vcpu_smstateen_csr {
         | ^~~~~~
   arch/riscv/include/asm/kvm_host.h:196:1: warning: empty declaration
     196 | struct kvm_vcpu_arch {
         | ^~~~~~
>> arch/riscv/include/asm/kvm_host.h:300:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     300 | {
         | ^
>> arch/riscv/include/asm/kvm_host.h:365:13: error: section attribute not allowed for 'kvm_riscv_gstage_mode_detect'
     365 | void __init kvm_riscv_gstage_mode_detect(void);
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/kvm_host.h:365:1: warning: 'cold' attribute ignored [-Wattributes]
     365 | void __init kvm_riscv_gstage_mode_detect(void);
         | ^~~~
>> arch/riscv/include/asm/kvm_host.h:366:22: error: section attribute not allowed for 'kvm_riscv_gstage_mode'
     366 | unsigned long __init kvm_riscv_gstage_mode(void);
         |                      ^~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/kvm_host.h:366:1: warning: 'cold' attribute ignored [-Wattributes]
     366 | unsigned long __init kvm_riscv_gstage_mode(void);
         | ^~~~~~~~
>> arch/riscv/include/asm/kvm_host.h:369:13: error: section attribute not allowed for 'kvm_riscv_gstage_vmid_detect'
     369 | void __init kvm_riscv_gstage_vmid_detect(void);
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/kvm_host.h:369:1: warning: 'cold' attribute ignored [-Wattributes]
     369 | void __init kvm_riscv_gstage_vmid_detect(void);
         | ^~~~
   In file included from arch/riscv/kernel/asm-offsets.c:15:
>> arch/riscv/include/asm/cpu_ops_sbi.h:13:36: error: storage class specified for parameter 'cpu_ops_sbi'
      13 | extern const struct cpu_operations cpu_ops_sbi;
         |                                    ^~~~~~~~~~~
   arch/riscv/include/asm/cpu_ops_sbi.h:21:1: warning: empty declaration
      21 | struct sbi_hart_boot_data {
         | ^~~~~~
   In file included from arch/riscv/kernel/asm-offsets.c:16:
   arch/riscv/include/asm/stacktrace.h:9:1: warning: empty declaration
       9 | struct stackframe {
         | ^~~~~~
>> arch/riscv/include/asm/stacktrace.h:14:21: error: storage class specified for parameter 'walk_stackframe'
      14 | extern void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
         |                     ^~~~~~~~~~~~~~~
>> arch/riscv/include/asm/stacktrace.h:14:21: error: 'no_instrument_function' attribute applies only to functions
>> arch/riscv/include/asm/stacktrace.h:16:13: error: storage class specified for parameter 'dump_backtrace'
      16 | extern void dump_backtrace(struct pt_regs *regs, struct task_struct *task,
         |             ^~~~~~~~~~~~~~
>> arch/riscv/include/asm/stacktrace.h:20:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      20 | {
         | ^
   In file included from arch/riscv/kernel/asm-offsets.c:17:
   arch/riscv/include/asm/suspend.h:12:1: warning: empty declaration
      12 | struct suspend_context {
         | ^~~~~~
>> arch/riscv/include/asm/suspend.h:31:12: error: storage class specified for parameter 'in_suspend'
      31 | extern int in_suspend;
         |            ^~~~~~~~~~
>> arch/riscv/kernel/asm-offsets.c:22:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      22 | {
         | ^
   include/linux/security.h:1607:12: error: old-style parameter declarations in prototyped function definition
    1607 | static int security_lsm_manage_policy(u32 lsm_id, u32 op, void __user *buf,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/riscv/kernel/asm-offsets.c:514: error: expected '{' at end of input
>> arch/riscv/kernel/asm-offsets.c:513:1: warning: no return statement in function returning non-void [-Wreturn-type]
     513 | }
         | ^
   include/linux/security.h: At top level:
   include/linux/security.h:1607:12: warning: 'security_lsm_manage_policy' defined but not used [-Wunused-function]
    1607 | static int security_lsm_manage_policy(u32 lsm_id, u32 op, void __user *buf,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~
   make[3]: *** [scripts/Makefile.build:98: arch/riscv/kernel/asm-offsets.s] Error 1
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1282: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:248: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/sbi_spec_version +423 arch/riscv/include/asm/sbi.h

6cfc624576a641 Andrew Jones    2023-12-20  275  
6cfc624576a641 Andrew Jones    2023-12-20 @276  struct sbi_sta_struct {
6cfc624576a641 Andrew Jones    2023-12-20  277  	__le32 sequence;
6cfc624576a641 Andrew Jones    2023-12-20  278  	__le32 flags;
6cfc624576a641 Andrew Jones    2023-12-20  279  	__le64 steal;
6cfc624576a641 Andrew Jones    2023-12-20  280  	u8 preempted;
6cfc624576a641 Andrew Jones    2023-12-20  281  	u8 pad[47];
6cfc624576a641 Andrew Jones    2023-12-20  282  } __packed;
6cfc624576a641 Andrew Jones    2023-12-20  283  
3ddb6d4df67dad Atish Patra     2024-04-20  284  #define SBI_SHMEM_DISABLE		-1
6cfc624576a641 Andrew Jones    2023-12-20  285  
5daf89e73d77a5 Anup Patel      2024-10-21  286  enum sbi_ext_nacl_fid {
5daf89e73d77a5 Anup Patel      2024-10-21  287  	SBI_EXT_NACL_PROBE_FEATURE = 0x0,
5daf89e73d77a5 Anup Patel      2024-10-21  288  	SBI_EXT_NACL_SET_SHMEM = 0x1,
5daf89e73d77a5 Anup Patel      2024-10-21  289  	SBI_EXT_NACL_SYNC_CSR = 0x2,
5daf89e73d77a5 Anup Patel      2024-10-21  290  	SBI_EXT_NACL_SYNC_HFENCE = 0x3,
5daf89e73d77a5 Anup Patel      2024-10-21  291  	SBI_EXT_NACL_SYNC_SRET = 0x4,
5daf89e73d77a5 Anup Patel      2024-10-21  292  };
5daf89e73d77a5 Anup Patel      2024-10-21  293  
5daf89e73d77a5 Anup Patel      2024-10-21 @294  enum sbi_ext_nacl_feature {
5daf89e73d77a5 Anup Patel      2024-10-21  295  	SBI_NACL_FEAT_SYNC_CSR = 0x0,
5daf89e73d77a5 Anup Patel      2024-10-21  296  	SBI_NACL_FEAT_SYNC_HFENCE = 0x1,
5daf89e73d77a5 Anup Patel      2024-10-21  297  	SBI_NACL_FEAT_SYNC_SRET = 0x2,
5daf89e73d77a5 Anup Patel      2024-10-21  298  	SBI_NACL_FEAT_AUTOSWAP_CSR = 0x3,
5daf89e73d77a5 Anup Patel      2024-10-21  299  };
5daf89e73d77a5 Anup Patel      2024-10-21  300  
5daf89e73d77a5 Anup Patel      2024-10-21  301  #define SBI_NACL_SHMEM_ADDR_SHIFT	12
5daf89e73d77a5 Anup Patel      2024-10-21  302  #define SBI_NACL_SHMEM_SCRATCH_OFFSET	0x0000
5daf89e73d77a5 Anup Patel      2024-10-21  303  #define SBI_NACL_SHMEM_SCRATCH_SIZE	0x1000
5daf89e73d77a5 Anup Patel      2024-10-21  304  #define SBI_NACL_SHMEM_SRET_OFFSET	0x0000
5daf89e73d77a5 Anup Patel      2024-10-21  305  #define SBI_NACL_SHMEM_SRET_SIZE	0x0200
5daf89e73d77a5 Anup Patel      2024-10-21  306  #define SBI_NACL_SHMEM_AUTOSWAP_OFFSET	(SBI_NACL_SHMEM_SRET_OFFSET + \
5daf89e73d77a5 Anup Patel      2024-10-21  307  					 SBI_NACL_SHMEM_SRET_SIZE)
5daf89e73d77a5 Anup Patel      2024-10-21  308  #define SBI_NACL_SHMEM_AUTOSWAP_SIZE	0x0080
5daf89e73d77a5 Anup Patel      2024-10-21  309  #define SBI_NACL_SHMEM_UNUSED_OFFSET	(SBI_NACL_SHMEM_AUTOSWAP_OFFSET + \
5daf89e73d77a5 Anup Patel      2024-10-21  310  					 SBI_NACL_SHMEM_AUTOSWAP_SIZE)
5daf89e73d77a5 Anup Patel      2024-10-21  311  #define SBI_NACL_SHMEM_UNUSED_SIZE	0x0580
5daf89e73d77a5 Anup Patel      2024-10-21  312  #define SBI_NACL_SHMEM_HFENCE_OFFSET	(SBI_NACL_SHMEM_UNUSED_OFFSET + \
5daf89e73d77a5 Anup Patel      2024-10-21  313  					 SBI_NACL_SHMEM_UNUSED_SIZE)
5daf89e73d77a5 Anup Patel      2024-10-21  314  #define SBI_NACL_SHMEM_HFENCE_SIZE	0x0780
5daf89e73d77a5 Anup Patel      2024-10-21  315  #define SBI_NACL_SHMEM_DBITMAP_OFFSET	(SBI_NACL_SHMEM_HFENCE_OFFSET + \
5daf89e73d77a5 Anup Patel      2024-10-21  316  					 SBI_NACL_SHMEM_HFENCE_SIZE)
5daf89e73d77a5 Anup Patel      2024-10-21  317  #define SBI_NACL_SHMEM_DBITMAP_SIZE	0x0080
5daf89e73d77a5 Anup Patel      2024-10-21  318  #define SBI_NACL_SHMEM_CSR_OFFSET	(SBI_NACL_SHMEM_DBITMAP_OFFSET + \
5daf89e73d77a5 Anup Patel      2024-10-21  319  					 SBI_NACL_SHMEM_DBITMAP_SIZE)
5daf89e73d77a5 Anup Patel      2024-10-21  320  #define SBI_NACL_SHMEM_CSR_SIZE		((__riscv_xlen / 8) * 1024)
5daf89e73d77a5 Anup Patel      2024-10-21  321  #define SBI_NACL_SHMEM_SIZE		(SBI_NACL_SHMEM_CSR_OFFSET + \
5daf89e73d77a5 Anup Patel      2024-10-21  322  					 SBI_NACL_SHMEM_CSR_SIZE)
5daf89e73d77a5 Anup Patel      2024-10-21  323  
5daf89e73d77a5 Anup Patel      2024-10-21  324  #define SBI_NACL_SHMEM_CSR_INDEX(__csr_num)	\
5daf89e73d77a5 Anup Patel      2024-10-21  325  		((((__csr_num) & 0xc00) >> 2) | ((__csr_num) & 0xff))
5daf89e73d77a5 Anup Patel      2024-10-21  326  
5daf89e73d77a5 Anup Patel      2024-10-21  327  #define SBI_NACL_SHMEM_HFENCE_ENTRY_SZ		((__riscv_xlen / 8) * 4)
5daf89e73d77a5 Anup Patel      2024-10-21  328  #define SBI_NACL_SHMEM_HFENCE_ENTRY_MAX		\
5daf89e73d77a5 Anup Patel      2024-10-21  329  		(SBI_NACL_SHMEM_HFENCE_SIZE /	\
5daf89e73d77a5 Anup Patel      2024-10-21  330  		 SBI_NACL_SHMEM_HFENCE_ENTRY_SZ)
5daf89e73d77a5 Anup Patel      2024-10-21  331  #define SBI_NACL_SHMEM_HFENCE_ENTRY(__num)	\
5daf89e73d77a5 Anup Patel      2024-10-21  332  		(SBI_NACL_SHMEM_HFENCE_OFFSET +	\
5daf89e73d77a5 Anup Patel      2024-10-21  333  		 (__num) * SBI_NACL_SHMEM_HFENCE_ENTRY_SZ)
5daf89e73d77a5 Anup Patel      2024-10-21  334  #define SBI_NACL_SHMEM_HFENCE_ENTRY_CONFIG(__num)	\
5daf89e73d77a5 Anup Patel      2024-10-21  335  		SBI_NACL_SHMEM_HFENCE_ENTRY(__num)
5daf89e73d77a5 Anup Patel      2024-10-21  336  #define SBI_NACL_SHMEM_HFENCE_ENTRY_PNUM(__num)\
5daf89e73d77a5 Anup Patel      2024-10-21  337  		(SBI_NACL_SHMEM_HFENCE_ENTRY(__num) + (__riscv_xlen / 8))
5daf89e73d77a5 Anup Patel      2024-10-21  338  #define SBI_NACL_SHMEM_HFENCE_ENTRY_PCOUNT(__num)\
5daf89e73d77a5 Anup Patel      2024-10-21  339  		(SBI_NACL_SHMEM_HFENCE_ENTRY(__num) + \
5daf89e73d77a5 Anup Patel      2024-10-21  340  		 ((__riscv_xlen / 8) * 3))
5daf89e73d77a5 Anup Patel      2024-10-21  341  
5daf89e73d77a5 Anup Patel      2024-10-21  342  #define SBI_NACL_SHMEM_HFENCE_CONFIG_PEND_BITS	1
5daf89e73d77a5 Anup Patel      2024-10-21  343  #define SBI_NACL_SHMEM_HFENCE_CONFIG_PEND_SHIFT	\
5daf89e73d77a5 Anup Patel      2024-10-21  344  		(__riscv_xlen - SBI_NACL_SHMEM_HFENCE_CONFIG_PEND_BITS)
5daf89e73d77a5 Anup Patel      2024-10-21  345  #define SBI_NACL_SHMEM_HFENCE_CONFIG_PEND_MASK	\
5daf89e73d77a5 Anup Patel      2024-10-21  346  		((1UL << SBI_NACL_SHMEM_HFENCE_CONFIG_PEND_BITS) - 1)
5daf89e73d77a5 Anup Patel      2024-10-21  347  #define SBI_NACL_SHMEM_HFENCE_CONFIG_PEND		\
5daf89e73d77a5 Anup Patel      2024-10-21  348  		(SBI_NACL_SHMEM_HFENCE_CONFIG_PEND_MASK << \
5daf89e73d77a5 Anup Patel      2024-10-21  349  		 SBI_NACL_SHMEM_HFENCE_CONFIG_PEND_SHIFT)
5daf89e73d77a5 Anup Patel      2024-10-21  350  
5daf89e73d77a5 Anup Patel      2024-10-21  351  #define SBI_NACL_SHMEM_HFENCE_CONFIG_RSVD1_BITS	3
5daf89e73d77a5 Anup Patel      2024-10-21  352  #define SBI_NACL_SHMEM_HFENCE_CONFIG_RSVD1_SHIFT \
5daf89e73d77a5 Anup Patel      2024-10-21  353  		(SBI_NACL_SHMEM_HFENCE_CONFIG_PEND_SHIFT - \
5daf89e73d77a5 Anup Patel      2024-10-21  354  		 SBI_NACL_SHMEM_HFENCE_CONFIG_RSVD1_BITS)
5daf89e73d77a5 Anup Patel      2024-10-21  355  
5daf89e73d77a5 Anup Patel      2024-10-21  356  #define SBI_NACL_SHMEM_HFENCE_CONFIG_TYPE_BITS	4
5daf89e73d77a5 Anup Patel      2024-10-21  357  #define SBI_NACL_SHMEM_HFENCE_CONFIG_TYPE_SHIFT	\
5daf89e73d77a5 Anup Patel      2024-10-21  358  		(SBI_NACL_SHMEM_HFENCE_CONFIG_RSVD1_SHIFT - \
5daf89e73d77a5 Anup Patel      2024-10-21  359  		 SBI_NACL_SHMEM_HFENCE_CONFIG_TYPE_BITS)
5daf89e73d77a5 Anup Patel      2024-10-21  360  #define SBI_NACL_SHMEM_HFENCE_CONFIG_TYPE_MASK	\
5daf89e73d77a5 Anup Patel      2024-10-21  361  		((1UL << SBI_NACL_SHMEM_HFENCE_CONFIG_TYPE_BITS) - 1)
5daf89e73d77a5 Anup Patel      2024-10-21  362  
5daf89e73d77a5 Anup Patel      2024-10-21  363  #define SBI_NACL_SHMEM_HFENCE_TYPE_GVMA		0x0
5daf89e73d77a5 Anup Patel      2024-10-21  364  #define SBI_NACL_SHMEM_HFENCE_TYPE_GVMA_ALL	0x1
5daf89e73d77a5 Anup Patel      2024-10-21  365  #define SBI_NACL_SHMEM_HFENCE_TYPE_GVMA_VMID	0x2
5daf89e73d77a5 Anup Patel      2024-10-21  366  #define SBI_NACL_SHMEM_HFENCE_TYPE_GVMA_VMID_ALL 0x3
5daf89e73d77a5 Anup Patel      2024-10-21  367  #define SBI_NACL_SHMEM_HFENCE_TYPE_VVMA		0x4
5daf89e73d77a5 Anup Patel      2024-10-21  368  #define SBI_NACL_SHMEM_HFENCE_TYPE_VVMA_ALL	0x5
5daf89e73d77a5 Anup Patel      2024-10-21  369  #define SBI_NACL_SHMEM_HFENCE_TYPE_VVMA_ASID	0x6
5daf89e73d77a5 Anup Patel      2024-10-21  370  #define SBI_NACL_SHMEM_HFENCE_TYPE_VVMA_ASID_ALL 0x7
5daf89e73d77a5 Anup Patel      2024-10-21  371  
5daf89e73d77a5 Anup Patel      2024-10-21  372  #define SBI_NACL_SHMEM_HFENCE_CONFIG_RSVD2_BITS	1
5daf89e73d77a5 Anup Patel      2024-10-21  373  #define SBI_NACL_SHMEM_HFENCE_CONFIG_RSVD2_SHIFT \
5daf89e73d77a5 Anup Patel      2024-10-21  374  		(SBI_NACL_SHMEM_HFENCE_CONFIG_TYPE_SHIFT - \
5daf89e73d77a5 Anup Patel      2024-10-21  375  		 SBI_NACL_SHMEM_HFENCE_CONFIG_RSVD2_BITS)
5daf89e73d77a5 Anup Patel      2024-10-21  376  
5daf89e73d77a5 Anup Patel      2024-10-21  377  #define SBI_NACL_SHMEM_HFENCE_CONFIG_ORDER_BITS	7
5daf89e73d77a5 Anup Patel      2024-10-21  378  #define SBI_NACL_SHMEM_HFENCE_CONFIG_ORDER_SHIFT \
5daf89e73d77a5 Anup Patel      2024-10-21  379  		(SBI_NACL_SHMEM_HFENCE_CONFIG_RSVD2_SHIFT - \
5daf89e73d77a5 Anup Patel      2024-10-21  380  		 SBI_NACL_SHMEM_HFENCE_CONFIG_ORDER_BITS)
5daf89e73d77a5 Anup Patel      2024-10-21  381  #define SBI_NACL_SHMEM_HFENCE_CONFIG_ORDER_MASK	\
5daf89e73d77a5 Anup Patel      2024-10-21  382  		((1UL << SBI_NACL_SHMEM_HFENCE_CONFIG_ORDER_BITS) - 1)
5daf89e73d77a5 Anup Patel      2024-10-21  383  #define SBI_NACL_SHMEM_HFENCE_ORDER_BASE	12
5daf89e73d77a5 Anup Patel      2024-10-21  384  
5daf89e73d77a5 Anup Patel      2024-10-21  385  #if __riscv_xlen == 32
5daf89e73d77a5 Anup Patel      2024-10-21  386  #define SBI_NACL_SHMEM_HFENCE_CONFIG_ASID_BITS	9
5daf89e73d77a5 Anup Patel      2024-10-21  387  #define SBI_NACL_SHMEM_HFENCE_CONFIG_VMID_BITS	7
5daf89e73d77a5 Anup Patel      2024-10-21  388  #else
5daf89e73d77a5 Anup Patel      2024-10-21  389  #define SBI_NACL_SHMEM_HFENCE_CONFIG_ASID_BITS	16
5daf89e73d77a5 Anup Patel      2024-10-21  390  #define SBI_NACL_SHMEM_HFENCE_CONFIG_VMID_BITS	14
5daf89e73d77a5 Anup Patel      2024-10-21  391  #endif
5daf89e73d77a5 Anup Patel      2024-10-21  392  #define SBI_NACL_SHMEM_HFENCE_CONFIG_VMID_SHIFT	\
5daf89e73d77a5 Anup Patel      2024-10-21  393  				SBI_NACL_SHMEM_HFENCE_CONFIG_ASID_BITS
5daf89e73d77a5 Anup Patel      2024-10-21  394  #define SBI_NACL_SHMEM_HFENCE_CONFIG_ASID_MASK	\
5daf89e73d77a5 Anup Patel      2024-10-21  395  		((1UL << SBI_NACL_SHMEM_HFENCE_CONFIG_ASID_BITS) - 1)
5daf89e73d77a5 Anup Patel      2024-10-21  396  #define SBI_NACL_SHMEM_HFENCE_CONFIG_VMID_MASK	\
5daf89e73d77a5 Anup Patel      2024-10-21  397  		((1UL << SBI_NACL_SHMEM_HFENCE_CONFIG_VMID_BITS) - 1)
5daf89e73d77a5 Anup Patel      2024-10-21  398  
5daf89e73d77a5 Anup Patel      2024-10-21  399  #define SBI_NACL_SHMEM_AUTOSWAP_FLAG_HSTATUS	BIT(0)
5daf89e73d77a5 Anup Patel      2024-10-21  400  #define SBI_NACL_SHMEM_AUTOSWAP_HSTATUS		((__riscv_xlen / 8) * 1)
5daf89e73d77a5 Anup Patel      2024-10-21  401  
5daf89e73d77a5 Anup Patel      2024-10-21  402  #define SBI_NACL_SHMEM_SRET_X(__i)		((__riscv_xlen / 8) * (__i))
5daf89e73d77a5 Anup Patel      2024-10-21  403  #define SBI_NACL_SHMEM_SRET_X_LAST		31
5daf89e73d77a5 Anup Patel      2024-10-21  404  
6cfc624576a641 Andrew Jones    2023-12-20  405  /* SBI spec version fields */
b9dcd9e415872a Atish Patra     2020-03-17  406  #define SBI_SPEC_VERSION_DEFAULT	0x1
b9dcd9e415872a Atish Patra     2020-03-17  407  #define SBI_SPEC_VERSION_MAJOR_SHIFT	24
b9dcd9e415872a Atish Patra     2020-03-17  408  #define SBI_SPEC_VERSION_MAJOR_MASK	0x7f
b9dcd9e415872a Atish Patra     2020-03-17  409  #define SBI_SPEC_VERSION_MINOR_MASK	0xffffff
6d60b6ee0c9777 Palmer Dabbelt  2017-07-10  410  
b9dcd9e415872a Atish Patra     2020-03-17  411  /* SBI return error codes */
b9dcd9e415872a Atish Patra     2020-03-17  412  #define SBI_SUCCESS		0
b9dcd9e415872a Atish Patra     2020-03-17  413  #define SBI_ERR_FAILURE		-1
b9dcd9e415872a Atish Patra     2020-03-17  414  #define SBI_ERR_NOT_SUPPORTED	-2
b9dcd9e415872a Atish Patra     2020-03-17  415  #define SBI_ERR_INVALID_PARAM	-3
b9dcd9e415872a Atish Patra     2020-03-17  416  #define SBI_ERR_DENIED		-4
b9dcd9e415872a Atish Patra     2020-03-17  417  #define SBI_ERR_INVALID_ADDRESS	-5
3e1d86569c210e Atish Patra     2021-11-18  418  #define SBI_ERR_ALREADY_AVAILABLE -6
90beae5185c260 Atish Patra     2022-02-18  419  #define SBI_ERR_ALREADY_STARTED -7
90beae5185c260 Atish Patra     2022-02-18  420  #define SBI_ERR_ALREADY_STOPPED -8
8f486ced2860e1 Atish Patra     2024-04-20  421  #define SBI_ERR_NO_SHMEM	-9
6d60b6ee0c9777 Palmer Dabbelt  2017-07-10  422  
b9dcd9e415872a Atish Patra     2020-03-17 @423  extern unsigned long sbi_spec_version;
b9dcd9e415872a Atish Patra     2020-03-17  424  struct sbiret {
b9dcd9e415872a Atish Patra     2020-03-17  425  	long error;
b9dcd9e415872a Atish Patra     2020-03-17  426  	long value;
b9dcd9e415872a Atish Patra     2020-03-17  427  };
6d60b6ee0c9777 Palmer Dabbelt  2017-07-10  428  
641e8cd2cbf045 Kefeng Wang     2020-11-26  429  void sbi_init(void);
1ff95eb2bebda5 Alexandre Ghiti 2024-08-29  430  long __sbi_base_ecall(int fid);
16badacd8af489 Alexandre Ghiti 2024-03-22  431  struct sbiret __sbi_ecall(unsigned long arg0, unsigned long arg1,
16badacd8af489 Alexandre Ghiti 2024-03-22  432  			  unsigned long arg2, unsigned long arg3,
16badacd8af489 Alexandre Ghiti 2024-03-22  433  			  unsigned long arg4, unsigned long arg5,
16badacd8af489 Alexandre Ghiti 2024-03-22  434  			  int fid, int ext);
16badacd8af489 Alexandre Ghiti 2024-03-22  435  #define sbi_ecall(e, f, a0, a1, a2, a3, a4, a5)	\
16badacd8af489 Alexandre Ghiti 2024-03-22  436  		__sbi_ecall(a0, a1, a2, a3, a4, a5, f, e)
6d60b6ee0c9777 Palmer Dabbelt  2017-07-10  437  
f503b167b66007 Anup Patel      2023-11-24  438  #ifdef CONFIG_RISCV_SBI_V01
b9dcd9e415872a Atish Patra     2020-03-17  439  void sbi_console_putchar(int ch);
b9dcd9e415872a Atish Patra     2020-03-17  440  int sbi_console_getchar(void);
f503b167b66007 Anup Patel      2023-11-24  441  #else
f503b167b66007 Anup Patel      2023-11-24 @442  static inline void sbi_console_putchar(int ch) { }
f503b167b66007 Anup Patel      2023-11-24  443  static inline int sbi_console_getchar(void) { return -ENOENT; }
f503b167b66007 Anup Patel      2023-11-24  444  #endif
183787c6fcc2c7 Vincent Chen    2021-03-22  445  long sbi_get_mvendorid(void);
183787c6fcc2c7 Vincent Chen    2021-03-22  446  long sbi_get_marchid(void);
183787c6fcc2c7 Vincent Chen    2021-03-22  447  long sbi_get_mimpid(void);
b9dcd9e415872a Atish Patra     2020-03-17  448  void sbi_set_timer(uint64_t stime_value);
b9dcd9e415872a Atish Patra     2020-03-17  449  void sbi_shutdown(void);
832f15f4264681 Anup Patel      2023-03-28  450  void sbi_send_ipi(unsigned int cpu);
26fb751ca37846 Atish Patra     2022-01-20  451  int sbi_remote_fence_i(const struct cpumask *cpu_mask);
6d60b6ee0c9777 Palmer Dabbelt  2017-07-10  452  
26fb751ca37846 Atish Patra     2022-01-20  453  int sbi_remote_sfence_vma_asid(const struct cpumask *cpu_mask,
b9dcd9e415872a Atish Patra     2020-03-17  454  				unsigned long start,
b9dcd9e415872a Atish Patra     2020-03-17  455  				unsigned long size,
b9dcd9e415872a Atish Patra     2020-03-17  456  				unsigned long asid);
26fb751ca37846 Atish Patra     2022-01-20  457  int sbi_remote_hfence_gvma(const struct cpumask *cpu_mask,
1ef46c231df4b8 Atish Patra     2020-03-17  458  			   unsigned long start,
1ef46c231df4b8 Atish Patra     2020-03-17  459  			   unsigned long size);
26fb751ca37846 Atish Patra     2022-01-20  460  int sbi_remote_hfence_gvma_vmid(const struct cpumask *cpu_mask,
1ef46c231df4b8 Atish Patra     2020-03-17  461  				unsigned long start,
1ef46c231df4b8 Atish Patra     2020-03-17  462  				unsigned long size,
1ef46c231df4b8 Atish Patra     2020-03-17  463  				unsigned long vmid);
26fb751ca37846 Atish Patra     2022-01-20  464  int sbi_remote_hfence_vvma(const struct cpumask *cpu_mask,
1ef46c231df4b8 Atish Patra     2020-03-17  465  			   unsigned long start,
1ef46c231df4b8 Atish Patra     2020-03-17  466  			   unsigned long size);
26fb751ca37846 Atish Patra     2022-01-20  467  int sbi_remote_hfence_vvma_asid(const struct cpumask *cpu_mask,
1ef46c231df4b8 Atish Patra     2020-03-17  468  				unsigned long start,
1ef46c231df4b8 Atish Patra     2020-03-17  469  				unsigned long size,
1ef46c231df4b8 Atish Patra     2020-03-17  470  				unsigned long asid);
41cad8284d5e6b Andrew Jones    2023-04-27  471  long sbi_probe_extension(int ext);
6d60b6ee0c9777 Palmer Dabbelt  2017-07-10  472  
b9dcd9e415872a Atish Patra     2020-03-17  473  /* Check if current SBI specification version is 0.1 or not */
b9dcd9e415872a Atish Patra     2020-03-17  474  static inline int sbi_spec_is_0_1(void)
6d60b6ee0c9777 Palmer Dabbelt  2017-07-10  475  {
b9dcd9e415872a Atish Patra     2020-03-17  476  	return (sbi_spec_version == SBI_SPEC_VERSION_DEFAULT) ? 1 : 0;
6d60b6ee0c9777 Palmer Dabbelt  2017-07-10  477  }
6d60b6ee0c9777 Palmer Dabbelt  2017-07-10  478  
b9dcd9e415872a Atish Patra     2020-03-17  479  /* Get the major version of SBI */
b9dcd9e415872a Atish Patra     2020-03-17  480  static inline unsigned long sbi_major_version(void)
6d60b6ee0c9777 Palmer Dabbelt  2017-07-10  481  {
b9dcd9e415872a Atish Patra     2020-03-17  482  	return (sbi_spec_version >> SBI_SPEC_VERSION_MAJOR_SHIFT) &
b9dcd9e415872a Atish Patra     2020-03-17  483  		SBI_SPEC_VERSION_MAJOR_MASK;
6d60b6ee0c9777 Palmer Dabbelt  2017-07-10  484  }
6d60b6ee0c9777 Palmer Dabbelt  2017-07-10  485  
b9dcd9e415872a Atish Patra     2020-03-17  486  /* Get the minor version of SBI */
b9dcd9e415872a Atish Patra     2020-03-17  487  static inline unsigned long sbi_minor_version(void)
6d60b6ee0c9777 Palmer Dabbelt  2017-07-10 @488  {
b9dcd9e415872a Atish Patra     2020-03-17  489  	return sbi_spec_version & SBI_SPEC_VERSION_MINOR_MASK;
6d60b6ee0c9777 Palmer Dabbelt  2017-07-10  490  }
f90b43ce176c12 Atish Patra     2020-03-17  491  
b579dfe71a6a5c Anup Patel      2021-06-09  492  /* Make SBI version */
b579dfe71a6a5c Anup Patel      2021-06-09  493  static inline unsigned long sbi_mk_version(unsigned long major,
b579dfe71a6a5c Anup Patel      2021-06-09  494  					    unsigned long minor)
b579dfe71a6a5c Anup Patel      2021-06-09  495  {
b737fc24a12ceb Atish Patra     2024-04-20  496  	return ((major & SBI_SPEC_VERSION_MAJOR_MASK) << SBI_SPEC_VERSION_MAJOR_SHIFT)
b737fc24a12ceb Atish Patra     2024-04-20  497  		| (minor & SBI_SPEC_VERSION_MINOR_MASK);
b579dfe71a6a5c Anup Patel      2021-06-09  498  }
b579dfe71a6a5c Anup Patel      2021-06-09  499  
1ff95eb2bebda5 Alexandre Ghiti 2024-08-29  500  static inline int sbi_err_map_linux_errno(int err)
1ff95eb2bebda5 Alexandre Ghiti 2024-08-29  501  {
1ff95eb2bebda5 Alexandre Ghiti 2024-08-29  502  	switch (err) {
1ff95eb2bebda5 Alexandre Ghiti 2024-08-29  503  	case SBI_SUCCESS:
1ff95eb2bebda5 Alexandre Ghiti 2024-08-29  504  		return 0;
1ff95eb2bebda5 Alexandre Ghiti 2024-08-29  505  	case SBI_ERR_DENIED:
1ff95eb2bebda5 Alexandre Ghiti 2024-08-29  506  		return -EPERM;
1ff95eb2bebda5 Alexandre Ghiti 2024-08-29  507  	case SBI_ERR_INVALID_PARAM:
1ff95eb2bebda5 Alexandre Ghiti 2024-08-29  508  		return -EINVAL;
1ff95eb2bebda5 Alexandre Ghiti 2024-08-29  509  	case SBI_ERR_INVALID_ADDRESS:
1ff95eb2bebda5 Alexandre Ghiti 2024-08-29  510  		return -EFAULT;
1ff95eb2bebda5 Alexandre Ghiti 2024-08-29  511  	case SBI_ERR_NOT_SUPPORTED:
1ff95eb2bebda5 Alexandre Ghiti 2024-08-29  512  	case SBI_ERR_FAILURE:
1ff95eb2bebda5 Alexandre Ghiti 2024-08-29  513  	default:
1ff95eb2bebda5 Alexandre Ghiti 2024-08-29  514  		return -ENOTSUPP;
1ff95eb2bebda5 Alexandre Ghiti 2024-08-29  515  	};
1ff95eb2bebda5 Alexandre Ghiti 2024-08-29  516  }
f43fabf444ca3c Anup Patel      2023-11-24  517  
f43fabf444ca3c Anup Patel      2023-11-24 @518  extern bool sbi_debug_console_available;
f43fabf444ca3c Anup Patel      2023-11-24  519  int sbi_debug_console_write(const char *bytes, unsigned int num_bytes);
f43fabf444ca3c Anup Patel      2023-11-24  520  int sbi_debug_console_read(char *bytes, unsigned int num_bytes);
f43fabf444ca3c Anup Patel      2023-11-24  521  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

