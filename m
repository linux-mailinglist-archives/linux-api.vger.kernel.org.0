Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86C8914C9D7
	for <lists+linux-api@lfdr.de>; Wed, 29 Jan 2020 12:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgA2Lll (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 29 Jan 2020 06:41:41 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41080 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgA2Lll (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 29 Jan 2020 06:41:41 -0500
Received: by mail-lj1-f193.google.com with SMTP id h23so18088435ljc.8
        for <linux-api@vger.kernel.org>; Wed, 29 Jan 2020 03:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XUJCo3W0DrPJvZgiPwUB2UqemEKFFUaj+v+ZvMScm5g=;
        b=A/d5W6M/KY0Iy011nwBgjDsd/ZN9BXjzxCYTMLUeVgqP0RrB3n6W6NFvtwH9+BvOr8
         xVOrwdn5IM4+R1O2RUT1Uc/rDcwaUgGwYJ4LBQ7Wz2vWsiBFsCl84SaDK+UdSMbTsF8m
         jUFURAtutNCr4lCzJC/1rllPdsbU0IH0+1frKloBIIz9kek0xOnGy4Ponl/ZlaokMqTB
         ocu+RpfjK/VLGs34EPOxOCM0Ocp1Xwv5S0gXqy9vq0N2hwbb2L8o2nayIzbPSSKx3QGx
         /3XmM+IhiRAEYalclncuDZfHlPGx6c0sU8ADJZFC1+GG+5UcY1/O09OjMtiMGmfAbnSo
         vA8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XUJCo3W0DrPJvZgiPwUB2UqemEKFFUaj+v+ZvMScm5g=;
        b=Lezfb+IEoKghMOxyykfA74Z8nDpaAfghppk96BfisrpRpQSoBW8s+/bDB5Zabv82t4
         b6BQIQQLonvWivZrRDGvsEQr2RPV2sJc61qm4QMLrXc0CjnrFV0sIS03AbtJ2ptD228M
         Ca2nBN3GmJcMQdyxj3M9g7lQFs4nRBN2IrVrMUcnZgUoi/Gy5tL/Mk3Q5IwzaRN0zBLU
         DX0IWy3ykYbMTBF7LqhVPXneiFghamxlf5V0menMcPPeQnAEOnr2/mUpf2+F/YJEDh88
         RHxC0LEqwHQ2wkZy+Nj1Zkcm5mOt7UN5gxvdJORkhnaqLf5rsA+pNFzmN+1GoLNKjI+k
         IYfw==
X-Gm-Message-State: APjAAAX3w8Fb+Ui81e+DsAZ87oOs2juGsKvtULptM+q7qv0GjHqDjfRi
        6naQEoE2HzNeccEe7j9GuYGDnMd7Nveu+ttqzsDAxhjEF/Y=
X-Google-Smtp-Source: APXvYqw52vefJuUlCsee/38Qg+2Y8n1LuyvfKiMQiALCoQO8FQ99jAnblWw1bfjfhOBJxjQZnDG8M58FQBW1CuLytMM=
X-Received: by 2002:a2e:a490:: with SMTP id h16mr16103138lji.115.1580298098188;
 Wed, 29 Jan 2020 03:41:38 -0800 (PST)
MIME-Version: 1.0
References: <CALN7hCJRe1uL6pd+VwgzDt=5giMVjvX+YpF28f5qbLOVCZf4GQ@mail.gmail.com>
 <04EB5627-FD42-4397-995B-FDF051CFCFB5@brauner.io> <CALN7hC+YmHGpniNKBiD03cBnTyO+cqXhrVvE7SdtgEb7GkG-LQ@mail.gmail.com>
 <87d0e19qvh.fsf@mid.deneb.enyo.de> <CALN7hC+QS=PJLvtH4k8paVae6PzLdAQJXyU64gUxXu-ULMKvng@mail.gmail.com>
 <87sgmv5s8l.fsf@mid.deneb.enyo.de>
In-Reply-To: <87sgmv5s8l.fsf@mid.deneb.enyo.de>
From:   Elichai Turkel <elichai.turkel@gmail.com>
Date:   Wed, 29 Jan 2020 13:41:12 +0200
Message-ID: <CALN7hC+C7Ln5wDTW74r-eSChje3N6=79_qrr3TDCCF5WnWO2mg@mail.gmail.com>
Subject: Re: Missing size_t declaration in UAPI
To:     linux-api@vger.kernel.org
Cc:     libc-alpha <libc-alpha@sourceware.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi, I want to continue that discussion
I see three options to resolve this:
1. Add `#include <stddef.h>` in every header that uses `size_t` (patch
provided).
2. Add `#include <stddef.h>` to `asm-generic/posix_types.h` and make
sure every header that uses `size_t` will include that.
3. Replace all usages of `size_t` with `__kernel_size_t`.

Included a patch for the first option but if people prefer I'll
provide patches for the rest.
I never contributed code to linux so feedback on your thoughts and the
process are more than welcome :)

```
diff --git a/include/uapi/linux/agpgart.h b/include/uapi/linux/agpgart.h
index f52510451..9630abcb8 100644
--- a/include/uapi/linux/agpgart.h
+++ b/include/uapi/linux/agpgart.h
@@ -52,7 +52,7 @@

 #ifndef __KERNEL__
 #include <linux/types.h>
-#include <stdlib.h>
+#include <stddef.h>

 struct agp_version {
  __u16 major;
diff --git a/include/uapi/linux/arcfb.h b/include/uapi/linux/arcfb.h
index 7a9008b36..f7018f92b 100644
--- a/include/uapi/linux/arcfb.h
+++ b/include/uapi/linux/arcfb.h
@@ -2,6 +2,10 @@
 #ifndef __LINUX_ARCFB_H__
 #define __LINUX_ARCFB_H__

+#ifndef __KERNEL__
+#include <stddef.h>
+#endif
+
 #define FBIO_WAITEVENT _IO('F', 0x88)
 #define FBIO_GETCONTROL2 _IOR('F', 0x89, size_t)

diff --git a/include/uapi/linux/coda.h b/include/uapi/linux/coda.h
index aa34c2dca..1b909ef35 100644
--- a/include/uapi/linux/coda.h
+++ b/include/uapi/linux/coda.h
@@ -97,6 +97,7 @@ typedef unsigned long long u_quad_t;
 #include <linux/time.h>
 #define cdev_t u_quad_t
 #ifndef __KERNEL__
+#include <stddef.h>
 #if !defined(_UQUAD_T_) && (!defined(__GLIBC__) || __GLIBC__ < 2)
 #define _UQUAD_T_ 1
 typedef unsigned long long u_quad_t;
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 379a612f8..edd20ca84 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -15,6 +15,7 @@
 #include <linux/types.h>
 #ifndef __KERNEL__
 #include <linux/fscrypt.h>
+#include <stddef.h>
 #endif

 /* Use of MS_* flags within the kernel is restricted to core mount(2) code. */
diff --git a/include/uapi/linux/fsmap.h b/include/uapi/linux/fsmap.h
index 91fd519a3..521c2f650 100644
--- a/include/uapi/linux/fsmap.h
+++ b/include/uapi/linux/fsmap.h
@@ -10,6 +10,9 @@
 #define _LINUX_FSMAP_H

 #include <linux/types.h>
+#ifndef __KERNEL__
+#include <stddef.h>
+#endif

 /*
  * Structure for FS_IOC_GETFSMAP.
diff --git a/include/uapi/linux/i8k.h b/include/uapi/linux/i8k.h
index 268e6268f..91c478cca 100644
--- a/include/uapi/linux/i8k.h
+++ b/include/uapi/linux/i8k.h
@@ -18,6 +18,10 @@
 #ifndef _LINUX_I8K_H
 #define _LINUX_I8K_H

+#ifndef __KERNEL__
+#include <stddef.h>
+#endif
+
 #define I8K_PROC "/proc/i8k"
 #define I8K_PROC_FMT "1.0"

diff --git a/include/uapi/linux/if_pppox.h b/include/uapi/linux/if_pppox.h
index e7a693c28..1b3ebaab1 100644
--- a/include/uapi/linux/if_pppox.h
+++ b/include/uapi/linux/if_pppox.h
@@ -28,6 +28,10 @@
 #include <linux/in.h>
 #include <linux/in6.h>

+#ifndef __KERNEL__
+#include <stddef.h>
+#endif
+
 /* For user-space programs to pick up these definitions
  * which they wouldn't get otherwise without defining __KERNEL__
  */
diff --git a/include/uapi/linux/kexec.h b/include/uapi/linux/kexec.h
index 05669c87a..5873e22f8 100644
--- a/include/uapi/linux/kexec.h
+++ b/include/uapi/linux/kexec.h
@@ -8,6 +8,9 @@
  */

 #include <linux/types.h>
+#ifndef __KERNEL__
+#include <stddef.h>
+#endif

 /* kexec flags for different usage scenarios */
 #define KEXEC_ON_CRASH 0x00000001
@@ -47,6 +50,7 @@
 #define KEXEC_SEGMENT_MAX 16

 #ifndef __KERNEL__
+#include <stddef.h>
 /*
  * This structure is used to hold the arguments that are used when
  * loading  kernel binaries.
diff --git a/include/uapi/linux/matroxfb.h b/include/uapi/linux/matroxfb.h
index 23e025b7e..50fd2453a 100644
--- a/include/uapi/linux/matroxfb.h
+++ b/include/uapi/linux/matroxfb.h
@@ -7,6 +7,10 @@
 #include <linux/videodev2.h>
 #include <linux/fb.h>

+#ifndef __KERNEL__
+#include <stddef.h>
+#endif
+
 struct matroxioc_output_mode {
  __u32 output; /* which output */
 #define MATROXFB_OUTPUT_PRIMARY 0x0000
diff --git a/include/uapi/linux/nfc.h b/include/uapi/linux/nfc.h
index f6e3c8c9c..491607e9b 100644
--- a/include/uapi/linux/nfc.h
+++ b/include/uapi/linux/nfc.h
@@ -23,6 +23,9 @@

 #include <linux/types.h>
 #include <linux/socket.h>
+#ifndef __KERNEL__
+#include <stddef.h>
+#endif

 #define NFC_GENL_NAME "nfc"
 #define NFC_GENL_VERSION 1
diff --git a/include/uapi/linux/omapfb.h b/include/uapi/linux/omapfb.h
index 44f43af4c..21a4803bf 100644
--- a/include/uapi/linux/omapfb.h
+++ b/include/uapi/linux/omapfb.h
@@ -28,6 +28,9 @@
 #include <linux/fb.h>
 #include <linux/ioctl.h>
 #include <linux/types.h>
+#ifndef __KERNEL__
+#include <stddef.h>
+#endif

 /* IOCTL commands. */

diff --git a/include/uapi/linux/pmu.h b/include/uapi/linux/pmu.h
index f2fc1bd80..1664bdd3c 100644
--- a/include/uapi/linux/pmu.h
+++ b/include/uapi/linux/pmu.h
@@ -122,6 +122,9 @@ enum {
  * Ioctl commands for the /dev/pmu device
  */
 #include <linux/ioctl.h>
+#ifndef __KERNEL__
+#include <stddef.h>
+#endif

 /* no param */
 #define PMU_IOC_SLEEP _IO('B', 0)
diff --git a/include/uapi/linux/radeonfb.h b/include/uapi/linux/radeonfb.h
index 86eafb805..428a99482 100644
--- a/include/uapi/linux/radeonfb.h
+++ b/include/uapi/linux/radeonfb.h
@@ -4,6 +4,9 @@

 #include <asm/ioctl.h>
 #include <linux/types.h>
+#ifndef __KERNEL__
+#include <stddef.h>
+#endif

 #define ATY_RADEON_LCD_ON 0x00000001
 #define ATY_RADEON_CRT_ON 0x00000002
diff --git a/include/uapi/linux/reiserfs_xattr.h
b/include/uapi/linux/reiserfs_xattr.h
index 28f10842f..f121bc88a 100644
--- a/include/uapi/linux/reiserfs_xattr.h
+++ b/include/uapi/linux/reiserfs_xattr.h
@@ -7,6 +7,9 @@
 #define _LINUX_REISERFS_XATTR_H

 #include <linux/types.h>
+#ifndef __KERNEL__
+#include <stddef.h>
+#endif

 /* Magic value in header */
 #define REISERFS_XATTR_MAGIC 0x52465841 /* "RFXA" */
diff --git a/include/uapi/linux/seg6_iptunnel.h
b/include/uapi/linux/seg6_iptunnel.h
index 09fb608a3..b4debe869 100644
--- a/include/uapi/linux/seg6_iptunnel.h
+++ b/include/uapi/linux/seg6_iptunnel.h
@@ -16,6 +16,9 @@
 #define _UAPI_LINUX_SEG6_IPTUNNEL_H

 #include <linux/seg6.h> /* For struct ipv6_sr_hdr. */
+#ifndef __KERNEL__
+#include <stddef.h>
+#endif

 enum {
  SEG6_IPTUNNEL_UNSPEC,
diff --git a/include/uapi/linux/sysctl.h b/include/uapi/linux/sysctl.h
index 87aa2a6d9..f56befb69 100644
--- a/include/uapi/linux/sysctl.h
+++ b/include/uapi/linux/sysctl.h
@@ -26,6 +26,9 @@
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/compiler.h>
+#ifndef __KERNEL__
+#include <stddef.h>
+#endif

 #define CTL_MAXNAME 10 /* how many path components do we allow in a
    call to sysctl?   In other words, what is
diff --git a/include/uapi/xen/privcmd.h b/include/uapi/xen/privcmd.h
index d20295560..51cf59019 100644
--- a/include/uapi/xen/privcmd.h
+++ b/include/uapi/xen/privcmd.h
@@ -38,6 +38,10 @@
 #include <linux/compiler.h>
 #include <xen/interface/xen.h>

+#ifndef __KERNEL__
+#include <stddef.h>
+#endif
+
 struct privcmd_hypercall {
  __u64 op;
  __u64 arg[5];
```


On Sun, Nov 10, 2019 at 11:36 PM Florian Weimer <fw@deneb.enyo.de> wrote:
>
> * Elichai Turkel:
>
> >>>> <stddef.h> is expected to be provided by the compiler. It's probably
> >>>> easier to fix your build environment.
> >
> > `<stddef.h>` is obviously *provided* by the compiler. but it's still
> > need to be *included*.
> > so maybe I'm going too far and we just need to include `<stddef.h>` in
> > `linux/types.h`.
>
> Yes, that should work.  <linux/types.h> obviously must be compatible
> with <stddef.h>.



-- 
PGP: 5607C93B5F86650C
