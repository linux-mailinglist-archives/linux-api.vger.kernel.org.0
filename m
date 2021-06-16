Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1632A3A9C41
	for <lists+linux-api@lfdr.de>; Wed, 16 Jun 2021 15:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbhFPNmx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 16 Jun 2021 09:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233375AbhFPNmc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 16 Jun 2021 09:42:32 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0FAC06175F
        for <linux-api@vger.kernel.org>; Wed, 16 Jun 2021 06:40:26 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id nd37so4036367ejc.3
        for <linux-api@vger.kernel.org>; Wed, 16 Jun 2021 06:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=0tGswtVSoXRKAfKt7OuY6NcaJZ9I5MXJkKZxBsMjOfQ=;
        b=eG/WZ9NliQk5ifageRib4vEkSuXSNh1jAWsR7T+fFcv68h66n5yRWcDRDa+L7rvQZJ
         7Oo9957dq96iC1QHvYXVuE96HkjDQVmRXuAGzBbyVPIDBuHfAIDOcVVesDCqS46Ccab9
         Nx5s4jr4wEjOVv7uWcba/wIIbpF9slSSzxrNM5uEj/XoufC7UuMb4eiyoG1vDs/bFqN/
         TXm1RFLt0EfotsQULDqY6JNROzihMDj/Si670Vb+5p5FRMRTppJUY3jDxrt2ZBV+8h/B
         eNjylASQksurheU62VK7AtZw9WYu4u2acz9F4cG+KPbgawnw8I947mz4JRb0PPwp4V1m
         FVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=0tGswtVSoXRKAfKt7OuY6NcaJZ9I5MXJkKZxBsMjOfQ=;
        b=ZPe0XcHmJP/CNypVVsY/Pb4wftJLwfDx6+eeVabBbwFksrxVq459wwUpbHtKznml0u
         PmQPHeYF0r4PAR6OMS1OWjIwurtdy0Un3YuIvBPVQ5AK02w1YLrxLjvZp+7dV4pHidAU
         iztxRwUmtJnFoH9AXiHULL0ziTQOwRpS6mR+QlZTs1rff0VtYVwIoXemn3OocC56l9j8
         7WLk4Scl+SsMKxcAaK8NkZlNX3Zg27847wIHvWwgNUbG2kdURKIgSM/FnCF4dfwFPVJo
         dUKLSgT6caBnsTYHR7HEb66/4n2UYiK2rBCN80/QZ/c85ydJTm3800FaO2UM8aD1puUw
         xCqA==
X-Gm-Message-State: AOAM533Hbhx8vNBWDbEev6iG9ITRtOBgD0p09py79VwipBDlLtY7NuPT
        7hck+qLtIi8uex/KB/hVu82DSmnJAwqr8Wpo+PY=
X-Google-Smtp-Source: ABdhPJy2bkV/z39E4B8g9wJVPn21Nd/v9jEB0BTEcSUNxbDH5S1PWQOedY/5rmXTtXuuMq55T1ZPEKnvhRoZLqpoL9w=
X-Received: by 2002:a17:906:fc18:: with SMTP id ov24mr557216ejb.223.1623850824463;
 Wed, 16 Jun 2021 06:40:24 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?THXDrXMgTWVuZGVz?= <luis.p.mendes@gmail.com>
Date:   Wed, 16 Jun 2021 14:40:13 +0100
Message-ID: <CAEzXK1q7SR-CpMyP0jpdHx4GSCr5qkO_-+Dnn5xjmtVLSkDH0g@mail.gmail.com>
Subject: Discussion of a possible modern alternate of the removed Sysctl syscall
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Dear Linux kernel maintainers/developers,


I would like to discuss a modern alternate to Sysctl syscall and its
feasibility for armhf and aarch64 for supporting ioperm, iopl, inb,
outb and their siblings APIs emulation in Glibc, or even on an
external library to provide such sys/io.h API compatibility with
x86_64.

The advantage of having ioperm, iopl, inb and outb emulation for armhf
and aarch64 is that they can provide cross-compilation ability of
x86_64 applications and constitutes an easy and practical API for
simple I/O. This was not only useful for old ISA cards as it is today
for PCIe cards with I/O space, like I/O cards, LPT Parallel interface
cards, as well as many other cards that may have PCIe I/O space
(network cards, etc). PCIe LPT interface cards as well as
multi-function cards are still widely available, just search ebay or
amazon, and many suggestions will pop up.

