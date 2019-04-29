Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28BD2E5CE
	for <lists+linux-api@lfdr.de>; Mon, 29 Apr 2019 17:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbfD2PJd (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Apr 2019 11:09:33 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:57877 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728253AbfD2PJd (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Apr 2019 11:09:33 -0400
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x3TF9KC8006419;
        Tue, 30 Apr 2019 00:09:21 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x3TF9KC8006419
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1556550561;
        bh=MW1aGUukyb5H+fRSy4kTMiPDEchWe4IFhiW9Utfmjp8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BErTn8EcfVgazUjgbaVzOqESVQn3n51PzT0778Socc5TcBBrGZCGGohxkDq1MgW94
         Iwks6bwmTwbSefpQCRrYtxUGmPNmLDWmawEgSuOCXQIu2NqSNjfNOXwB3qPLuovE5r
         HTyQlkNgtqOkgTdgc81A3LEEyeOFBe/Hq+/dNZYFp48oXh9cPOdc2viG3hTo9XpT+Q
         Q7O76I7aO1I5eifl23gZDP/9SKNBGwhp0a80C7kLTc1tYJjHbPWkgF7IE085JWGfk1
         cqpTAEzKnCD3l0ZK9uWFCNtwYFjPopBJRcxdjFtRIDVfXpytay+74JV1UMqWzcKdZl
         9MFy48RqhW29g==
X-Nifty-SrcIP: [209.85.222.51]
Received: by mail-ua1-f51.google.com with SMTP id h4so3600107uaj.9;
        Mon, 29 Apr 2019 08:09:21 -0700 (PDT)
X-Gm-Message-State: APjAAAUUyfzvK6dJ5qZQNqmenek2T77Nr7Ki/2UJqoqi2753KDptmy3W
        tfGlZW3hnhF9LybE5wRFM157C8pVO4pClv1HLzQ=
X-Google-Smtp-Source: APXvYqxkwcGqg1dUxJR5uNJzQww6ku12Zq9V2fnR5+weRvJDt+V0L3rkBfD0KFczMq29mFbSW64iIFLza3fW+6g0ZaI=
X-Received: by 2002:ab0:3058:: with SMTP id x24mr6928895ual.95.1556550560107;
 Mon, 29 Apr 2019 08:09:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190429090854.GU9023@dhcp129-178.brq.redhat.com>
In-Reply-To: <20190429090854.GU9023@dhcp129-178.brq.redhat.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 30 Apr 2019 00:08:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNARpeSTr=VWudDRQ8sobcPQqtqzcLm7EqyvoKFYT84Hk6Q@mail.gmail.com>
Message-ID: <CAK7LNARpeSTr=VWudDRQ8sobcPQqtqzcLm7EqyvoKFYT84Hk6Q@mail.gmail.com>
Subject: Re: [PATCH v3] moduleparam: Save information about built-in modules
 in separate file
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-api@vger.kernel.org, linux-modules@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Jessica Yu <jeyu@kernel.org>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Apr 29, 2019 at 6:09 PM Alexey Gladkov <gladkov.alexey@gmail.com> wrote:
>
> Problem:
>
> When a kernel module is compiled as a separate module, some important
> information about the kernel module is available via .modinfo section of
> the module.  In contrast, when the kernel module is compiled into the
> kernel, that information is not available.
>
> Information about built-in modules is necessary in the following cases:
>
> 1. When it is necessary to find out what additional parameters can be
> passed to the kernel at boot time.
>
> 2. When you need to know which module names and their aliases are in
> the kernel. This is very useful for creating an initrd image.
>
> Proposal:
>
> The proposed patch does not remove .modinfo section with module
> information from the vmlinux at the build time and saves it into a
> separate file after kernel linking. So, the kernel does not increase in
> size and no additional information remains in it. Information is stored
> in the same format as in the separate modules (null-terminated string
> array). Because the .modinfo section is already exported with a separate
> modules, we are not creating a new API.
>
> It can be easily read in the userspace:
>
> $ tr '\0' '\n' < kernel.builtin
> ext4.softdep=pre: crc32c
> ext4.license=GPL
> ext4.description=Fourth Extended Filesystem
> ext4.author=Remy Card, Stephen Tweedie, Andrew Morton, Andreas Dilger, Theodore Ts'o and others
> ext4.alias=fs-ext4
> ext4.alias=ext3
> ext4.alias=fs-ext3
> ext4.alias=ext2
> ext4.alias=fs-ext2
> md_mod.alias=block-major-9-*
> md_mod.alias=md
> md_mod.description=MD RAID framework
> md_mod.license=GPL
> md_mod.parmtype=create_on_open:bool
> md_mod.parmtype=start_dirty_degraded:int
> ...
>
> v2:
>  * Extract modinfo from vmlinux.o as suggested by Masahiro Yamada;
>  * Rename output file to kernel.builtin;
>  * Add MODULE_VERSION to modinfo that is saved to the kernel.builtin;
>  * Fix build warnings on powerpc.
>
> v3:
>  * Rename output file to modules.builtin.modinfo as suggested by Masahiro Yamada;
>  * Update Documentation/dontdiff, Documentation/kbuild/kbuild.txt.
>
> Co-Developed-by: Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>
> Signed-off-by: Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>
> Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
> ---
>  .gitignore                        |  1 +
>  Documentation/dontdiff            |  1 +
>  Documentation/kbuild/kbuild.txt   |  5 +++++
>  Makefile                          |  2 ++
>  include/asm-generic/vmlinux.lds.h |  1 +
>  include/linux/module.h            |  1 +
>  include/linux/moduleparam.h       | 12 +++++-------
>  scripts/link-vmlinux.sh           |  4 ++++
>  8 files changed, 20 insertions(+), 7 deletions(-)
>
> diff --git a/.gitignore b/.gitignore
> index a20ac26aa2f5..8ef2c87703b3 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -45,6 +45,7 @@
>  *.xz
>  Module.symvers
>  modules.builtin
> +modules.builtin.modinfo
>
>  #
>  # Top-level generic files


Let me repeat the same comments as in v2
(https://patchwork.kernel.org/patch/10888207/#22595563)
as you ignored them.



This file is generated only in the top of the tree.

Please add '/' prefix and move it to
the "# Top-level generic files" section.



#
# Top-level generic files
#
/tags
/TAGS
/linux
/vmlinux
/vmlinux.32
/vmlinux-gdb.py
/vmlinuz
/System.map
/Module.markers
/modules.builtin.modinfo




> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index c8cf45362bd6..41ef7cb043c1 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -226,6 +226,10 @@ modpost_link vmlinux.o
>  # modpost vmlinux.o to check for section mismatches
>  ${MAKE} -f "${srctree}/scripts/Makefile.modpost" vmlinux.o
>
> +info MODINFO modules.builtin.modinfo
> +"${OBJCOPY}" -j .modinfo -O binary vmlinux.o modules.builtin.modinfo
> +chmod 444 modules.builtin.modinfo


Why is this 'chmod 444' necessary?



> +
>  kallsymso=""
>  kallsyms_vmlinux=""
>  if [ -n "${CONFIG_KALLSYMS}" ]; then







-- 
Best Regards
Masahiro Yamada
