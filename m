Return-Path: <linux-api+bounces-38-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA607E95CD
	for <lists+linux-api@lfdr.de>; Mon, 13 Nov 2023 05:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EA59280E9A
	for <lists+linux-api@lfdr.de>; Mon, 13 Nov 2023 04:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8CCC12F;
	Mon, 13 Nov 2023 04:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NBukC86a"
X-Original-To: linux-api@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4ABDBE7E
	for <linux-api@vger.kernel.org>; Mon, 13 Nov 2023 04:03:26 +0000 (UTC)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE900111
	for <linux-api@vger.kernel.org>; Sun, 12 Nov 2023 20:03:21 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-daf7ed42ea6so937528276.0
        for <linux-api@vger.kernel.org>; Sun, 12 Nov 2023 20:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1699848201; x=1700453001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iRKvgXEPdTcIwmzv/iuNWx/9TY6/jvc6e9bi50eXZnM=;
        b=NBukC86aSqPGefXGdxt1I+UMWWU7EBWh4CDfsnso8XWZQLc3gTVQDRzvbYP91wjoYi
         Eg8veUyS6OKJ277Snvw6K1tIdXHfIzwMsLP+7k/fcvywjagMrxj4d6dlO0N/nQ1DC/eR
         jwXccOZecI6w5POCSsTE1FctoAlY66gtD/EnbWZT2Q+UAv+y5VbI9uw8vw+eqSgnwvF0
         hNHj9iDgOfWFPPggdilabmsbGIM/81ItBK0fzwW+W5Z5VX2zpk93PmxSoAna2g5m1vaa
         JcrJ8k1z5uGEFO9FC/7H5VJyV2jUhWXYPcddtn9BxTcU8ST4PphdHubR7/gP8PlliykT
         J3gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699848201; x=1700453001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iRKvgXEPdTcIwmzv/iuNWx/9TY6/jvc6e9bi50eXZnM=;
        b=DYXf6i30riO+Cfa1JHLQEWTsihjx/urGyWasxxjaUCLzYBTWJXe956xP7FUjeMRgHn
         akcxQkduHhC+vrGW+0vqu/Lt7AWmmcPFCkjdi9uD2SIBagKwiY0hUrIHCPp/VpnmdH+u
         6qdB6EySMijOJthhvAhcpv4fHylyVCECysrLeW615RjyZocB4JQ9vfbO4jYVKa2gQ/t5
         Vs2u40V4mj5Zc8k8+Hv3bLmGKOS8ujNplQJJsxihkhg4coZX/QBWGM4kwHEHaoRCyfqU
         k3YYzF0+UJ/PmBdD2VdDMFbHdESAa9PK93ex2zIE8E44WW+dm6p9yiuQeYtcOQ8zRCkE
         Aq7Q==
X-Gm-Message-State: AOJu0YxVJPl/s+VxGxfHKL3krQXJB9ZvAagEC/Yoh8KRd6Zib+kKM1hR
	vuCQD5YaaOV4TFhfe7hsXd+6nWm71eVd6igk2ASe
X-Google-Smtp-Source: AGHT+IG0AXV/0EbCQQOgNaZ+Sq3IiT+KDXRTzB+RqaaoT+zauZclhuu1ok2U9TaCRt2pC/zF9DBmPW/0PgRuaNhKEqE=
X-Received: by 2002:a25:abac:0:b0:da0:4fba:1c61 with SMTP id
 v41-20020a25abac000000b00da04fba1c61mr5868466ybi.46.1699848200999; Sun, 12
 Nov 2023 20:03:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230912205658.3432-1-casey.ref@schaufler-ca.com> <20230912205658.3432-1-casey@schaufler-ca.com>
In-Reply-To: <20230912205658.3432-1-casey@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 12 Nov 2023 23:03:09 -0500
Message-ID: <CAHC9VhQ=+Wkww2zhvtNvW8wacd6KBTc1AHTGVVY=1mUNK8Y_Jg@mail.gmail.com>
Subject: Re: [PATCH v15 00/11] LSM: Three basic syscalls
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, 
	keescook@chromium.org, john.johansen@canonical.com, 
	penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2023 at 4:57=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
