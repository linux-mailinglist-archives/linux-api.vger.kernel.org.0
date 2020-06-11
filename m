Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8306E1F6354
	for <lists+linux-api@lfdr.de>; Thu, 11 Jun 2020 10:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgFKIMS (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 11 Jun 2020 04:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgFKIMS (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 11 Jun 2020 04:12:18 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27476C08C5C1
        for <linux-api@vger.kernel.org>; Thu, 11 Jun 2020 01:12:18 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id t18so5141025wru.6
        for <linux-api@vger.kernel.org>; Thu, 11 Jun 2020 01:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kUiKHVOoF7ZJ8wmYqv/EYMT0xBNo94MONSSmPtqQvA4=;
        b=MEbAXRgO0MQVR2F0fIZQNqz2FB/AJS6wntOpGny86mtKUPRYnONkoxK6UM09b2jFOq
         Mw2MQLsYe6hsesCsJutBua51Te81CgWQOsvxX00UbHsLcNF7Id3vIPPHoXkLd1GZs3YO
         KBGnBH45D2lhJQ/5YSlw+p4ofvZab94WQfkmWjpJL5Pvv8uA5CswRQj60eKBBEFbngmF
         t2xV91VrgKR4M8vk2vHL4Xyw9NR0JUdTIKbJzLp5MHEfpZJNY5ewscz7HcCWzelvWm7C
         TohzWS8wwx2UbEp3v8sosGgOdwu5gdR8E5lTVydIdv5yLwCiDs8vOsORtmT9rzgHUu+g
         dsyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kUiKHVOoF7ZJ8wmYqv/EYMT0xBNo94MONSSmPtqQvA4=;
        b=a3l5v+e/m/tykK5q3JIIItI6ZEBLHbg/JgFXtKbd73pDELFbWGllxEXSVI+cQEcv7E
         4Q3jknIwJ3EUM8rs72jrdQrMauiuCsxWud76tEkBbuk+Jll1iK13KYVHlx3RtocKlSvo
         XJ/RVsSa8NiTcgnKVq244nrod0j/BACE/NAmru1Q1pvBWN6R2hor+Xmdd0K3kPqD6INI
         z9EXKkTxXKjobufjIm4hTXlNTK2JfoPBvLU3D5I2q05oRNjME+a2vyIUFDk0ZmMivQek
         olr1L0WyYu6/OnTZTNoObzyJsTBrhrr4hPTXASiUkUNzZDDb995oRGivkH1psRC1dWQs
         jT5Q==
X-Gm-Message-State: AOAM5321GwSA5+jZhHMzEs0uHanbAFSV4kS3wpnqMTVbDhxz5QyCMbOC
        UGkK7CS5ATiH7FYoWru3tiQ=
X-Google-Smtp-Source: ABdhPJzW2MewmfkeF39bRIJHVdmLK2NgXFIW32JkzPi0SIpm3PlmXIMuGPVl4AQ6q8FKsAidHGFkpg==
X-Received: by 2002:adf:fd4f:: with SMTP id h15mr8051524wrs.397.1591863136557;
        Thu, 11 Jun 2020 01:12:16 -0700 (PDT)
Received: from bobo.ibm.com (193-116-110-116.tpgi.com.au. [193.116.110.116])
        by smtp.gmail.com with ESMTPSA id w17sm3604826wra.71.2020.06.11.01.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 01:12:15 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, musl@lists.openwall.com,
        libc-dev@lists.llvm.org, linux-api@vger.kernel.org
Subject: Linux powerpc new system call instruction and ABI
Date:   Thu, 11 Jun 2020 18:12:01 +1000
Message-Id: <20200611081203.995112-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Thanks to everyone who has given feedback on the proposed new system
call instruction and ABI, I think it has reached agreement and the
implementation can be merged into Linux.

I have a hacked glibc implementation (that doesn't do all the right
HWCAP detection and misses a few things) that I've tested several things
including some kernel selftests (involving signals and syscalls) with.

System Call Vectored (scv) ABI
==============================

The scv instruction is introduced with POWER9 / ISA3, it comes with an
rfscv counter-part. The benefit of these instructions is performance
(trading slower SRR0/1 with faster LR/CTR registers, and entering the
kernel with MSR[EE] and MSR[RI] left enabled, which can reduce MSR 
updates. The scv instruction has 128 levels (not enough to cover the Linux
system call space).

Assignment and advertisement
----------------------------
The proposal is to assign scv levels conservatively, and advertise them
with HWCAP feature bits as we add support for more.

Linux has not enabled FSCR[SCV] yet, so executing the scv instruction will
cause the kernel to log a "SCV facility unavilable" message, and deliver a
SIGILL with ILL_ILLOPC to the process. Linux has defined a HWCAP2 bit
PPC_FEATURE2_SCV for SCV support, but does not set it.

This change allocates the zero level ('scv 0'), advertised with
PPC_FEATURE2_SCV, which will be used to provide normal Linux system
calls (equivalent to 'sc').

Attempting to execute scv with other levels will cause a SIGILL to be
delivered the same as before, but will not log a "SCV facility unavailable"
message (because the processor facility is enabled).

Calling convention
------------------
The proposal is for scv 0 to provide the standard Linux system call ABI 
with the following differences from sc convention[1]:

- lr is to be volatile across scv calls. This is necessary because the 
  scv instruction clobbers lr. From previous discussion, this should be 
  possible to deal with in GCC clobbers and CFI.

- cr1 and cr5-cr7 are volatile. This matches the C ABI and would allow the
  kernel system call exit to avoid restoring the volatile cr registers
  (although we probably still would anyway to avoid information leaks).

- Error handling: The consensus among kernel, glibc, and musl is to move to
  using negative return values in r3 rather than CR0[SO]=1 to indicate error,
  which matches most other architectures, and is closer to a function call.

Notes
-----
- r0,r4-r8 are documented as volatile in the ABI, but the kernel patch as
  submitted currently preserves them. This is to leave room for deciding
  which way to go with these. Some small benefit was found by preserving
  them[1] but I'm not convinced it's worth deviating from the C function
  call ABI just for this. Release code should follow the ABI.

Previous discussions:
https://lists.ozlabs.org/pipermail/linuxppc-dev/2020-April/208691.html
https://lists.ozlabs.org/pipermail/linuxppc-dev/2020-April/209268.html

[1] https://github.com/torvalds/linux/blob/master/Documentation/powerpc/syscall64-abi.rst
[2] https://lists.ozlabs.org/pipermail/linuxppc-dev/2020-April/209263.html

The following patches to add scv support to Linux are posted to

 https://lists.ozlabs.org/pipermail/linuxppc-dev/

Nicholas Piggin (2):
  powerpc/64s/exception: treat NIA below __end_interrupts as soft-masked
  powerpc/64s: system call support for scv/rfscv instructions

Thanks,
Nick

-- 
2.23.0

