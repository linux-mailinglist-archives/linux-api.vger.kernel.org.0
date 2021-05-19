Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6699238864E
	for <lists+linux-api@lfdr.de>; Wed, 19 May 2021 07:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbhESFCj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 19 May 2021 01:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbhESFCi (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 19 May 2021 01:02:38 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51792C06175F
        for <linux-api@vger.kernel.org>; Tue, 18 May 2021 22:01:18 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id i5so8635624pgm.0
        for <linux-api@vger.kernel.org>; Tue, 18 May 2021 22:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=esnhAa6zxT8tZsaixbuTSr+w0I6APKP+rmmO7EtAWv8=;
        b=Nwmr/n+uZ+qIVnNcGfFrwhhAiHAr4FxT9EBnK3cxa7KO+Ne3CBxUItj4lbX/egY6In
         XnT8HOLih6Z0kqPzx6lbFw3AihXuE3g1UUuSEKFoNJucJrfbmVX/QyFJgZU5sVUdUx9f
         GEZ9NV76PX4k+eZpjBlEaZsKCOFK4taOBuCeqQQ8L0q/ey3abVbuWJHFH4I5SKDM9zTP
         ENzgzoSNsmgM+qKso3YNJWneeO8bPLO9AXUno7lxcbEZh06+pel3sxPYwhE+0Es5NUrX
         XnHin1HPVJOv1AKHB0IQFhU5yOuVIwj7Rqok6QD93uCURq2OXAILT22bTLkmb4HJri3P
         hT2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=esnhAa6zxT8tZsaixbuTSr+w0I6APKP+rmmO7EtAWv8=;
        b=Mh6mGodycIvecJebWZZWy6UY8oLxj/tfHFLLVjTPcjJssOR5tZyiTgbHS29dEHsKV0
         Ltx5FiwQS9WeDoS8YsWXKFiv5GU9FfBdB3ReWE++cYCDEjF3FLP8UwFQ0fagy13ZzbbO
         J07A91yWjmmFZAEYPaC2tmqdLDx+1cUBsEVthnOGbV07LdGKggrnA0m9N4aE/UtnrI3E
         DIv7QSORHlZjOq3oE+n+WLR4J+/6THjcxQcfJylef7d2qK8Acb9WyhK6XSrvSFebUHGB
         I8lwn4vSbVU8ggoPynniAm4k131Jf5CnuU5NQ9kRFkLBINQrYj4zVrwo0OjRdevZBuTU
         7ECg==
X-Gm-Message-State: AOAM533cZdnftw5bLI+ORIL0/NOpQKv9phwhfDlO5k2e4/R5vi9USVw4
        XULfvWcLI23i9LcNQtevPB+uNLBPMk0=
X-Google-Smtp-Source: ABdhPJyxD/YfxWVyE3DDoF4YolxhuSLaZtlKUGtlNvp/sulWv5s9PfeXY/SVs3u/C7ewBdu/bBIG1g==
X-Received: by 2002:a63:5641:: with SMTP id g1mr6412836pgm.351.1621400477693;
        Tue, 18 May 2021 22:01:17 -0700 (PDT)
Received: from localhost (14-201-155-8.tpgi.com.au. [14.201.155.8])
        by smtp.gmail.com with ESMTPSA id i7sm5092172pgv.93.2021.05.18.22.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 22:01:17 -0700 (PDT)
Date:   Wed, 19 May 2021 15:01:12 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: Linux powerpc new system call instruction and ABI
To:     "Dmitry V. Levin" <ldv@altlinux.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     libc-alpha@sourceware.org, libc-dev@lists.llvm.org,
        linux-api@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Matheus Castanho <msc@linux.ibm.com>, musl@lists.openwall.com
References: <20200611081203.995112-1-npiggin@gmail.com>
        <20210518231331.GA8464@altlinux.org>
        <1621385544.nttlk5qugb.astroid@bobo.none>
In-Reply-To: <1621385544.nttlk5qugb.astroid@bobo.none>
MIME-Version: 1.0
Message-Id: <1621400263.gf0mbqhkrf.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Excerpts from Nicholas Piggin's message of May 19, 2021 12:50 pm:
> Excerpts from Dmitry V. Levin's message of May 19, 2021 9:13 am:
>> Hi,
>>=20
>> On Thu, Jun 11, 2020 at 06:12:01PM +1000, Nicholas Piggin wrote:
>> [...]
>>> - Error handling: The consensus among kernel, glibc, and musl is to mov=
e to
>>>   using negative return values in r3 rather than CR0[SO]=3D1 to indicat=
e error,
>>>   which matches most other architectures, and is closer to a function c=
all.
>>=20
>> Apparently, the patchset merged by commit v5.9-rc1~100^2~164 was
>> incomplete: all functions defined in arch/powerpc/include/asm/ptrace.h a=
nd
>> arch/powerpc/include/asm/syscall.h that use ccr are broken when scv is u=
sed.
>> This includes syscall_get_error() and all its users including
>> PTRACE_GET_SYSCALL_INFO API, which in turn makes strace unusable
>> when scv is used.
>>=20
>> See also https://bugzilla.redhat.com/1929836
>=20
> I see, thanks. Using latest strace from github.com, the attached kernel
> patch makes strace -k check results a lot greener.
>=20
> Some of the remaining failing tests look like this (I didn't look at all
> of them yet):
>=20
> signal(SIGUSR1, 0xfacefeeddeadbeef)     =3D 0 (SIG_DFL)
> write(1, "signal(SIGUSR1, 0xfacefeeddeadbe"..., 50signal(SIGUSR1, 0xfacef=
eeddeadbeef) =3D 0 (SIG_DFL)
> ) =3D 50
> signal(SIGUSR1, SIG_IGN)                =3D 0xfacefeeddeadbeef
> write(2, "errno2name.c:461: unknown errno "..., 41errno2name.c:461: unkno=
wn errno 559038737) =3D 41
> write(2, ": Unknown error 559038737\n", 26: Unknown error 559038737
> ) =3D 26
> exit_group(1)                           =3D ?
>=20
> I think the problem is glibc testing for -ve, but it should be comparing
> against -4095 (+cc Matheus)
>=20
>   #define RET_SCV \
>       cmpdi r3,0; \
>       bgelr+; \
>       neg r3,r3;

This glibc patch at least gets that signal test working. Haven't run the=20
full suite yet because of trouble making it work with a local glibc
install...

Thanks,
Nick

---

diff --git a/sysdeps/powerpc/powerpc64/sysdep.h b/sysdeps/powerpc/powerpc64=
/sysdep.h
index c57bb1c05d..1ea4c3b917 100644
--- a/sysdeps/powerpc/powerpc64/sysdep.h
+++ b/sysdeps/powerpc/powerpc64/sysdep.h
@@ -398,8 +398,9 @@ LT_LABELSUFFIX(name,_name_end): ; \
 #endif
=20
 #define RET_SCV \
-    cmpdi r3,0; \
-    bgelr+; \
+    li r9,-4095; \
+    cmpld r3,r9; \
+    bltlr+; \
     neg r3,r3;
=20
 #define RET_SC \
