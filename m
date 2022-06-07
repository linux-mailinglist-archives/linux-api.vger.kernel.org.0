Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B825410A4
	for <lists+linux-api@lfdr.de>; Tue,  7 Jun 2022 21:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352328AbiFGT2q (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 7 Jun 2022 15:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356765AbiFGT2K (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 7 Jun 2022 15:28:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141257354D
        for <linux-api@vger.kernel.org>; Tue,  7 Jun 2022 11:10:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8677B61929
        for <linux-api@vger.kernel.org>; Tue,  7 Jun 2022 18:10:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 879B2C385A5;
        Tue,  7 Jun 2022 18:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654625441;
        bh=Cp+1TMF0hGRCVl32z1k66YVDqokGbwvXJz8mRgClFaY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aKgR0yCLzDD72+YDeB6jlIzwkma2BpQKd8KTyk8jGH7tj9jwAF9cD9POnneG8FLXo
         4OlsWbAXnaPnA9fFdZ67A4XjLnJ1HzNDMKrywI35pI+apllTYVH/3ycnEp51wqkynk
         cGVay1xxHLK0+8NQ/xRfBsWhs3dMUHJ5ahVqkMlwimW1VwwrCyIiJr/TogVkOSBOsk
         dDt7tHNyZkSa4apfmHjOKFWFo3lB4+twrrFm/QmZhxtjopisqADRYP2i0BKdTzxwo0
         sYC7iAH3R60Q4srb2N+MojjvdnVG77Fo0MdHuezDyHmY/8TJxjeBAgF0B64SKKoO4j
         EIVzCTFiAcB+Q==
Date:   Tue, 7 Jun 2022 20:10:32 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Yann Droneaud <ydroneaud@opteya.com>
Cc:     Adhemerval Zanella <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>, linux-api@vger.kernel.org,
        GNU C Library <libc-alpha@sourceware.org>
Subject: Re: [PATCH v5 8/8] linux: Add mount_setattr
Message-ID: <20220607181032.s4rnqwxik7scuhzx@wittgenstein>
References: <20220606134432.1944534-1-adhemerval.zanella@linaro.org>
 <20220606134432.1944534-9-adhemerval.zanella@linaro.org>
 <5a3f8e2f-d67a-d1e1-c5a5-0f711323a782@opteya.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5a3f8e2f-d67a-d1e1-c5a5-0f711323a782@opteya.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Jun 07, 2022 at 06:34:46PM +0200, Yann Droneaud wrote:
> Hi,
> 
> Le 06/06/2022 à 15:44, Adhemerval Zanella via Libc-alpha a écrit :
> > It was added on Linux 5.12 (2a1867219c7b27f928e2545782b86daaf9ad50bd)
> > to allow change the properties of a mount or a mount tree using file
> > descriptors which the new mount api is based on.
> > 
> > Checked on x86_64-linux-gnu.
> > ---
> >   NEWS                                          |  6 ++--
> >   sysdeps/unix/sysv/linux/Versions              |  1 +
> >   sysdeps/unix/sysv/linux/aarch64/libc.abilist  |  1 +
> >   sysdeps/unix/sysv/linux/alpha/libc.abilist    |  1 +
> >   sysdeps/unix/sysv/linux/arc/libc.abilist      |  1 +
> >   sysdeps/unix/sysv/linux/arm/be/libc.abilist   |  1 +
> >   sysdeps/unix/sysv/linux/arm/le/libc.abilist   |  1 +
> >   sysdeps/unix/sysv/linux/csky/libc.abilist     |  1 +
> >   sysdeps/unix/sysv/linux/hppa/libc.abilist     |  1 +
> >   sysdeps/unix/sysv/linux/i386/libc.abilist     |  1 +
> >   sysdeps/unix/sysv/linux/ia64/libc.abilist     |  1 +
> >   .../sysv/linux/m68k/coldfire/libc.abilist     |  1 +
> >   .../unix/sysv/linux/m68k/m680x0/libc.abilist  |  1 +
> >   .../sysv/linux/microblaze/be/libc.abilist     |  1 +
> >   .../sysv/linux/microblaze/le/libc.abilist     |  1 +
> >   .../sysv/linux/mips/mips32/fpu/libc.abilist   |  1 +
> >   .../sysv/linux/mips/mips32/nofpu/libc.abilist |  1 +
> >   .../sysv/linux/mips/mips64/n32/libc.abilist   |  1 +
> >   .../sysv/linux/mips/mips64/n64/libc.abilist   |  1 +
> >   sysdeps/unix/sysv/linux/nios2/libc.abilist    |  1 +
> >   sysdeps/unix/sysv/linux/or1k/libc.abilist     |  1 +
> >   .../linux/powerpc/powerpc32/fpu/libc.abilist  |  1 +
> >   .../powerpc/powerpc32/nofpu/libc.abilist      |  1 +
> >   .../linux/powerpc/powerpc64/be/libc.abilist   |  1 +
> >   .../linux/powerpc/powerpc64/le/libc.abilist   |  1 +
> >   .../unix/sysv/linux/riscv/rv32/libc.abilist   |  1 +
> >   .../unix/sysv/linux/riscv/rv64/libc.abilist   |  1 +
> >   .../unix/sysv/linux/s390/s390-32/libc.abilist |  1 +
> >   .../unix/sysv/linux/s390/s390-64/libc.abilist |  1 +
> >   sysdeps/unix/sysv/linux/sh/be/libc.abilist    |  1 +
> >   sysdeps/unix/sysv/linux/sh/le/libc.abilist    |  1 +
> >   .../sysv/linux/sparc/sparc32/libc.abilist     |  1 +
> >   .../sysv/linux/sparc/sparc64/libc.abilist     |  1 +
> >   sysdeps/unix/sysv/linux/sys/mount.h           | 22 ++++++++++++++
> >   sysdeps/unix/sysv/linux/syscalls.list         |  1 +
> >   sysdeps/unix/sysv/linux/tst-mount.c           | 30 +++++++++++++++++--
> >   .../unix/sysv/linux/x86_64/64/libc.abilist    |  1 +
> >   .../unix/sysv/linux/x86_64/x32/libc.abilist   |  1 +
> >   38 files changed, 87 insertions(+), 6 deletions(-)
> > 
> > diff --git a/NEWS b/NEWS
> > index de12657449..696de3962b 100644
> > --- a/NEWS
> > +++ b/NEWS
> > @@ -29,9 +29,9 @@ Major new features:
> >     memory is carried out in the context of the caller, using the caller's
> >     CPU affinity, and priority with CPU usage accounted to the caller.
> > -* On Linux, the fsopen, fsmount, move_mount, fsconfig, fspick, and open_tree
> > -  have been added.  It is a new mount API to allow more flexibility on mount
> > -  operations, specially when used along namespaces.
> > +* On Linux, the fsopen, fsmount, move_mount, fsconfig, fspick, open_tree,
> > +  and mount_setattr have been added.  It is a new mount API to allow more
> > +  flexibility on mount operations, specially when used along namespaces.
> >   Deprecated and removed features, and other changes affecting compatibility:
> > diff --git a/sysdeps/unix/sysv/linux/Versions b/sysdeps/unix/sysv/linux/Versions
> > index b70530ef40..65d2ceda2c 100644
> > --- a/sysdeps/unix/sysv/linux/Versions
> > +++ b/sysdeps/unix/sysv/linux/Versions
> > @@ -305,6 +305,7 @@ libc {
> >       fsopen;
> >       fspick;
> >       move_mount;
> > +    mount_setattr;
> >       open_tree;
> >       pidfd_open;
> >       pidfd_getfd;
> 
> > diff --git a/sysdeps/unix/sysv/linux/sys/mount.h b/sysdeps/unix/sysv/linux/sys/mount.h
> > index eb6705a091..4929d84027 100644
> > --- a/sysdeps/unix/sysv/linux/sys/mount.h
> > +++ b/sysdeps/unix/sysv/linux/sys/mount.h
> > @@ -23,6 +23,8 @@
> >   #include <fcntl.h>
> >   #include <features.h>
> > +#include <stdint.h>
> > +#include <stddef.h>
> >   #include <sys/ioctl.h>
> >   #define BLOCK_SIZE	1024
> > @@ -155,6 +157,17 @@ enum
> >   #define MOUNT_ATTR_NOSYMFOLLOW  0x00200000 /* Do not follow symlinks.  */
> > +/* For mount_setattr.  */
> > +struct mount_attr
> > +{
> > +  uint64_t attr_set;
> > +  uint64_t attr_clr;
> > +  uint64_t propagation;
> > +  uint64_t userns_fd;
> > +};
> > +
> > +#define MOUNT_ATTR_SIZE_VER0    32 /* sizeof first published struct */
> > +
> >   /* move_mount flags.  */
> >   #define MOVE_MOUNT_F_SYMLINKS   0x00000001 /* Follow symlinks on from path */
> >   #define MOVE_MOUNT_F_AUTOMOUNTS 0x00000002 /* Follow automounts on from path */
> > @@ -240,6 +253,15 @@ extern int fspick (int __dfd, const char *__path, unsigned int __flags)
> >   extern int open_tree (int __dfd, const char *__filename, unsigned int __flags)
> >     __THROW;
> > +/* Change the mount proprieties of the mount or an entire mount tree.  If
> > +   PATH is a relative pathname, then it is interpreted relative to the directory
> > +   referred to by the file descriptor dirfd.  Otherwise if DFD is the special
> > +   value AT_FDCWD then PATH is interpreted relative to the current working
> > +   directory of the calling process.  */
> > +extern int mount_setattr (int __dfd, const char *__path, unsigned int __flags,
> > +			  struct mount_attr *__uattr, size_t __usize)
> > +  __THROW;
> > +
> 
> 
> I wonder why __uattr is not declared const struct mount_attr * ?
> 
> Is it really expected that future mount_setattr() extensions to write back
> into the userspace structure ?

I don't think we can in principle rule this out. A const is a bit of a
scary commitment in this regard... I need to think about this a bit.