I know for instance that LPT interface cards have their ppdev driver
which already provides an ioctl interface to access the card I/O
lines, but it is not performant for applications like bit-banging an
LPT card to load firmware into a micro-controller, for instance,
Microchip/ATMEL 8-bit micro-controllers. Plus the ioperm, iopl, inb,
outb has a simpler API for doing simple interactions with the I/O
space, like is the case with the IO lines of the LPT parallel
interface card.

There are many complaints in the web, like bug reports and
cross-compilation issues/reports regarding sys/io.h removal on armhf.
There are also people wishing for such functionality on aarch64.


I had an application working up to two years ago on two armhf systems
(armv7) on imx6q and mvebu architectures, to be concrete. The
application did and does just that, currently only for x84_64, but it
is able to bit-bang the ports to load the firmware into the chips. I
just didn't got to up-stream these quite small changes, like selecting
(in the kernel configuration):
General setup->Configure standard Kernel features (expert
users)->Sysctl syscall support->Enable
and do:
arch/arm/mach-imx/mach-imx6q.c, function __init imx6q_init_late(void)
and appended:

   register_isa_ports(0xfee0000, 0x1f80000, 0);

Which is the PCIe IO memory region in the imx6q memory map. It was
just a matter of up-streaming the change. It maybe also useful to
rename register_isa_ports to register_pci_ports, or so in the kernel,
to avoid this confusion regarding to ISA bus only applicability.


So I would like to have some opinions regarding the introduction of a
modern alternate for the sysctl syscall update in order to achieve
Glibc cross-compatibility for armhf and possibly aarch64 of what
already exists in Glibc for x86_64. What do you say?

I am available to contribute with implementation, despite not being so
well familiarized with the Linux kernel code and development, but I
will do my best to provide an RFC implementation. Provided some small
guidance.


The facts:

The removal of the sysctl syscall caused Glibc to drop sys/io.h
emulation for ioperm, iopl, inb and outb for armhf.

-> commit 61a47c1ad3a4dc6882f01ebdc88138ac62d0df03
Author: Eric W. Biederman
Date:   Tue Oct 1 13:01:19 2019 -0500

    sysctl: Remove the sysctl system call

    This system call has been deprecated almost since it was introduced, an=
d
    in a survey of the linux distributions I can no longer find any of them
    that enable CONFIG_SYSCTL_SYSCALL.  The only indication that I can find
    that anyone might care is that a few of the defconfigs in the kernel
    enable CONFIG_SYSCTL_SYSCALL.  However this appears in only 31 of 414
    defconfigs in the kernel, so I suspect this symbols presence is simply
    because it is harmless to include rather than because it is necessary.

    As there appear to be no users of the sysctl system call, remove the
    code.  As this removes one of the few uses of the internal kernel mount
    of proc I hope this allows for even more simplifications of the proc
    filesystem.


The Glibc maintainers found no evidence of current users for the
sys/io.h on armhf at the time:

-> commit 6b33f373c7b9199e00ba5fbafd94ac9bfb4337b1
Author: Florian Weimer
Date:   Wed May 29 16:53:09 2019 +0200

    arm: Remove ioperm/iopl/inb/inw/inl/outb/outw/outl support

    Linux only supports the required ISA sysctls on StrongARM devices,
    which are armv4 and no longer tested during glibc development
    and probably bit-rotted by this point.  (No reported test results,
    and the last discussion of armv4 support was in the glibc 2.19
    release notes.)


Then, to my surprise, I found this discussion:

http://sourceware-org.1504.n7.nabble.com/ioperm-support-for-Arm-td574053.ht=
ml

"Do we still need this?  I'm not sure how many kernels/boards support the
ISA bus today. "

"All that said, I don't imagine anybody would notice if the
ioperm() support in glibc were to go away, and in the unlikely
event that there is some application somewhere that relies on it,
it wouldn't be very difficult to patch ioperm() into the
application itself.  It doesn't interact with anything else
inside glibc. "

Except that PCIe can also benefit from this.


Regards,

Lu=C3=ADs Mendes

Aparapi open-source project developer (www.aparapi.com)

PhD Student and Researcher