>
> Add three system calls for the Linux Security Module ABI.
>
> lsm_get_self_attr() provides the security module specific attributes
> that have previously been visible in the /proc/self/attr directory.
> For each security module that uses the specified attribute on the
> current process the system call will return an LSM identifier and
> the value of the attribute. The LSM and attribute identifier values
> are defined in include/uapi/linux/lsm.h
>
> LSM identifiers are simple integers and reflect the order in which
> the LSM was added to the mainline kernel. This is a convention, not
> a promise of the API. LSM identifiers below the value of 100 are
> reserved for unspecified future uses. That could include information
> about the security infrastructure itself, or about how multiple LSMs
> might interact with each other.
>
> A new LSM hook security_getselfattr() is introduced to get the
> required information from the security modules. This is similar
> to the existing security_getprocattr() hook, but specifies the
> format in which string data is returned and requires the module
> to put the information into a userspace destination.
>
> lsm_set_self_attr() changes the specified LSM attribute. Only one
> attribute can be changed at a time, and then only if the specified
> security module allows the change.
>
> A new LSM hook security_setselfattr() is introduced to set the
> required information in the security modules. This is similar
> to the existing security_setprocattr() hook, but specifies the
> format in which string data is presented and requires the module
> to get the information from a userspace destination.
>
> lsm_list_modules() provides the LSM identifiers, in order, of the
> security modules that are active on the system. This has been
> available in the securityfs file /sys/kernel/security/lsm.
>
> Patch 0001 changes the LSM registration from passing the name
> of the module to passing a lsm_id structure that contains the
> name of the module, an LSM identifier number and an attribute
> identifier.
> Patch 0002 adds the registered lsm_ids to a table.
> Patch 0003 changes security_[gs]etprocattr() to use LSM IDs instead
> of LSM names.
> Patch 0004 implements lsm_get_self_attr() and lsm_set_self_attr().
> New LSM hooks security_getselfattr() and security_setselfattr() are
> defined.
> Patch 0005 implements lsm_list_modules().
> Patch 0006 wires up the syscalls.
> Patch 0007 implements helper functions to make it easier for
> security modules to use lsm_ctx structures.
> Patch 0008 provides the Smack implementation for [gs]etselfattr().
> Patch 0009 provides the AppArmor implementation for [gs]etselfattr().
> Patch 0010 provides the SELinux implementation for [gs]etselfattr().
> Patch 0011 implements selftests for the three new syscalls.
>
> https://github.com/cschaufler/lsm-stacking.git#syscalls-6.5-rc7-v14
>
> v15: Rebased on 6.6-rc1.
>      Adopt suggested improvements to security_getprocattr,
>      making the code easier to read.
>      Squash a code fix from 0011 to 0004.
> v14: Make the handling of LSM_FLAG_SINGLE easier to understand.
>      Tighten the comments and documentation.
>      Better use of const, static, and __ro_after_init.
>      Add selftests for LSM_FLAG_SINGLE cases.
> v13: Change the setselfattr code to do a single user copy.
>      Make the self tests more robust.
>      Improve use of const.
>      Change syscall numbers to reflect upstream additions.
> v12: Repair a registration time overflow check.
> v11: Remove redundent alignment code
>      Improve a few comments.
>      Use LSM_ATTR_UNDEF in place of 0 in a few places.
>      Correct a return of -EINVAL to -E2BIG.
> v10: Correct use of __user.
>      Improve a few comments.
>      Revert unnecessary changes in module initialization.
> v9: Support a flag LSM_FLAG_SINGLE in lsm_get_self_attr() that
>     instructs the call to provide only the attribute for the LSM
>     identified in the referenced lsm_ctx structure.
>     Fix a typing error.
>     Change some coding style.
> v8: Allow an LSM to provide more than one instance of an attribute,
>     even though none of the existing modules do so.
>     Pad the data returned by lsm_get_self_attr() to the size of
>     the struct lsm_ctx.
>     Change some displeasing varilable names.
> v7: Pass the attribute desired to lsm_[gs]et_self_attr in its own
>     parameter rather than encoding it in the flags.
>     Change the flags parameters to u32.
>     Don't shortcut out of calling LSM specific code in the
>     infrastructure, let the LSM report that doesn't support an
>     attribute instead. With that it is not necessary to maintain
>     a set of supported attributes in the lsm_id structure.
>     Fix a typing error.
> v6: Switch from reusing security_[gs]procattr() to using new
>     security_[gs]selfattr() hooks. Use explicit sized data types
>     in the lsm_ctx structure.
>
> v5: Correct syscall parameter data types.
>
> v4: Restore "reserved" LSM ID values. Add explaination.
>     Squash patches that introduce fields in lsm_id.
>     Correct a wireup error.
>
> v3: Add lsm_set_self_attr().
>     Rename lsm_self_attr() to lsm_get_self_attr().
>     Provide the values only for a specifed attribute in
>     lsm_get_self_attr().
>     Add selftests for the three new syscalls.
>     Correct some parameter checking.
>
> v2: Use user-interface safe data types.
>     Remove "reserved" LSM ID values.
>     Improve kerneldoc comments
>     Include copyright dates
>     Use more descriptive name for LSM counter
>     Add documentation
>     Correct wireup errors
>
> Casey Schaufler (11):
>   LSM: Identify modules by more than name
>   LSM: Maintain a table of LSM attribute data
>   proc: Use lsmids instead of lsm names for attrs
>   LSM: syscalls for current process attributes
>   LSM: Create lsm_list_modules system call
>   LSM: wireup Linux Security Module syscalls
>   LSM: Helpers for attribute names and filling lsm_ctx
>   Smack: implement setselfattr and getselfattr hooks
>   AppArmor: Add selfattr hooks
>   SELinux: Add selfattr hooks
>   LSM: selftests for Linux Security Module syscalls
>
>  Documentation/userspace-api/index.rst         |   1 +
>  Documentation/userspace-api/lsm.rst           |  73 +++++
>  MAINTAINERS                                   |   2 +
>  arch/alpha/kernel/syscalls/syscall.tbl        |   3 +
>  arch/arm/tools/syscall.tbl                    |   3 +
>  arch/arm64/include/asm/unistd.h               |   2 +-
>  arch/arm64/include/asm/unistd32.h             |   6 +
>  arch/ia64/kernel/syscalls/syscall.tbl         |   3 +
>  arch/m68k/kernel/syscalls/syscall.tbl         |   3 +
>  arch/microblaze/kernel/syscalls/syscall.tbl   |   3 +
>  arch/mips/kernel/syscalls/syscall_n32.tbl     |   3 +
>  arch/mips/kernel/syscalls/syscall_n64.tbl     |   3 +
>  arch/mips/kernel/syscalls/syscall_o32.tbl     |   3 +
>  arch/parisc/kernel/syscalls/syscall.tbl       |   3 +
>  arch/powerpc/kernel/syscalls/syscall.tbl      |   3 +
>  arch/s390/kernel/syscalls/syscall.tbl         |   3 +
>  arch/sh/kernel/syscalls/syscall.tbl           |   3 +
>  arch/sparc/kernel/syscalls/syscall.tbl        |   3 +
>  arch/x86/entry/syscalls/syscall_32.tbl        |   3 +
>  arch/x86/entry/syscalls/syscall_64.tbl        |   3 +
>  arch/xtensa/kernel/syscalls/syscall.tbl       |   3 +
>  fs/proc/base.c                                |  29 +-
>  fs/proc/internal.h                            |   2 +-
>  include/linux/lsm_hook_defs.h                 |   4 +
>  include/linux/lsm_hooks.h                     |  17 +-
>  include/linux/security.h                      |  46 ++-
>  include/linux/syscalls.h                      |   6 +
>  include/uapi/asm-generic/unistd.h             |   9 +-
>  include/uapi/linux/lsm.h                      |  90 ++++++
>  kernel/sys_ni.c                               |   3 +
>  security/Makefile                             |   1 +
>  security/apparmor/include/procattr.h          |   2 +-
>  security/apparmor/lsm.c                       |  99 ++++++-
>  security/apparmor/procattr.c                  |  10 +-
>  security/bpf/hooks.c                          |   9 +-
>  security/commoncap.c                          |   8 +-
>  security/landlock/cred.c                      |   2 +-
>  security/landlock/fs.c                        |   2 +-
>  security/landlock/ptrace.c                    |   2 +-
>  security/landlock/setup.c                     |   6 +
>  security/landlock/setup.h                     |   1 +
>  security/loadpin/loadpin.c                    |   9 +-
>  security/lockdown/lockdown.c                  |   8 +-
>  security/lsm_syscalls.c                       | 120 ++++++++
>  security/safesetid/lsm.c                      |   9 +-
>  security/security.c                           | 253 +++++++++++++++-
>  security/selinux/hooks.c                      | 143 +++++++--
>  security/smack/smack_lsm.c                    | 103 ++++++-
>  security/tomoyo/tomoyo.c                      |   9 +-
>  security/yama/yama_lsm.c                      |   8 +-
>  .../arch/mips/entry/syscalls/syscall_n64.tbl  |   3 +
>  .../arch/powerpc/entry/syscalls/syscall.tbl   |   3 +
>  .../perf/arch/s390/entry/syscalls/syscall.tbl |   3 +
>  .../arch/x86/entry/syscalls/syscall_64.tbl    |   3 +
>  tools/testing/selftests/Makefile              |   1 +
>  tools/testing/selftests/lsm/.gitignore        |   1 +
>  tools/testing/selftests/lsm/Makefile          |  17 ++
>  tools/testing/selftests/lsm/common.c          |  89 ++++++
>  tools/testing/selftests/lsm/common.h          |  33 +++
>  tools/testing/selftests/lsm/config            |   3 +
>  .../selftests/lsm/lsm_get_self_attr_test.c    | 275 ++++++++++++++++++
>  .../selftests/lsm/lsm_list_modules_test.c     | 140 +++++++++
>  .../selftests/lsm/lsm_set_self_attr_test.c    |  74 +++++
>  63 files changed, 1694 insertions(+), 93 deletions(-)
>  create mode 100644 Documentation/userspace-api/lsm.rst
>  create mode 100644 include/uapi/linux/lsm.h
>  create mode 100644 security/lsm_syscalls.c
>  create mode 100644 tools/testing/selftests/lsm/.gitignore
>  create mode 100644 tools/testing/selftests/lsm/Makefile
>  create mode 100644 tools/testing/selftests/lsm/common.c
>  create mode 100644 tools/testing/selftests/lsm/common.h
>  create mode 100644 tools/testing/selftests/lsm/config
>  create mode 100644 tools/testing/selftests/lsm/lsm_get_self_attr_test.c
>  create mode 100644 tools/testing/selftests/lsm/lsm_list_modules_test.c
>  create mode 100644 tools/testing/selftests/lsm/lsm_set_self_attr_test.c

This patchset is now in lsm/dev, thanks everyone!

--=20
paul-moore.com

